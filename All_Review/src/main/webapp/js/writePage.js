const imageInput = document.getElementById('images');
const preview = document.getElementById('image_preview');

imageInput.addEventListener('change', (event) => {
    preview.innerHTML = '';
    Array.from(event.target.files).forEach(file => {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.style.maxWidth = '100px';
            img.style.marginRight = '10px';
            preview.appendChild(img);
        };
        reader.readAsDataURL(file);
    });
});

function handleChange(event) {
	            const file = event.target.files[0];
	            const preview = document.getElementById('preview');
	            const reader = new FileReader();

	            reader.onload = function(e) {
	                preview.src = e.target.result;
	                preview.style.display = 'block';
	            }

	            if (file) {
	                reader.readAsDataURL(file);
	            } else {
	                preview.style.display = 'none';
	            }
	        }

	        document.addEventListener('DOMContentLoaded', () => {
	            const closeButton = document.getElementById('closeButton');
	            closeButton.addEventListener('click', () => {
	                document.getElementById('post_form').style.display = 'none';
	                document.getElementById('overlay').style.display = 'none';
		});
	
		const submitButton = document.getElementById('submitButton');
		submitButton.addEventListener('click', () => {
		document.getElementById('post_form').style.display = 'none';
		document.getElementById('overlay').style.display = 'none';
	});
});