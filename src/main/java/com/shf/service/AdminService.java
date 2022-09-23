package com.shf.service;

import com.shf.pojo.Admin;

/**
 * @author shkstart
 * @create 2021-08-22 22:20
 */

public interface AdminService {
    /**
     * 完成登陆判断
     *
     * @return
     */
    Admin login(String name, String password);
}
