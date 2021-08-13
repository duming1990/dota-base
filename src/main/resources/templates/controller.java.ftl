package ${package.Controller};


import cn.hutool.core.util.ArrayUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>
import com.yiyi.common.core.emums.DelFlag;
import com.yiyi.common.core.entity.PageParams;
import com.yiyi.common.core.entity.Result;
import com.yiyi.common.core.mybatisplus.conditions.Wraps;
import com.yiyi.common.core.mybatisplus.conditions.query.LbqWrapper;
import com.yiyi.common.core.utils.SecurityUtils;
import ${package.Entity}.${entity};
import ${package.Service}.${table.serviceName};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Date;
import java.util.stream.Collectors;


/**
*
* ${table.comment!} 前端控制器
*
*
* @author ${author}
* @since ${date}
*/
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>
    @Autowired
    private ${table.serviceName} ${table.entityPath}Service;

    /**
    * 获取列表
    */
    @ApiOperation(value = "查询list")
    @PostMapping("/list")
    public Result list(@RequestBody PageParams<${entity}> data) {

        LbqWrapper<${entity}> wraps = Wraps.lbQ(data.getModel());
        wraps.orderByDesc(${entity}::getOrderValue, ${entity}::getCreateTime).eq(${entity}::getDelFlag, DelFlag.OK.getCode());
        data.buildSpecWrap(wraps, data.getModel());

        IPage<${entity}> roleIPage = ${table.entityPath}Service.page(data.buildPage(), wraps);

        return Result.ok(data.buildTableResult(roleIPage));
    }

    /**
    * 根据详细信息
    */
    @ApiOperation(value = "获取单个记录")
    @GetMapping(value = "/{id}")
    public Result getEntity(@PathVariable String id) {
        return Result.ok(${table.entityPath}Service.getById(id));
    }


    /**
    * 保存
    */
    @ApiOperation(value = "保存记录")
    @PostMapping("/save")
    public Result save(@Validated @RequestBody ${entity} entity) {
        if (entity.getId() == null) {
            entity.setCreateBy(SecurityUtils.getUsername());
        }
        entity.setUpdateBy(SecurityUtils.getUsername());
        return toAjaxBoolean(${table.entityPath}Service.saveOrUpdate(entity));
    }

    /**
    * 删除
    */
    @ApiOperation(value = "删除记录")
    @DeleteMapping("/{ids}")
    public Result remove(@PathVariable String[] ids) {

        if (ArrayUtil.isEmpty(ids)) {
            return toAjaxBoolean(false);
        }

        List<${entity}> removeEntityList = Arrays.stream(ids)
            .map(id -> {
                ${entity} entity = new ${entity}().setId(id);
                entity.setDelFlag(DelFlag.DELETED.getCode());
                entity.setDeleteBy(SecurityUtils.getUsername());
                entity.setDeleteTime(new Date());
                return entity;
            }).collect(Collectors.toList());

        return toAjaxBoolean(${table.entityPath}Service.updateBatchById(removeEntityList));
    }



}
</#if>
