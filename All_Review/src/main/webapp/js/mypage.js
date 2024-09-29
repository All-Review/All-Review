$(function () {
    // 프로필 개인 정보 설정, 설정 버튼 클릭
    const $proflie_menu_list = $('.profile_box > ul > .mypage_button > ul');
    
    $proflie_menu_list.parent().each(function (index, item) {
        $(this).on('click', function () {
            $(this).siblings().children().css('display', 'none');
            $(this).children().toggle();
        });
    });
    
});