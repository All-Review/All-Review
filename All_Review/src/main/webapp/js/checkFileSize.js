$(function() {
	function checkingFileSize(input) {
		const maxSize = 10 * 1024 * 1024;
		const file = input.files[0];
		const message = $('#fileSizeMessage');
		const submitButton = $('#userUpdate');
			  		
		submitButton.prop('disabled', false).css({
			'backgroundColor': '',
			'cursor': ''
		});
		  		
		if (file && file.size > maxSize) {
			//message.text('파일 크기가 10MB를 초과합니다. 파일 크기를 줄여주세요.');
			message.html('파일 크기가 10MB를 초과합니다.<br>파일 크기를 줄여주세요.');
			
			submitButton.prop('disabled', true).css({
				'backgroundColor': 'grey',
				'cursor': 'not-allowed'
			});
		}
		else {
			message.text('');
		}
	}
		  	
	$('#newImageUpload').on('change', function () {
		checkingFileSize(this);
	});
});