/*  ---------------------------------------------------
    Template Name: Ogani
    Description:  Ogani eCommerce  HTML Template
    Author: Colorlib
    Author URI: https://colorlib.com
    Version: 1.0
    Created: Colorlib
---------------------------------------------------------  */

'use strict';

(function ($) {

    /*------------------
        Preloader
    --------------------*/
    $(window).on('load', function () {
        $(".loader").fadeOut();
        $("#preloder").delay(100).fadeOut("slow");

        /*------------------
            Gallery filter
        --------------------*/
        $('.featured__controls li').on('click', function () {
            $('.featured__controls li').removeClass('active');
            $(this).addClass('active');
        });
        if ($('.featured__filter').length > 0) {
            var containerEl = document.querySelector('.featured__filter');
            var mixer = mixitup(containerEl);
        }
    });

    /*------------------
        Background Set
    --------------------*/
    $('.set-bg').each(function () {
        var bg = $(this).data('setbg');
        $(this).css('background-image', 'url(' + bg + ')');
    });

    //Humberger Menu
    $(".humberger__open").on('click', function () {
        $(".humberger__menu__wrapper").addClass("show__humberger__menu__wrapper");
        $(".humberger__menu__overlay").addClass("active");
        $("body").addClass("over_hid");
    });

    $(".humberger__menu__overlay").on('click', function () {
        $(".humberger__menu__wrapper").removeClass("show__humberger__menu__wrapper");
        $(".humberger__menu__overlay").removeClass("active");
        $("body").removeClass("over_hid");
    });

    /*------------------
		Navigation
	--------------------*/
    $(".mobile-menu").slicknav({
        prependTo: '#mobile-menu-wrap',
        allowParentLinks: true
    });

    /*-----------------------
        Categories Slider
    ------------------------*/
    $(".categories__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 4,
        dots: false,
        nav: true,
        navText: ["<span class='fa fa-angle-left'><span/>", "<span class='fa fa-angle-right'><span/>"],
        animateOut: 'fadeOut',
        animateIn: 'fadeIn',
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {

            0: {
                items: 1,
            },

            480: {
                items: 2,
            },

            768: {
                items: 3,
            },

            992: {
                items: 4,
            }
        }
    });


    $('.hero__categories__all').on('click', function(){
        $('.hero__categories ul').slideToggle(400);
    });

    /*--------------------------
        Latest Product Slider
    ----------------------------*/
    $(".latest-product__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        navText: ["<span class='fa fa-angle-left'><span/>", "<span class='fa fa-angle-right'><span/>"],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*-----------------------------
        Product Discount Slider
    -------------------------------*/
    $(".product__discount__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 3,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {

            320: {
                items: 1,
            },

            480: {
                items: 2,
            },

            768: {
                items: 2,
            },

            992: {
                items: 3,
            }
        }
    });

    /*---------------------------------
        Product Details Pic Slider
    ----------------------------------*/
    $(".product__details__pic__slider").owlCarousel({
        loop: true,
        margin: 20,
        items: 4,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*-----------------------
		Price Range Slider
	------------------------ */
    var rangeSlider = $(".price-range"),
        minamount = $("#minamount"),
        maxamount = $("#maxamount"),
        minPrice = rangeSlider.data('min'),
        maxPrice = rangeSlider.data('max');
    rangeSlider.slider({
        range: true,
        min: minPrice,
        max: maxPrice,
        values: [minPrice, maxPrice],
        slide: function (event, ui) {
            minamount.val('$' + ui.values[0]);
            maxamount.val('$' + ui.values[1]);
        }
    });
    minamount.val('$' + rangeSlider.slider("values", 0));
    maxamount.val('$' + rangeSlider.slider("values", 1));

    /*--------------------------
        Select
    ----------------------------*/
    $("select").niceSelect();

    /*------------------
		Single Product
	--------------------*/
    $('.product__details__pic__slider img').on('click', function () {

        var imgurl = $(this).data('imgbigurl');
        var bigImg = $('.product__details__pic__item--large').attr('src');
        if (imgurl != bigImg) {
            $('.product__details__pic__item--large').attr({
                src: imgurl
            });
        }
    });

    /*-------------------
		Quantity change
	--------------------- */
    var proQty = $('.pro-qty');
    proQty.prepend('<span class="dec qtybtn">-</span>');
    proQty.append('<span class="inc qtybtn">+</span>');
    proQty.on('click', '.qtybtn', function () {
        var $button = $(this);
        var oldValue = $button.parent().find('input').val();
        if ($button.hasClass('inc')) {
            var newVal = parseFloat(oldValue) + 1;
        } else {
            // Don't allow decrementing below zero
            if (oldValue > 1) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 1;
            }
        }
        $button.parent().find('input').val(newVal);
    });	
	
})(jQuery);

