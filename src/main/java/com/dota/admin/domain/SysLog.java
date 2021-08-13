package com.dota.admin.domain;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@ApiModel(value = "SysLog")
@Data
public class SysLog implements Serializable {

  private Integer id;
  private String username;
  private String operation;
  private Integer time;
  private String method;
  private String params;
  private String ip;
  private Date createTime;
}
