$(function () {
    $("body").on("click", "#add", function () {
        location.href = "/toOpeArticle";
    });
    $("body").on("click", "#modify", function () {
        location.href = "/toOpeArticle?id=" + $(this).attr("data-id");
    });
    $("body").on("click", "#delete", function () {
        $("#type").val("delete");
        $("#id").val($(this).attr("data-id"));
        $("#deleteModal").modal("show");
    });
    $("body").on("click", "#toView", function () {
        $("#preview").html("")
        let id = $(this).attr("data-id");
        $.ajax({
            url: "/getArticle",
            type: "GET",
            data: {'id': id},
            success: res => {
                let title = '<div style="text-align: center;font-size: 20px;font-weight: 800;margin-bottom: 10px">' + res.data.title + '</div>'
                let html = '<div>' + res.data.content + '</div>'
                $("#preview").append(title + html);
            }
        });
        $("#previewModal").modal("show");
    });
    $("body").on("click", "#save", function () {
        $.ajax({
            url: "doOpeArticle",
            type: "POST",
            data: $("#opeForm").serialize(),
            success: res => {
                $("#deleteModal").modal("hide");
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