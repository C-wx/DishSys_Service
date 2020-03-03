$(function () {
    let $citypicker1 = $('#city-picker1');
    $citypicker1.citypicker();
    let $citypicker2 = $('#city-picker2');
    $citypicker2.citypicker({
        province: '福建省',
        city: '福州市',
        district: '屏南县'
    });

    $("#btn_save").on("click", function () {
        let $citypicker3 = $('#city-picker3').val();
        let address = $("#addr").val();
        $("#address").val($citypicker3 + "-" + address);
         $.ajax({
             url: "modifyInfo",
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
    let blob_image = $("#file")[0].files[0];
    let url = window.URL.createObjectURL(blob_image);
    // 替换image
    $("#image").attr("src", url);
}
