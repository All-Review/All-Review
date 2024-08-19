$(function () {
    const $settingContainer = $('#setting_container');
	const $close = $('.close');

	$('#settingBtn').on('click', function (event) {
	    event.preventDefault();

	    $settingContainer.addClass('on');
	});
	
	$close.on('click', function () {
	    $settingContainer.removeClass('on');
	});
    
});