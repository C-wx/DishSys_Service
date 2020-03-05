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

    <script src="${base}/js/orderManage.js"></script>
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
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="outModal" role="dialog">
    <div class="modal-dialog modal-sm" role="document" style="margin-top: 360px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="kaiti f28 bold center" style="color: #1b6d85;">确认出菜？</div>
                <form id="outForm">
                    <input type="hidden" name="orderCode" id="orderCode">
                    <input type="hidden" name="outStatus" value="Y">
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
                        <a href="/toClassifyManage"><i class="fa fa-table fa-fw"></i> 类别管理</a>
                    </li>
                    <li>
                        <a href="/toOrderManage" class="active"><i class="fa fa-edit fa-fw"></i> 订单管理</a>
                    </li>
                    <li>
                        <a href="/toArticleManage"><i class="fa fa-edit fa-fw"></i> 文章管理</a>
                    </li>
                    <li>
                        <a href="/toDiscussManage"><i class="fa fa-edit fa-fw"></i> 评论管理</a>
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
                <h1 class="alert alert-danger page-header" role="alert">订单管理</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        订单列表 <i class="fa fa-folder"></i>
                    </div>
                    <form class="form-inline" style="margin: 10px 0 0 20px" action="/toOrderManage">
                        <div class="form-group">
                            <label for="orderCode" style="width: 100px">订单编码:</label>
                            <input type="text" class="form-control" id="orderCode" name="orderCode">
                        </div>
                        <button type="submit" class="btn btn-default">查找</button>
                        <button type="submit" class="btn btn-danger">重置</button>
                    </form>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>订单号</th>
                                    <th>客户名称</th>
                                    <th>桌号</th>
                                    <th>用餐人数</th>
                                    <th>备注</th>
                                    <th>创建时间</th>
                                    <th>订单状态</th>
                                    <th>出菜状态</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list pageInfo.list as order>
                                <tr>
                                    <th>${order.orderCode}</th>
                                    <th>${order.customer.name}</th>
                                    <th>${order.tableNo}</th>
                                    <th>${order.peopleNum}</th>
                                    <th>${order.remark}</th>
                                    <th>${order.createTime?string('yyyy-MM-dd hh:mm:ss')}</th>
                                    <th>
                                        <#if order.orderStatus == "0">
                                            待付款
                                        <#elseif order.orderStatus == "1">
                                            已付款
                                        <#else >
                                            已评价
                                        </#if>
                                    </th>
                                    <th>
                                        <#if order.outStatus == "Y">
                                            已出菜
                                        <#else >
                                            未出菜
                                        </#if>
                                    </th>
                                    <th>
                                        <button type="button" class="btn btn-info btn-sm" id="detail"
                                                data-orderCode="${order.orderCode}">
                                            详情
                                        </button>
                                        <button type="button" class="btn btn-success btn-sm" id="outDish"
                                                data-orderCode="${order.orderCode}">
                                            出菜
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
</body>
</html>
