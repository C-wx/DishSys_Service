$(function () {
    $("body").on("click", "#add", function () {
        location.href = "/toOpeDish"
    });
    $("body").on("click", "#modify", function () {
        location.href = "/toOpeDish?id=" + $(this).attr("data-id");
    });
    $("body").on("click", "#delete", function () {
        $("#type").val("delete");
        $("#id").val($(this).attr("data-id"));
        $("#deleteModal").modal("show");
    });
    $("body").on("click", "#save", function () {
        $.ajax({
            url: "/doOpeDish",
            type: "POST",
            data: $("#opeForm").serialize(),
            success: res => {
                if (200 === res.code) {
                    $("#deleteModal").modal("hide");
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
    })
});