$(document).ready(function() {

    $("span.error").css("visibility", "hidden");
	
});

function submitAdvertisement(){
	var foundInvalid = true;
	var foundInvalidNameCI = true;
	 
	 	
	if ($("#advertiser_advertiser_name").val() == "") {
		$("#advertisement_advertiser_name_error").text("Community Name is required.");
		$("#advertisement_advertiser_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#advertisement_advertiser_name_error").text("");
		$("#advertisement_advertiser_name_error").css("visibility", "hidden");
	}
	
	if ($("#advertiser_description").val() == "") {
		$("#advertisement_description_error").text("Advertisment detail is required.");
		$("#advertisement_description_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#advertisement_description_error").text("");
		$("#advertisement_description_error").css("visibility", "hidden");
	}
	
	if ($("#advertiser_advertiser_email").val() == "") {
		$("#advertisement_advertiser_email_error").text("Advertisement contact email is required.");
		$("#advertisement_advertiser_email_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#advertisement_advertiser_email_error").text("");
		$("#advertisement_advertiser_email_error").css("visibility", "hidden");
	}
	
		if ($("#advertiser_advertiser_url").val() == "") {
		$("#advertisement_advertiser_url_error").text("Advertisement contact URL is required.");
		$("#advertisement_advertiser_email_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#advertisement_advertiser_email_error").text("");
		$("#advertisement_advertiser_email_error").css("visibility", "hidden");
	}
	
		
	
    if (foundInvalid) {

		$("form").submit();
	}
	
	
}








