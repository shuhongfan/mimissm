package com.shf.controller;

import com.shf.pojo.ProductInfo;
import com.shf.pojo.vo.ProductInfoVo;
import com.shf.service.ProductInfoService;
import com.shf.utils.FileNameUtil;
import com.github.pagehelper.PageInfo;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/prod")
public class ProductInfoAction {
    //每页显示的记录数
    public static final int PAGE_SIZE = 5;
    //异步上传的图片的名称
    String saveFilename = "";

    //切记:在界面层中,一定有业务逻辑层的对象
    @Autowired
    ProductInfoService productInfoService;

    //显示全部商品不分页
    @RequestMapping("/getAll.action")
    public String getAll(HttpServletRequest request) {
        List<ProductInfo> list = productInfoService.getAll();
        request.setAttribute("list", list);
        return "product";
    }

    //显示第一页商品五条记录
    @RequestMapping("/split.action")
    public String split(HttpServletRequest request) {
        PageInfo info = null;
        Object vo = request.getSession().getAttribute("prodVo");
        if (vo != null) {//如果现在的 vo不等于空说明是带着条件来的
            info = productInfoService.splitPageVo((ProductInfoVo) vo, PAGE_SIZE);
            request.getSession().removeAttribute("prodVo");
        } else {
            //得到第一页的数据
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
        request.setAttribute("info", info);
        return "product";
    }

    //ajax分页翻页处理
    //ResponseBody 不仅可以处理 ajax请去,还可以绕过视图解析器,如果有返回值转换成 json格式返回到客户端
    @ResponseBody
    @RequestMapping("/ajaxSplit.action")
    public void ajaxsplit(ProductInfoVo vo, HttpSession session) {
        //取得当前 page参数的页面的数据
//        PageInfo<ProductInfo> info = productInfoService.splitPage(page, PAGE_SIZE);
        PageInfo<ProductInfo> info = productInfoService.splitPageVo(vo, PAGE_SIZE);
        session.setAttribute("info", info);
    }

    //多条件查询功能实现
    //ajax
    @ResponseBody
    @RequestMapping("/condition.avtion")
    public void condition(ProductInfoVo vo, HttpServletRequest request) {
        List<ProductInfo> list = productInfoService.selectCondition(vo);
        request.setAttribute("list", list);
    }


    //ajax 页面回显图片
    @ResponseBody
    @RequestMapping("/ajaxImg.action")
    public Object ajaxImg(MultipartFile pimage, HttpServletRequest request) {//pimage 要和 图片上传页面的image标签的 name属性一致
        //1. 提取生成文件名 uuid + 上传图片的后缀
        saveFilename = FileNameUtil.getUUIDFileName() + FileNameUtil.getFileType(pimage.getOriginalFilename());
        //2. 得到项目中图片存储的路径
        String path = request.getServletContext().getRealPath("/image_big");
        //3. 转存
        //D:\code\mimissm\image_big\4321898f83924.png
        try {
            pimage.transferTo(new File(path + File.separator + saveFilename));

        } catch (IOException e) {
            e.printStackTrace();
        }
        //返回客户端 json对象,封装图片的路径,为了在页面实现立即回显
        JSONObject object = new JSONObject();
        //放入上传图片的名称
        object.put("imgurl", saveFilename);
        //如果 json对象返回必须 toString,转换特点
        return object.toString();
    }

    //新增商品
    @RequestMapping("/save.action")
    public String save(ProductInfo info, HttpServletRequest request) {
        info.setpImage(saveFilename);
        info.setpDate(new Date());
        //info 对象中有表单提交来的 5个数据,有异步 ajax上来的图片名称数据,有上架时间的数据
        int num = -1;
        try {
            num = productInfoService.save(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num > 0) {
            request.setAttribute("msg", "增加成功");
        } else {
            request.setAttribute("msg", "增加失败");
        }
        //只是添加商品时清空 saveFileName,如果再次访问 异步ajax就不会为空
        //清空 saveFileName 内容 为了下次新增或者修改的异步 ajax的上传处理
        saveFilename = "";
        //增加成功后应该重新访问数据库,所以跳转分页显示的 action上
        return "forward:/prod/split.action";
    }

    // one.action?pid=6&pname=&typeid=2&lprice=[object%20HTMLInputElement]&hprice=&page=1
    // one.action?pid=6&pname=&typeid=2&lprice=undefined&hprice=&page=1
    //根据 id查询
    @RequestMapping("/one.action")
    public String one(int pid, ProductInfoVo vo, Model model, HttpSession session) {
        ProductInfo info = productInfoService.getById(pid);
        //向域中存储数据
        model.addAttribute("prod", info);
        //将多条件及页码放入 session,更新处理时读取条件和页码进行处理
        session.setAttribute("prodVo", vo);
        return "update";
    }

    //更新
    @RequestMapping("/update.action")
    public String update(ProductInfo info, HttpServletRequest request) {
        //因为 ajax的异步图片上传,如果有上传过,
        //则 saveFileName里有上传来的图片的名称,
        //如果没有使用异步 ajax上传过图片,则 saveFileName="";
        //实体类 info使用隐藏表单域提供上来的 pImage原始图片的名称
        if (!saveFilename.equals("")) {//说明 修改过图片
            info.setpImage(saveFilename);
        }
        int num = -1;
        try {
            num = productInfoService.update(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num > 0) {
            //此时说明更新成功
            request.setAttribute("msg", "更新成功");
        } else {
            request.setAttribute("msg", "更新失败");
        }
        //处理完更新后,saveFileName 里可能有数据,而下一次更新时要
        //使用这个变量作为判断依据,就会报错,所以必须清空 saveFileName
        saveFilename = "";
        return "forward:/prod/split.action";
    }

    //这里不应该加 ResponseBody,执行完删除的请求要跳转到 ajaxSplit.action 请求上
    //vo 批量删除分页
    @RequestMapping("/delete.action")
    public String delete(int pid, ProductInfoVo vo, HttpServletRequest request) {
        // System.out.println("pid = " + pid);
        int num = -1;
        try {
            num = productInfoService.delete(pid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num > 0) {
            request.setAttribute("msg", "删除成功");
            request.getSession().setAttribute("deleteProdVo", vo);
        } else {
            request.setAttribute("msg", "删除失败");
        }
        //删除成功之后跳转到 ajax分页显示
        //因为删除完以后,只是异步刷新表格而不是整个页面,request添加的属性就显示不了
        return "forward:/prod/deleteAjaxSplit.action";
    }


    //重新写一个 ajax分页有返回值
    @ResponseBody
    @RequestMapping(value = "/deleteAjaxSplit.action",
            produces = "text/html;charset=utf-8")//因为有中文显示所以设置编码
    public Object deleteAjaxSplit(HttpServletRequest request) {
        //重新,取得第一页的数据
        PageInfo info = null;
        //获取分页数据
        Object vo = request.getSession().getAttribute("deleteProdVo");
        //如果不等于 null说明是带着条件的
        if (vo != null) {
            //待条件的查询
            info = productInfoService.splitPageVo((ProductInfoVo) vo, PAGE_SIZE);
            //删除 session 可以别的 请求会创建
            request.getSession().removeAttribute("deleteProdVo");

        } else {
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
        request.getSession().setAttribute("info", info);
        return request.getAttribute("msg");
    }

    //批量删除
    @RequestMapping("/deleteBatch.action")
    public String deleteBatch(String pids, ProductInfoVo vo, HttpServletRequest request) {
        //pids = "1,4,5,7" pids[1,4,5]
        //将上传来的字符串截开,形成商品 id的字符数组
        String[] split = pids.split(",");
        int num = -1;
        try {
            num = productInfoService.deleteBatch(split);
            if (num > 0) {
                request.setAttribute("msg", "批量删除成功");
                //删除成功 存储分页的数据
                request.getSession().setAttribute("deleteProdVo", vo);
            } else {
                request.setAttribute("msg", "批量删除成功");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "商品不可删除");
        }

        //转发到  重新写一个 ajax分页有返回值
        return "forward:/prod/deleteAjaxSplit.action";
    }


}
