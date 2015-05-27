  $(document).ready(function() {
   
    $("span.error").css("visibility", "hidden");
    	$("div#rapid_borrower").css('display', 'block');
    	$("div#country_selected").css("display", "none");




	$("select#borrower_country_id").bind('change', function() {

		
		var country_text = $("select#borrower_country_id option:selected").text();
		$("div#country_selected").css("display", "block");
		if ((country_text != 'United States') || (country_text == 'Please select')) {

			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$("select#borrower_country_id").trigger('change');
	
		$("#borrower_category_id").bind('change', function() {
		var cat_cmb = $("select#borrower_category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "block");

		} else {
			$("#other_category").css('display', 'none');
		}

	});

	$("#borrower_category_id").trigger('change');
	

		$("select#lender_country_id").bind('change', function() {

		
		var country_text = $("select#lender_country_id option:selected").text();
		$("div#country_selected").css("display", "block");
		if ((country_text != 'United States') || (country_text == 'Please select')) {

			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$("select#lender_country_id").trigger('change');
	
		$("#lender_category_id").bind('change', function() {
		var cat_cmb = $("select#lender_category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "block");

		} else {
			$("#other_category").css('display', 'none');
		}

	});

	$("#lender_category_id").trigger('change');
	
});


function addBorrowerItem(){
	
	 var incomplete_information = '';
	 
	 $("div.error_warning").css("display", "none");
	 $("span#incomplete_rapid_information").text("");	
	 $("span#incomplete_rapid_information").css("visibility", "hidden");
    
    var current_email = $("input#lender_email_alternative").val(); 
	
	if (validEmail(current_email)) {
		incomplete_information = incomplete_information + "- Your email address is improperly formatted<br />";
	}
	  if ($("input#lender_postal_code").val() == '' ) {
		incomplete_information = incomplete_information + "- A postal code is required<br />";
	}
	
	if (validLenderCountryState()) {
		incomplete_information = incomplete_information + "- Country with either State or Region is required<br />";
	}
	
	if (checkLenderCategory()) {
		incomplete_information = incomplete_information + "- If you choose an 'Other' category, you must provide your suggested 'Other' category option. Otherwise a Category selection is required.<br />";
	}
	
	if ($("input#lender_item_description").val() == '' ) {
		incomplete_information = incomplete_information + "- An Item Desription is required<br />";
    }
    
	if ($("select#lender_item_condition_id option:selected").text() == 'Please select' ) {
		incomplete_information = incomplete_information + "- Please select an Item Condition<br />";
		
	}
	
	
	
	if (checkLenderLegal()) {
		incomplete_information = incomplete_information + "- You must confirm that you are acting in goodwill and you are at least 18 years old<br />";
	}

    if (incomplete_information == '') {
	  $('form.rapid_item').submit(); 	}
	else {
	 $("div.error_warning").css("display", "block");
	 $("span#incomplete_rapid_information").html(incomplete_information);
	 $("span#incomplete_rapid_information").css("visibility", "visible");	
    
	}

	
}



function addLenderItem(){
	
 var incomplete_information = '';
	
	 $("div.error_warning").css("display", "none");
	 $("span#incomplete_rapid_information").text("");	
	 $("span#incomplete_rapid_information").css("visibility", "hidden");
    
    var current_email = $("#borrower_email_alternative").val(); 
	
	if (validEmail(current_email)) {
		incomplete_information = incomplete_information + "- Your email address is improperly formatted<br />";
	}
	if ($("#borrower_postal_code").val() == '' ) {
		incomplete_information = incomplete_information + "- A postal code is required<br />";
	}
	
	if (validBorrowerCountryState()) {
		incomplete_information = incomplete_information + "- Country with either State or Region is required<br />";
	}

		if (checkBorrowerCategory()) {
		incomplete_information = incomplete_information + "- If you choose an 'Other' category, you must provide your suggested 'Other' category option. Otherwise a Category selection is required.<br />";
	}
	
	if ($("#borrower_item_description").val() == '' ) {
		incomplete_information = incomplete_information + "- An item description is required<br />";
    }
    
	if ($("select#borrower_item_condition_id option:selected").text() == 'Please select' ) {
		incomplete_information = incomplete_information + "- Please select an Item Condition<br />";
			
	}
		

	if (checkBorrowerLegal()) {
		incomplete_information = incomplete_information + "- You must confirm that you are acting in goodwill and you are at least 18 years old\<br />";
	} 
    if (incomplete_information == '') {
	$('form.rapid_item').submit(); 	}
	else {
	 $("div.error_warning").css("display", "block");
	 $("span#incomplete_rapid_information").html(incomplete_information);
	 $("span#incomplete_rapid_information").css("visibility", "visible");	
    
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


function validLenderCountryState() {
	
	var foundIncomplete = false;
	var cid = $("select#lender_country_id option:selected").val();
	var sid = $("select#lender_us_state_id option:selected").val(); 
	var sis = $("input#lender_us_state_id").val();
	
		
	if (cid == '99') { 
	
		foundIncomplete = true;
	} else if (cid != 'US' && sis == ''){
		foundIncomplete = true;
	} else if (cid == 'US' && sid == '99') {
		foundIncomplete = true; 
	} 	
			
	return foundIncomplete;
}


function validBorrowerCountryState() {
	
	var foundIncomplete = false;
	var cid = $("select#borrower_country_id option:selected").val();
	var sid = $("select#borrower_us_state_id option:selected").val(); 
	var sis = $("input#borrower_us_state_id").val();
	
	if (cid == '99') { 
		foundIncomplete = true;
		
	} else if (cid != 'US' && sis == ''){
		foundIncomplete = true;
	} else if (cid == 'US' && sid == '99') {
		foundIncomplete = true; 
	} 	
			
	return foundIncomplete;
}


function checkBorrowerLegal() {

	var notChecked = false;
	var legal_18 = $("#borrower_age_18_or_more");
	var legal_goodwill = $("#borrower_goodwill");
	
	if (!(legal_18.is(':checked'))) {
		notChecked = true;
	} 
	if (!(legal_goodwill.is(':checked'))) {
		notChecked = true;
	} 
	
	return notChecked;
}


function checkLenderLegal() {

	var notChecked = false;
	var legal_18 = $("#lender_age_18_or_more");
	var legal_goodwill = $("#lender_goodwill");

	
	
	if (!(legal_18.is(':checked'))) {
		notChecked = true;
	} 
	if (!(legal_goodwill.is(':checked'))) {
		notChecked = true;
	} 
	
	return notChecked;
}


function checkBorrowerCategory() {

	var notChecked = false;
	var cat_id = $("select#borrower_category_id option:selected").text();
	var o_i_c =  $("input#borrower_other_item_category").val();
	if (cat_id == 'Other' && o_i_c == ''){
		notChecked = true;
	} else if (cat_id == 'Please select') {
		notChecked = true;
		
	}
	
	return notChecked;
}

function checkLenderCategory() {

	var notChecked = false;
	var cat_id = $("select#lender_category_id option:selected").text();
	var o_i_c =  $("input#lender_other_item_category").val();
	if (cat_id == 'Other' && o_i_c == ''){
		notChecked = true;
	} else if (cat_id == 'Please select') {
		notChecked = true;
		
	}
	
	return notChecked;
}










