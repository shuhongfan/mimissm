package com.shf.service.impl;

import com.shf.mapper.ProductTypeMapper;
import com.shf.pojo.ProductType;
import com.shf.pojo.ProductTypeExample;
import com.shf.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shkstart
 * @create 2021-09-15 22:31
 */
@Service("ProductTypeServiceImpl")
public class ProductTypeServiceImpl implements ProductTypeService {
    //在业务逻辑层一定有数据访问的对象
    @Autowired
    ProductTypeMapper productTypeMapper;

    @Override
    public List<ProductType> getAll() {
        return productTypeMapper.selectByExample(new ProductTypeExample());
    }
}
