$(function () {
    $("#btn_save").on("click", function () {
        $.ajax({
            url: "doOpeDish",
            type: "POST",
            data: new FormData($("form")[0]),
            processData: false,
            contentType: false,
            success: function (result) {
                if (200 === result.code) {
                    $("#toastText").html("操作成功");
                    $("#toastModal").modal("show");
                    setTimeout(() => {
                        $("#toastModal").modal("hide");
                        location.href = "/toDishManage";
                    }, 500);
                } else {
                    $("#toastText").html("操作失败");
                    $("#toastModal").modal("show");
                    setTimeout(() => {
                        $("#toastModal").modal("hide");
                    }, 500);
                }
            }
        })
    })
});

function click_image() {
    $("#file").click();
}

function replace_image() {
    $("#inputImg").hide();
    // 获得图片对象
    var blob_image = $("#file")[0].files[0];
    var url = window.URL.createObjectURL(blob_image);
    // 替换image
    $("#image").attr("src", url);
}