/*-------------------
    CSRF Header
-------------------- */

var CSRFheader = $("meta[name='_csrf_header']").attr('content');
var CSRFtoken  = $("meta[name='_csrf']").attr('content');

/* ------------------ 
  product Register
------------------- */

var checkImage = RegExp(/\.(bmp|gif|jpg|jpeg|png)$/);
var maxSize = 10 * 1024 * 1024; // 10MB
function checkExtension(fileName, fileSize) {

	if (fileSize >= maxSize) {
		alert("이미지 사이즈는 10MB를 넘을 수 없습니다.");
		return false;
	}

	if (!checkImage.test(fileName)) {
		alert("이미지 파일만 등록할 수 있습니다.");
		return false;
	}
	
	return true;
}

$("#uploadBtn").click( () => {
	
	var formData = new FormData();
	var inputImage = $("input[name='uploadImage']");
	var images = inputImage[0].files;
	
	for (var i = 0; i < images.length; i++) {
		if (!checkExtension(images[i].name, images[i].size)) {
			return false;
		}
			
		formData.append("uploadedImage", images[i]);
	}
	
	$.ajax({
		url: "/admin/product/uploadProductImage",
		type: "POST",
		processData: false,
		contentType: false,
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		data: formData,
		dataType: "json",
		success: (ajaxResult) => {
			showUploadedImage(ajaxResult);
		}
	});
	
	$("input[name='uploadImage']").val("");
});

var uploadResultDiv = $(".uploadResult");
function showUploadedImage(uploadResult) {
	
	let imageDiv = '';
	uploadResult.forEach((result) => {

		var fileCallPath = result.prod_image_url + "/thumb_" + result.prod_image_uuid + "_" + result.prod_image_name;
		var originPath   = result.prod_image_url + "/"       + result.prod_image_uuid + "_" + result.prod_image_name;
		
		imageDiv =
		`
		<div class="m-2">
		  <a href="javascript:showImage('${originPath}')" style="text-decoration: none;">
		    <img src="/admin/product/displayImage?imageName=${fileCallPath}"/><br>
		    ${result.prod_image_name}
		  </a>
		  <span data-image="${fileCallPath}" style="color: #CA010B;">
		    <i class='far fa-minus-square' style='position: relative; top: 2px; cursor: pointer;'></i>
		  </span>
		</div>
		`;

		uploadResultDiv.append(imageDiv);
	});
}

function showImage(originPath) {
	let imgCallPath = `"<img src='/admin/product/displayImage?imageName=${originPath}'>"`;
	$(".bigImageWrapper").css("display", "block");
	$(".bigImage").html(imgCallPath);
}

$(".bigImageWrapper").click(() => {
	$(".bigImageWrapper").css("display", "none");
	$(".bigImage").html("");
});
  		
$(".uploadResult").on("click", "span", function() {
	
	$.ajax({
		url: "/admin/product/deleteImage",
		type: "POST",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		data: $(this).data("image"),
		contentType: "text/plain",
		dataType: "text",
		success: () => $(this).closest("div").remove()
	});
});