/*-------------------
  Daum Postcode API	
-------------------- */
 
var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    element_wrap.style.display = 'none';
}

function sample3_execDaumPostcode() {

	$("#vm-cust_address").text("");
    
	var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';

            if (data.userSelectedType === 'R') { 
                addr = data.roadAddress;
            } else { 							 
                addr = data.jibunAddress;
            }

            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample3_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample3_extraAddress").value = '';
            }

            document.getElementById('sample3_postcode').value = data.zonecode;
            document.getElementById("sample3_address").value = addr;
            document.getElementById("sample3_detailAddress").focus();

            element_wrap.style.display = 'none';

            document.body.scrollTop = currentScroll;
        },
        onresize : function(size) {
            element_wrap.style.height = size.height + 'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);

    element_wrap.style.display = 'block';
}

/*-------------------
	jQuery shake()	
--------------------- */

jQuery.fn.shake = function(interval, distance, times) {
	interval = typeof interval == "undefined" ? 100 : interval;
	distance = typeof distance == "undefined" ? 10 : distance;
	times = typeof times == "undefined" ? 3 : times;
	var jTarget = $(this);
	jTarget.css('position', 'relative');
	for (var iter = 0; iter < (times + 1); iter++) {
		jTarget.animate({
			left: ((iter % 2 == 0 ? distance : distance * -1))
		}, interval);
	}
	return jTarget.animate({
		left: 0
	}, interval);
}

/*-------------------
    CSRF Header
-------------------- */

var CSRFheader = $("meta[name='_csrf_header']").attr('content');
var CSRFtoken  = $("meta[name='_csrf']").attr('content');

/*-------------------
    	Regex
-------------------- */

const getId = RegExp(/^[a-zA-Z]{1}[a-zA-Z0-9]{5,19}$/);
const getPwd = RegExp(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,30}$/);
const getEmail = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
const getPhone = RegExp(/^(01[016789]{1})-(\d{3,4})-(\d{4})$/);
const getName = RegExp(/^[가-힣]{2,20}$/);

/*-------------------
   	 Index page
-------------------- */

$(".featured__item").on("click", ".featured__item__pic", function() {
	var prodNo = $(this).prev().val();
	location.assign("/goods/" + prodNo);
});

$(".featured__item").on("click", ".featured__item__pic__hover__anchor", function(e) {
	e.stopPropagation();
	
	var prodNo = $(this).data("cart");
	var custNo = $("#cust_no").val();
	
	if (custNo === undefined) {
		location.assign("/login?prod_no=" + prodNo);
	}
	
	addCart(custNo, prodNo, 1);
	
});

/*-------------------
   	 Shop page
-------------------- */

$(".product__item").on("click", ".product__item__pic", function() {
	var prodNo = $(this).prev().val();
	location.assign("/goods/" + prodNo);
});

$(".product__item").on("click", ".product__item__pic__hover__anchor", function(e) {
	e.stopPropagation();
	
	var prodNo = $(this).data("cart");
	var custNo = $("#cust_no").val();

	if (custNo === undefined || custNo === '0') {
		location.assign("/login?prod_no=" + prodNo);
	}
	
	addCart(custNo, prodNo, 1);
	
});

var shopBlockNum = $(".product__pagination").data("blockNum");
var shopLastBlockNum = $(".product__pagination").data("lastBlockNum");

