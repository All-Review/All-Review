$(document).ready(function() {
	// 비밀번호 유효성 검사 함수 (길이, 영문+숫자 조합)
	function isPasswordValid(password) {
		var passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/; // 영문과 숫자 조합, 8~16글자
		return passwordRegex.test(password);
	}
					
	// 비밀번호와 비밀번호 재확인이 같은지 확인하는 함수
	function checkPasswordMatch() {
		var password = $("#password").val();
		var confirmPassword = $("#confirm_password").val();
		
		if (!isPasswordValid(password)) {
			$("#passwordMatchMessage").text("비밀번호는 영문과 숫자 조합으로 8~16글자여야 합니다.");
			$("#userJoin").prop('disabled', true).css('backgroundColor', 'green').css('cursor', 'notAllowed');
		} else if (password !== confirmPassword) {
			$("#passwordMatchMessage").text("비밀번호가 일치하지 않습니다.");
			$("#userJoin").prop('disabled', true).css('backgroundColor', 'green').css('cursor', 'notAllowed');
		} else {
			$("#passwordMatchMessage").text(""); // 일치하고 유효할 경우 메시지 제거
			$("#userJoin").prop('disabled', false); // 버튼 활성화
			$("#userJoin").removeAttr('style');
		}
	}
	
	// 비밀번호와 비밀번호 재확인 입력 시마다 확인
	$("#password, #confirm_password").keyup(checkPasswordMatch);
});