package com.shf.test;

import com.shf.mapper.ProductInfoMapper;
import com.shf.pojo.vo.ProductInfoVo;
import com.shf.utils.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author shkstart
 * @create 2021-08-22 22:18
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext_dao.xml", "classpath:applicationContext_service.xml"})
public class MyTest {

    @Autowired
    ProductInfoMapper mapper;

    @Test
    public void testSerlectCondition() {
        /*ProductInfoVo vo = new ProductInfoVo();
        List<ProductInfo> list = mapper.selectCondition(vo);
        list.forEach(System.out::println);
        System.out.println("*******************");
        mapper.selectCondition(
                new ProductInfoVo(null, null, 500, null)).
                forEach(System.out::println);
        System.out.println("*******************");
        mapper.selectCondition(
                new ProductInfoVo(null, 2, null, 8000)).
                forEach(System.out::println);
        System.out.println("*******************");
        mapper.selectCondition(
                new ProductInfoVo("i", null, null, null)).
                forEach(System.out::println);
        System.out.println("*******************");
        mapper.selectCondition(
                new ProductInfoVo(null, 2, null, null)).
                forEach(System.out::println);*/
        System.out.println("*******************");
        mapper.selectCondition(
                new ProductInfoVo("4", 3, 800, null)).
                forEach(System.out::println);
        System.out.println("*******************");
    }


    @Test
    public void test1() {
        String mi = MD5Util.getMD5("000000");
        System.out.println(mi);
    }
}