if (shopBlockNum === 0) {
	$(".product__pagination .prev_bt").hide();
}
if (shopBlockNum === shopLastBlockNum || shopLastBlockNum === '-1') {
	$(".product__pagination .next_bt").hide();
}

/*-------------------
   	findIdPw page
-------------------- */

$("#idfind-submit").click(function() {
	
	var email = $("#idfind-email").val();
	
	if (!getEmail.test(email)) {
		$("#idfind-result").text("올바르지 않은 이메일입니다").shake();
		$("#idfind-email").focus();
		return false;
	}
	
	$.ajax({
		url: "/findidpw/findid",
		type: "POST",
		data: email,
		contentType: "text/plain",
		dataType: "json",
		beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (result) => {
			console.log(result.findIdResult);
			if (result.findIdResult === true) 
				$("#idfind-result").text("아이디가 이메일로 전송되었습니다.").shake();
			if (result.findIdResult === false) 
				$("#idfind-result").text("등록된 계정을 찾지 못하였습니다.").shake();
		}
	}); 
});

$("#pwfind-submit").click(function() {
	
	var id = $("#pwfind-id").val();
	var email = $("#pwfind-email").val();
	
	if (!getEmail.test(email)) {
		$("#pwfind-result").text("올바르지 않은 이메일입니다").shake();
		$("#pwfind-email").focus();
		return false;
	}
	
	$.ajax({
		url: "/findidpw/findpw",
		type: "POST",
		data: JSON.stringify({
			cust_id: id,
			cust_email: email	
		}),
		contentType: "application/json",
		dataType: "json",
		beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (result) => {
			console.log(result.findIdResult);
			if (result.findPwResult === true) 
				$("#pwfind-result").text("비밀번호 변경 링크가 이메일로 전송되었습니다.").shake();
			if (result.findPwResult === false) 
				$("#pwfind-result").text("등록된 계정을 찾지 못하였습니다.").shake();
		}
	}); 
});

/*-------------------
   	changePw page
-------------------- */

$("#changepw-submit").click(function() {
	
	var id = $("input[name='cust_id']").val();
	var newPassword = $("#pwchange-new-password").val();
	var confirmNewPassword = $("#pwchange-new-password-confirm").val();
	
	if (!getPwd.test(newPassword)) {
		$("#changepw-result").text("비밀번호가 올바르지 않습니다.").shake();
		$("#pwchange-new-password").focus();
	return false;
	}
	if (id == newPassword) {
		$("#changepw-result").text("아이디와 비밀번호가 같습니다").shake();
		$("#pwchange-new-password-confirm").val("");
		$("#pwchange-new-password").val("").focus();
	return false;
	}
	if (newPassword != confirmNewPassword) {
		$("#changepw-result").text("비밀번호가 일치하지 않습니다").shake();
		$("#pwchange-new-password-confirm").val("").focus();
	return false;
	}
	
	var form = $("form[name='pwfind']")
	form.submit();
});

/*-------------------
  Register Validation	
--------------------- */

$("#signup-cust_id").blur(function() {
	
	$("#vr-cust_idcheck").text("");
	
	var id = $("#signup-cust_id").val();
	if (id == "") {
		$("#vr-cust_idcheck").text("필수 입력 항목 입니다.");
		$("#vr-cust_idcheck").shake();
	
	} else {
		$.ajax({
			url: "register/idcheck",
			type: "POST",
			data: id,
			contentType: "text/plain",
			dataType: "json",
			beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
			success: (data) => {
				if (data.checkResult == "1") {
					$("#vr-cust_idcheck").text("이미 존재하거나 사용이 불가능한 아이디 입니다");
					$("#vr-cust_idcheck").shake();
					$("#signup-cust_id").focus();
				} else {
					$("#vr-cust_idcheck").text("");
				}
			}
		});
	}
});


