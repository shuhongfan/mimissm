package com.shf.service.impl;

import com.shf.mapper.ProductInfoMapper;
import com.shf.pojo.ProductInfo;
import com.shf.pojo.ProductInfoExample;
import com.shf.pojo.vo.ProductInfoVo;
import com.shf.service.ProductInfoService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shkstart
 * @create 2021-09-15 18:01
 */
@Service
public class ProductInfoServiceImpl implements ProductInfoService {

    //切记:业务逻辑层一定有数据访问层的对象
    @Autowired
    ProductInfoMapper productInfoMapper;

    @Override
    public List<ProductInfo> getAll() {
        return productInfoMapper.selectByExample(new ProductInfoExample());
    }

    //select * from product_info order by p_id desc limit 起始记录数=((当前页-1)*每页的条数),每页去几条
    @Override
    public PageInfo<ProductInfo> splitPage(int pageNum, int pageSize) {
        //分页插件使用 pageHelper工具类完成分页设置
        Page<Object> page = PageHelper.startPage(pageNum, pageSize);

        //进行 PageInfo的数据封装
        //进行条件的查询操作,必须要创建 ProductInfoExample对象
        ProductInfoExample example = new ProductInfoExample();
        //设置 排序,按主键降序排序
        //select * from product_info order by p_id desc ;
        example.setOrderByClause("p_id desc");
        //设置完排序后,取集合,切记切记:一定要在取集合之前,设置 PageHelper.startPage(pageNum, pageSize);
        List<ProductInfo> list = productInfoMapper.selectByExample(example);
        //将查询到的集合封装到 pageInfo 对象中
        PageInfo<ProductInfo> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int save(ProductInfo info) {
        return productInfoMapper.insert(info);
    }

    @Override
    public ProductInfo getById(int pid) {
        return productInfoMapper.selectByPrimaryKey(pid);
    }

    @Override
    public int update(ProductInfo info) {
        return productInfoMapper.updateByPrimaryKey(info);

    }

    @Override
    public int delete(int pid) {
        return productInfoMapper.deleteByPrimaryKey(pid);
    }

    @Override
    public int deleteBatch(String... ids) {
        return productInfoMapper.deleteBatch(ids);
    }

    @Override
    public List<ProductInfo> selectCondition(ProductInfoVo vo) {
        return productInfoMapper.selectCondition(vo);
    }

    @Override
    public PageInfo<ProductInfo> splitPageVo(ProductInfoVo vo, int pageSize) {
        //取出集合之前,想要设置 pageHelper.startPage() 属性
        PageHelper.startPage(vo.getPage(), pageSize);
        List<ProductInfo> list = productInfoMapper.selectCondition(vo);
        return new PageInfo<>(list);
    }


}
