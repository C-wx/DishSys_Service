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

    <script src="${base}/js/dishManage.js"></script>
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${base}/plugins/font-awesome/css/font-awesome.min.css">
</head>
<body>

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
                <form id="opeForm">
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
                        <a href="/toDishManage" class="active"><i class="fa fa-dashboard fa-fw"></i> 菜品管理</a>
                    </li>
                    <li>
                        <a href="/toClassifyManage"><i class="fa fa-table fa-fw"></i> 类别管理</a>
                    </li>
                    <li>
                        <a href="/toOrderManage"><i class="fa fa-edit fa-fw"></i> 订单管理</a>
                    </li>
                    <li>
                        <a href="/toArticleManage"><i class="fa fa-edit fa-fw"></i> 文章管理</a>
                    </li>
                    <li>
                        <a href="/toInfoManage"><i class="fa fa-edit fa-fw"></i> 信息管理</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="alert alert-success page-header" role="alert">菜品管理</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        菜品列表 <i class="fa fa-folder"></i>
                    </div>
                    <div class="panel-body">
                        <button type="button" class="btn btn-info btn-sm" style="margin-bottom: 8px" id="add">
                            添加
                            <i class="fa fa-plus"></i>
                        </button>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>主图</th>
                                    <th>菜品名称</th>
                                    <th>所属类别</th>
                                    <th>描述</th>
                                    <th>价格</th>
                                    <th>销量</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list pageInfo.list as dish>
                                <tr>
                                    <th><a href="${dish.picture}" target="view_window"><img src="${dish.picture}" width="100px" height="80px"></a></th>
                                    <th>${dish.name}</th>
                                    <th>${dish.classify.value}</th>
                                    <th style="max-width: 300px">${dish.descript}</th>
                                    <th>${dish.price}</th>
                                    <th>${dish.sales}</th>
                                    <th>${dish.createTime?string('yyyy-MM-dd hh:mm:ss')}</th>
                                    <th>
                                        <button type="button" class="btn btn-primary btn-sm" id="modify"
                                                data-id="${dish.id}">
                                            修改
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" id="delete"
                                                data-id="${dish.id}">
                                            删除
                                        </button>
                                    </th>
                                </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div id="navigatepage" style="text-align: center">
                            <nav aria-label="Page navigation">
                                <ul class="pagination" style="margin: 0px">
                                    <#if pageInfo.navigateFirstPage gt 1>
                                        <li>
                                            <a href="/toDishManage?pn=1" aria-label="Previous">
                                                <span aria-hidden="true">&lt;&lt;</span>
                                            </a>
                                        </li>
                                    </#if>
                                    <#if  pageInfo.hasPreviousPage >
                                        <li>
                                            <a href="/toDishManage?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                                <span aria-hidden="true">&lt;</span>
                                            </a>
                                        </li>
                                    </#if>
                                    <#list pageInfo.navigatepageNums as pn>
                                                <li class="${(pageInfo.pageNum==pn)?string('active','')}">
                                                    <a href="/toDishManage?pn=${pn}">${pn}</a>
                                                </li>
                                    </#list>
                                    <#if pageInfo.hasNextPage >
                                        <li>
                                            <a href="/toDishManage?pn=${pageInfo.pageNum+1}" aria-label="Previous">
                                                <span aria-hidden="true">&gt;</span>
                                            </a>
                                        </li>
                                    </#if>
                                    <#if pageInfo.navigateLastPage<pageInfo.pages >
                                        <li>
                                            <a href="/toDishManage?pn=${pageInfo.pages}" aria-label="Previous">
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
</body>
</html>
