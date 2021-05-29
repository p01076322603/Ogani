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
        $("#preloder").delay(200).fadeOut("slow");

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
 
// 우편번호 찾기 찾기 화면을 넣을 element
var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_wrap.style.display = 'none';
}

function sample3_execDaumPostcode() {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample3_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample3_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample3_postcode').value = data.zonecode;
            document.getElementById("sample3_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample3_detailAddress").focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_wrap.style.display = 'none';

            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size) {
            element_wrap.style.height = size.height + 'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);

    // iframe을 넣은 element를 보이게 한다.
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
const getPhone = RegExp(/^(01[016789]{1})-\d{3,4}-\d{4}$/);


/*-------------------
  Register Validation	
--------------------- */

$("#signup-cust_id").blur(function() {
	$("#v-cust_idcheck").text("");
		var id = $("#signup-cust_id").val();
		if (id == "") {
			$("#v-cust_idcheck").text("필수 입력 항목 입니다.");
			$("#v-cust_idcheck").shake();
		} else {
			$.ajax({
				url: "register/idcheck",
				type: "POST",
				data: { 'id': id },
				dataType: "json",
				beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
				success: (data) => {
					if (data.checkResult == "1") {
						$("#v-cust_idcheck").text("이미 존재하거나 사용이 불가능한 아이디 입니다");
						$("#v-cust_idcheck").shake();
					} else {
						$("#v-cust_idcheck").text("");
					}
				},
				fail: () =>	alert("시스템 에러")
			});
		}
});


$("#signup-cust_password, #signup-cust_confirm_password").blur(function() {
	$("#v-cust_confirm_password").text("");
});
$("#signup-cust_email").blur(function() {
	$("#v-cust_email").text("");
});
$("#signup-cust_phone").blur(function() {
	$("#v-cust_phone").text("");
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
});

function registerCheck() {

	if (!getId.test($("#signup-cust_id").val())) {
		$("#signup-cust_id").focus();
		$("#v-cust_id").shake();
		return false;
	}
	if (!getPwd.test($("#signup-cust_password").val())) {
		$("#signup-cust_password").focus();
		$("#v-cust_password").shake();
		return false;
	}
	if ($("#signup-cust_id").val() == $("#signup-cust_password").val()) {
		$("#v-cust_confirm_password").text("아이디와 비밀번호가 같습니다");
		$("#signup-cust_password").val("");
		$("#signup-cust_confirm_password").val("");
		$("#signup-cust_password").focus();
		$("#v-cust_confirm-password").shake();
		return false;
	}
	if ($("#signup-cust_password").val() != $("#signup-cust_confirm_password").val()) {
		$("#v-cust_confirm_password").text("비밀번호가 일치하지 않습니다");
		$("#signup-cust_confirm_password").val("");
		$("#signup-cust_confirm_password").focus();
		$("#v-cust_confirm-password").shake();
		return false;
	}
	if (!getEmail.test($("#signup-cust_email").val())) {
		$("#v-cust_email").text("올바르지 않은 이메일입니다");
		$("#signup-cust_email").focus();
		$("#v-cust_email").shake();
		return false;
	}
	if (!getPhone.test($("#signup-cust_phone").val())) {
		$("#v-cust_phone").text("올바르지 않은 전화번호입니다");
		$("#signup-cust_phone").focus();
		$("#v-cust_phone").shake();
		return false;
	}

	return true;
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
		$("#login-result").text("아이디를 입력해주세요");
		$("#login-result").shake();
		return false;
	}
	if ($.trim($("#password").val()) == "") {
		$("#login-result").text("비밀번호를 입력해주세요");
		$("#login-result").shake();
		return false;
	}
	
	var loginUsername = $("#username").val();
	var loginPassword = $("#password").val();
	$.ajax({
		url: "/login",
		type : "POST",
		data : "username=" + loginUsername + "&password=" + loginPassword,
		dataType : "json",
		beforeSend : (xhr) => xhr.setRequestHeader(CSRFheader, CSRFtoken),
		success: (data) => {
			if (data.loginResult == 0) {
				$("#login-result").text("아이디 혹은 비밀번호가 일치하지 않습니다");	
				$("#login-result").shake();
			}
			if (data.loginResult == 1) {
				 $(document).ajaxStop(function(){
    			     window.location.assign(data.targetUrl);
				 });
			}				
		},
		fail: () =>	alert("시스템 에러")
	});
}

$("#login-submit").click(function () {
	loginCheck();
});


/*-------------------
MemberModify Validation	
--------------------- */