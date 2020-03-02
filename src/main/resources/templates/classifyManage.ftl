<!DOCTYPE html>
<html lang="en">
<#assign base=request.contextPath />
<head>
    <meta charset="utf-8">
    <title>点餐后台</title>
    <script src="${base}/js/jquery.min.js"></script>
    <!-- Bootstrap -->
    <link href="${base}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${base}/js/bootstrap.min.js"></script>

    <link href="${base}/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="${base}/css/main.css" rel="stylesheet">

    <script src="${base}/js/classifyManage.js"></script>
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${base}/vendor/font-awesome/css/font-awesome.min.css">
</head>
<body>

<!--新增/修改模态框-->
<div class="modal fade" id="addOrModify" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document" style="margin-top: 360px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="kaiti f18 bold" style="color: #1b6d85;">请输入菜品类别：</div>
                <form id="classifyForm">
                    <input type="hidden" name="id" id="id">
                    <input type="text" name="value" id="value" class="form-control f18 bold">
                    <div style="text-align: center;margin-top: 20px">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" id="save" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--END-->

<!--提示模态框-->
<div class="modal fade bs-example-modal-sm" id="toastModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <h4 class="modal-title bold kaiti" id="toastText"></h4>
    </div>
</div>
<!--END-->

<!--删除模态框-->
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="deleteModal" role="dialog">
    <div class="modal-dialog modal-sm" role="document" style="margin-top: 360px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="kaiti f28 bold center" style="color: #1b6d85;">确认删除？</div>
                <form id="classifyForm">
                    <input type="hidden" name="id" id="id">
                    <input type="hidden" name="type" id="type">
                    <div style="text-align: center;margin-top: 20px">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" id="save" class="btn btn-primary">确定</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
<!--END-->

<div id="wrapper">
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><i class="fa fa-gears"></i>&nbsp;&nbsp;点餐系统后台</a>
        </div>
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                     <#if Session["LOGIN_USER"]?exists>
                         ${Session["LOGIN_USER"].name}
                     <#else >
                        未登录
                     </#if>
                    <i class="fa fa-user fa-fw"></i>
                    <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                    </li>
                </ul>
            </li>
        </ul>

        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li>
                        <a href="/toDishManage"><i class="fa fa-dashboard fa-fw"></i> 菜品管理</a>
                    </li>
                    <li>
                        <a href="/toClassifyManage" class="active"><i class="fa fa-table fa-fw"></i> 类别管理</a>
                    </li>
                    <li>
                        <a href="forms.html"><i class="fa fa-edit fa-fw"></i> 订单管理</a>
                    </li>
                    <li>
                        <a href="forms.html"><i class="fa fa-edit fa-fw"></i> 信息管理</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">菜品类别管理</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <button type="button" class="btn btn-info btn-sm" style="margin-bottom: 8px" id="add">
                    添加
                    <i class="fa fa-plus"></i>
                </button>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>类别名称</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list pageInfo.list as classify>
                                <tr>
                                    <th>${classify_index+1}</th>
                                    <th>${classify.value}</th>
                                    <th>${classify.createTime?string('yyyy-MM-dd hh:mm:ss')}</th>
                                    <th>
                                        <button type="button" class="btn btn-primary btn-sm" id="modify"
                                                data-id="${classify.id}" data-value="${classify.value}">
                                            修改
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" id="delete"
                                                data-id="${classify.id}" data-value="${classify.value}">
                                            删除
                                        </button>
                                    </th>
                                </tr>
                                </#list>
                                </tbody>
                            </table>
                            <div id="navigatepage" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <#if pageInfo.navigateFirstPage gt 1>
                                            <li>
                                                <a href="/toClassifyManage?pn=1" aria-label="Previous">
                                                    <span aria-hidden="true">&lt;&lt;</span>
                                                </a>
                                            </li>
                                        </#if>
                                        <#if  pageInfo.hasPreviousPage >
                                            <li>
                                                <a href="/toClassifyManage?pn=${pageInfo.pageNum-1}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&lt;</span>
                                                </a>
                                            </li>
                                        </#if>
                                        <#list pageInfo.navigatepageNums as pn>
                                                    <li class="${(pageInfo.pageNum==pn)?string('active','')}">
                                                        <a href="/toClassifyManage?pn=${pn}">${pn}</a>
                                                    </li>
                                        </#list>
                                        <#if pageInfo.hasNextPage >
                                            <li>
                                                <a href="/toClassifyManage?pn=${pageInfo.pageNum+1}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&gt;</span>
                                                </a>
                                            </li>
                                        </#if>
                                        <#if pageInfo.navigateLastPage<pageInfo.pages >
                                            <li>
                                                <a href="/toClassifyManage?pn=${pageInfo.pages}" aria-label="Previous">
                                                    <span aria-hidden="true">&gt;&gt;</span>
                                                </a>
                                            </li>
                                        </#if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
