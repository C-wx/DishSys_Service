$(function () {
    $("body").on("click", "#login-btn", () => {
        var phone = $("#phone").val();
        var password = $("#password").val();
        var veryCode = $("#veryCode").val();
        if (!phone) {
            $("#toastText").html("请输入手机号！");
            $("#toastModal").modal('show');
            return
        } else if (!password) {
            $("#toastText").html("请输入密码！");
            $("#toastModal").modal('show');
            return
        } else if (!veryCode) {
            $("#toastText").html("请输入验证码！");
            $("#toastModal").modal('show');
            return
        }
        $.ajax({
            url: "doLogin",
            type: "GET",
            data: $("#login_form").serialize(),
            success: (e) => {
                if (e.code == 200) {
                    $("#toastText").html("登录成功！");
                    $("#toastModal").modal('show');
                    setTimeout(() => {
                        $("#toastModal").modal('hide');
                        location.href = "/toDishManage";
                    }, 1000);
                } else {
                    $("#toastText").html(e.msg);
                    $("#toastModal").modal('show');
                    setTimeout(function () {
                        $("#toastModal").modal('hide');
                        $("#veryCode").val("");
                        changeImg();
                    }, 1000);
                }
            }
        });
    });
})
$(document).keyup(function (event) {
    if (event.keyCode == 13) {
        $("#login-btn").click();
    }
});