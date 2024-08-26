$(function () {
    const $gallery_images = $('#content > .image_box > div > img');
    const $gallery_image = $('#content > .image_box > div > a');

    // 이미지갤러리 마우스 오버
    $gallery_images.each(function(index) {
        $(this).on({
            'mouseover' : function () {
            $gallery_image.eq(index).addClass('image_overlay');
            },
            'mouseout' : function () {
            $gallery_image.removeClass('image_overlay');
        }
        });
    });

    $gallery_image.each(function(index) {
        $(this).on({
            'mouseover' : function () {
            $gallery_image.eq(index).addClass('image_overlay');
            },
            'mouseout' : function () {
            $gallery_image.removeClass('image_overlay');
        }
        });
    });

});