package com.shf.lister;

/**
 * @author shkstart
 * @create 2021-09-15 22:36
 */

import com.shf.pojo.ProductType;
import com.shf.service.ProductTypeService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;

//监听器 用于商品类型回显
@WebListener
public class ProductTypeListener implements ServletContextListener {
    //对象被创建之后执行该方法
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        //创建 productTypeService 对象
        //手工从 spring容器中获取 ProductTypeServiceImpl对象
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext_*.xml");
        ProductTypeService productTypeService = (ProductTypeService) context.getBean("ProductTypeServiceImpl");
        List<ProductType> typeList = productTypeService.getAll();
        //放入全局应用作用域,提供新增页面,修改页面,前台的查询功能提供全部商品类别集合
        servletContextEvent.getServletContext().setAttribute("typeList", typeList);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
