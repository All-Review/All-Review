$(document).ready(function() {
	
	const editOverlay = $('#profileEditOverlay');
	
	$('#editProfile').click(function() {
		editOverlay.css('display', 'flex');
	});
	
	$('#closeProfileEdit').click(function() {
		editOverlay.css('display', 'none');
	});
	
	// 프로필 이미지 클릭 시 파일 선택 창 열기
	$('#profileImageContainer').click(function() {
		$('#newImageUpload').click();
	});
	
	// 파일 선택 시 이미지 미리보기
	$('#newImageUpload').change(function(event) {
		const file = event.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				$('#profileImagePreview').attr('src', e.target.result).show();
			}
			reader.readAsDataURL(file);
		}
	});
});