$("#signup-cust_password, #signup-cust_confirm_password").blur(function() {
	$("#vr-cust_confirm_password").text("");
});
$("#signup-cust_email").blur(function() {
	$("#vr-cust_email").text("");
});
$("#signup-cust_phone").blur(function() {
	$("#vr-cust_phone").text("");
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^01[016789]{1})(\d{3,4})(\d{4})$/, "$1-$2-$3").replace("--", "-") );
});

function registerCheck() {

	if (!getId.test($("#signup-cust_id").val())) {
		$("#signup-cust_id").focus();
		$("#vr-cust_id").shake();
		return false;
	}
	if (!getPwd.test($("#signup-cust_password").val())) {
		$("#signup-cust_password").focus();
		$("#vr-cust_password").shake();
		return false;
	}
	if ($("#signup-cust_id").val() == $("#signup-cust_password").val()) {
		$("#vr-cust_confirm_password").text("아이디와 비밀번호가 같습니다").shake();
		$("#signup-cust_confirm_password").val("");
		$("#signup-cust_password").val("").focus();
		return false;
	}
	if ($("#signup-cust_password").val() != $("#signup-cust_confirm_password").val()) {
		$("#vr-cust_confirm_password").text("비밀번호가 일치하지 않습니다").shake();
		$("#signup-cust_confirm_password").val("").focus();
		return false;
	}
	if (!getEmail.test($("#signup-cust_email").val())) {
		$("#vr-cust_email").text("올바르지 않은 이메일입니다").shake();
		$("#signup-cust_email").focus();
		return false;
	}
	if (!getPhone.test($("#signup-cust_phone").val())) {
		$("#vr-cust_phone").text("올바르지 않은 전화번호입니다").shake();
		$("#signup-cust_phone").focus();
		return false;
	}

	return true;
}

function checkAgreement() {
	$("input:checkbox[id='agreement_checkbox']").prop("checked", true);
}

/*-------------------
   Login Validation	
--------------------- */

$("#username, #password").blur(function() {
	$("#login-result").text("");
});

function loginCheck() {
	
	$("#login-result").text("");
	if ($.trim($("#username").val()) == "") {
		$("#login-result").text("아이디를 입력해주세요").shake();
		return false;
	}
	if ($.trim($("#password").val()) == "") {
		$("#login-result").text("비밀번호를 입력해주세요").shake();
		return false;
	}
	
	var loginUsername = $("#username").val();
	var loginPassword = $("#password").val();
	$.ajax({
		url: "/login",
		type: "POST",
		data: {
			username: loginUsername,
			password: loginPassword
		},
		dataType: "json",
		beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.loginResult == 0) {
				$("#login-result").text("아이디 혹은 비밀번호가 일치하지 않습니다").shake();	
				$("#password").val("");
			}
			if (data.loginResult == -1) {
				$("#login-result").text("이메일 인증이 되지 않은 계정입니다.").shake();	
			}
			if (data.loginResult == 1) {
				 $(document).ajaxStop(function(){
    			     window.location.assign(data.targetUrl);
				 });
			}				
		}
	});
}

$("#login-submit").click( () => loginCheck() );

$("#username, #password").on('keypress', (e) => {
    	if(e.which == 13) { loginCheck(); }
});

/*-------------------
  	 MemberInfo	
--------------------- */
$(".order-each").on("click", "#orderHeading", function() {
	$(this).siblings("#orderCollapse").collapse('toggle');	
});

/*---------------------
MemberModify Validation	
--------------------- */

$("#modify-cust_password").blur(function() {
	$("#vm-cust_password").text("");
});
$("#modify-cust_new_password, #modify-cust_confirm_new_password").blur(function() {
	$("#vm-cust_confirm_new_password").text("");
});
$("#modify-cust_email").blur(function() {
	$("#vm-cust_email").text("");
});
$("#modify-cust_phone").blur(function() {
	$("#vm-cust_phone").text("");
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^01[016789]{1})(\d{3,4})(\d{4})$/,"$1-$2-$3").replace("--", "-") );
});
$("#modify-cust_name").blur(function() {
	$("#modify-cust_name").val($.trim($("#modify-cust_name").val()));
	$("#vm-cust_name").text("");
});
$("#sample3_postcode, #sample3_address, #sample3_detailAddress, #sample3_extraAddress").blur(function() {
	$("#vm-cust_address").text("");
});

