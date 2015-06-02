$(document).ready(function() {


    $("span.error").css("visibility", "hidden");
			
	$("#user_password_confirmation").change(function() {

		if ($("#user_password_confirmation").val() != $("#user_password").val()) {
			$("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
			$("#registration_password_confirmation_error").css("visibility", "visible");
		} else {
			
			$("#registration_password_confirmation_error").css("visibility", "hidden");
		}
	});
	
	
	
});

function submitCommunityLogin() {
	var foundInvalid = true;
	var foundInvalidNameAlias = true;
	if ($("#user_community_name").val() == "") {
		$("#login_community_name_error").text("Community name is required.");
		$("#login_community_name_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_community_name_error").text("");
		$("#login_community_name_error").css("visibility", "hidden");
	}

	if ($("#user_community_password").val() == "") {
		$("#login_community_password_error").text("Password is required.");
		$("#login_community_password_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_community_password_error").text("");
		$("#login_community_password_error").css("visibility", "hidden");
	}
	
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
	
	    $("#login_community_mi_error").text("");
		$("#login_community_mi_error").css("visibility", "hidden");
		
		$("#login_community_last_name_error").text("");
		$("#login_community_last_name_error").css("visibility", "hidden");
				
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		
		
		/*
		alert("Alias");
				alert( $(".community.alias").val() == ""          ); 
				alert("FN");
				alert( $(".community.first_name").val() == ""          );
				alert("MI");
				alert( $(".community.mi").val() == ""          );
				alert("LN");
				alert( $(".community.last_name").val() == ""          );*/
		
		
		
	if (!(($(".community.alias").val() == "") && ($(".community.first_name").val() == "") && ($(".community.mi").val() == "")  && ($(".community.last_name").val() == "") )) { 
		
	if (($(".community.alias").val() != "") && ($(".community.first_name").val() != "" || $(".community.mi").val() != "" || $(".community.last_name").val() != "")   ) {
		$("#login_community_alias_error").text("Provide only a fullname or alias.");
		$("#login_community_alias_error").css("visibility", "visible");
		$("#login_community_first_name_error").text("");
		$("#login_community_first_name_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} 
	
		if (foundInvalidNameAlias) {	
		if (($(".community.first_name").val() != "") &&  ($(".community.last_name").val() == "")   ) {
		$("#login_community_first_name_error").text("Provide a last name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} 
	}
	
	if (foundInvalidNameAlias) {	
	if (($(".community.first_name").val() == "") &&  ($(".community.last_name").val() != "")   ) {
		$("#login_community_first_name_error").text("Provide a first name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} 
	}
	
	
	if (foundInvalidNameAlias) {	
	if (($(".community.first_name").val() == "") &&  ($(".community.mi").val() != "") && ($(".community.last_name").val() != "")   ) {
		$("#login_community_first_name_error").text("Provide a first name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
		foundInvalidNameAlias = false;
	} 
	}
	
	if (foundInvalidNameAlias) {	
		if (($(".community.first_name").val() != "") &&  ($(".community.mi").val() != "") && ($(".community.last_name").val() == "")   ) {
		$("#login_community_first_name_error").text("Provide a last name");
		$("#login_community_first_name_error").css("visibility", "visible");
		$("#login_community_alias_error").text("");
		$("#login_community_alias_error").css("visibility", "hidden");
		foundInvalid = false;
	} 
	}
	}
	if (foundInvalid) {

		$("form.login").submit();
	}
}

function submitPasswordReset() {

	
	var foundInvalid = true;

	if ($("#user_password_confirmation").val() != $("#user_password").val()) {
		$("#registration_password_confirmation_error").text("Password and Confirm Password don't match.");
		$("#registration_password_confirmation_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#user_password_confirmation").val() == "" && $("#user_password").val() == "") {
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


function showRegistration() {
	window.location.replace("/user/register");
}

function submitForgotUsername() {

	if ($("#user_email").val() == "") {
		$("#forgot_username_email_error").text("Email is required.");
		$("#forgot_username_email_error").css("visibility", "visible");

	} else {
		$("#forgot_username_email_error").text("");
		$("#forgot_username_email_error").css("visibility", "hidden");
		$("form.forgot_username").submit();
	}

}


function submitForgotPassword() {

	if ($("#user_email").val() == "") {
		$("#reset_password_email_error").text("Email is required.");
		$("#reset_password_email_error").css("visibility", "visible");

	} else {
		$("#reset_password_email_error").text("");
		$("#reset_password_email_error").css("visibility", "hidden");
		$("form.forgot_password").submit();
	}
}

function submitLogin() {
	var foundInvalid = true;
	if ($("#user_username").val() == "") {
		$("#login_username_error").text("Username is required.");
		$("#login_username_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#login_username_error").text("");
		$("#login_username_error").css("visibility", "hidden");
	}

	if ($("#user_password").val() == "") {
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

function submitRegistration() {
	var foundInvalid = false;

	if ($("input[name='user[user_type]']:checked").val() == '') {
		$("#no_type_choice_error").text("Please choose a User Type.");
		$("#no_type_choice_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#no_type_choice_error").text("");
		$("#no_type_choice_error").css("visibility", "hidden");
	}

	if ($("#user_user_alias").val() == "") {
		$("#registration_alias_error").text("User alias is required.");
		$("#registration_alias_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_alias_error").text("");
		$("#registration_alias_error").css("visibility", "hidden");
	}

	if ($("#user_username").val() == "") {
		$("#registration_username_error").text("Username is required.");
		$("#registration_username_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_username_error").text("");
		$("#registration_username_error").css("visibility", "hidden");
	}

	if (($("#user_username").val()).length < 8) {
		$("#registration_username_error").text("Username is too short, 8 - 40 characters required.");
		$("#registration_username_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_username_error").text("");
		$("#registration_username_error").css("visibility", "hidden");
	}
	
		if (($("#user_user_alias").val()).length < 8) {
		$("#registration_alias_error").text("User alias is too short, 8 - 40 characters required.");
		$("#registration_alias_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_alias_error").text("");
		$("#registration_alias_error").css("visibility", "hidden");
	}

	if ($("#user_password").val() == "") {
		$("#registration_password_error").text("Password is required.");
		$("#registration_password_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_password_error").text("");
		$("#registration_password_error").css("visibility", "hidden");
	}

	if (($("#user_password").val()).length < 8) {
		$("#registration_password_error").text("Password is too short, 8 - 16 characters required.");
		$("#registration_password_error").css("visibility", "visible");
		foundInvalid = true;
	} else {
		$("#registration_password_error").text("");
		$("#registration_password_error").css("visibility", "hidden");
	}

	if ($("#user_email").val() == "") {
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




