$(document).ready(function() {


	$.fn.center = function() {

		
		var element = $(this);
		var e_width = element.width();
		var win_width = $(window).width();
		var left_margin_calc = (win_width - e_width) / 2;
		element.css('margin-left', (left_margin_calc + "px"));
		element.css('border', '2px solid #4A572B');
	};


	$("div.form_wrapper").center();



	showFormContact();
		
	$("input#borrower_organization_name").bind('change', function() {
		
		$("span#organization_name_selection").html($(this).val());
	});
	$("input#borrower_organization_name").trigger('change');


	$("input[name='borrower[displayBorrowerOrganizationName]']").bind('change', function() {
		var y_n = $("input[name='borrower[displayBorrowerOrganizationName]']:checked").val();
		
		
		if (y_n == 1) {
			$("span#displayBorrowerOrganizationName_selection").html("Yes");
		} else if (y_n == 0) {
			$("span#displayBorrowerOrganizationName_selection").html("No");
		}

		if ((y_n == 1) && ($("#borrower_organization_name").val() == "")) {
			$("span#organization_name_error").text("Please provide an organization name.");
			$("span#organization_name_error").css("visibility", "visible");
		} else {
			$("span#organization_name_error").text("");
			$("span#organization_name_error").css("visibility", "hidden");
		}

	});
	$("input[name='borrower[displayBorrowerOrganizationName]']").trigger('change');
	
	
	$("input[name='borrower[displayBorrowerAddress]']").bind('change', function() {
	var	y_n = $("input[name='borrower[displayBorrowerAddress]']:checked").val();
	if (y_n == 1) {
	if (
		($(".borrower.primary.address_line_1").val() == "") || 
		($(".borrower.primary.postal_code").val() == "") || 
		($(".borrower.primary.city").val() == "") || 
		($(".borrower.primary.country_id option:selected").text() == "Please select")
	) {
		
		$("span#display_address_error").text("Please provide a complete address.");
		$("span#display_address_error").css("visibility", "visible");
		
	} else {
		$("span#display_address_error").text("");
		$("span#display_address_error").css("visibility", "hidden");
	}
	}
	
	});
	$("input[name='borrower[displayBorrowerAddress]']").trigger('change');
	


	$("input[name='borrower[displayBorrowerName]']").bind('change', function() {
    var y_n = $("input[name='borrower[displayBorrowerName]']:checked").val();
	if (y_n == 1) {
	if (
		($("#borrower_first_name").val() == "") || 
		($("#borrower_last_name").val() == "") 
	) {
		
		$("span#public_display_name_error").text("Please provide a complete name.");
		$("span#public_display_name_error").css("visibility", "visible");
	
	} else {
		$("span#public_display_name_error").text("");
		$("span#public_display_name_error").css("visibility", "hidden");
	}
	}  
	
	});
$("input[name='borrower[displayBorrowerName]']").trigger('change');


	$("input[name='borrower[notify_lenders]']").bind('change', function() {
    var y_n = $("input[name='borrower[notify_lenders]']:checked").val();
	if (y_n == 1) {
		$("span#category_notification_selection").text("Yes");
	} else if (y_n == 0) {
		$("span#category_notification_selection").text("No");

	}
	});
$("input[name='borrower[notify_lenders]']").trigger('change');


	$("#borrower_age_18_or_more").bind('change', function() {
		var is_c = $("#borrower_age_18_or_more").is(':checked');
		
		if (is_c == true) {
			$("span#18_selection").html("Yes");
		} else if (is_c == false)  {
			$("span#18_selection").html("No");
		}

	});
	$("#borrower_age_18_or_more").trigger('change');


	$("#borrower_goodwill").bind('change', function() {
		var is_c = $("#borrower_goodwill").is(':checked');
		if (is_c == true) {
			$("span#goodwill_selection").html("Yes");
		} else if (is_c == false){
			$("span#goodwill_selection").html("No");
		}

	});
	$("#borrower_goodwill").trigger('change');

	$("#borrower_borrower_contact_by_home_phone").bind('change', function() {
		if ($("#borrower_borrower_contact_by_home_phone").is(':checked')) {
			$("span#home_phone_contact_permission_selection").html("Yes");
		} else {
			$("span#home_phone_contact_permission_selection").html("No");
		}

	});

	$("#borrower_borrower_contact_by_home_phone").trigger('change');

	$("#borrower_borrower_contact_by_cell_phone").bind('change', function() {
		if ($("#borrower_borrower_contact_by_cell_phone").is(':checked')) {
			$("span#cell_phone_contact_permission_selection").html("Yes");
		} else {
			$("span#cell_phone_contact_permission_selection").html("No");
		}
	});
	$("#borrower_borrower_contact_by_cell_phone").trigger('change');

	$("#borrower_borrower_contact_by_alternative_phone").bind('change', function() {
		if ($("#borrower_borrower_contact_by_alternative_phone").is(':checked')) {
			$("span#alternative_phone_contact_permission_selection").html("Yes");
		} else {
			$("span#alternative_phone_contact_permission_selection").html("No");
		}
	});
	$("#borrower_borrower_contact_by_alternative_phone").trigger('change');

	$("#borrower_borrower_contact_by_Facebook").bind('change', function() {

		$("span#facebook_selection").html($(this).val());
	});
	$("#borrower_borrower_contact_by_Facebook").trigger('change');

	$("#borrower_borrower_contact_by_Twitter").bind('change', function() {

		$("span#twitter_selection").html($(this).val());
	});
	$("#borrower_borrower_contact_by_Twitter").trigger('change');

	$("#borrower_borrower_contact_by_Instagram").bind('change', function() {

		$("span#instagram_selection").html($(this).val());
	});
	$("#borrower_borrower_contact_by_Instagram").trigger('change');

	$("#borrower_borrower_contact_by_LinkedIn").bind('change', function() {

		$("span#linkedin_selection").html($(this).val());
	});

	$("#borrower_borrower_contact_by_LinkedIn").trigger('change');

	$("#borrower_borrower_contact_by_Other_Social_Media").bind('change', function() {

		$("span#other_media_selection").html($(this).val());
	});

	$("#borrower_borrower_contact_by_Other_Social_Media").trigger('change');

	$("#borrower_borrower_contact_by_Other_Social_Media_Access").bind('change', function() {

		$("span#other_media_access_selection").html($(this).val());
	});

	$("#borrower_borrower_contact_by_Other_Social_Media_Access").trigger('change');

	$("#borrower_public_display_home_phone").bind('change', function() {

		if (((($("#borrower_public_display_home_phone").prop('checked'))) ) && ((($("#borrower_home_phone").val() == '')))) {

			$("span#home_phone_error").text("Whoops! Don't forget your home phone.");
			$("span#home_phone_error").css("visibility", "visible");
		} else {

			$("span#home_phone_error").text("");
			$("span#home_phone_error").css("visibility", "hidden");
		}
		if ($("#borrower_public_display_home_phone").prop('checked')) {
			$("span#display_home_phone_selection").html("Yes");
		} else {
			$("span#display_home_phone_selection").html("No");
		}

	});

	$("#borrower_public_display_home_phone").trigger('change');

	$("#borrower_public_display_cell_phone").bind('change', function() {

		if (((($("#borrower_public_display_cell_phone").prop('checked'))) ) && ((($("#borrower_cell_phone").val() == '')))) {

			$("span#cell_phone_error").text("Whoops! Don't forget your cell phone.");
			$("span#cell_phone_error").css("visibility", "visible");
		} else {

			$("span#cell_phone_error").text("");
			$("span#cell_phone_error").css("visibility", "hidden");
		}

		if ($("#borrower_public_display_cell_phone").prop('checked')) {
			$("span#display_cell_phone_selection").html("Yes");
		} else {
			$("span#display_cell_phone_selection").html("No");
		}

	});

	$("#borrower_public_display_cell_phone").trigger('change');

	$("#borrower_public_display_alternative_phone").bind('change', function() {

		if (((($("#borrower_public_display_alternative_phone").prop('checked'))) ) && ((($("#borrower_alternative_phone").val() == '')))) {

			$("span#alternative_phone_error").text("Whoops! Don't forget your alternative phone.");
			$("span#alternative_phone_error").css("visibility", "visible");
		} else {

			$("span#alternative_phone_error").text("");
			$("span#alternative_phone_error").css("visibility", "hidden");
		}
		if ($("#borrower_public_display_alternative_phone").prop('checked')) {
			$("span#display_alternative_phone_selection").html("Yes");
		} else {
			$("span#display_alternative_phone_selection").html("No");
		}
	});

	$("#borrower_public_display_alternative_phone").trigger('change');

	$("#borrower_home_phone").bind('change', function() {

	$("span#home_phone_error").text("");
				$("span#home_phone_error").css("visibility", "hidden");

		if ($("#borrower_home_phone").val() != '') {
			if (($("#borrower_home_phone").val() == $("#borrower_cell_phone").val()) || ($("#borrower_home_phone").val() == $("#borrower_alternative_phone").val())) {

				$("span#home_phone_error").text("Home phone should be distinct from others.");
				$("span#home_phone_error").css("visibility", "visible");
			} 
		}

		if (($("#borrower_home_phone").val() == '') && ($("#borrower_public_display_home_phone").prop('checked') > -1)) {
			$("span#home_phone_error").text("Empty Home phone will not be displayed.");
			$("span#home_phone_error").css("visibility", "visible");
		} 

		$("span#home_phone_contact_selection").html($(this).val());
		$("span#contact_home_phone").html($(this).val());
		$("span#home_phone_selection").html($(this).val());

	});

	$("#borrower_home_phone").trigger('change');

	$("#borrower_cell_phone").bind('change', function() {
$("span#cell_phone_error").text("");
				$("span#cell_phone_error").css("visibility", "hidden");
				
		if ($("#borrower_cell_phone").val() != '') {
			if (($("#borrower_cell_phone").val() == $("#borrower_home_phone").val()) || ($("#borrower_cell_phone").val() == $("#borrower_alternative_phone").val())) {

				$("span#cell_phone_error").text("Cell phone should be distinct from others.");
				$("span#cell_phone_error").css("visibility", "visible");
			} 
		}

		if (($("#borrower_cell_phone").val() == '') && ($("#borrower_public_display_cell_phone").prop('checked') > -1)) {
			$("span#cell_phone_error").text("Empty Cell phone will not be displayed.");
			$("span#cell_phone_error").css("visibility", "visible");
		} 
		$("span#cell_phone_contact_selection").html($(this).val());
		$("span#contact_cell_phone").html($(this).val());
		$("span#cell_phone_selection").html($(this).val());
	});

	$("#borrower_cell_phone").trigger('change');

	$("#borrower_alternative_phone").bind('change', function() {
	$("span#alternative_phone_error").text("");
		$("span#alternative_phone_error").css("visibility", "hidden");
		if ($("#borrower_alternative_phone").val() != '') {
			if (($("#borrower_alternative_phone").val() == $("#borrower_home_phone").val()) || ($("#borrower_alternative_phone").val() == $("#borrower_cell_phone").val())) {

				$("span#alternative_phone_error").text("Alternative phone should be distinct from others.");
				$("span#alternative_phone_error").css("visibility", "visible");
			} 
		}
		if (($("#borrower_alternative_phone").val() == '') && ($("#borrower_public_display_alternative_phone").prop('checked') > -1)) {
			$("span#alternative_phone_error").text("Empty Alternative phone will not be displayed.");
			$("span#alternative_phone_error").css("visibility", "visible");
		} 
		$("span#alternative_phone_contact_selection").html($(this).val());
		$("span#contact_alternative_phone").html($(this).val());
		$("span#alternative_phone_selection").html($(this).val());
	});

	$("#borrower_alternative_phone").trigger('change');

	$("#borrower_category_id").bind('change', function() {
		var cat_cmb = $("select#borrower_category_id option:selected").text();

		if (cat_cmb == "Other") {

			$("#other_category").css("display", "inline-table");

		} else {
			$("#other_category").css('display', 'none');
		}

	});

	$("#borrower_category_id").trigger('change');

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
				$("#image_details").css('display', 'block');
				$("#imagePreview").attr("src", this.result);
				$("img#imagePreview_selection").attr("src", this.result);

			}
		} else {
			$("span#file_image_error").text("You need to select an image file.");
			$("span#file_image_error").css("visibility", "visible");

		}

	});
	$("#l2bimage").trigger('change');

		
	
	$("#borrower_other_describe_yourself").bind('change', function() {
		$("span#contact_describe_id").html($(this).val());
	    			
	});
	$("#borrower_other_describe_yourself").trigger('change');
	
	

	$("select#borrower_contact_describe_id").bind('change', function() {
	
		var contact_describe_id_str = $("select#borrower_contact_describe_id option:selected").text();
		if (contact_describe_id_str == "Other") {
			$("div#other_describe_yourself").css("display", "inline");
			$("span#contact_describe_id").html(contact_describe_id_str);
		} else {
			$("div#other_describe_yourself").css("display", "none");
			$("#borrower_other_describe_yourself").val("");

		}
		if (contact_describe_id_str != "Please select") {
		
		$("span#contact_describe_id").html(contact_describe_id_str);
		
		}
	});
	$("select#borrower_contact_describe_id").trigger('change');


	$("input#borrower_first_name").bind('change', function() {
		$("span#first_name_selection").html($(this).val());
	});
	$("input#borrower_first_name").trigger('change');

	$("input#borrower_mi").bind('change', function() {
		$("span#mi_selection").html($(this).val());
	});
	$("input#borrower_mi").trigger('change');

	$("input#borrower_last_name").bind('change', function() {
		$("span#last_name_selection").html($(this).val());
	});
	$("input#borrower_last_name").trigger('change');

	$("input[name='borrower[displayBorrowerName]']").bind('change', function() {
		var y_n = $("input[name='borrower[displayBorrowerName]']:checked").val();
		if (y_n == 1) {
			$("span#display_name_selection").html("Yes");
		} else if (y_n == 0){
			$("span#display_name_selection").html("No");
		} else {}

	});
	$("input[name='borrower[displayBorrowerName]']").trigger('change');

	$("input[name='borrower[displayBorrowerAddress]']").bind('change', function() {

	/*	$("#postalWithContactAddress").css("display", "none"); */
		var y_n = $("input[name='borrower[displayBorrowerAddress]']:checked").val();
		if (y_n == 1) {
			$("#postalWithContactAddress").css("display", "block");
			$("span#display_address_selection").html("Yes");
		}
		if (y_n == 0) {
		/*	$("#postalWithOutContactAddress").css("display", "block"); */
			$("span#display_address_selection").html("No");
		}

	});
	$("input[name='borrower[displayBorrowerAddress]']").trigger('change');

	$("input[name='borrower[useWhichContactAddress]']").bind('change', function() {

	/*	$("div#contactAddressWhich").css("display", "block");
		$("div#contactAddressOnly").css("display", "block");
		$("div#contactAddressWithAlternative").css("display", "block"); */
		var y_n = $("input[name='borrower[useWhichContactAddress]']:checked").val();
		if (y_n == 0) {
			$("span#useWhichContactAddress_selection").html("Neither Address");
		} else if (y_n == 1) {
			$("span#useWhichContactAddress_selection").html("Either Address");
		} else if (y_n == 2) {
			$("span#useWhichContactAddress_selection").html("Use Alternative");
		} else if (y_n == 3) {
			$("span#useWhichContactAddress_selection").html("Use Contact Address");
		} else {
		}
	});

	$("input[name='borrower[useWhichContactAddress]']").trigger('change');

	$("input[name='borrower[borrower_contact_by_email]']").bind('change', function() {
		$("span#email2_contact_error").css("visibility", "hidden");
		$("span#email2_contact_error").text("");
		var y_n = $("input[name='borrower[borrower_contact_by_email]']:checked").val();
		if (y_n == 0) {
			$("span#borrower_contact_by_email_selection").html("Neither Email");
		} else if (y_n == 1) {
			$("span#borrower_contact_by_email_selection").html("Either Email");
			if ($("#borrower_email_alternative").val() == '') {
				$("span#email2_contact_error").css("visibility", "visible");
				$("span#email2_contact_error").text("Please provide an alternative email");
			} else {
				$("span#email2_contact_error").css("visibility", "hidden");
				$("span#email2_contact_error").text("");
			}
		} else if (y_n == 2) {
			$("span#borrower_contact_by_email_selection").html("Use Alternative Email");
			if ($("#borrower_email_alternative").val() == '') {
				$("span#email2_contact_error").css("visibility", "visible");
				$("span#email2_contact_error").text("Please provide an alternative email");
			} else {
				$("span#email2_contact_error").css("visibility", "hidden");
				$("span#email2_contact_error").text("");
			}

		} else if (y_n == 3) {
			$("span#borrower_contact_by_email_selection").html("Use Login Email");

		} else {
		}

	});
	$("input[name='borrower[borrower_contact_by_email]']").trigger('change');

	$("#borrower_email_alternative").bind('change', function() {
		$("span#email_alternative_selection").html($(this).val());
	});
	$("#borrower_email_alternative").trigger('change');

	$("#borrower_category_id").bind('change', function() {
		var item_cat = $("#borrower_category_id option:selected").text();
		$("span#category_selection").html(item_cat);
	});
	$("#borrower_category_id").trigger('change');

	$("#borrower_other_item_category").bind('change', function() {
		$("span#other_item_category_selection").html($(this).val());
	});
	$("#borrower_other_item_category").trigger('change');

	$("#borrower_item_model").bind('change', function() {
		$("span#item_model_selection").html($(this).val());
	});
	$("#borrower_item_model").trigger('change');

	$("#borrower_item_description").bind('change', function() {
		$("span#item_description_selection").html($(this).val());
	});
	$("#borrower_item_description").trigger('change');

	$("#borrower_item_condition_id").bind('change', function() {
		var item_cat = $("#borrower_item_condition_id option:selected").text();
		$("span#item_condition_selection").html(item_cat);
	});
	$("#borrower_item_condition_id").trigger('change');

	$(".borrower.primary.item_image_caption").bind('change', function() {
		$("span#image_caption_selection").html($(this).val());
	});
	$(".borrower.primary.item_image_caption").trigger('change');

	$("#borrower_item_count").bind('change', function() {
		$("span#item_count_selection").html($(this).val());
	});
	$("#borrower_item_count").trigger('change');

