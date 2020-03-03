<!DOCTYPE html>
<html lang="en">
<#assign base=request.contextPath />
<head>
    <title>登录页</title>
    <script src="${base}/js/jquery.min.js"></script>
    <!-- Bootstrap -->
    <link href="${base}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${base}/js/bootstrap.min.js"></script>
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${base}/plugins/font-awesome/css/font-awesome.min.css">

    <link rel="stylesheet" href="${base}/css/login.css">
    <link href="${base}/css/main.css" rel="stylesheet">
    <script src="${base}/js/login.js"></script>
</head>
<body>

<!--提示模态框-->
<div class="modal fade bs-example-modal-sm" id="toastModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
            <h4 class="modal-title bold kaiti" id="toastText"></h4>
    </div>
</div>

<div class="login-area">
    <div class="login_area_box">
        <div class="mainloginbox" id="LOGIN-FORM">
            <div class="logo_login" style="text-align:center;vertical-align:middle;">
                <span style="font-size:50px;color:#1b6d85;font-weight:700;padding-top: 40px;display: inline-block;">点餐后台</>
            </div>
            <form class="login-form" id="login_form" name="form" method="post">
                <ul>
                    <li>
                        <input type="text" id="phone" name="phone" class="input-style position" autocomplete="off"
                               placeholder="请输入手机号"/>
                        <span id="helpBlock1" class="help-block" style="display: none"></span>
                    <li>
                        <input type="password" id="password" name="password" class="input-style position"
                               placeholder="请输入密码 "/>
                        <span id="helpBlock2" class="help-block" style="display: none"></span>
                    </li>
                    <li>
                        <div class="form-group">
                            <span class="form-con row">
                                <input type="text" id="veryCode" name="veryCode" placeholder="请输入验证码" autocomplete="off"
                                       class="input-style position col-md-4" maxlength="4"/>
                                <img src="/verycode/getImgCode" id="imgObj" class="col-md-4" onclick="changeImg()">
                            </span>
                        </div>
                    </li>
                    <li class="loginbtn">
                        <button type="button" class="btn" id="login-btn">点击登录</button>
                    </li>
                </ul>
            </form>
        </div>
    </div>
</div>

<script>
    function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        urlurl = url.substring(0, 17);
        if ((url.indexOf("&") >= 0)) {
            urlurl = url + "×tamp=" + timestamp;
        } else {
            urlurl = url + "?timestamp=" + timestamp;
        }
        urlurl = "${base}/verycode/getImgCode?timestamp=" + timestamp + "&imgCodeType=NUM";
        return urlurl;
    }
</script>
</body>
</html>
