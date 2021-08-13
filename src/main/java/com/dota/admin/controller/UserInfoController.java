package com.dota.admin.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.dota.admin.domain.UserInfo;
import com.dota.admin.service.IUserInfoService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Api("用户管理")
@RestController
@RequestMapping("/user")
public class UserInfoController {
    @Autowired IUserInfoService iUserInfoService;

    @RequestMapping(value ="/getUser/{userName}",method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "根据用户名获取用户的信息",notes = "查询数据库中的记录",httpMethod = "POST",response = String.class)
    @ApiImplicitParam(name = "userName",value = "用户名",required = true,dataType = "String",paramType = "query")
    public UserInfo getUserInfo(@PathVariable(name = "userName")  String userName) {
        UserInfo user=iUserInfoService.getOne(Wrappers.<UserInfo>lambdaQuery().eq(UserInfo::getUserName, userName),false);
        return user;
    }

    public String register(@RequestBody  UserInfo userInfo) {


       iUserInfoService.save(userInfo);
        return "200";
    }
}
