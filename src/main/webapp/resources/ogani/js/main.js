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
            if (oldValue > 0) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 0;
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
			beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
			success: (data) => {
				if (data.checkResult == "1") {
					$("#vr-cust_idcheck").text("이미 존재하거나 사용이 불가능한 아이디 입니다");
					$("#vr-cust_idcheck").shake();
					$("#signup-cust_id").focus();
				} else {
					$("#vr-cust_idcheck").text("");
				}
			},
			
			fail: () =>	alert("서버로부터 응답이 없습니다. 관리자에게 문의 해주세요")
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
		type : "POST",
		data : {
			username: loginUsername,
			password: loginPassword
		},
		dataType : "json",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.loginResult == 0) {
				$("#login-result").text("아이디 혹은 비밀번호가 일치하지 않습니다").shake();	
				$("#password").val("");
			}
			if (data.loginResult == 1) {
				 $(document).ajaxStop(function(){
    			     window.location.assign(data.targetUrl);
				 });
			}				
		},
		
		fail: () =>	alert("로그인에 실패하였습니다. 관리자에게 문의 해주세요")
	});
}

$("#login-submit").click( () => loginCheck() );

$("#username, #password").on('keypress', (e) => {
    	if(e.which == 13) { loginCheck(); }
});

/*-------------------
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
		$("#sample3_detailAddress").val() != "") {
		$("#vm-cust_address").text("우편번호 찾기를 눌러 주소를 입력해주세요").shake();
		return false;
	}
	if ($("#sample3_postcode").val() != "" &&
		$("#sample3_detailAddress").val() == "") {
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
		dataType : "json",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.checkResult === 0) {
				$("#modify-cust_password").focus();
				$("#vm-cust_password").text("계정의 비밀번호가 일치하지 않습니다.").shake();	
			}
			if (data.checkResult === 1) {
				passwordCheckResult = true;
			}
		},
		
		fail: () =>	alert("서버로부터 응답이 없습니다. 관리자에게 문의 해주세요")
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
	$('.toast').toast('show');
	// 상품 이름 : prod_name, 상품 개수 : cart_quantity
}

$("body").on("click", "#addCart", function() {
	
	var custNo = $("#cust_no").val();
	var prodNo = $("#prod_no").val();
	var cartQuantity = $("#cart_quantity").val();
	
	if (custNo === "0") {
		location.href = "/login";
	}
	
	$.ajax({
		url: "/cart/add",
		type : "POST",
		data : JSON.stringify({
			cust_no: custNo,
			prod_no: prodNo,
			cart_quantity: cartQuantity
		}),
		contentType: 'application/json',
		dataType : "json",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.addCartResult) {
				cartAddSuccessToast(data.prod_name, data.cart_quantity);
			}
		},
		fail: () =>	alert("서버로부터 응답이 없습니다. 관리자에게 문의 해주세요")
	});
	
});	

$("body").on("click", ".icon_close", function() {
	
	var cartNo = $(this).data("cart");
	
	$.ajax({
		url: "/cart/remove",
		type: "POST",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		data: JSON.stringify({
			cart_no: cartNo
		}),
		contentType: "application/json",
		dataType: "text",
		success: () => $(this).closest("tr").remove()
	});
});