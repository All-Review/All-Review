$(function () {
    // 댓글 내용 없을 시 경고창
    const $comment_form = $('#comment_form');
    const $comment_input = $('#comment_form > input');
    const $comment_alert = $('#comment_alert');
    const $star_radios = $('#comment_form > .star_radio > input:radio[name="star_rate"]');
    
    
    $comment_form.on('submit', function(event) {
        // 댓글 내용 없을 시 경고창
        if (!$comment_input.val()) {
            event.preventDefault();
            $comment_alert.css('display', 'block');
            setTimeout(() => {
                $comment_alert.css('display', 'none');
            }, 3000);
        }
        
        // 별점 선택 안하면 경고창
        if ($star_radios.is(':checked') == false) {}
    }
    );

    // top 버튼 (스크롤 위로가기)
    const $top_button = $('#top_button');
    const $html = $('html');

    $top_button.on('click', function () {
        $html.animate({scrollTop : 0}, 300);
    });

    // 댓글 더보기(...)버튼 클릭
    const $comment_menu_list = $('.comment_menu > ul');
    
    $comment_menu_list.parent().each(function (index, item) {
        $(this).on('click', function () {
            $(this).children().toggle();

        });
    });
    
});