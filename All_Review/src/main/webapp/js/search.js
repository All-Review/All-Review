$(function () {
    const $search_form = $('input[name="search"]');
    const $search_dropdown = $('#search_dropdown');
    const $search_delete_btn = $('#search_delete');

        // 검색창 드롭다운 목록들 클릭
        const $dropdown_lists = $('#search_dropdown > ul > li > a');
        $dropdown_lists.each(function (index) {
            $(this).on('mousedown', function () {
                location.href = $(this).attr('href');
            });
        });

        // 검색창 포커스 시 드롭다운
        $search_form.on({
            'focus' : function () {
            $search_dropdown.css('display', 'block');
            },
            'blur' : function () {
                // if ($search_dropdown.css.displ) {}
            $search_dropdown.css('display', 'none');
            }
        });

        // 검색창 입력시 글자 확인해서 바뀌게
        let $search_word = $('#search_dropdown > p > span');
        $search_form.on('keyup', function () {
            $search_word.text(`"#${$(this).val()}"`);
        });

        // 삭제 버튼 누르면 내용 삭제
        $search_delete_btn.on('click', function (event) {
            event.preventDefault();
            $search_form.val("");
            $search_word.text(`"#"`);
        });
    
});