function modifyCheck() {
	
	if (!$("#modify-cust_new_password").val() == "" &&
		!getPwd.test($("#modify-cust_new_password").val())) {
		$("#modify-cust_new_password").focus();
		$("#vm-cust_new_password").shake();
		return false;
	}
	if ($("#modify-cust_id").val() == $("#modify-cust_new_password").val()) {
		$("#vm-cust_confirm_new_password").text("아이디와 비밀번호가 같습니다").shake();
		$("#modify-cust_confirm_new_password").val("");
		$("#modify-cust_new_password").val("").focus();
		return false;
	}
	if ($("#modify-cust_new_password").val() != $("#modify-cust_confirm_new_password").val()) {
		$("#vm-cust_confirm_new_password").text("비밀번호가 일치하지 않습니다").shake();
		$("#modify-cust_confirm_new_password").val("").focus();
		return false;
	}
	if (!getEmail.test($("#modify-cust_email").val())) {
		$("#vm-cust_email").text("올바르지 않은 이메일입니다").shake();
		$("#modify-cust_email").focus();
		return false;
	}
	if (!getPhone.test($("#modify-cust_phone").val())) {
		$("#vm-cust_phone").text("올바르지 않은 전화번호입니다").shake();
		$("#modify-cust_phone").focus();
		return false;
	}
	
	if ($.trim($("#modify-cust_name").val()).length != 0) {
		
		if ($.trim($("#modify-cust_name").val()).length < 2 ||
			$.trim($("#modify-cust_name").val()).length > 20) {
			$("#vm-cust_name").text("이름은 2글자 이상 20글자 이하 한글로 작성 해주세요.").shake();
			$("#modify-cust_name").focus();
			return false;
		}	
		if (!getName.test($.trim($("#modify-cust_name").val()))) {
			$("#vm-cust_name").text("이름은 2글자 이상 20글자 이하로 한글로 작성 해주세요.").shake();
			$("#modify-cust_name").focus();
			return false;
		}
	}
	
	if ($("#sample3_postcode").val() == "" &&
		$.trim($("#sample3_detailAddress").val()) != "") {
		$("#vm-cust_address").text("우편번호 찾기를 눌러 주소를 입력해주세요").shake();
		return false;
	}
	if ($("#sample3_postcode").val() != "" &&
		$.trim($("#sample3_detailAddress").val()) == "") {
		$("#vm-cust_address").text("상세 주소를 입력해주세요").shake();
		$("#sample3-detailAddress").focus();
		return false;
	}

	var currentPassword = $("#modify-cust_password").val();
	var customerNo      = $("#modify-cust_no").val();
	var passwordCheckResult = false;
	$.ajax({
		url: "/member/modify/passwordcheck",
		type : "POST",
		async: false,
		data : JSON.stringify({
			cust_password: currentPassword,
			cust_no: customerNo
		}),
		contentType: 'application/json',
		dataType: "json",
		beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.checkResult === 0) {
				$("#modify-cust_password").focus();
				$("#vm-cust_password").text("계정의 비밀번호가 일치하지 않습니다.").shake();	
			}
			if (data.checkResult === 1) {
				passwordCheckResult = true;
			}
		}
	});
	
	if (passwordCheckResult === false) { return false; }

	return true;
}
/*-------------------
  MemberModify Leave	
--------------------- */

$('[data-oper="leaveModal"]').click( () => {
	$('#leaveModal').modal({ backdrop: 'static', keyboard: false });
	$('#leaveModalModal').modal('show');
});
$('[data-oper="leave"]').click( () => {
	const cust_no = $('#modify-cust_no').data("cust_no");
	let leaveForm = $("<form></form>");

	leaveForm.attr("method", "POST");
	leaveForm.attr("action", "/member/modify/leave");

	leaveForm.append($("<input/>", { type: "hidden", name: "_csrf", value: CSRFtoken}));
	leaveForm.append($("<input/>", { type: "hidden", name: "cust_no", value: cust_no}));
	leaveForm.appendTo("body");
	leaveForm.submit();
});

