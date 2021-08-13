package com.dota;

import com.dota.admin.domain.UserInfo;
import com.dota.admin.mapper.UserInfoMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest()
public class DotaBaseApplicationTests {
  @Resource private UserInfoMapper userInfoMapper;

  @Test
  public void testSelect() {
    System.out.println(("----- selectAll method test ------"));
    UserInfo userInfo = new UserInfo();
    List<UserInfo> userList = userInfoMapper.selectList(null);
    Assert.assertEquals(4, userList.size());
    userList.forEach(System.out::println);
  }
}
