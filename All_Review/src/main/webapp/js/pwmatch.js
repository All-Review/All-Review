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
        
        // 비밀번호 유효성 검사
        if (!isPasswordValid(password)) {
            $("#passwordMatchMessage").text("비밀번호는 영문과 숫자 조합으로 8~16글자여야 합니다.");
            disableSubmitButton();
        } 
        // 비밀번호 일치 검사
        else if (password !== confirmPassword) {
            $("#passwordMatchMessage").text("비밀번호가 일치하지 않습니다.");
            disableSubmitButton();
        } 
        // 비밀번호가 유효하고 일치할 경우
        else {
            $("#passwordMatchMessage").text(""); // 일치하고 유효할 경우 메시지 제거
            enableSubmitButton(); // 버튼 활성화
        }
    }

    // 버튼 비활성화 함수
    function disableSubmitButton() {
        $("#userJoin").prop('disabled', true).css({
            'backgroundColor': 'grey',
            'cursor': 'not-allowed'
        });
    }

    // 버튼 활성화 함수
    function enableSubmitButton() {
        $("#userJoin").prop('disabled', false).removeAttr('style');
    }
    
    // 비밀번호와 비밀번호 재확인 입력 시마다 확인
    $("#password, #confirm_password").keyup(checkPasswordMatch);
});