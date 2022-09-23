package com.shf.service.impl;

import com.shf.mapper.AdminMapper;
import com.shf.pojo.Admin;
import com.shf.pojo.AdminExample;
import com.shf.service.AdminService;
import com.shf.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shkstart
 * @create 2021-08-22 22:23
 */
@Service
public class AdminServiceImpl implements AdminService {
    //在业务逻辑层中，一定有数据访问，访问层的对象
    @Autowired
    AdminMapper adminMapper;

    @Override
    public Admin login(String name, String password) {
        //根据传入的用户 或者到 db中查询相应的对象
        //如果有条件，则一定要创建 adminExample对象，用来封装条件
        AdminExample example = new AdminExample();
        /*
         * 如何添加条件
         * select * from admin where a_name = `admin`
         * */
        //添加用户名 a_name条件
        example.createCriteria().andANameEqualTo(name);
        List<Admin> list = adminMapper.selectByExample(example);
        if (list.size() > 0) {
            Admin admin = list.get(0);
            //如果查询到用户对象，在进行密码的比对，注意密码是密文
            /*
            * 分析：
            * admin.getApass=>c98***762d
            * pwd=000000
            * 在进行密码对比时，要将传入的pwd进行 md5加密，在与数据库中查询到的对象的密码进行比对
            *
            * */
            String miPwd= MD5Util.getMD5(password);
            if (miPwd.equals(admin.getaPass())){
                return admin;
            }
        }
        return null;
    }
}
