$(function() {
	function isPasswordValid(password) {
		let passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
		return passwordRegex.test(password);
	}
	
	function checkPasswordMatch() {
		let password = $("#password").val();
		let confirmPassword = $("#confirm_password").val();
		
		if (!isPasswordValid(password)) {
			$("#passwordMatchMessage").text("비밀번호는 영문과 숫자 조합으로 8~16글자여야 합니다.");
			disableSubmitButton();
		}
		else if (password !== confirmPassword) {
			$("#passwordMatchMessage").text("비밀번호가 일치하지 않습니다.");
			disableSubmitButton();
		} 
		else {
			$("#passwordMatchMessage").text("");
			enableSubmitButton();
		}
	}
	
	function disableSubmitButton() {
		$("#userJoin").prop('disabled', true).css({
			'backgroundColor': 'grey',
			'cursor': 'not-allowed'
		});
	}

	function enableSubmitButton() {
		$("#userJoin").prop('disabled', false).removeAttr('style');
	}
	    
	$("#password, #confirm_password").keyup(checkPasswordMatch);
});