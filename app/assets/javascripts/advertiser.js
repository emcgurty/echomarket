$(document).ready(function() {

    
    alert("SADAS");
    
    $("span.error").css("visibility", "hidden");
	

	$("#l2bimage").bind('change', function() {
		$("span#file_image_error").css("visibility", "hidden");
		$("span#file_image_error").text("");

		var files = !!this.files ? this.files : [];
		if (!files.length || !window.FileReader) {
			$("span#file_image_error").text("No file selected? Old browser options?");
			$("span#file_image_error").css("visibility", "visible");
			return;
		}

		if (/^image/.test(files[0].type)) {
			var reader = new FileReader();
			reader.readAsDataURL(files[0]);

			reader.onloadend = function() {
				$("div#image_details").css('display', 'block');
				$("#imagePreview").attr("src", this.result);
				$("img#imagePreview_selection").attr("src", this.result);

			}
		} else {
			$("span#file_image_error").text("You need to select an image file.");
			$("span#file_image_error").css("visibility", "visible");

		}

	});
	$("#l2bimage").trigger('change');
	
	$("select#advertiser_advertiser_category_id").bind('change', function() {

		var cat_cmb = $("select#advertiser_advertiser_category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("div#other_category").css("display", "block");

		} else {
			$("div#other_category").css('display', 'none');
		}

	});

	$("select#advertiser_advertiser_category_id").trigger('change');

});

function submitAdvertisement(){
	var foundInvalid = true;
	
	$("span.error").text("");
	$("span.error").css("visibility", "hidden"); 
	 	
	if ($("#advertiser_title").val() == "") {
		$("#advertisement_title_error").text("Advertisement title is required.");
		$("#advertisement_title_error").css("visibility", "visible");
		foundInvalid = false;
	}
	
	if ($("#advertiser_description").val() == "") {
		$("#advertisement_description_error").text("Advertisment detail is required.");
		$("#advertisement_description_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	
	if ($("#advertiser_advertiser_email").val() == "") {
		$("#advertisement_email_error").text("Advertisement contact email is required.");
		$("#advertisement_email_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	
	if ($("#advertiser_advertiser_url").val() == "") {
		$("#advertisement_url_error").text("Advertisement contact URL is required.");
		$("#advertisement_url_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	
	var cat_cmb = $("select#advertiser_advertiser_category_id option:selected").text();	
	if (cat_cmb == 'Please select'){
		$("#advertiser_category_id_error").text("Advertisement Category is required.");
		$("#advertiser_category_id_error").css("visibility", "visible");
		foundInvalid = false;
		
	} 
	
	var cat_other = $("#advertiser_category_other").text();
	if (cat_cmb == 'Other' && cat_other == ''){
		$("#advertiser_category_id_error").text("Other Category information is required.");
		$("#advertiser_category_id_error").css("visibility", "visible");
		foundInvalid = false;
		
	} 
	
	var advert_email = $("#advertiser_advertiser_email").text();
	if (validEmail(advert_email)){
		$("#advertisement_email_error").text("Contact Email not properly formatted.");
		$("#advertisement_email_error").css("visibility", "visible");
		foundInvalid = false;
		
	} 
	
    if (foundInvalid) {

		$("form.advertiser").submit();
	}
	
	
}


function validEmail(em) {
	
	
	 var foundIncomplete = false;
	 var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
	  if (!( emailRegex.test(em) ) ) {
	  	foundIncomplete = true;
	  } 
	 
	return foundIncomplete;
}







