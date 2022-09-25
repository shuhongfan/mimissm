package com.shf.controller;

import com.shf.pojo.Admin;
import com.shf.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/admin")
public class AdminAction {
    //切记：在所有界面层，一定有业务逻辑的对象
    @Autowired
    AdminService adminService;

    @RequestMapping("/logout.action")
    public String logout(){
        return "login";
    }

    //实现登陆判断，并进行相应的跳转
    //不知道啥 web.info 添加了.action交给 mvc管理,这里应该不需要添加才对
    @RequestMapping("/login.action")
    public String login(String name, String pwd, HttpServletRequest request) {
        Admin admin = adminService.login(name, pwd);
        if (admin != null) {
            //登陆成功
            request.getSession().setAttribute("admin", admin);
            //request.setAttribute("admin", admin);
            return "main";
        } else {
            //登陆失败
            request.setAttribute("errmsg", "用户名或密码错误");
            return "login";
        }
    }
}
