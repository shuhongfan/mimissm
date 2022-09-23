package com.shf.service;

import com.shf.pojo.ProductInfo;
import com.shf.pojo.vo.ProductInfoVo;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author shkstart
 * @create 2021-09-15 18:00
 */
public interface ProductInfoService {
    //显示全部商品(不分页)
    List<ProductInfo> getAll();

    //分页功能实现
    /*
     * 分析
     * 1. 当前页显示的 5条数据的集合
     * 2. 页码的导航显示(总共多少页)
     * 3. 当前是第几页
     * 4. 当前页码的背显示
     * 5. 每页显示几条数据
     * select * from product_info limit 起始记录数=((当前页-1)*每页的条数),每页去几条
     * */
    PageInfo<ProductInfo> splitPage(int pageNum, int pageSize);

    //添加商品
    int save(ProductInfo info);

    //按主键id查询
    ProductInfo getById(int pid);

    //更新商品
    int update(ProductInfo info);

    //单个商品删除
    int delete(int pid);

    //批量删除
    int deleteBatch(String... ids);

    //多条件插叙
    List<ProductInfo> selectCondition(ProductInfoVo vo);

    //按将查询商品 分页
    PageInfo<ProductInfo> splitPageVo(ProductInfoVo vo, int pageSize);

}