/*-------------------
  		 Cart	
--------------------- */

function cartAddSuccessToast(prod_name, cart_quantity) {
	
	var toast = 
	`
	  <div class="position-fixed bottom-0 right-0 p-3" style="z-index: 5; right: 0; bottom: 0;">
	    <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000">
	      <div class="toast-header">
	        <strong class="mr-auto">장바구니 추가</strong>
	        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="toast-body">
	        장바구니에 ${prod_name} 상품이 ${cart_quantity}개 추가되었습니다.
	      </div>
	    </div>
	  </div>
	`
	$("body").append(toast);
	$('.toast').toast('show');
}

function addCart(custNo, prodNo, cartQuantity) {
	
	$.ajax({
		url: "/cart/add",
		type : "POST",
		data : JSON.stringify({
			cust_no: custNo,
			prod_no: prodNo,
			cart_quantity: cartQuantity
		}),
		contentType: 'application/json',
		dataType: "json",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.addCartResult || data.addCartResult === "modified") {
				cartAddSuccessToast(data.prod_name, data.cart_quantity);
			}
		}
	});
}

$("body").on("click", "#addCart", function() {
	
	var custNo = $("#cust_no").val();
	var prodNo = $("#prod_no").val();
	var cartQuantity = $("#cart_quantity").val();
	
	if (custNo === "0") {
		location.href = "/login?prod_no=" + prodNo;
		return;
	}
	
	addCart(custNo, prodNo, cartQuantity);
	
});	

$(".cartDetails").on("click", ".icon_close", function() {
	
	var cartNo = $(this).data("cart");
	var price = parseInt($(this).parent().prev().text().replace(/(￦|,)/g, ""));
	
	$.ajax({
		url: "/cart/remove",
		type: "POST",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		data: JSON.stringify({ cart_no: cartNo }),
		contentType: "application/json",
		success: () => {
			$(this).closest("tr").remove();
			
			var totalPrice = parseInt($(".cart_total").text().replace(/(￦|,)/g, ""));
			$(".cart_total").text("￦" + $.number(totalPrice - price));
			
			if (totalPrice - price === 0) $(".cart-empty").text("장바구니가 비어있습니다.");
		}
	});
});

$(".cartDetails").each(function() {
	
	var cartDetails = $(this);
	var thisCartProductPrice = parseInt($(this).children(".shoping__cart__price").data("cart"));

	$(this).find(".dec.qtybtn").click(function() {
	
		var currentQty = parseInt($(this).siblings("input").val()) - 1;

		if (currentQty >= 1) {
			var price = thisCartProductPrice * currentQty;
			cartDetails.children(".shoping__cart__total").text("￦" + $.number(price));
		}
		
	});

	$(this).find(".inc.qtybtn").click(function() {
	
		var currentQty = parseInt($(this).siblings("input").val()) + 1;
		var price = thisCartProductPrice * currentQty;
		
		cartDetails.children(".shoping__cart__total").text("￦" + $.number(price));
		
	});
});

var cartTimer;
var cartParam = [];
$('.cartDetails').on('click', '.qtybtn', function() {
    
	if (cartTimer) { clearTimeout(cartTimer); }

	var cartNo = $(this).parent(".pro-qty").data("cart");
	
	var dupeParam = cartParam.findIndex(param => param.cart_no === cartNo);
	if (dupeParam !== -1) {
		cartParam.splice(dupeParam, 1);
	}

	var cartData = { 
		cart_no: cartNo, 
		cart_quantity: $(this).siblings("input[type='text']").val() 
	};
	cartParam.push(cartData);

	cartTimer = setTimeout(function() {
		$.ajax({
			url: "/cart/modify",
			type: "POST",
			beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
			traditional: true,
			data: JSON.stringify(cartParam),
			contentType: "application/json",
			success: () => cartParam = []
		});
	}, 500);
	
	var totalPrice = 0;
	$(".shoping__cart__total").each(function() {
		var eachPrice = parseInt($(this).text().replace(/(￦|,)/g, ""));
		totalPrice += eachPrice;
	});
	
	$(".cart_total").text("￦" + $.number(totalPrice));
	
});

