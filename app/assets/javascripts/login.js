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
     
			
	$("#users_password_confirmation").change(function() {

		if ($("#users_password_confirmation").val() != $("#users_password").val()) {
			$("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
			$("#registration_password_confirmation_error").css("visibility", "visible");
		} else {
			$("#registration_password_confirmation_error").text("");
			$("#registration_password_confirmation_error").css("visibility", "hidden");
		}
	});
	
	$("#communities_password_confirmation").bind('change', function() {

		if ($("#communities_password_confirmation").val() != $("#communities_password").val()) {
			$("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
			$("#registration_password_confirmation_error").css("visibility", "visible");
		} else {
			$("#registration_password_confirmation_error").text("");
			$("#registration_password_confirmation_error").css("visibility", "hidden");
		}
	});
	$("#communities_password_confirmation").trigger('change');
	
	$("select#communities_country_id").bind('change', function() {

		var country_text    = $( "select#communities_country_id option:selected" ).text();
        if ((country_text != 'United States') || (country_text == 'Please select')) {
               	
			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");
			
			
		} 
		else {
			
			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}
        	
        
	});
	$("select#communities_country_id").trigger('change');
	
});

function submitPasswordReset() {

	
	var foundInvalid = true;

	if ($("#users_password_confirmation").val() != $("#users_password").val()) {
		$("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#users_password_confirmation").val() == "" && $("#users_password").val() == "") {
		$("#registration_password_confirmation_error").text("Please provide a password and confirmation password.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if (foundInvalid) {

		
		

		$("form.reset_password").submit();

	}
}

function showLogin() {
	window.location.replace("/user/login");
}

function showForgotPassword() {
	window.location.replace("/user/forgot_password");
}

function showForgotUsername() {
	window.location.replace("/user/forgot_username");
}

function showForgotCommunityPassword() {
	window.location.replace("/community/forgot_community_password");
}

function showForgotCommunityName() {
	window.location.replace("/community/forgot_community_name");
}

function showRegistration() {
	window.location.replace("/user/register");
}

function showCommunityRegistration() {
	window.location.replace("/community/new");
}

function submitForgotUsername() {

	if ($("#users_email").val() == "") {
		$("#forgot_username_email_error").text("Email is required.");
		$("#forgot_username_email_error").css("visibility", "visible");

	} else {
		$("#forgot_username_email_error").text("");
		$("#forgot_username_email_error").css("visibility", "hidden");
		$("form.forgot_username").submit();
	}

}

function submitCommunityRegistration(){
	var foundInvalid = true;
	
	 
	 if (($("select#communities_country_id option:selected").text() == 'United States') && ($("select#communities_state_id option:selected").text() == 'Please select')) {
		$("span#state_error").text("A State selection is required.");
		$("span#state_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("span#state_error").text("");
		$("span#state_error").css("visibility", "hidden");
	}
	
	if (($("select#communities_country_id option:selected").text() == 'Please select') && ($("input#communities_state_id_string").val() == '')) {
		$("span#country_error").text("A Country with Region information is required.");
		$("span#country_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
	}
	
	if (($("select#communities_country_id option:selected").text() == 'Please select') && ($("input#communities_state_id_string").val() != '')) {
		$("span#country_error").text("Please select a Country.");
		$("span#country_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
	}
	
	if (($("select#communities_country_id option:selected").text() != 'Please select') && ($("select#communities_country_id option:selected").text() != 'United States') && ($("input#communities_state_id_string").val() == '')) {
		$("span#country_error").text("Please provide the required Region.");
		$("span#country_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
	}
	
	
	if ($("#communities_community_name").val() == "") {
		$("#registration_community_name_error").text("Community Name is required.");
		$("#registration_community_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_community_name_error").text("");
		$("#registration_community_name_error").css("visibility", "hidden");
	}
	
	if ($("#communities_email").val() == "") {
		$("#registration_community_email_error").text("Community email is required.");
		$("#registration_community_email_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_community_email_error").text("");
		$("#registration_community_email_error").css("visibility", "hidden");
	}
	
	if ($("#communities_password_confirmation").val() == "") {
		$("#registration_password_confirmation_error").text("Community password re-entry is required.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_password_confirmation_error").text("");
		$("#registration_password_confirmation_error").css("visibility", "hidden");
	}
	if ($("#communities_password").val() == "") {
		$("#registration_password_error").text("Community password is required.");
		$("#registration_password_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_password_error").text("");
		$("#registration_password_error").css("visibility", "hidden");
	}
	
	if ($("#communities_password_confirmation").val() != $("#communities_password").val()) {
		
		$("#registration_password_confirmation_error").text("Community password and password re-entry must match.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_password_confirmation_error").text("");
		$("#registration_password_confirmation_error").css("visibility", "hidden");
	}
	
	
	if ($("#communities_first_name").val() == "") {
		
		$("#first_name_error").text("First name is required.");
		$("#first_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#first_name_error").text("");
		$("#first_name_error").css("visibility", "hidden");
	}
	
	if ($("#communities_last_name").val() == "") {
		$("#last_name_error").text("Last name is required.");
		$("#last_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#last_name_error").text("");
		$("#last_name_error").css("visibility", "hidden");
	}
	
	
	if ($("#communities_address_line_1").val() == "") {
		$("#address_line_1_error").text("First address line is required.");
		$("#address_line_1_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#address_line_1_error").text("");
		$("#address_line_1_error").css("visibility", "hidden");
	}
	if ($("#communities_city").val() == "") {
		$("#city_error").text("City is required.");
		$("#city_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#city_error").text("");
		$("#city_error").css("visibility", "hidden");
	}
	if ($("#communities_postal_code").val() == "") {
		$("#postal_code_error").text("Postal Code is required.");
		$("#postal_code_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#postal_code_error").text("");
		$("#postal_code_error").css("visibility", "hidden");
	}
	
    if (foundInvalid) {

		$("form").submit();
	}
	
	
}

function submitForgotCommunityName() {

	if ($("#communities_email").val() == "") {
		$("#forgot_community_email_error").text("Email is required.");
		$("#forgot_community_email_error").css("visibility", "visible");

	} else {
		$("#forgot_community_email_error").text("");
		$("#forgot_community_email_error").css("visibility", "hidden");
		$("form.forgot_community_name").submit();
	}

}

function submitForgotPassword() {

	if ($("#users_email").val() == "") {
		$("#reset_password_email_error").text("Email is required.");
		$("#reset_password_email_error").css("visibility", "visible");

	} else {
		$("#reset_password_email_error").text("");
		$("#reset_password_email_error").css("visibility", "hidden");
		$("form.forgot_password").submit();
	}
}
function submitForgotCommunityPassword() {
	

	if ($("#communities_email").val() == "") {
		$("#forgot_community_password_email_error").text("Email is required.");
		$("#forgot_community_password_email_error").css("visibility", "visible");

	} else {
	
		$("#forgot_community_password_email_error").text("");
		$("#forgot_community_password_email_error").css("visibility", "hidden");
		$("form.forgot_community_password").submit();
	}
}


function submitLogin() {
	var foundInvalid = true;
	if ($("#users_username").val() == "") {
		$("#login_username_error").text("Username is required.");
		$("#login_username_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_username_error").text("");
		$("#login_username_error").css("visibility", "hidden");
	}

	if ($("#users_password").val() == "") {
		$("#login_password_error").text("Password is required.");
		$("#login_password_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_password_error").text("");
		$("#login_password_error").css("visibility", "hidden");
	}
	if (foundInvalid) {

		$("form.login").submit();
	}
}

function submitCommunityLogin() {
	var foundInvalid = true;
	var foundInvalidNameAlias = true;
	if ($("#users_community_name").val() == "") {
		$("#login_community_name_error").text("Community name is required.");
		$("#login_community_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_community_name_error").text("");
		$("#login_community_name_error").css("visibility", "hidden");
	}

	if ($("#users_community_password").val() == "") {
		$("#login_community_password_error").text("Password is required.");
		$("#login_community_password_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_community_password_error").text("");
		$("#login_community_password_error").css("visibility", "hidden");
	}
	
	
	if ($("#users_community_alias").val() != "" && ($("#users_community_first_name").val() != "" || $("#users_community_mi").val() != "" || $("#users_community_last_name").val() != "")   ) {
		$("#login_community_alias_error").text("Provide only a fullname or alias.");
		$("#login_community_alias_error").css("visibility", "visible");
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} else {
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
	}
	
	if (foundInvalidNameAlias) {	
	if (($("#users_community_first_name").val() != "") &&  ($("#users_community_last_name").val() == "")   ) {
		$("#login_community_first_name_error").text("Provide a last name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} else {
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
	}
	}	
	
	if (foundInvalidNameAlias) {	
	if (($("#users_community_first_name").val() == "") &&  ($("#users_community_last_name").val() != "")   ) {
		$("#login_community_first_name_error").text("Provide a first name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} else {
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
	}
	}
	
	
	if (foundInvalidNameAlias) {	
	if (($("#users_community_first_name").val() == "") &&  ($("#users_community_mi").val() != "") && ($("#users_community_last_name").val() != "")   ) {
		$("#login_community_first_name_error").text("Provide a first name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} else {
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
	}
	}
	
	if (foundInvalidNameAlias) {	
		if (($("#users_community_first_name").val() != "") &&  ($("#users_community_mi").val() != "") && ($("#users_community_last_name").val() == "")   ) {
		$("#login_community_first_name_error").text("Provide a last name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
	} else {
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
	}
	}
	if (foundInvalid) {

		$("form.login").submit();
	}
}

function submitRegistration() {
	var foundInvalid = false;

	if ($("input[name='users[user_type]']:checked").val() == '') {
		$("#no_type_choice_error").text("Please choose a User Type.");
		$("#no_type_choice_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#no_type_choice_error").text("");
		$("#no_type_choice_error").css("visibility", "hidden");
	}

	if ($("#users_user_alias").val() == "") {
		$("#registration_alias_error").text("User alias is required.");
		$("#registration_alias_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_alias_error").text("");
		$("#registration_alias_error").css("visibility", "hidden");
	}

	if ($("#users_username").val() == "") {
		$("#registration_username_error").text("Username is required.");
		$("#registration_username_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_username_error").text("");
		$("#registration_username_error").css("visibility", "hidden");
	}

	if (($("#users_username").val()).length < 8) {
		$("#registration_username_error").text("Username is too short, 8 - 16 characters required.");
		$("#registration_username_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_username_error").text("");
		$("#registration_username_error").css("visibility", "hidden");
	}

	if ($("#users_password").val() == "") {
		$("#registration_password_error").text("Password is required.");
		$("#registration_password_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_password_error").text("");
		$("#registration_password_error").css("visibility", "hidden");
	}

	if (($("#users_password").val()).length < 8) {
		$("#registration_password_error").text("Password is too short, 8 - 16 characters required.");
		$("#registration_password_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_password_error").text("");
		$("#registration_password_error").css("visibility", "hidden");
	}

	if ($("#users_email").val() == "") {
		$("#registration_email_error").text("Email is required.");
		$("#registration_email_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_email_error").text("");
		$("#registration_email_error").css("visibility", "hidden");
	}

	if (!(foundInvalid)) {

		$("form.register").submit();

	}
}




