  $(document).ready(function() {
   
   		$.fn.center = function() {

		$(this).css("width: " + $("form").width() + "15px", "height: " + $("form").height() + "15px");
		var element = $(this);
		var e_width = element.width();
		var win_width = $(window).width();
		var left_margin_calc = (win_width - e_width) / 2;
		element.css('margin-left', (left_margin_calc + "px"));

	};

	$.fn.center_form = function() {
		var element = $(this);
		var e_width = element.width();
		var win_width = $("div.form_wrapper").width();
		var left_margin_calc = (win_width - e_width) / 2;
		element.css('margin-left', (left_margin_calc + "px"));

	};

	$("div.form_wrapper").center();
	$("form").center_form();
	
    $("span.error").css("visibility", "hidden");
    	$("div#rapid_borrower").css('display', 'block');
    	$("div#country_selected").css("display", "none");

});


	$("select#borrowers_country_id").bind('change', function() {

		
		var country_text = $("select#borrowers_country_id option:selected").text();
		$("div#country_selected").css("display", "block");
		if ((country_text != 'United States') || (country_text == 'Please select')) {

			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$("select#borrowers_country_id").trigger('change');
	
		$("#borrowers_item_category_id").bind('change', function() {
		var cat_cmb = $("select#borrowers_item_category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "block");

		} else {
			$("#other_category").css('display', 'none');
		}

	});

	$("#borrowers_item_category_id").trigger('change');
	
	////
		$("select#lenders_country_id").bind('change', function() {

		
		var country_text = $("select#lenders_country_id option:selected").text();
		$("div#country_selected").css("display", "block");
		if ((country_text != 'United States') || (country_text == 'Please select')) {

			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$("select#lenders_country_id").trigger('change');
	
		$("#lenders_item_category_id").bind('change', function() {
		var cat_cmb = $("select#lenders_item_category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "block");

		} else {
			$("#other_category").css('display', 'none');
		}

	});

	$("#lenders_item_category_id").trigger('change');
	



function addLenderItem(){
	
	 $("div.error_warning").css("display", "none");
	 $("span#incomplete_rapid_information").text("");	
	 $("span#incomplete_rapid_information").css("visibility", "hidden");
    
	
	if (
	$("#lenders_postal_code").val() == '' ||
	$("#lenders_email_alternative").val() == '' ||
	$("#lenders_item_description").val() == '' ||
	$("#lenders_item_condition_id").val() == '' ||  validLenderCountryState() ||  checkLenderLegal() || checkLenderCategory()
	)
	{ $("div.error_warning").css("display", "block");
	 $("span#incomplete_rapid_information").text("All fields are required.");
	 
	 $("span#incomplete_rapid_information").css("visibility", "visible");	
     
    } else {
	
	}

	
}

function addBorrowerItem(){
	alert('submit borrow1');
	 $("div.error_warning").css("display", "none");
	 $("span#incomplete_rapid_information").text("");
	 $("span#incomplete_rapid_information").css("visibility", "hidden");	
     
	
		
	if ($("select#borrowers_item_category_id option:selected").val() == '' ||
	$("#borrowers_postal_code").val() == '' ||
	$("#borrowers_email_alternative").val() == '' ||
	$("#borrowers_item_description").val() == '' ||
	$("#borrowers_item_condition_id").val() == '' ||  validBorrowerCountryState() ||  checkBorrowerLegal() || checkBorrowerCategory()
	)
	{ $("div.error_warning").css("display", "block");
	 $("span#incomplete_rapid_information").text("All fields are required");
	 $("span#incomplete_rapid_information").css("visibility", "visible");	
     
    } else {
	
	}

	
}

/// Lazy but I just dont't want to fool around with typos
function validLenderCountryState() {
	
	var foundIncomplete = false;
	var cid = $("select#lenders_country_id option:selected").val();
	var sid = $("select#lenders_state_id option:selected").val(); 
	var sis = $("input#lenders_state_id_string").val();
		
	if (cid == '99') { 
		foundIncomplete = true;
	} else if ((cid != 'US') && (sis == '')){
		foundIncomplete = true;
	} else if ((cid == 'US') && (sid == '99')) {
		foundIncomplete = true; 
	} 	
			
	return foundIncomplete;
}


function validBorrowerCountryState() {
	
	var foundIncomplete = false;
	var cid = $("select#borrowers_country_id option:selected").val();
	var sid = $("select#borrowers_state_id option:selected").val(); 
	var sis = $("input#borrowers_state_id_string").val();
	
	if (cid == '99') { 
		foundIncomplete = true;
		
	} else if ((cid != 'US') && (sis == '')){
		foundIncomplete = true;
	} else if ((cid == 'US') && (sid == '99')) {
		foundIncomplete = true; 
	} 	
			
	return foundIncomplete;
}

// Realize could have just passed args
function checkBorrowerLegal() {

	var notChecked = false;
	var legal_18 = $("#borrowers_age_18_or_more");
	var legal_goodwill = $("#borrowers_goodwill");
	
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
	var legal_18 = $("#lenders_age_18_or_more");
	var legal_goodwill = $("#lenders_goodwill");

	
	
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
	var cat_id = $("select#borrowers_item_category_id option:selected").text();
	var o_i_c =  $("input#borrowers_other_item_category_id").val();
	if ((cat_id == 'Other') && (o_i_c == '')){
		notChecked = true;
	} else if (cat_id == '') {
		notChecked = true;
		
	}
	
	return notChecked;
}

function checkLenderCategory() {

	var notChecked = false;
	var cat_id = $("select#lenders_item_category_id option:selected").text();
	var o_i_c =  $("input#lenderers_other_item_category_id").val();
	if ((cat_id == 'Other') && (o_i_c == '')){
		notChecked = true;
	} else if (cat_id == '') {
		notChecked = true;
		
	}
	
	return notChecked;
}