$(".checkout-submit").click(function() {

	if (cartParam.length !== 0) { return false; }
	
	if (parseInt($(".cart_total").text().replace(/(￦|,)/g, "")) === 0) {
		alert("장바구니가 비어있습니다.");
		return false;
	}

	var checkoutArray = [];
	$(".cartDetails").each(function() {
		var checkout = $(this).find(".pro-qty").data("cart");
		checkoutArray.push(checkout);
	});
	JSON.stringify(checkoutArray);
	
	var checkoutForm = $("<form></form>");
	checkoutForm.attr("method", "POST");
	checkoutForm.attr("action", "/checkout");

	checkoutForm.append($("<input/>", { type: "hidden", name: "_csrf", value: CSRFtoken}));
	checkoutForm.append($("<input/>", { type: "hidden", name: "cartList", value: checkoutArray}));
	
	checkoutForm.appendTo("body").submit();
});

/*-------------------
 Checkout validation
--------------------- */
$("#checkout-cust_name").blur(function() {
	$("#checkout-cust_name").val($.trim($("#checkout-cust_name").val()));
	$("#vc-cust_name").text("");
});
$("#sample3_postcode, #sample3_address, #sample3_detailAddress, #sample3_extraAddress").blur(function() {
	$("#vc-cust_address").text("");
});
$("#checkout-cust_phone").blur(function() {
	$("#vc-cust_phone").text("");
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^01[016789]{1})(\d{3,4})(\d{4})$/,"$1-$2-$3").replace("--", "-") );
});
$("#checkout-cust_email").blur(function() {
	$("#vc-cust_email").text("");
});
$("#checkout-cust_password").blur(function() {
	$("#vc-cust_password").text("");
});

