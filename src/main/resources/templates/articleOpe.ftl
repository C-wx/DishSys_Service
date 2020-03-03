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

    <!--富文本-->
    <script src="${base}/plugins/nkeditor/libs/JDialog/JDialog.min.js"></script>
    <script src="${base}/plugins/nkeditor/NKeditor-all-min.js"></script>
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
                        <form class="form-horizontal" id="artileForm">
                            <input type="hidden" name="id" value="${article.id!}">
                            <hr>
                            <div class="form-group has-warning">
                                <label for="title" class="col-sm-5 control-label">文章标题：</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="title" name="title"
                                           value="${article.title!}">
                                </div>
                            </div>
                            <hr>
                            <div class="form-group has-warning">
                                <label for="summary" class="col-sm-5 control-label">文章摘要：</label>
                                <div class="col-sm-4">
                                    <textarea id="summary" name="summary" class="form-control"
                                              rows="5">${article.summary!}</textarea>
                                </div>
                            </div>
                            <div class="form-group has-warning">
                                <label for="editor" class="col-sm-5 control-label">文章内容：</label>
                                <textarea id="editor" name="content" style="display: none;">${article.content!}</textarea>
                            </div>
                            <hr>
                            <div style="text-align: center">
                                <button type="button" class="btn btn-primary btn-lg" id="btn_save">提交</button>
                                <a href="/toArticleManage" class="btn btn-warning btn-lg">返回</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var editor;
    /** 引入富文本组价*/
    KindEditor.options.filterMode = false;
    KindEditor.ready(function (K) {
        editor = K.create('#editor', {
            cssData: 'body {font-family: 微软雅黑; font-size: 16px}',
            width: "100%",
            height: "700px",
            items: [
                'source', 'preview', 'undo', 'redo', 'code', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                'superscript', 'clearhtml', 'quickformat', 'selectall',
                'formatblock', 'fontname', 'fontsize', 'forecolor', 'hilitecolor', 'bold',
                'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', 'image',
                'insertfile', 'table', 'hr', 'emoticons', 'pagebreak',
                'link', 'unlink', 'fullscreen'
            ],
            uploadJson: '/uploadImg',
            dialogOffset: 0, //对话框距离页面顶部的位置，默认为0居中，
            allowImageUpload: true,
            allowMediaUpload: true,
            themeType: 'default',
            fixToolBar: true,
            autoHeightMode: true,
            filePostName: 'file',//指定上传文件form名称，默认imgFile
            resizeType: 1,//可以改变高度
            afterCreate: function () {
                var self = this;
                KindEditor.ctrl(document, 13, function () {
                    self.sync();
                    K('form[name=example]')[0].submit();
                });
                KindEditor.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    KindEditor('form[name=example]')[0].submit();
                });
            },
            //错误处理 handler
            errorMsgHandler: function (message, type) {
                try {
                    JDialog.msg({type: type, content: message, timer: 2000});
                } catch (Error) {
                    alert(message);
                }
            }
        });
        $("body").on("click", "#btn_save", function () {
            $("#editor").html(editor.html());
            $.ajax({
                url: "doOpeArticle",
                type: "POST",
                data: $("#artileForm").serialize(),
                success: res => {
                    $("#addOrModify").modal("hide");
                    if (200 === res.code) {
                        $("#toastText").html("操作成功");
                        $("#toastModal").modal("show");
                        setTimeout(() => {
                            $("#toastModal").modal("hide");
                            location.href = "/toArticleManage";
                        }, 500);
                    } else {
                        $("#toastText").html("操作异常");
                        $("#toastModal").modal("show");
                        setTimeout(() => {
                            $("#toastModal").modal("hide");
                        }, 500);
                    }
                }
            })
        })
    });
</script>
</html>
