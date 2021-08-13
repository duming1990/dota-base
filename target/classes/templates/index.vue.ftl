<template>
    <div class="app-container">
        <el-form :model="queryParams.model" ref="queryForm" :inline="true" label-width="68px">
            <el-form-item label="公告标题" prop="noticeTitle">
                <el-input v-model="queryParams.model.noticeTitle" placeholder="请输入公告标题" clearable size="small"
                          @keyup.enter.native="handleQuery"/>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd">新增</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple"
                           @click="handleDelete">删除
                </el-button>
            </el-col>
        </el-row>

        <el-table stripe border v-loading="loading" :data="entityList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column label="公告标题" align="center" prop="noticeTitle" :show-overflow-tooltip="true"/>
            <el-table-column label="创建时间" align="center" prop="createTime" width="100">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column width="140" label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)"
                               v-hasPermi="['system:notice:edit']">修改
                    </el-button>
                    <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)"
                               v-hasPermi="['system:notice:remove']">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum"
                    :limit.sync="queryParams.pageSize" @pagination="getList"/>

        <!-- 添加或修改对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="780px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="公告标题" prop="noticeTitle">
                            <el-input v-model="form.noticeTitle" placeholder="请输入公告标题"/>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import {deleteEntity, getEntity, listEntity, saveEntity} from '@/api/system/${table.entityPath}';

    export default {
        name: '${entity}',
        data() {
            return {
                // 遮罩层
                loading: true,
                // 选中数组
                ids: [],
                // 非单个禁用
                single: true,
                // 非多个禁用
                multiple: true,
                // 总条数
                total: 0,
                // 公告表格数据
                entityList: [],
                // 弹出层标题
                title: '',
                // 是否显示弹出层
                open: false,
                // 查询参数
                queryParams: {
                    pageNum: 1,
                    pageSize: 10,
                    model: {
                        noticeTitle: '',
                    }
                },
                // 表单参数
                form: {},
                // 表单校验
                rules: {
                    noticeTitle: [{required: true, message: '标题不能为空', trigger: 'blur'}],
                }
            };
        },
        created() {
            this.getList();
        },
        methods: {
            /** 查询公告列表 */
            getList() {
                this.loading = true;
                listEntity(this.queryParams).then(response => {
                    this.entityList = response.data.rows;
                    this.total = response.data.total;
                    this.loading = false;
                });
            },
            /** 新增按钮操作 */
            handleAdd() {
                this.reset();
                this.open = true;
                this.title = '添加';
            },
            /** 修改按钮操作 */
            handleUpdate(row) {
                this.reset();
                const id = row.id || this.ids;
                getEntity(id).then(response => {
                    this.form = response.data;
                    this.open = true;
                    this.title = '修改';
                });
            },
            /** 保存按钮 */
            submitForm: function () {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        saveEntity(this.form).then(response => {
                            this.msgSuccess('操作成功');
                            this.open = false;
                            this.getList();
                        });
                    }
                });
            },
            /** 删除按钮操作 */
            handleDelete(row) {
                const ids = row.id || this.ids;
                this.$confirm('是否确认删除该数据项?', '警告', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    return deleteEntity(ids);
                }).then(() => {
                    this.getList();
                    this.msgSuccess('删除成功');
                });
            },
            // 取消按钮
            cancel() {
                this.open = false;
                this.reset();
            },
            // 表单重置
            reset() {
                this.form = {
                    id: undefined,
                    noticeTitle: undefined,
                };
                this.resetForm('form');
            },
            /** 搜索按钮操作 */
            handleQuery() {
                this.queryParams.pageNum = 1;
                this.getList();
            },
            // 多选框选中数据
            handleSelectionChange(selection) {
                this.ids = selection.map(item => item.id);
                this.single = selection.length != 1;
                this.multiple = !selection.length;
            }
        }
    };
</script>
