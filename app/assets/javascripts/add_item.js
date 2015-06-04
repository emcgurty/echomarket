  $(document).ready(function() {
   
        $("span.error").css("visibility", "hidden");
    	$("div#rapid_borrower").css('display', 'block');
    	

	
		$(".rapid.category_id").bind('change', function() {
		var cat_cmb = $(".rapid.category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "block");

		} else {
			$("#other_category").css('display', 'none');
		}

    	});
	    $(".rapid.category_id").trigger('change');
	

		$(".rapid.country_id").bind('change', function() {
		
		var country_text = $(".rapid.country_id option:selected").text();
		
		if ((country_text != 'United States') || (country_text == 'Please select')) {
		$(".rapid.us_state_id option[value='99']" ).attr( "selected", "selected" );
			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$(".rapid.country_id").trigger('change');
	
		$(".rapid.category_id").bind('change', function() {
		var cat_cmb = $(".rapid.category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "block");

		} else {
			$("#other_category").css('display', 'none');
		}

	});

	$(".rapid.category_id").trigger('change');
	
});


function addRapidItem(){
	
	 var incomplete_information = '';
	 
	 $("div.error_warning").css("display", "none");
	 $("span#incomplete_rapid_information").text("");	
	 $("span#incomplete_rapid_information").css("visibility", "hidden");
    
    var current_email = $(".rapid.email").val(); 
	
	if (validEmail(current_email)) {
		incomplete_information = incomplete_information + "- Your email address is improperly formatted<br />";
	}
	  if ($(".rapid.postal_code").val() == '' ) {
		incomplete_information = incomplete_information + "- A postal code is required<br />";
	}
	
	if (validCountryState()) {
		incomplete_information = incomplete_information + "- Country with either State or Region is required<br />";
	}
	
	if (checkCategory()) {
		incomplete_information = incomplete_information + "- If you choose an 'Other' category, you must provide your suggested 'Other' category option. Otherwise a Category selection is required.<br />";
	}
	
	if ($(".rapid.item_description").val() == '' ) {
		incomplete_information = incomplete_information + "- An Item Desription is required<br />";
    }
    
	if ($(".rapid.item_condition_id option:selected").text() == 'Please select' ) {
		incomplete_information = incomplete_information + "- Please select an Item Condition<br />";
		
	}
	
	if (checkLegal()) {
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


function validEmail(em) {
	
	
	 var foundIncomplete = false;
	 var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
	  if (!( emailRegex.test(em) ) ) {
	  	foundIncomplete = true;
	  } 
	 
	return foundIncomplete;
}


function validCountryState() {
	
	var foundIncomplete = false;
	var cid = $(".rapid.country_id option:selected").val();
	var sid = $(".rapid.us_state_id option:selected").val(); 
	var sis = $(".rapid.region").val();
	
		
	if (cid == '99') { 
		foundIncomplete = true;
	} else if (cid != 'US' && sis == ''){
		foundIncomplete = true;
	} else if (cid == 'US' && sid == '99') {
		foundIncomplete = true; 
	} 	
			
	return foundIncomplete;
}


function checkLegal() {

	var notChecked = false;
	var legal_18 = $(".rapid.age_18_or_more");
	var legal_goodwill = $(".rapid.goodwill");
	
	if (!(legal_18.is(':checked'))) {
		notChecked = true;
	} 
	if (!(legal_goodwill.is(':checked'))) {
		notChecked = true;
	} 
	
	return notChecked;
}

function checkCategory() {

	var notChecked = false;
	var cat_id = $(".rapid.category_id option:selected").text();
	var o_i_c =  $(".rapid.other_item_category").val();
	if (cat_id == 'Other' && o_i_c == ''){
		notChecked = true;
	} else if (cat_id == 'Please select') {
		notChecked = true;
		
	}
	
	return notChecked;
}

