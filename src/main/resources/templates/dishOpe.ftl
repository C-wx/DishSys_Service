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

    <script src="${base}/js/dishOpe.js"></script>
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${base}/vendor/font-awesome/css/font-awesome.min.css">
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
                        <a href="/toDishManage" class="active"><i class="fa fa-dashboard fa-fw"></i> 菜品管理</a>
                    </li>
                    <li>
                        <a href="/toClassifyManage"><i class="fa fa-table fa-fw"></i> 类别管理</a>
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
                <h1 class="page-header">菜品管理</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form class="form-inline" id="dish_form">
                                <input type="hidden" name="id" id="productId" value="${(dish.id)!""}">
                                <div class="form-group has-success" style="margin: 10px 0px">
                                    <label>菜品名称：</label>
                                    <input type="text" class="form-control" id="name" name="name" style="width:200px" value="${(dish.name)!""}"
                                           placeholder="请输入菜品名称">
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 10px 0px">
                                    <label>菜品描述：</label>
                                    <textarea class="form-control" id="descript" name="descript" rows="3" placeholder="请输入菜品描述" style="width: 350px;">${(dish.descript)!""}</textarea>
                                </div>
                                <hr>
                                <div class="form-group" >
                                    <label>商品主图:</label>
                                    <input id="file" type="file" name="files" style="display:none;" onChange="replace_image(0)"/>
                                    <img id="image" onclick="click_image()" src="${(dish.picture)!'${base}/images/offer_upload.png'}" height="160px" width="200px" />
                                </div>
                                <hr>
                                <div class="form-group has-success" >
                                    <label >价格：</label>
                                    <div class="input-group" >
                                        <div class="input-group-addon">$</div>
                                        <input type="text" class="form-control" id="price" name="price" value="${(dish.price)!""}"
                                               style="width: 80px">
                                    </div>
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 20px 0px">
                                    <label>类别：</label>
                                    <select class="form-control" id="classifyId" name="classifyId">
                                        <option>请选择分类</option>
                                        <#list classifyList as classify>
                                            <option value="${classify.id}" <#if dish??>${(dish.classifyId == classify.id)?string("selected","")}</#if>>${classify.value}</option>
                                        </#list>
                                    </select>
                                </div>
                                <hr>
                                <div class="form-group has-success" style="margin: 20px 0px">
                                    <label>推荐指数：</label>
                                    <select class="form-control" id="recommended" name="recommended">
                                        <option>请选择</option>
                                        <option value="1" <#if dish??>${(dish.recommended == 1)?string("selected","")}</#if>>★✩✩✩✩</option>
                                        <option value="2" <#if dish??>${(dish.recommended == 2)?string("selected","")}</#if>>★★✩✩✩</option>
                                        <option value="3" <#if dish??>${(dish.recommended == 3)?string("selected","")}</#if>>★★★✩✩</option>
                                        <option value="4" <#if dish??>${(dish.recommended == 4)?string("selected","")}</#if>>★★★★✩</option>
                                        <option value="5" <#if dish??>${(dish.recommended == 5)?string("selected","")}</#if>>★★★★★</option>
                                    </select>
                                </div>
                                <hr>
                                <div style="text-align: center">
                                    <button type="button" class="btn btn-primary btn-lg" id="btn_save">提交</button>
                                    <a href="/toDishManage" class="btn btn-warning btn-lg" >返回</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
