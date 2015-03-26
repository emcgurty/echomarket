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
    showFormContact();
    
    
    $( "input#lenders_organization_name" ).bind( 'change', function() {
        $("span#organization_name_selection").html($(this).val());
    });
    $("input#lenders_organization_name").trigger('change');


    $("input[name='lenders[displayLenderOrganizationName]']").bind('change', function() {
        var y_n = $("input[name='lenders[displayLenderOrganizationName]']:checked").val();
        if (y_n == 1) {
            $("span#displayLenderOrganizationName_selection").html("Yes");
        } else {
            $("span#displayLenderOrganizationName_selection").html("No");
        }

        if ((y_n == 1) && ($("#lenders_organization_name").val() == "")) {
            $("span#organization_name_error").text("Please provide an organization name.");
            $("span#organization_name_error").css("visibility", "visible");
        } else {
            $("span#organization_name_error").text("");
            $("span#organization_name_error").css("visibility", "hidden");
        }
               

    });
    $("input[name='lenders[displayLenderOrganizationName]']").trigger('change');

   	$("input[name='lenders[displayLenderAddress]']").bind('change', function() {
	var	y_n = $("input[name='lenders[displayLenderAddress]']:checked").val();
	if (y_n == 1) {
	if (
		($("#lenders_address_line_1").val() == "") || 
		($("#lenders_postal_code").val() == "") || 
		($("#lenders_city").val() == "") || 
		($("#lenders_country_id option:selected").text() == "Please select")
	) {
		
		$("span#display_address_error").text("Please provide a complete address.");
		$("span#display_address_error").css("visibility", "visible");
		
	} else {
		$("span#display_address_error").text("");
		$("span#display_address_error").css("visibility", "hidden");
	}
	}
	});
	$("input[name='lenders[displayLenderAddress]']").trigger('change');
	


	$("input[name='lenders[displayLenderName]']").bind('change', function() {
    	var y_n = $("input[name='lenders[displayLenderName]']:checked").val();
	if (y_n == 1) {
	if (
		($("input#lenders_first_name").val() == "") || 
		($("input#lender_last_name").val() == "") 
	) {
		
		$("span#public_display_name_error").text("Please provide a complete name.");
		$("span#public_display_name_error").css("visibility", "visible");
	
	} else {
		$("span#public_display_name_error").text("");
		$("span#public_display_name_error").css("visibility", "hidden");
	}
	}
	});
