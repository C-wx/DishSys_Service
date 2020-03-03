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

    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${base}/plugins/font-awesome/css/font-awesome.min.css">
</head>
<body>

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
                        <a href="/toInfoManage"><i class="fa fa-edit fa-fw"></i> 信息管理</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="alert alert-danger page-header" role="alert">订单详情</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <#list orderList as order>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading"
                                 style="font-size: 20px;font-weight: 800;text-align: center">
                                菜品${order_index+1}
                            </div>
                            <div class="panel-body">
                                <div>
                                    <span class="title">菜品名称：</span>
                                    <span class="key">${order.dish.name}</span>
                                </div>
                                <div>
                                    <span class="title">点菜数量：</span>
                                    <span class="key">${order.num} 份</span>
                                </div>
                                <div>
                                    <span class="title">当前总价：</span>
                                    <span class="key">￥${order.price}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
                <h4 class="alert alert-info page-header col-md-6" role="alert">
                    <div>
                        <span class="title">桌号：</span>
                        <span class="key">${orderList[0].tableNo}</span>
                    </div>
                    <hr>
                    <div>
                        <span class="title">用餐人数：</span>
                        <span class="key">${orderList[0].peopleNum} 人</span>
                    </div>
                    <hr>
                    <div>
                        <span class="title">备注：</span>
                        <span class="key">${orderList[0].remark}</span>
                    </div>
                    <hr>
                    <div>
                        <span class="title">总价：</span>
                        <span class="key">￥${totalPrice}</span>
                    </div>
                </h4>
            </div>
            <div style="text-align: center;">
                <a href="/toOrderManage" class="btn btn-warning btn-lg">返回</a>
            </div>
        </div>
    </div>
</div>
<style>
    .title {
        font-size: 18px;
        font-weight: 800;
        display: inline-block;
        width: 150px;
        margin: 10px;
    }

    .key {
        font-size: 22px;
        letter-spacing: 2px;
        color: red;
    }
</style>
</body>
</html>
