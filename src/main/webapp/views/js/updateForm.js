	const productImgDragZone = document.getElementById("productImgDragZone");
	const productImgInput = document.getElementById("productImgInput");
	const productImgPreview = document.getElementById("productImgPreview");
	const productImgCount = document.getElementById("productImgCount");
	const deleteBtn = document.getElementById("deleteBtn");
	const cancleBtn = document.getElementById('cancelBtn');
	
	const input = document.querySelector('input[name="deleteList"]');
	
	// 이미지 삭제 예약 
	let deleteList = [];
	
	// 상품이미지 드래그 & 드롭
	productImgDragZone.addEventListener("dragover", (e) => {
		e.preventDefault();
	});

	productImgDragZone.addEventListener("drop", (e) => {
	    e.preventDefault();

	    const files = e.dataTransfer.files;
	    if (files.length > 0) {
	    	displayImage(files,productImgPreview);
	    	productImgInput.files = files;
	    	productImgCount.innerText = files.length;
	    	
	    }
	 });

	 productImgDragZone.addEventListener("click", () => {
	    productImgInput.click();
	 });

	 productImgInput.addEventListener("change", () => {
	    const files = productImgInput.files;
	    if (files.length > 0) {
	       displayImage(files,productImgPreview);
	    }
	 });

	    function displayImage(files,productImgPreview) {
	    	console.log(files)
	    	 for (let i = 0; i < files.length; i++) {
	    		 const file = files[i];
	        	const reader = new FileReader();
	        	reader.onload = () => {
	        		const imgElement = document.createElement("img");
	        		imgElement.src = reader.result;
	        		imgElement.style.display = "block";
	        		imgElement.style.width = "100"
	        		imgElement.style.height = "100"
	            	imgElement.classList.add("pro-preview-image");
	            	productImgPreview.appendChild(imgElement);
	       	 	};
	        	reader.readAsDataURL(file);
	    	};
	    	
	    };


	
	function deleteImg(imgSid){
		deleteList.push(imgSid);
		document.getElementById(imgSid).style.opacity = "0.3";
		
		console.log(deleteList);
	}
	
	function deleteCancel(imgSid){
		let index = deleteList.indexOf(imgSid);
		
		if(index !== -1){
			deleteList.splice(index, 1);
			document.getElementById(imgSid).style.opacity = "1";
			console.log(deleteList);
		}
	}
	
	
	function listJoin(){
		input.value = deleteList.join(',');
	}
	
	// 배송비 유무에 따른 이벤트
	function showInputBox(){
		document.getElementById("d_price").style.display="block";
	}
	function closeInputBox(){
		document.getElementById("d_price").style.display="none";
	}
	