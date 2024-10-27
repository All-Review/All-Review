$(function () {
    // 프로필 개인 정보 설정, 설정 버튼 클릭
    const $proflie_menu_list = $('.profile_box > ul > .mypage_button > ul');
    
    $proflie_menu_list.parent().each(function (index, item) {
        $(this).on('click', function () {
            $(this).siblings().children().css('display', 'none');
            $(this).children().toggle();
        });
    });
    
	// 팔로우 중이면 마우스 올렸을 때 취소로
	const $followBtn = $('#content > .follow_list > button.following');
	$followBtn.on('mouseover', function () {
	    $(this).text("팔로우 취소");
	});
	
	$followBtn.on('mouseout', function () {
	    $(this).text("팔로우 중");
	});
	
	const $myPageFollowBtn = $('.profile_box > ul > li > button.following');
	$myPageFollowBtn.on('mouseover', function () {
	    $(this).text("팔로우 취소");
	});

	$myPageFollowBtn.on('mouseout', function () {
	    $(this).text("팔로우 중");
	});
	
});