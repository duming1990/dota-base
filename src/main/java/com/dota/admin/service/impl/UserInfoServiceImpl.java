package com.dota.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dota.admin.domain.UserInfo;
import com.dota.admin.mapper.UserInfoMapper;
import com.dota.admin.service.IUserInfoService;
import org.springframework.stereotype.Service;

@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper,  UserInfo> implements IUserInfoService {
}
