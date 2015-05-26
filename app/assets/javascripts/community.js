$(document).ready(function() {


    $("span.error").css("visibility", "hidden");
			
		$("#community_password_confirmation").bind('change', function() {

		if ($("#community_password_confirmation").val() != $("#community_password").val()) {
			$("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
			$("#registration_password_confirmation_error").css("visibility", "visible");
		} else {
			
			$("#registration_password_confirmation_error").css("visibility", "hidden");
		}
	});
	$("#community_password_confirmation").trigger('change');
	
	$("select#community_country_id").bind('change', function() {

		var country_text    = $( "select#community_country_id option:selected" ).text();
        if ((country_text != 'United States') || (country_text == 'Please select')) {
               	
			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");
			
			
		} 
		else {
			
			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}
        	
        
	});
	$("select#community_country_id").trigger('change');
	
});

function submitCommunityPasswordReset() {

	   var foundInvalid= true;

        if ($("#community_password_confirmation").val() != $("#community_password").val()) {
            $("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
            $("#registration_password_confirmation_error").css("visibility", "visible");
		 foundInvalid= false;
        } 

        if ($("#community_password_confirmation").val() == "" && $("#community_password").val() == "") {
            $("#registration_password_confirmation_error").text("Please provide a password and confirmation password.");
            $("#registration_password_confirmation_error").css("visibility", "visible");
		 foundInvalid= false;
        }

        if (foundInvalid) {

        $("form.reset_password").submit();

    }
}


function addMember(){
	
	var foundIncomplete = false;
	$("span#incomplete_information_error").css("visibility", "hidden");
	if ($("input#community_members_alias").val() == "") {
		if (($("input#community_members_first_name").val() == "") || ($("input#community_members_last_name").val() == "")) {
			foundIncomplete = true;
			/* incomplete_information_error */
			$("span#incomplete_information_error").text("You need to provide either a Full Name with middle initial optional, or an Alias.");
			$("span#incomplete_information_error").css("visibility", "visible");
		}
	} else if ($("input#community_members_alias").val() != "") {
			if ($("input#community_members_mi").val() != "")  {
			  if (($("input#community_members_first_name").val() == "") || ($("input#community_members_last_name").val() == "")) {
			    foundIncomplete = true;
				$("span#incomplete_information_error").text("You need to provide either a Full Name with middle initial optional, or an Alias.");
				$("span#incomplete_information_error").css("visibility", "visible"); }
			 } else if ($("input#community_members_mi").val() == "")  {
				 if (($("input#community_members_first_name").val() != "") || ($("input#community_members_last_name").val() !== "")) {
			   	 foundIncomplete = true;
				$("span#incomplete_information_error").text("You need to provide either a Full Name with middle initial optional, or an Alias.");
				$("span#incomplete_information_error").css("visibility", "visible"); }
			}	
	}
	if (($("input#community_members_alias").val() != "") && ($("input#community_members_first_name").val() != "") && 
			($("input#community_members_mi").val() != "") && ($("input#community_members_last_name").val() != "")){
				foundIncomplete = true;
				$("span#incomplete_information_error").text("You need to provide either a Full Name with middle initial optional, or an Alias.");
				$("span#incomplete_information_error").css("visibility", "visible");
				
	}
			
	if (!(foundIncomplete)) {
		$("form.register_community").submit();
	}
	
}



function showForgotCommunityPassword() {
	window.location.replace("/community/forgot_community_password");
}

function showForgotCommunityName() {
	window.location.replace("/community/forgot_community_name");
}


function showCommunityRegistration() {
	window.location.replace("/community/new");
}


function submitCommunityRegistration(){
	var foundInvalid = true;
	var foundInvalidNameCI = true;
	 
	 if (($("select#community_country_id option:selected").text() == 'United States') && ($("select#community_us_state_id option:selected").text() == 'Please select')) {
		$("span#state_error").text("A State selection is required.");
		$("span#state_error").css("visibility", "visible");
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameCI = false;
	} else {
		$("span#state_error").text("");
		$("span#state_error").css("visibility", "hidden");
	}
	
	if (foundInvalidNameCI) {
	if (($("select#community_country_id option:selected").text() == 'Please select') && ($("input#community_us_state_id").val() == '')) {
		$("span#country_error").text("A Country with Region information is required.");
		$("span#country_error").css("visibility", "visible");
		foundInvalid = false;
		foundInvalidNameCI = false;
	} else {
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
	}
	}
	
	if (foundInvalidNameCI) {
		if (($("select#community_country_id option:selected").text() == 'Please select') && ($("input#community_us_state_id").val() != '')) {
		$("span#country_error").text("Please select a Country.");
		$("span#country_error").css("visibility", "visible");
		foundInvalid = false;
		foundInvalidNameCI = false;
	} else {
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
	}
	}
	if (foundInvalidNameCI) {
	if (($("select#community_country_id option:selected").text() != 'Please select') && ($("select#community_country_id option:selected").text() != 'United States') && ($("input#community_us_state_id").val() == '')) {
		$("span#country_error").text("Please provide the required Region.");
		$("span#country_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("span#country_error").text("");
		$("span#country_error").css("visibility", "hidden");
	}
	}
	
	if ($("#community_community_name").val() == "") {
		$("#registration_community_name_error").text("Community Name is required.");
		$("#registration_community_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_community_name_error").text("");
		$("#registration_community_name_error").css("visibility", "hidden");
	}
	
	if ($("#community_email").val() == "") {
		$("#registration_community_email_error").text("Community email is required.");
		$("#registration_community_email_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_community_email_error").text("");
		$("#registration_community_email_error").css("visibility", "hidden");
	}
	
	if ($("#community_password_confirmation").val() == "") {
		$("#registration_password_confirmation_error").text("Community password re-entry is required.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_password_confirmation_error").text("");
		$("#registration_password_confirmation_error").css("visibility", "hidden");
	}
	if ($("#community_password").val() == "") {
		$("#registration_password_error").text("Community password is required.");
		$("#registration_password_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_password_error").text("");
		$("#registration_password_error").css("visibility", "hidden");
	}
	
	if ($("#community_password_confirmation").val() != $("#community_password").val()) {
		
		$("#registration_password_confirmation_error").text("Community password and password re-entry must match.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#registration_password_confirmation_error").text("");
		$("#registration_password_confirmation_error").css("visibility", "hidden");
	}
	
	
	if ($("#community_first_name").val() == "") {
		
		$("#first_name_error").text("First name is required.");
		$("#first_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#first_name_error").text("");
		$("#first_name_error").css("visibility", "hidden");
	}
	
	if ($("#community_last_name").val() == "") {
		$("#last_name_error").text("Last name is required.");
		$("#last_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#last_name_error").text("");
		$("#last_name_error").css("visibility", "hidden");
	}
	
	
	if ($("#community_address_line_1").val() == "") {
		$("#address_line_1_error").text("First address line is required.");
		$("#address_line_1_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#address_line_1_error").text("");
		$("#address_line_1_error").css("visibility", "hidden");
	}
	if ($("#community_city").val() == "") {
		$("#city_error").text("City is required.");
		$("#city_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#city_error").text("");
		$("#city_error").css("visibility", "hidden");
	}
	if ($("#community_postal_code").val() == "") {
		$("#postal_code_error").text("Postal Code is required.");
		$("#postal_code_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#postal_code_error").text("");
		$("#postal_code_error").css("visibility", "hidden");
	}
	
	if ($("#community_postal_code").val() != "") {
		var re = /^[A-Za-z]+$/;
		if (re.test(document.getElementById("community_postal_code").value)) {
			$("#postal_code_error").text("Please verify your postal code, it should contain at least one number.");
			$("#postal_code_error").css("visibility", "visible");
			foundInvalid = false;
		} else {
		$("#postal_code_error").text("");
		$("#postal_code_error").css("visibility", "hidden");
	}
	}
	
	
    if (foundInvalid) {

		$("form").submit();
	}
	
	
}

function submitForgotCommunityName() {

	if ($("#community_email").val() == "") {
		$("#forgot_community_email_error").text("Email is required.");
		$("#forgot_community_email_error").css("visibility", "visible");

	} else {
		$("#forgot_community_email_error").text("");
		$("#forgot_community_email_error").css("visibility", "hidden");
		$("form.forgot_community_name").submit();
	}

}


function submitForgotCommunityPassword() {
	

	if ($("#community_email").val() == "") {
		$("#forgot_community_password_email_error").text("Email is required.");
		$("#forgot_community_password_email_error").css("visibility", "visible");

	} else {
	
		$("#forgot_community_password_email_error").text("");
		$("#forgot_community_password_email_error").css("visibility", "hidden");
		$("form.forgot_community_password").submit();
	}
}



function submitCommunityLogin() {
	var foundInvalid = true;
	var foundInvalidNameAlias = true;
	if ($("#community_community_name").val() == "") {
		$("#login_community_name_error").text("Community name is required.");
		$("#login_community_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_community_name_error").text("");
		$("#login_community_name_error").css("visibility", "hidden");
	}

	if ($("#community_password").val() == "") {
		$("#login_community_password_error").text("Password is required.");
		$("#login_community_password_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_community_password_error").text("");
		$("#login_community_password_error").css("visibility", "hidden");
	}
	
	
	if ($("#user_community_alias").val() != "" && ($("#user_community_first_name").val() != "" || $("#user_community_mi").val() != "" || $("#user_community_last_name").val() != "")   ) {
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
	if (($("#user_community_first_name").val() != "") &&  ($("#user_community_last_name").val() == "")   ) {
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
	if (($("#user_community_first_name").val() == "") &&  ($("#user_community_last_name").val() != "")   ) {
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
	if (($("#user_community_first_name").val() == "") &&  ($("#user_community_mi").val() != "") && ($("#user_community_last_name").val() != "")   ) {
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
		if (($("#user_community_first_name").val() != "") &&  ($("#user_community_mi").val() != "") && ($("#user_community_last_name").val() == "")   ) {
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


