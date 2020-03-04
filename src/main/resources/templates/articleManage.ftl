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

    <script src="${base}/js/articleManage.js"></script>
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${base}/plugins/font-awesome/css/font-awesome.min.css">
</head>
<body>

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

<!--预览模态框-->
<div class="modal fade" tabindex="-1" id="previewModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 900px">
        <div class="modal-content">
            <div class="modal-body" id="preview">
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
                        <a href="/toOrderManage"><i class="fa fa-edit fa-fw"></i> 订单管理</a>
                    </li>
                    <li>
                        <a href="/toArticleManage" class="active"><i class="fa fa-edit fa-fw"></i> 文章管理</a>
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
                <h1 class="alert  page-header" style="background-color: rgba(220,188,255,0.53);color: rgb(135,115,156)"
                    role="alert">文章管理</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        文章编辑
                        <i class="fa fa-edit"></i>
                    </div>
                    <div class="panel-body">
                        <button type="button" class="btn btn-info btn-sm" style="margin-bottom: 8px" id="add">
                            发布文章
                            <i class="fa fa-plus"></i>
                        </button>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>文章标题</th>
                                    <th>文章摘要</th>
                                    <th>发布时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list pageInfo.list as article>
                                <tr>
                                    <th>${article_index+1}</th>
                                    <th>${article.title}</th>
                                    <th>${article.summary}</th>
                                    <th>${article.publishTime?string('yyyy-MM-dd hh:mm:ss')}</th>
                                    <th>
                                        <button type="button" class="btn btn-info btn-sm" id="toView"
                                                data-id="${article.id}">
                                            预览
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" id="modify"
                                                data-id="${article.id}">
                                            修改
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" id="delete"
                                                data-id="${article.id}">
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