$(".place-order").click(function() {

	if ($.trim($("#checkout-cust_name").val()).length < 2 ||
		$.trim($("#checkout-cust_name").val()).length > 20) {
		$("#vc-cust_name").text("이름은 2글자 이상 20글자 이하 한글로 작성 해주세요.").shake();
		$("#checkout-cust_name").focus();
		return false;
	}	
	if (!getName.test($.trim($("#checkout-cust_name").val()))) {
		$("#vc-cust_name").text("이름은 2글자 이상 20글자 이하로 한글로 작성 해주세요.").shake();
		$("#checkout-cust_name").focus();
		return false;
	}
	if ($("#sample3_postcode").val() == "") {
		$("#vc-cust_address").text("우편번호 찾기를 눌러 주소를 입력해주세요.").shake();
		return false;
	}
	if ($.trim($("#sample3_detailAddress").val()) == "") {
		$("#vc-cust_address").text("상세 주소를 입력해주세요.").shake();
		$("#sample3-detailAddress").focus();
		return false;
	}
	if (!getPhone.test($("#checkout-cust_phone").val())) {
		$("#vc-cust_phone").text("올바르지 않은 전화번호입니다").shake();
		$("#checkout-cust_phone").focus();
		return false;
	}
	if (!getEmail.test($("#checkout-cust_email").val())) {
		$("#vc-cust_email").text("올바르지 않은 이메일입니다").shake();
		$("#checkout-cust_email").focus();
		return false;
	}

	var currentPassword = $("#checkout-cust_password").val();
	var customerNo      = $("#checkout-cust_no").val();
	var passwordCheckResult = false;
	$.ajax({
		url: "/member/modify/passwordcheck",
		type : "POST",
		async: false,
		data : JSON.stringify({
			cust_password: currentPassword,
			cust_no: customerNo
		}),
		contentType: 'application/json',
		dataType: "json",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.checkResult === 0) {
				$("#vc-cust_password").text("계정의 비밀번호가 일치하지 않습니다.").shake();
				$("#checkout-cust_password").focus().val("");
			}
			if (data.checkResult === 1) {
				passwordCheckResult = true;
			}
		}
	});
	
	if (passwordCheckResult === false) { return false; }

	/*-------------------------
	 After checkout validation
	------------------------ */
	
	var checkoutLength = $(".checkout-list").data("checkout");
	var checkoutName = checkoutLength == 1 
			? $(".checkout-list").children(":first").data("checkout")
			: $(".checkout-list").children(":first").data("checkout") + " 외 " + (checkoutLength - 1);
	
	var cartArray = [];
	$("input[name='cart_no']").each(function() {
		var cartNo = $(this).val();
		cartArray.push(cartNo);
	});
	var checkoutAmount = 0;
	$.ajax({
		url: "/checkout/validatePrice",
		type : "POST",
		async: false,
		data : JSON.stringify(cartArray),
		contentType: 'text/plain',
		dataType: "json",
		beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (result) => {
			if (result == 0) alert("잘못된 접근입니다.")
			else checkoutAmount = result;
		}
	});
	
	if (checkoutAmount === 0) return false;
	
	var buyerEmail = $("#checkout-cust_email").val();
	var buyerName = $("#checkout-cust_name").val();
	var buyerTel = $("#checkout-cust_phone").val();
	var buyerPostcode = $("input[name='cust_address1']").val();
	var buyerAddr     = $("input[name='cust_address2']").val() + "，"
	    	          + $("input[name='cust_address3']").val() + ($("input[name='cust_address4']").val().length > 0 ? "，" : "")
				      + $("input[name='cust_address4']").val();
	
	IMP.init('imp57705805');

	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method: 'card',
	    merchant_uid: 'order_' + new Date().getTime(),
	    buyer_name: buyerName,
	    buyer_postcode: buyerPostcode,
	    buyer_addr: buyerAddr,
	    buyer_tel: buyerTel,
	    buyer_email: buyerEmail,
	    name: checkoutName,
	    amount: checkoutAmount
	}, 
	function(rsp) {
		
		$.ajax({
			url: "/checkout/verifyCheckout/" + rsp.imp_uid,
			type : "POST",
			async: false,
			beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		
		}).done(function(data) {
		/* 결제 종료 후 받은 결과의 금액과
		 * 아임포트 서버에 imp_uid로 요청한 결제 결과의 금액을 비교 */

			if (rsp.paid_amount == data.response.amount) {
				/* 금액 일치 */
				var orderInfo = {
					order_uid: rsp.merchant_uid,
					order_imp_uid: rsp.imp_uid,
					order_price: rsp.paid_amount,
					order_card_approval: rsp.apply_num,
					order_name: checkoutName,
					order_buyer: buyerName,
					order_postcode: buyerPostcode,
					order_address: buyerAddr,
					order_phone: buyerTel,
					order_email: buyerEmail,
					order_request: $("#order_request").val()
				};

				var	save_request = $("input[name='save-request']").is(":checked") ? 1 : 0;
				
				$.ajax({
					url: "/checkout/complete",
					type: "POST",
					async: false,
					traditional: true,
					data: JSON.stringify({
						cart: JSON.stringify(cartArray),
						order: JSON.stringify(orderInfo),
						save_request: JSON.stringify(save_request)
					}),	
					contentType: "application/json; charset=UTF-8",
					beforeSend: (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
					success: () => window.location.assign("/checkout/complete?imp_uid=" + rsp.imp_uid + "&merchant_uid=" + rsp.merchant_uid),
					fail: () => {
						// 서버 장애시 환불 로직 작성 
						$.ajax({
						url: "/checkout/checkoutFail/" + rsp.imp_uid,
						type: "POST",
						beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
						success: () => alert("결제에 실패하였습니다. (서버 장애)")
						});
					}
				});
				
			} else {
				/* 금액 불일치 (결제 중단) */
				$(".error_msg").text(rsp.error_msg);
				$('#checkoutFailModal').modal();
			}
		});
	});
});

$('[data-toggle="tooltip"]').tooltip();