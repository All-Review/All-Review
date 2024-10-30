$(function () {
	  // 본문 이미지 슬라이드
	  const $left_button = $('#image_list > button:nth-child(1)');
	  const $right_button = $('#image_list > button:nth-child(2)');
	  const $image_list = $('#image_list > ul');
	  const $indicators = $('#image_list > ol > li');
	  let index = 0;
	  $indicators.eq(index).addClass('on');

	  $left_button.on('click', function() {
	      if(!$image_list.is(':animated')) {
	          pointingIndicator(false);
	          $image_list.prepend($image_list.children(':last')).css('margin-left', '-100%').animate({marginLeft: 0});
	      }
	  });

	  $right_button.on('click', function() {
	      if(!$image_list.is(':animated')) {
	          pointingIndicator(true);
	          $image_list.animate({marginLeft: '-100%'}, function () {
	              $(this).removeAttr('style').children(':first').appendTo(this);
	          });
	      }
	  });

	  function pointingIndicator (isRight) {
	      $indicators.removeClass('on');
	      if (isRight == true) {
	          if (index >= $indicators.length - 1) {
	              index = 0;
	          } else {
	              index += 1;
	          }
	      } else {
	          if (index <= 0) {
	              index = $indicators.length - 1;
	          } else {
	              index -= 1;
	          }
	      }
	      $indicators.eq(index).addClass('on');
	  }
	
	  // 공유하기 버튼
	  const $share = $('.like_container > div:nth-child(3)');
	  $share.on('click', function () {
	      $share.children().toggle();
	  });
	  
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
	
	function openImageDetail(postNum, imageUrl) {
	    const encodedImageUrl = encodeURIComponent(imageUrl); // 이미지 URL 인코딩
	    console.log(`Navigating to detailPage.jsp?postNum=${postNum}&imageUrl=${encodedImageUrl}`); // 디버깅용 로그
	    window.location.href = `detailPage.jsp?postNum=${postNum}&imageUrl=${encodedImageUrl}`;
	}
    
});