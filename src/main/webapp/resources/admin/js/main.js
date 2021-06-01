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
		alert("파일 사이즈는 10MB를 넘을 수 없습니다.");
		return false;
	}

	if (!checkImage.test(fileName)) {
		alert("이미지 파일만 첨부하실 수 있습니다.");
		return false;
	}
	
	return true;
}

$("#uploadBtn").click( () => {
	
	var formData = new FormData();
	var inputImage = $("input[name='uploadImage']");
	var images = inputImage[0].files;
	console.log(images);
	
	for (var i = 0; i < images.length; i++) {
		if (!checkExtension(images[i].name, images[i].size)) {
			return false;
		}
			
		formData.append("uploadedImage", images[i]);
	}

	$.ajax({
		url: "/admin/product/uploadProductImage",
		processData: false,
		contentType: false,
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		data: formData,
		type: "POST",
		dataType: "json",
		success: (result) => {
			console.log(result);
			showUploadedImage(result);
		}
	});
});

var uploadResult = $(".uploadResult ul");
function showUploadedImage(uploadResultArr) {
	
	let str = '';
	$(uploadResultArr).each( (result) => {

		var fileCallPath = encodeURIComponent(result.uploadPath + "/s_" + result.uuid + "_" + result.fileName);
		var originPath = encodeURIComponent(result.uploadPath + "/" + result.uuid + "_" + result.fileName);
		
		str =
		`
		<li>
		  <a href="javascript:showImage('\${originPath}')" style="text-decoration: none;">
		    <img src="/display?fileName=\${fileCallPath}"/><br>
		    \${result.fileName}
		  </a>
		  <span data-file="\${fileCallPath}" data-type="image" style="color: #CA010B;">
		    <i class='far fa-minus-square' style='cursor: pointer;'></i>
		  </span>
		</li>
		`;

	uploadResult.append(str);

	});
}