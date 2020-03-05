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

    <!--城市级联-->
    <script src="${base}/js/city-picker.data.js"></script>
    <script src="${base}/js/city-picker.js"></script>

    <script src="${base}/js/infoManage.js"></script>
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
                        <a href="/toArticleManage"><i class="fa fa-edit fa-fw"></i> 文章管理</a>
                    </li>
                    <li>
                        <a href="/toDiscussManage"><i class="fa fa-edit fa-fw"></i> 评论管理</a>
                    </li>
                    <li>
                        <a href="/toInfoManage" class="active"><i class="fa fa-edit fa-fw"></i> 信息管理</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="alert alert-info page-header" role="alert">信息管理</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        信息编辑
                        <i class="fa fa-edit"></i>
                    </div>
                    <div class="panel-body">
                        <#if (Session["LOGIN_USER"])??>
                            <form class="form-horizontal">
                                <input type="hidden" name="id" value="${Session["LOGIN_USER"].id}">
                                <br>
                                <div class="form-group has-warning">
                                    <label for="file" class="col-sm-5 control-label">店铺主图:</label>
                                    <input id="file" type="file" name="files" style="display:none;" class="form-control"
                                           onChange="replace_image(0)"/>
                                    <img id="image" onclick="click_image()" class="img-rounded" style="margin-left: 15px"
                                         src="${(Session["LOGIN_USER"].avatar)!'${base}/images/offer_upload.png'}"
                                         height="120px" width="120px"/>
                                </div>
                                <hr>
                                <div class="form-group has-warning">
                                    <label for="name" class="col-sm-5 control-label">店铺名称：</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="name" name="name"
                                               value="${Session["LOGIN_USER"].name}">
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-warning">
                                    <label for="phone" class="col-sm-5 control-label">联系电话：</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="phone" name="phone"
                                               value="${Session["LOGIN_USER"].phone}">
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-warning">
                                    <label for="password" class="col-sm-5 control-label">登录密码：</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="password" name="password"
                                               value="${Session["LOGIN_USER"].password}">
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-warning">
                                    <label for="descript" class="col-sm-5 control-label">店铺描述：</label>
                                    <div class="col-sm-4">
                                    <textarea id="descript" name="descript" class="form-control"
                                              rows="5">${Session["LOGIN_USER"].descript}</textarea>
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-warning">
                                    <label for="city-picker3" class="col-sm-5 control-label">店铺地址：</label>
                                    <div class="col-sm-7">
                                        <div class="col-sm-3">
                                            <input id="city-picker3" class="form-control" readonly type="text"
                                                   value="福建省/福州市/屏南县" data-toggle="city-picker">
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="addr"
                                                   value="${Session["LOGIN_USER"].address?substring(12)}"
                                                   style="border:none;border-bottom: 1px solid rgb(138,109,59)">
                                        </div>
                                        <div class="col-sm-4">
                                            <input readonly id="address" name="address" style="border:none" type="hidden">
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div style="text-align: center">
                                    <button type="button" class="btn btn-primary btn-lg" id="btn_save">提交</button>
                                </div>
                            </form>
                            <#else>
                            <h3>当前登录状态已过期,请重新登录 <a href="/toLogin">跳转登录</a></h3>
                        </#if>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
