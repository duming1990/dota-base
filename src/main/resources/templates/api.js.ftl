import request from '@/utils/request'

// 查询列表
export function listEntity(data) {
    return request({
        url: '/${package.ModuleName}/${table.entityPath}/list',
        method: 'post',
        data: data
    })
}

// 查询
export function getEntity(id) {
    return request({
        url: '/${package.ModuleName}/${table.entityPath}/' + id,
        method: 'get'
    })
}

//保存
export function saveEntity(data) {
    return request({
        url: '/${package.ModuleName}/${table.entityPath}/save',
        method: 'post',
        data: data
    })
}

// 删除
export function deleteEntity(ids) {
    return request({
        url: '/${package.ModuleName}/${table.entityPath}/' + ids,
        method: 'delete'
    })
}

