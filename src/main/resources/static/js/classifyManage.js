$(function () {
    $("body").on("click", "#modify", function () {
        $("#type").val("");
        $("#addOrModify").modal("show");
        $("#id").val($(this).attr("data-id"));
        $("#value").val($(this).attr("data-value"));
    });
    $("body").on("click", "#add", function () {
        $("#id").val("");
        $("#value").val("");
        $("#type").val("");
        $("#addOrModify").modal("show");
    });
    $("body").on("click", "#delete", function () {
        $("#id").val($(this).attr("data-id"));
        $("#type").val("delete");
        $("#deleteModal").modal("show");
    });
    $("body").on("click", "#save", function () {
        $.ajax({
            url: "doSaveClassify",
            type: "POST",
            data: $("#classifyForm").serialize(),
            success: res => {
                if (200 === res.code) {
                    $("#addOrModify").modal("hide");
                    $("#toastText").html("操作成功");
                    $("#toastModal").modal("show");
                    setTimeout(()=>{
                        $("#toastModal").modal("hide");
                        location.reload();
                    },500);
                }else{
                    $("#toastText").html("操作异常");
                    $("#toastModal").modal("show");
                    setTimeout(()=>{
                        $("#toastModal").modal("hide");
                    },500);
                }
            }
        })
    })
});