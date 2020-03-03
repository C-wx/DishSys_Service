$(function () {
    $("body").on("click", "#detail", function () {
        location.href = "/toOrderDetail?orderCode=" + $(this).attr("data-orderCode");
    });
    $("body").on("click", "#outDish", function () {
        $("#orderCode").val($(this).attr("data-orderCode"));
        $("#outModal").modal("show");
    });
    $("body").on("click", "#save", function () {
        $.ajax({
            url: "doOutDish",
            type: "POST",
            data: $("#outForm").serialize(),
            success: res => {
                $("#outModal").modal("hide");
                if (200 === res.code) {
                    $("#toastText").html("操作成功");
                    $("#toastModal").modal("show");
                    setTimeout(() => {
                        $("#toastModal").modal("hide");
                        location.reload();
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
    });
});