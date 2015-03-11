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

function showRegistration() {
	window.location.replace("/user/register");
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

function submitLogin() {
	foundInvalid = true;
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
	foundInvalid = true;
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




