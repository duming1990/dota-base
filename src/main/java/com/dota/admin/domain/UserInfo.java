package com.dota.admin.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@ApiModel(value = "UserInfo")
@Data
public class UserInfo implements Serializable {
  @ApiModelProperty(value = "主id")
  private int id;

  @ApiModelProperty(value = "用户编号")
  private int userId;

  @ApiModelProperty(value = "姓名")
  private String userName;

  @ApiModelProperty(value = "电话")
  private String mobile;

  @ApiModelProperty(value = "邮箱")
  private String email;

  @ApiModelProperty(value = "状态")
  private int status;

  @ApiModelProperty(value = "用户类型")
  private int userType;

  @ApiModelProperty(value = "微信openid")
  private String openId;

  @ApiModelProperty(value = "添加日期")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private Date addDate;

  @ApiModelProperty(value = "更新日期")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private Date upDate;

  @ApiModelProperty(value = "昵称")
  private String nickName;
}