/* Beginning of contact address */

   /*   $("name^='borrower[primary_address]'").trigger('change'); */

	$(".borrower.primary.address_line_1").bind('change', function() {
		address1 = $(this).val();
		$("span#address_1_selection").html($(this).val());
	});
	$(".borrower.primary.address_line_1").trigger('change');

	$(".borrower.primary.address_line_2").bind('change', function() {
		address2 = $(this).val();
		$("span#address_2_selection").html($(this).val());
	});
	$(".borrower.primary.address_line_2").trigger('change');

	$(".borrower.primary.province").bind('change', function() {
		province = $(this).val();
		$("span#province_selection").html($(this).val());

	});
	$(".borrower.primary.province").trigger('change');

	$(".borrower.primary.city").bind('change', function() {
		city = $(this).val();
		$("span#city_selection").html($(this).val());

	});
	$(".borrower.primary.city").trigger('change');

	$(".borrower.primary.postal_code").bind('change', function() {
		postal_code = $(this).val();
		$("span#postal_code_selection").html($(this).val());

	});
	$(".borrower.primary.postal_code").trigger('change');

	$(".borrower.primary.us_state_id").bind('change', function() {

		state_cmb = $(".borrower.primary.state_id option:selected").text();
		
		if (state_cmb != 'Please select') {
		$("span#us_state_selection").html(state_cmb);
		$("span#us_state_selection").html("Region Placeholder");
		}

	});
	$(".borrower.primary.us_state_id").trigger('change');


	$(".borrower.primary.country_id").bind('change', function() {

		var country_text = $(".borrower.primary.country_id option:selected").text();
		$("span#country_selection").html(country_text);
		if ((country_text != 'United States') || (country_text == 'Please select')) {
		$(".borrower.primary.us_state_id option[value='99']" ).attr( "selected", "selected" );
			$("span#us_state_selection").html('');
			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$(".borrower.primary.country_id").trigger('change');

	$(".borrower.primary.region").bind('change', function() {
		$("span#region_selection").html($(this).val());
	});
	$(".borrower.primary.region").trigger('change');
	
	
	
	
	/*Beginning of Alternative Address*/
	
	$("select.borrower.alternative.country_id").bind('change', function() {

		var country_text = $("select.borrower.alternative.country_id option:selected").text();
		$("span#country_alternative_selection").html(country_text);
		if ((country_text != 'United States') || (country_text == 'Please select')) {
		$("select.borrower.alternative.us_state_id option[value='99']" ).attr( "selected", "selected" );
			$("span#state_alternative_selection").html('');
			$("div#choose_us_state_alternative").css("display", "none");
			$("div#provide_country_state_alternative").css("display", "inline");


		} else {

			$("div#provide_country_state_alternative").css("display", "none");
			$("div#choose_us_state_alternative").css("display", "inline");
		}

	});
	$("select.borrower.alternative.country_id").trigger('change');
	
	
	$("input.borrower.alternative.region").bind('change', function() {
		$("span#region_alternative_selection").html($(this).val());
	});
	$("input.borrower.alternative.region").trigger('change');
	
	$("select.borrower.alternative.us_state_id").bind('change', function() {
		var tmpID = $("select.borrower.alternative.us_state_id option:selected").text();
		$("span#state_alternative_selection").html(tmpID);
		});
	$("select.borrower.alternative.us_state_id").trigger('change');



	$(".borrower.alternative.address_line_1").bind('change', function() {
		$("span#address_1_alternative_selection").html($(this).val());
	});
	$(".borrower.alternative.address_line_1").trigger('change');

	$(".borrower.alternative.address_line_2").bind('change', function() {
		$("span#address_2_alternative_selection").html($(this).val());
	});
	$(".borrower.alternative.address_line_2").trigger('change');

	$(".borrower.alternative.province").bind('change', function() {
		$("span#province_alternative_selection").html($(this).val());
	});
	$(".borrower.alternative.province").trigger('change');

	$(".borrower.alternative.city").bind('change', function() {
		$("span#city_alternative_selection").html($(this).val());
	});
	$(".borrower.alternative.city").trigger('change');
	
	$(".borrower.alternative.postal_code").bind('change', function() {
		$("span#postal_code_alternative_selection").html($(this).val());
	});
	$(".borrower.alternative.postal_code").trigger('change');



});

var address1 = "";
var address2 = "";
var city = "";
var province = "";
var postal_code = "";
var state_cmb = "";
var country_cmb = "";

function validateUseWhichBorrowerContactAddress() {
	var return_value = true;
	
	var use_which_ca = $("input[name='borrower[useWhichContactAddress]']:checked").val();
	if ((use_which_ca == 1) || (use_which_ca == 2 )) {

	if	( ($(".borrower.alternative.address_line_1").val() == "") || 
		  ($(".borrower.alternative.postal_code").val() == "") || 
		  ($(".borrower.alternative.city").val() == "") || 
		  ($(".borrower.alternative.country_id option:selected").text() == "Please select"))  {
			return_value = false;
		}	
}	

	return return_value;
}

function saveBAll() {
	


	var validContactInfo = validateContactPreferences();

	var validItem = validateBItem();

	var validContactAdress = validateUseWhichBorrowerContactAddress();

	var validLegal = checkBLegal();

	if (!(validContactInfo)) {
		showFormContact();
		return;
	}

	if (!(validLegal)) {
		showBLegal();

		return;
	}

	if (!(validItem)) {
		showItem();

		return;

	}

 if (!(validContactAdress)){
		alert("You have selected to provide an Alternative address with incomplete content.  Please go to '2. Your Borrowers Contact Preferences' to correct this matter.");
        $("span#whichContactAddressError").css("visibility", "visible");
        $("div#table_alternative_address_input").css("display", "block");
        location.href = "#menu_item_2";
       
        return;
	} else {
		
		$("form.borrower_seeking").submit();
	}
   
	return;
}

function showBLegal() {
	var asd = $(".contact_information");
	asd.css("display", "none");
	hideAllBFormHrefs();
	asd = $("#form_legal");
	asd.css("display", "inline-table");
	$("#menu_item_4").css("display", "inline");
	return false;

}

function validateBItem() {
	var return_value = true;
	var whichType = 'borrower';
	var item_count_element = $("#" + whichType + "_item_count");
	var item_count_value = item_count_element.val();
	var bad_count = isNaN(item_count_value);
	$("span#item_description_error").css("visibility", "hidden");
	$("span#item_count_error").css("visibility", "hidden");
	$("span#item_condition_id_error").css("visibility", "hidden");
	$("span#category_id_error").css("visibility", "hidden");

	if (bad_count) {
		$("span#item_count_error").css("visibility", "visible");
		return_value = false;
	} else if ((parseInt(item_count_value) < 1) || (parseInt(item_count_value) > 100)) {
		$("span#item_count_error").css("visibility", "visible");
		return_value = false;
	}

	if ($("#" + whichType + "_item_description").val() == '') {
		$("span#item_description_error").css("visibility", "visible");
		return_value = false;
	}

	if ($("#" + whichType + "_item_condition_id option:selected").text() == 'Please select') {
		$("span#item_condition_id_error").css("visibility", "visible");
		return_value = false;
	}
	if ($("#" + whichType + "_category_id option:selected").text() == 'Please select') {
		$("span#category_id_error").css("visibility", "visible");
		return_value = false;
	}

	return return_value;
}

function checkBLegal() {

	var notChecked = true;
	var legal_18 = $("#borrower_age_18_or_more");
	var legal_goodwill = $("#borrower_goodwill");

	if (!(legal_18.is(':checked'))) {
		notChecked = false;
		$("span#18_or_more_error").text("You must be 18 years of age.");
		$("span#18_or_more_error").css("visibility", "visible");
	} else {
		$("span#18_or_more_error").text("");
		$("span#18_or_more_error").css("visibility", "hidden");
	}
	if (!(legal_goodwill.is(':checked'))) {
		notChecked = false;
		$("span#goodwill_error").text("You must be acting in goodwill.");
		$("span#goodwill_error").css("visibility", "visible");
	} else {
		$("span#goodwill_error").text("");
		$("span#goodwill_error").css("visibility", "hidden");
	}

	return notChecked;
}

function hideAllBFormHrefs() {

	$("form#lender_item_registration").css("display", "block");
	$(".registration_header").css("display", "inline");
	$("[id^=menu_item_]").css("display", "none");
	$("[id='div_white']").css("display", "none");
	$("div#item_readonly").attr("display", "none");
	$("div#item_readonly").css("display", "none");
	return false;
}

function showFormContact() {
	$(".contact_information").css("display", "none");
	hideAllBFormHrefs();
	$("#form_contact_information").css("display", "block");
	$("#menu_item_1").css("display", "block");
	return false;
}

function showItem() {
	$(".contact_information").css("display", "none");
	hideAllBFormHrefs();
	$("#form_item").css("display", "inline-table");
	$("#menu_item_5").css("display", "inline");
	return false;
}

function showBorrowersContactPreferences() {


    var foundInvalid = validateContactPreferences(); 
      
      var home_phone_contact = $("#borrower_home_phone");
      var cell_phone_contact = $("#borrower_cell_phone");
      var alternative_phone_contact = $("#borrower_alternative_phone");
  
      if ((home_phone_contact.val() == '') && (cell_phone_contact.val() == '') && (alternative_phone_contact.val() == ''))  {
          $("div#byYourPhone").css("display", "none");
      } else {
          $("div#byYourPhone").css("display", "block");
      }
  
      if (home_phone_contact.val() == '') {
          $("div#displayHomePhoneContact").css("display", "none");
          $("div#nodisplayHomePhoneContact").css("display", "block");
      } else {
          $("div#displayHomePhoneContact").css("display", "block");
          $("div#nodisplayHomePhoneContact").css("display", "none");
      }
  
      if (cell_phone_contact.val() == '') {
          $("div#displayCellPhoneContact").css("display", "none");
          $("div#nodisplayCellPhoneContact").css("display", "block");
      } else {
          $("div#displayCellPhoneContact").css("display", "block");
          $("div#nodisplayCellPhoneContact").css("display", "none");
      }
  
      if (alternative_phone_contact.val() == '') {
          $("div#displayAlternativePhoneContact").css("display", "none");
          $("div#nodisplayAlternativePhoneContact").css("display", "block");
      } else {
          $("div#displayAlternativePhoneContact").css("display", "block");
          $("div#nodisplayAlternativePhoneContact").css("display", "none");
     
   }
     if (foundInvalid) {
          $(".contact_information").css("display", "none");
          hideAllBFormHrefs();
  
          $("#form_contact_information").css("display", "inline-table");
          $("#menu_item_1").css("display", "inline");
          $("#form_borrower_preference").css("display", "inline-table");
          $("#menu_item_2").css("display", "inline");
      } else {
    
          location.href = "#menu_item_1";
     } 
      return false ;
      
     
}

/* Returns foundInvalid */
function validateContactPreferences() {
	var foundInvalid = true;
    var y_n = "";
	$("span.error").css("visibility", "hidden");
	
	y_n = $("input[name='borrower[displayBorrowerOrganizationName]']:checked").val();
	if ((y_n == 1) && ($("#borrower_organization_name").val() == "")) {
		$("span#organization_name_error").text("Please provide an organization name.");
		$("span#organization_name_error").css("visibility", "visible");
		foundInvalid = false;
	} 

	y_n = $("input[name='borrower[displayBorrowerAddress]']:checked").val();
	if (y_n == 1) {
	if (
		($(".borrower.primary.address_line_1").val() == "") || 
		($(".borrower.primary.postal_code").val() == "") || 
		($(".borrower.primary.city").val() == "") || 
		($(".borrower.primary.country_id option:selected").text() == "Please select")
	) {
		
		$("span#display_address_error").text("Please provide a complete address.");
		$("span#display_address_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	}
	
	
	y_n = $("input[name='borrower[displayBorrowerName]']:checked").val();
	if (y_n == 1) {
	if (
		($("#borrower_first_name").val() == "") || 
		($("#borrower_last_name").val() == "") 
	) {
		
		$("span#public_display_name_error").text("Please provide a complete name.");
		$("span#public_display_name_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	}
		
	
	
	if ($("select#borrower_contact_describe_id option:selected").text() == "Please select") {
		$("#describe_yourself_combo_error").text("Please choose an option to describe yourself.");
		$("#describe_yourself_combo_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if (($("select#borrower_contact_describe_id option:selected").text() == "Other") && ($("#borrower_other_describe_yourself").val() == "")) {

		$("#other_describe_yourself_error").text("Other description is required.");
		$("#other_describe_yourself_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#other_describe_yourself_error").text("");
		$("#other_describe_yourself_error").css("visibility", "hidden");
	}

	if ($("#borrower_first_name").val() == "") {
		$("#first_name_error").text("First name is required.");
		$("#first_name_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#borrower_last_name").val() == "") {
		$("#last_name_error").text("Last name is required.");
		$("#last_name_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".borrower.primary.city").val() == "") {
		$("#city_error").text("City name is required.");
		$("#city_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".borrower.primary.address_line_1").val() == "") {
		$("#address_line_1_error").text("Address Line 1 is required.");
		$("#address_line_1_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".borrower.primary.postal_code").val() != "") {
		var re = /^[A-Za-z]+$/;
		var hold_postal_value = $(".borrower.primary.postal_code").val();
		if (re.test(hold_postal_value)) {
			$("#postal_code_error").text("Please verify your postal code, it should contain at least one numeric value.");
			$("#postal_code_error").css("visibility", "visible");
			foundInvalid = false;
		}
	}

	if ($(".borrower.primary.postal_code").val() == "") {
		$("#postal_code_error").text("Postal code is required.");
		$("#postal_code_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".borrower.primary.country_id option:selected").text() == "Please select") {
		$("#country_error").text("Please select a Country.");
		$("#country_error").css("visibility", "visible");
		foundInvalid = false;
	}



if ( ($(".borrower.primary.country_id option:selected").text() != "Please select")  || ($(".borrower.primary.country_id option:selected").text() != "United States") ) {  
		if  ($("input#borrower.primary.region").val() == "") {
			$("#state_error").text("Please provide a Region.");
			$("#state_error").css("visibility", "visible");
			foundInvalid = false;
	}
	}
	
	if ((($(".borrower.primary.us_state_id option:selected").text() == "Please select") || ($(".borrower.primary.us_state_id option:selected").val() == '')) && ($(".borrower.primary.country_id option:selected").text() == "United States")) {

		$("#state_error").text("Please select a State.");
		$("#state_error").css("visibility", "visible");

		foundInvalid = false;
	} 
	
	return foundInvalid;
	
	}
function showReview() {

	var asd = $("div#item_readonly");
	asd.css("display", "inline");
	asd = $("form.lender_item_registration");
	asd.css("display", "none");
	return false;

}