$("input[name='lenders[displayLenderName]']").trigger('change');
    	
	
	
    $("#lenders_age_18_or_more").bind('change', function() {
        if ($("#lenders_age_18_or_more").is (':checked')) {
            $("span#18_selection").html("Yes");
        } else {
            $("span#18_selection").html("No");
        }

    });
    $("#lenders_age_18_or_more").trigger('change');

    $("#lenders_goodwill").bind('change', function() {
        if ($("#lenders_goodwill").is (':checked')) {
            $("span#goodwill_selection").html("Yes");
        } else {
            $("span#goodwill_selection").html("No");
        }

    });
    $("#lenders_goodwill").trigger('change');

    $("#lenders_borrower_contact_by_home_phone").bind('change', function() {
        if ($("#lenders_borrower_contact_by_home_phone").is (':checked')) {
            $("span#home_phone_contact_permission_selection").html("Yes");
        } else {
            $("span#home_phone_contact_permission_selection").html("No");
        }
    });
    $("#lenders_borrower_contact_by_home_phone").trigger('change');


    $("#lenders_borrower_contact_by_cell_phone").bind('change', function() {
        if ($("#lenders_borrower_contact_by_cell_phone").is (':checked')) {
            $("span#cell_phone_contact_permission_selection").html("Yes");
        } else {
            $("span#cell_phone_contact_permission_selection").html("No");
        }
    });
    $("#lenders_borrower_contact_by_cell_phone").trigger('change');

    $("#lenders_borrower_contact_by_alternative_phone").bind('change', function() {
        if ($("#lenders_borrower_contact_by_alternative_phone").is (':checked')) {
            $("span#alternative_phone_contact_permission_selection").html("Yes");
        } else {
            $("span#alternative_phone_contact_permission_selection").html("No");
        }
    });
    $("#lenders_borrower_contact_by_alternative_phone").trigger('change');


    $("#lenders_borrower_contact_by_Facebook").bind('change', function() {

        $("span#facebook_selection").html($(this).val());
    });
    $("#lenders_borrower_contact_by_Facebook").trigger('change');

    $("#lenders_borrower_contact_by_Twitter").bind('change', function() {

        $("span#twitter_selection").html($(this).val());
    });
    $("#lenders_borrower_contact_by_Twitter").trigger('change');

    $("#lenders_borrower_contact_by_Instagram").bind('change', function() {

        $("span#instagram_selection").html($(this).val());
    });
    $("#lenders_borrower_contact_by_Instagram").trigger('change');

    $("#lenders_borrower_contact_by_LinkedIn").bind('change', function() {

        $("span#linkedin_selection").html($(this).val());
    });

    $("#lenders_borrower_contact_by_LinkedIn").trigger('change');

    $("#lenders_borrower_contact_by_Other_Social_Media").bind('change', function() {

        $("span#other_media_selection").html($(this).val());
    });

    $("#lenders_borrower_contact_by_Other_Social_Media").trigger('change');

    $("#lenders_borrower_contact_by_Other_Social_Media_Access").bind('change', function() {

        $("span#other_media_access_selection").html($(this).val());
    });
    
    $("#lenders_borrower_contact_by_Other_Social_Media_Access").trigger('change');

    $("input[name='lenders[b_comes_to_which_address]']").bind('change', function() {

        var y_n = $("input[name='lenders[b_comes_to_which_address]']:checked").val();
        if (y_n == 0) {
            $("span#borrower_comes_to_which_address_selection").html("Neither Address");
        } else if (y_n == 1){
            $("span#borrower_comes_to_which_address_selection").html("Either Address");
        } else if (y_n == 2){
            $("span#borrower_comes_to_which_address_selection").html("Use Alternative");
        } else if (y_n == 3){
            $("span#borrower_comes_to_which_address_selection").html("Use Contact Address");
        } else {}
    });
    $("input[name='lenders[b_comes_to_which_address]']").trigger('change');

    $("input[name='lenders[b_returns_to_which_address]']").bind('change', function() {

        var y_n = $("input[name='lenders[b_returns_to_which_address]']:checked").val();
        if (y_n == 0) {

            $("span#borrower_returns_to_which_address_selection").html("Neither Address");
        } else if (y_n == 1){
            $("span#borrower_returns_to_which_address_selection").html("Either Address");
        } else if (y_n == 2){
            $("span#borrower_returns_to_which_address_selection").html("Use Alternative");
        } else if (y_n == 3){
            $("span#borrower_returns_to_which_address_selection").html("Use Contact Address");
        } else {}
    });

    $("input[name='lenders[b_returns_to_which_address]']").trigger('change');

    $("#lenders_public_display_home_phone").bind('change', function() {

        if (((($("#lenders_public_display_home_phone").prop ('checked'))) ) && ((($("#lenders_home_phone").val() == ''))) ){

            $("span#home_phone_error").text("Whoops! Don't forget your home phone.");
            $("span#home_phone_error").css("visibility", "visible");
        } else {

            $("span#home_phone_error").text("");
            $("span#home_phone_error").css("visibility", "hidden");
        }
        if ($("#lenders_public_display_home_phone").prop ('checked')) {
            $("span#display_home_phone_selection").html("Yes");
        } else {
            $("span#display_home_phone_selection").html("No");
        }

    });

    $("#lenders_public_display_home_phone").trigger('change');

    $("#lenders_public_display_cell_phone").bind('change', function() {

        if (((($("#lenders_public_display_cell_phone").prop('checked'))) ) && ((($("#lenders_cell_phone").val() == ''))) ){

            $("span#cell_phone_error").text("Whoops! Don't forget your cell phone.");
            $("span#cell_phone_error").css("visibility", "visible");
        } else {

            $("span#cell_phone_error").text("");
            $("span#cell_phone_error").css("visibility", "hidden");
        }

        if ($("#lenders_public_display_cell_phone").prop ('checked')) {
            $("span#display_cell_phone_selection").html("Yes");
        } else {
            $("span#display_cell_phone_selection").html("No");
        }

    });

    $("#lenders_public_display_cell_phone").trigger('change');

    $("#lenders_public_display_alternative_phone").bind('change', function() {

        if (((($("#lenders_public_display_alternative_phone").prop ('checked'))) ) && ((($("#lenders_alternative_phone").val() == ''))) ){

            $("span#alternative_phone_error").text("Whoops! Don't forget your alternative phone.");
            $("span#alternative_phone_error").css("visibility", "visible");
        } else {

            $("span#alternative_phone_error").text("");
            $("span#alternative_phone_error").css("visibility", "hidden");
        }
        if ($("#lenders_public_display_alternative_phone").prop ('checked')) {
            $("span#display_alternative_phone_selection").html("Yes");
        } else {
            $("span#display_alternative_phone_selection").html("No");
        }
    });

    $("#lenders_public_display_alternative_phone").trigger('change');



    $("#lenders_home_phone").bind('change', function() {

        if ($("#lenders_home_phone").val() !=  '')  {
            if (($("#lenders_home_phone").val() == $("#lenders_cell_phone").val())  ||
                ($("#lenders_home_phone").val() == $("#lenders_alternative_phone").val()))   {

                $("span#home_phone_error").text("Home phone should be distinct from others.");
                $("span#home_phone_error").css("visibility", "visible");
            } else {
                $("span#home_phone_error").text("");
                $("span#home_phone_error").css("visibility", "hidden");

            }
        }

        if (($("#lenders_home_phone").val() ==  '') && ($("#lenders_public_display_home_phone").prop ('checked') > -1)) {
            $("span#home_phone_error").text("Empty Home phone will not be displayed.");
            $("span#home_phone_error").css("visibility", "visible");
        } else {
            $("span#home_phone_error").text("");
            $("span#home_phone_error").css("visibility", "hidden");

        }
        

        $("span#home_phone_contact_selection").html($(this).val());
        $("span#contact_home_phone").html($(this).val());
        $("span#home_phone_selection").html($(this).val());

    });

    $("#lenders_home_phone").trigger('change');


    $("#lenders_cell_phone").bind('change', function() {

        if ($("#lenders_cell_phone").val() !=  '')  {
            if (($("#lenders_cell_phone").val() == $("#lenders_home_phone").val())  ||
                ($("#lenders_cell_phone").val() == $("#lenders_alternative_phone").val()))   {

                $("span#cell_phone_error").text("Cell phone should be distinct from others.");
                $("span#cell_phone_error").css("visibility", "visible");
            } else {
                $("span#cell_phone_error").text("");
                $("span#cell_phone_error").css("visibility", "hidden");

            }
        }

        if (($("#lenders_cell_phone").val() ==  '') && ($("#lenders_public_display_cell_phone").prop ('checked') > -1)) {
            $("span#cell_phone_error").text("Empty Cell phone will not be displayed.");
            $("span#cell_phone_error").css("visibility", "visible");
        } else {
            $("span#cell_phone_error").text("");
            $("span#cell_phone_error").css("visibility", "hidden");

        }
        $("span#cell_phone_contact_selection").html($(this).val());
        $("span#contact_cell_phone").html($(this).val());
        $("span#cell_phone_selection").html($(this).val());
    });

    $("#lenders_cell_phone").trigger('change');

    $("#lenders_alternative_phone").bind('change', function() {

        if ($("#lenders_alternative_phone").val() !=  '')  {
            if (($("#lenders_alternative_phone").val() == $("#lenders_home_phone").val())  ||
                ($("#lenders_alternative_phone").val() == $("#lenders_cell_phone").val()))   {

                $("span#alternative_phone_error").text("Alternative phone should be distinct from others.");
                $("span#alternative_phone_error").css("visibility", "visible");
            } else {
                $("span#alternative_phone_error").text("");
                $("span#alternative_phone_error").css("visibility", "hidden");

            }
        }
        if (($("#lenders_alternative_phone").val() ==  '') && ($("#lenders_public_display_alternative_phone").prop ('checked') > -1)) {
            $("span#alternative_phone_error").text("Empty Alternative phone will not be displayed.");
            $("span#alternative_phone_error").css("visibility", "visible");
        } else {
            $("span#alternative_phone_error").text("");
            $("span#alternative_phone_error").css("visibility", "hidden");

        }
        $("span#alternative_phone_contact_selection").html($(this).val());
        $("span#contact_alternative_phone").html($(this).val());
        $("span#alternative_phone_selection").html($(this).val());
    });

    $("#lenders_alternative_phone").trigger('change');


    $("#lenders_item_category_id").bind('change', function() {
        var cat_cmb = $( "select#lenders_item_category_id option:selected" ).text();

        if (cat_cmb == "Other") {

            $("#other_category").css("display", "inline-table");

        } else {
            $("#other_category").css('display', 'none');
        }

    });

    $("#lenders_item_category_id").trigger('change');

    
    $("#l2bimage").bind('change', function() {
        $("span#file_image_error").css("visibility", "hidden");
        $("span#file_image_error").text("");

        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) {
            $("span#file_image_error").text("No file selected? Old browser options?");
            $("span#file_image_error").css("visibility", "visible");
            return;
        }

        if (/^image/.test( files[0].type)){
            var reader = new FileReader();
            reader.readAsDataURL(files[0]);

            reader.onloadend = function(){
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

    $("#lenders_other_describe_yourself").bind('change', function() {
        $("span#describe_yourself").html($(this).val());
    });
    $("#lenders_other_describe_yourself").trigger('change');
    

    $("#lenders_describe_yourself").bind('change', function() {
        var describe_yourself_str = $( "#lenders_describe_yourself option:selected" ).text();
        if (describe_yourself_str == "Other") {
            $("div#other_describe_yourself").css("display", "inline");
            $("span#describe_yourself").html(describe_yourself_str);
        } else {
            $("div#other_describe_yourself").css("display", "none");
            $("#lenders_other_describe_yourself").val("");

        }
        $("span#describe_yourself").html(describe_yourself_str);
    });
    $("#lenders_describe_yourself").trigger('change');
 

$("input[name='lenders[useWhichContactAddressAlternative]']").bind('change', function() {
     
       if ($(this).is(':checked')) {
            $("div#table_alternative_address_input").css("display", "block");
        } else {
            $("div#table_alternative_address_input").css("display", "block");
        }
    });
   $("input[name='lenders[useWhichContactAddressAlternative]']").trigger('change');


    $("input#lenders_first_name").bind('change', function() {
        $("span#first_name_selection").html($(this).val());
    });
    $("input#lenders_first_name").trigger('change');
  
    
    $("input#lenders_mi").bind('change', function() {
        $("span#mi_selection").html($(this).val());
    });
    $("input#lenders_mi").trigger('change');


    $("input#lenders_last_name").bind('change', function() {
        $("span#last_name_selection").html($(this).val());
    });
    $("input#lenders_last_name").trigger('change');

    $("input[name='lenders[notify_borrowers]']").bind('change', function() {
        var y_n = $("input[name='lenders[notify_borrowers]']:checked").val();
        if (y_n == 1) {
            $("span#category_notification_selection").html("Yes");
        } else {
            $("span#category_notification_selection").html("No");
        }

    });
    $("input[name='lenders[notify_lenders]']").trigger('change');

    $("input[name='lenders[displayLenderName]']").bind('change', function() {
        var y_n = $("input[name='lenders[displayLenderName]']:checked").val();
        if (y_n == 1) {
            $("span#display_name_selection").html("Yes");
        } else {
            $("span#display_name_selection").html("No");
        }

    });
    $("input[name='lenders[displayLenderName]']").trigger('change');



    $("input[name='lenders[displayLenderAddress]']").bind('change', function() {

        $("#postalWithContactAddress").css("display", "none");
        $("#postalWithOutContactAddress").css("display", "none");
        var y_n = $("input[name='lenders[displayLenderAddress]']:checked").val();
        if (y_n == 1) {
            $("#postalWithContactAddress").css("display", "block");
            $("span#display_address_selection").html("Yes");
        }
        if (y_n == 0) {
            $("#postalWithOutContactAddress").css("display", "block");
            $("span#display_address_selection").html("No");
        }

    });
    $("input[name='lenders[displayLenderAddress]']").trigger('change');



    $("input[name='lenders[useWhichContactAddress]']").bind('change', function() {
        $("div#contactAddressWhich").css("display", "none");
        $("div#contactAddressOnly").css("display", "none");
        $("div#contactAddressWithAlternative").css("display", "none");
        var y_n = $("input[name='lenders[useWhichContactAddress]']:checked").val();
        if (y_n == 0) {
            $("span#useWhichContactAddress_selection").html("Neither Address");
        } else if (y_n == 1){
            $("span#useWhichContactAddress_selection").html("Either Address");
        } else if (y_n == 2){
            $("span#useWhichContactAddress_selection").html("Use Alternative");
        } else if (y_n == 3){
            $("span#useWhichContactAddress_selection").html("Use Contact Address");
        } else {}
    });
    $("input[name='lenders[useWhichContactAddress]']").trigger('change');

    $("input[name='lenders[borrower_contact_by_email]']").bind('change', function() {
        $("span#email2_contact_error").css("visibility", "hidden");
        $("span#email2_contact_error").text("");
        var y_n = $("input[name='lenders[borrower_contact_by_email]']:checked").val();
        if (y_n == 0) {
            $("span#borrower_contact_by_email_selection").html("Neither Email");
        } else if (y_n == 1){
            $("span#borrower_contact_by_email_selection").html("Either Email");
            if ($("#lenders_email_alternative").val() == '') {
                $("span#email2_contact_error").css("visibility", "visible");
                $("span#email2_contact_error").text("Please provide an alternative email");
            } else {
                $("span#email2_contact_error").css("visibility", "hidden");
                $("span#email2_contact_error").text("");
            }
        } else if (y_n == 2){
            $("span#borrower_contact_by_email_selection").html("Use Alternative Email");
            if ($("#lenders_email_alternative").val() == '') {
                $("span#email2_contact_error").css("visibility", "visible");
                $("span#email2_contact_error").text("Please provide an alternative email");
            } else {
                $("span#email2_contact_error").css("visibility", "hidden");
                $("span#email2_contact_error").text("");
            }


        } else if (y_n == 3){
            $("span#borrower_contact_by_email_selection").html("Use Login Email");

        } else {}


    });
    $("input[name='lenders[borrower_contact_by_email]']").trigger('change');


    $("#lenders_email_alternative").bind('change', function() {
        $("span#email_alternative_selection").html($(this).val());
    });
    $("#lenders_email_alternative").trigger('change');

   
    $("#lenders_item_category_id").bind('change', function() {
        var item_cat = $( "#lenders_item_category_id option:selected" ).text();
        $("span#category_selection").html(item_cat);
    });
    $("#lenders_item_category_id").trigger('change');

    $("#lenders_other_item_category").bind('change', function() {
        $("span#other_item_category_selection").html($(this).val());
    });
    $("#lenders_other_item_category").trigger('change');

    $("#lenders_item_model").bind('change', function() {
        $("span#item_model_selection").html($(this).val());
    });
    $("#lenders_item_model").trigger('change');

    $("#lenders_item_description").bind('change', function() {
        $("span#item_description_selection").html($(this).val());
    });
    $("#lenders_item_description").trigger('change');

    $("#lenders_item_condition_id").bind('change', function() {
        var item_cat = $( "#lenders_item_condition_id option:selected" ).text();
        $("span#item_condition_selection").html(item_cat);
    });
    $("#lenders_item_condition_id").trigger('change');

    $("#lenders_item_image_caption").bind('change', function() {
        $("span#image_caption_selection").html($(this).val());
    });
    $("#lenders_item_image_caption").trigger('change');


    $("#lenders_item_count").bind('change', function() {
        $("span#item_count_selection").html($(this).val());
    });
    $("#lenders_item_count").trigger('change');

    $("input[name='lenders[for_free]']").bind('change', function() {
        var y_n = $("input[name='lenders[for_free]']:checked").val();
        if (y_n == 1) {
            $("span#for_free_selection").html("Yes");
        } else if (y_n == 0){
            $("span#for_free_selection").html("No");
        }
    });
    $("input[name='lenders[for_free]']").trigger('change');

    $("input[name='lenders[available_for_purchase]']").bind('change', function() {
        var y_n = $("input[name='lenders[available_for_purchase]']:checked").val();
        if (y_n == 1) {
            $("span#purchase_selection").html("Yes");
        } else if (y_n == 0){
            $("span#purchase_selection").html("No");
        }
    });
    $("input[name='lenders[available_for_purchase]']").trigger('change');

    $("#lenders_available_for_purchase_amount").bind('change', function() {
        $("span#purchase_amount_selection").html($(this).val());
    });
    $("#lenders_available_for_purchase_amount").trigger('change');



  $("#lenders_security_deposit_amount").bind('change', function() {
        $("span#security_deposit_amount_selection").html($(this).val());
    });
    $("#lenders_security_deposit_amount").trigger('change');

  $("input[name='lenders[security_deposit]']").bind('change', function() {
        var y_n = $("input[name='lenders[security_deposit]']:checked").val();
        if (y_n == 1) {
            $("span#security_deposit_selection").html("Yes");
        } else if (y_n == 0){
            $("span#security_deposit_selection").html("No");
        }
  });



    $("input[name='lenders[small_fee]']").bind('change', function() {
        var y_n = $("input[name='lenders[small_fee]']:checked").val();
        if (y_n == 1) {
            $("span#small_borrowing_fee_selection").html("Yes");
        } else if (y_n == 0){
            $("span#small_borrowing_fee_selection").html("No");
        }
    });
    $("input[name='lenders[small_fee]']").trigger('change');

    $("#lenders_small_fee_amount").bind('change', function() {
        $("span#small_fee_amount_selection").html($(this).val());
    });
    $("#lenders_small_fee_amount").trigger('change');

    $("input[name='lenders[available_for_donation]']").bind('change', function() {
        var y_n = $("input[name='lenders[available_for_donation]']:checked").val();
        if (y_n == 1) {
            $("span#donation_selection").html("Yes");
        } else if (y_n == 0){
            $("span#donation_selection").html("No");
        }
    });
    $("input[name='lenders[available_for_donation]']").trigger('change');

    $("input[name='lenders[donate_anonymous]']").bind('change', function() {
        var y_n = $("input[name='lenders[donate_anonymous]']:checked").val();
        if (y_n == 1) {
            $("span#anon_donations_selection").html("Yes");
        } else if (y_n == 0){
            $("span#anon_donations_selection").html("No");
        }
    });
    $("input[name='lenders[donate_anonymous]']").trigger('change');
    
    $("input[name='lenders[trade]']").bind('change', function() {
        var y_n = $("input[name='lenders[trade]']:checked").val();
        if (y_n == 1) {
            $("span#trade_selection").html("Yes");
        } else if (y_n == 0){
            $("span#trade_selection").html("No");
        }
    });
    $("input[name='lenders[trade]']").trigger('change');

    $("#lenders_trade_item").bind('change', function() {
        $("span#trade_item_selection").html($(this).val());
    });
    $("#lenders_trade_item").trigger('change');

    $("input[name='lenders[agreed_number_of_days]']").bind('change', function() {
        var y_n = $("input[name='lenders[agreed_number_of_days]']:checked").val();
        if (y_n == 1) {
            $("span#number_of_days_selection").html("Yes");
        } else if (y_n == 0){
            $("span#number_of_days_selection").html("No");
        }
    });
    $("input[name='lenders[agreed_number_of_days]']").trigger('change');

    $("input[name='lenders[agreed_number_of_hours]']").bind('change', function() {
        var y_n = $("input[name='lenders[agreed_number_of_hours]']:checked").val();
        if (y_n == 1) {
            $("span#number_of_hours_selection").html("Yes");
        } else if (y_n == 0){
            $("span#number_of_hours_selection").html("No");
        }
    });
    $("input[name='lenders[agreed_number_of_hours]']").trigger('change');

    $("input[name='lenders[indefinite_duration]']").bind('change', function() {
        var y_n = $("input[name='lenders[indefinite_duration]']:checked").val();
        if (y_n == 1) {
            $("span#indefinite_selection").html("Yes");
        } else if (y_n == 0){
            $("span#indefinite_selection").html("No");
        }
    });
    $("input[name='lenders[indefinite_duration]']").trigger('change');

    $("input[name='lenders[present_during_borrowing_period]']").bind('change', function() {
        var y_n = $("input[name='lenders[present_during_borrowing_period]']:checked").val();
        if (y_n == 1) {
            $("span#present_during_borrowing_period_selection").html("Yes");
        } else if (y_n == 0){
            $("span#present_during_borrowing_period_selection").html("No");
        }
    });
    $("input[name='lenders[present_during_borrowing_period]']").trigger('change');

    $("input[name='lenders[entire_period]']").bind('change', function() {
        var y_n = $("input[name='lenders[entire_period]']:checked").val();
        if (y_n == 1) {
            $("span#entire_period_selection").html("Yes");
        } else if (y_n == 0){
            $("span#entire_period_selection").html("No");
        }
    });
    $("input[name='lenders[entire_period]']").trigger('change');

    $("input[name='lenders[partial_period]']").bind('change', function() {
        var y_n = $("input[name='lenders[partial_period]']:checked").val();
        if (y_n == 1) {
            $("span#partial_period_selection").html("Yes");
        } else if (y_n == 0){
            $("span#partial_period_selection").html("No");
        }
    });
    $("input[name='lenders[partial_period]']").trigger('change');

    $("input[name='lenders[provide_proper_use_training]']").bind('change', function() {
        var y_n = $("input[name='lenders[provide_proper_use_training]']:checked").val();
        if (y_n == 1) {
            $("span#proper_use_selection").html("Yes");
        } else if (y_n == 0){
            $("span#proper_use_selection").html("No");
        }
    });
    $("input[name='lenders[provide_proper_use_training]']").trigger('change');

    $("#lenders_specific_conditions").bind('change', function() {
        $("span#specific_conditions_selection").html($(this).val());
    });
    $("#lenders_specific_conditions").trigger('change');

  

/* Beginning of Contact Address */

$("input#lenders_address_line_1").bind('change', function() {
		address1 = $(this).val();
		$("span#address_1_selection").html($(this).val());
	});
	$("input#lenders_address_line_1").trigger('change');

	$("#lenders_address_line_2").bind('change', function() {
		address2 = $(this).val();
		$("span#address_2_selection").html($(this).val());
	});
	$("#lenders_address_line_2").trigger('change');

	$("#lenders_province").bind('change', function() {
		province = $(this).val();
		$("span#province_selection").html($(this).val());

	});
	$("#lenders_province").trigger('change');

	$("#lenders_city").bind('change', function() {
		city = $(this).val();
		$("span#city_selection").html($(this).val());

	});
	$("#lenders_city").trigger('change');

	$("#lenders_postal_code").bind('change', function() {
		postal_code = $(this).val();
		$("span#postal_code_selection").html($(this).val());

	});
	$("#lenders_postal_code").trigger('change');

	


	$("select#lenders_state_id").bind('change', function() {

		state_cmb = $("select#lenders_state_id option:selected").text();
		
		if (state_cmb != 'Please select') {
		$("span#us_state_selection").html(state_cmb);
		$("span#state_id_string_selection").html("Region Placeholder");
		}

	});
	$("select#lenders_state_id").trigger('change');


	$("select#lenders_country_id").bind('change', function() {

		var country_text = $("select#lenders_country_id option:selected").text();
		$("span#country_selection").html(country_text);
		if ((country_text != 'United States') || (country_text == 'Please select')) {

			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$("select#lenders_country_id").trigger('change');

	$("input#lenders_state_id_string").bind('change', function() {
		$("span#state_id_string_selection").html($(this).val());
	});
	$("input#lenders_state_id_string").trigger('change');


  /*Beginning of Alternative Address*/
	
	$("select#lenders_country_id_alternative").bind('change', function() {

		var country_text = $("select#lenders_country_id_alternative option:selected").text();
		$("span#country_alternative_selection").html(country_text);
		if ((country_text != 'United States') || (country_text == 'Please select')) {

			$("div#choose_us_state_alternative").css("display", "none");
			$("div#provide_country_state_alternative").css("display", "inline");


		} else {

			$("div#provide_country_state_alternative").css("display", "none");
			$("div#choose_us_state_alternative").css("display", "inline");
		}

	});
	$("select#lenders_country_id_alternative").trigger('change');
	
	
	$("input#lenders_state_id_string_alternative").bind('change', function() {
		$("span#state_id_string_alternativeselection").html($(this).val());
	});
	$("input#lenders_state_id_string_alternative").trigger('change');
	
	$("select#lenders_state_id_alternative").bind('change', function() {
		var tmpID = $("select#lenders_state_id_alternative option:selected").text();
		$("span#state_alternative_selection").html(tmpID);
		});
	$("select#lenders_state_id_alternative").trigger('change');



	$("#lenders_address_line_1_alternative").bind('change', function() {
		$("span#address_1_alternative_selection").html($(this).val());
	});
	$("#lenders_address_line_1_alternative").trigger('change');

	$("#lenders_address_line_2_alternative").bind('change', function() {
		$("span#address_2_alternative_selection").html($(this).val());
	});
	$("#lenders_address_line_2_alternative").trigger('change');

	$("#lenders_province_alternative").bind('change', function() {
		$("span#province_alternative_selection").html($(this).val());
	});
	$("#lenders_province_alternative").trigger('change');

	$("#lenders_city_alternative").bind('change', function() {
		$("span#city_alternative_selection").html($(this).val());
	});
	$("#lenders_city_alternative").trigger('change');
	
	$("#lenders_postal_code_alternative").bind('change', function() {
		$("span#postal_code_alternative_selection").html($(this).val());
	});
	$("#lenders_postal_code_alternative").trigger('change');

});

var whichUserType = "lenders";
var loadLoginForm = false;
var tempstr = "";
var num_rows = 2;
var address1 = "";
var address2 = "";
var city = "";
var province = "";
var postal_code = "";
var state_cmb = "";
var country_cmb = "";
notChecked = true;


function validateUseWhichLenderContactAddress() {
    var return_value = true;
    var whichType = 'lenders';
	var use_which_ca = $("input[name='lenders[useWhichContactAddress]']:checked").val();
	var useAddressAlternative = $('input#lenders_useWhichContactAddressAlternative').is(':checked');
	if ((use_which_ca == 1) || (use_which_ca == 2 || useAddressAlternative )) {

	if	( ($("#lenders_address_line_1_alternative").val() == "") || 
		  ($("#lenders_postal_code_alternative").val() == "") || 
		($("#lenders_city_alternative").val() == "") || 
		($("#lenders_country_id_alternative option:selected").text() == "Please select"))  {
			return_value = false;
		}	
}	

	return return_value;
}

function checkLLegal() {

    var notChecked = true;
    var legal_18 = $("#lenders_age_18_or_more");
    var legal_goodwill = $("#lenders_goodwill");

    if (!(legal_18.is (':checked'))) {
        notChecked = false;
        $("span#18_or_more_error").text("You must be 18 years of age.");
        $("span#18_or_more_error").css("visibility", "visible");
    } else {
        $("span#18_or_more_error").text("");
        $("span#18_or_more_error").css("visibility", "hidden");
    }
    if (!(legal_goodwill.is (':checked'))) {
        notChecked = false;
        $("span#goodwill_error").text("You must be acting in goodwill.");
        $("span#goodwill_error").css("visibility", "visible");
    } else {
        $("span#goodwill_error").text("");
        $("span#goodwill_error").css("visibility", "hidden");
    }

    return notChecked;
}
function validateLItem() {
    var return_value = true;
    var whichType = 'lenders';
    var item_count_element = $("#" + whichType + "_item_count");
    var item_count_value = item_count_element.val();
    var bad_count = isNaN(item_count_value);
    $("span#item_description_error").css("visibility", "hidden");
    $("span#item_count_error").css("visibility", "hidden");
    $("span#item_condition_id_error").css("visibility", "hidden");
    $("span#item_category_id_error").css("visibility", "hidden");

    if (bad_count){
        $("span#item_count_error").css("visibility", "visible");
        return_value = false;
    } else if ((parseInt(item_count_value) < 1) || (parseInt(item_count_value) > 100)){
        $("span#item_count_error").css("visibility", "visible");
        return_value = false;
    }

    if ($("#" + whichType + "_item_description").val() == '') {
        $("span#item_description_error").css("visibility", "visible");
        return_value = false;
    }

    if  ($("#" + whichType + "_item_condition_id option:selected").text() == 'Please select') {
        $("span#item_condition_id_error").css("visibility", "visible");
        return_value = false;
    }
    if  ($("#" + whichType + "_item_category_id option:selected").text() == 'Please select') {
        $("span#item_category_id_error").css("visibility", "visible");
        return_value = false;
    }

    return return_value;
}

function saveAll() {

   
    var validContactInfo = validateContactPreferences();

    var validItem = validateLItem();
     
    var validContactAdress = validateUseWhichLenderContactAddress();
     
    var validLegal = checkLLegal();
 
    if (!(validContactInfo)) {
        showFormContact();
        
        return;
    }


    if (!(validLegal)) {
        showLegal();
        
        return;
    }

    if (!(validItem)) {
        showItem();
        
        return;

    }

    if (!(validContactAdress)){

        $("span#whichContactAddressError").css("visibility", "visible");
        $("div#table_alternative_address_input").css("display", "block");
        location.href = "#menu_item_2";
       
        return;
    } else {
        
        $("#lenders_is_active").val('1');
        $("#lenders_is_saved").val('1');
        $("form.update_lender_offering").submit();
    }
    return;
}


function hideAllFormHrefs() {

    $("form#lender_item_registration").css("display", "block");
    $(".registration_header").css("display", "inline");
    $("[id^=menu_category]").css("display", "none");
    $("[id^=menu_item_]").css("display", "none");
    $("[id='div_white']").css("display", "none");
    $("#item_transfer").css("display", "none");
    $("#terms_of_lending").css("display", "none");
    $("div#item_readonly").attr("display", "none");
    $("div#item_readonly").css("display", "none");
    return false;
}

function showFormContact(){
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("#form_contact_information").css("display", "block");
    $("#menu_item_1").css("display", "block");
    return false;
}


function showItem(){
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("#form_item").css("display", "inline-table");
    $("#menu_item_5").css("display", "inline");
    return false;
}

function showBorrowersContactPreferences() {


    var foundInvalid = validateContactPreferences();
    
    var home_phone_contact = $("#lenders_home_phone");
    var cell_phone_contact = $("#lenders_cell_phone");
    var alternative_phone_contact = $("#lenders_alternative_phone");

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
        hideAllFormHrefs();

        $("#form_contact_information").css("display", "inline-table");
        $("#menu_item_1").css("display", "inline");
        $("#form_borrower_preference").css("display", "inline-table");
        $("#menu_item_2").css("display", "inline");
    } else {
        
        location.href = "#menu_item_1";
    }
    return foundInvalid;
}

function validateContactPreferences() {
	var foundInvalid = true;
    var y_n = "";
	$("span.error").css("visibility", "hidden");
	
	y_n = $("input[name='lenders[displayLenderOrganizationName]']:checked").val();
	if ((y_n == 1) && ($("#lenders_organization_name").val() == "")) {
		$("span#organization_name_error").text("Please provide an organization name.");
		$("span#organization_name_error").css("visibility", "visible");
		foundInvalid = false;
	} 

	y_n = $("input[name='lenders[displayLenderAddress]']:checked").val();
	if (y_n == 1) {
	if (
		($("#lenders_address_line_1").val() == "") || 
		($("#lenders_postal_code").val() == "") || 
		($("#lenders_city").val() == "") || 
		($("#lenders_country_id option:selected").text() == "Please select")
	) {
		
		$("span#display_address_error").text("Please provide a complete address.");
		$("span#display_address_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	}
	
	
	y_n = $("input[name='lenders[displayLenderName]']:checked").val();
	if (y_n == 1) {
	if (
		($("#lenders_first_name").val() == "") || 
		($("#lenders_last_name").val() == "") 
	) {
		
		$("span#public_display_name_error").text("Please provide a complete name.");
		$("span#public_display_name_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	}
		
	
	
	if ($("#lenders_describe_yourself option:selected").text() == "Please select") {
		$("#describe_yourself_combo_error").text("Please chooose an option to describe yourself.");
		$("#describe_yourself_combo_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if (($("#lenders_describe_yourself option:selected").text() == "Other") && ($("#lenders_other_describe_yourself").val() == "")) {

		$("#other_describe_yourself_error").text("Other description is required.");
		$("#other_describe_yourself_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#other_describe_yourself_error").text("");
		$("#other_describe_yourself_error").css("visibility", "hidden");
	}

	if ($("#lenders_first_name").val() == "") {
		$("#first_name_error").text("First name is required.");
		$("#first_name_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#lenders_last_name").val() == "") {
		$("#last_name_error").text("Last name is required.");
		$("#last_name_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#lenders_city").val() == "") {
		$("#city_error").text("City name is required.");
		$("#city_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#lenders_address_line_1").val() == "") {
		$("#address_line_1_error").text("Address Line 1 is required.");
		$("#address_line_1_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#lenders_postal_code").val() != "") {
		var re = /^[A-Za-z]+$/;
		if (re.test(document.getElementById("lenders_postal_code").value)) {
			$("#postal_code_error").text("Please verify your postal code, it should contain at least one numeric value.");
			$("#postal_code_error").css("visibility", "visible");
			foundInvalid = false;
		}
	}

	if ($("#lenders_postal_code").val() == "") {
		$("#postal_code_error").text("Postal code is required.");
		$("#postal_code_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#lenders_country_id option:selected").text() == "Please select") {
		$("#country_error").text("Please select a Country.");
		$("#country_error").css("visibility", "visible");
		foundInvalid = false;
	}



	if ( ($("#lenders_country_id option:selected").text() == "Please select")   &&  ($("input#lenders_state_id_string").val() == "")) {
		$("#state_error").text("Please provide a Region.");
		$("#state_error").css("visibility", "visible");
		foundInvalid = false;
	}
	
	if ((($("#lenders_state_id option:selected").text() == "Please select") || ($("#lenders_state_id option:selected").val() == '')) && ($("#lenders_country_id option:selected").text() == "United States")) {

		$("#state_error").text("Please select a State.");
		$("#state_error").css("visibility", "visible");

		foundInvalid = false;
	}
	
	return foundInvalid;
	
	}



function showLenderToBorrower(){
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("#form_lender_to_borrower").css("display", "inline-table");
    $("#menu_item_3").css("display", "inline");
    return false;
}
function showBorrowerToLender(){
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("#form_borrower_to_lender").css("display", "inline-table");
    $("#menu_item_4").css("display", "inline");
    return false;
}

function showMonetary()
{
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("div#form_monetary").css("display", "inline-table");
    $("#menu_item_6").css("display", "inline");
    return false;

}
function showDuration()
{
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("div#form_duration").css("display", "inline-table");
    $("#menu_item_7").css("display", "inline");
    return false;

}
function showConditions()   {

  
    $(".contact_information").css("display", "none");
    hideAllFormHrefs();
    $("#form_conditions").css("display", "inline-table");
    $("#menu_item_8").css("display", "inline");
    return false;

}


function showLegal()    {
    var asd = $(".contact_information");
    asd.css("display", "none");
    hideAllFormHrefs();
    asd = $("#form_legal");
    asd.css("display", "inline-table");
    $("#menu_item_9").css("display", "inline");
    return false;

}
function showReview() {
    
    var asd = $("div#item_readonly");
    asd.css("display", "inline");
    asd = $("form.lender_item_registration");
    asd.css("display", "none");
    return false;


}





