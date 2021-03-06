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
    
    
    $( "input#lender_organization_name" ).bind( 'change', function() {
        $("span#organization_name_selection").html($(this).val());
    });
    $("input#lender_organization_name").trigger('change');

  
    $("input[name='lender[displayLenderOrganizationName]']").bind('change', function() {
        var y_n = $("input[name='lender[displayLenderOrganizationName]']:checked").val();
        if (y_n == 1) {
            $("span#displayLenderOrganizationName_selection").html("Yes");
        } else {
            $("span#displayLenderOrganizationName_selection").html("No");
        }

        if ((y_n == 1) && ($("#lender_organization_name").val() == "")) {
            $("span#organization_name_error").text("Please provide an organization name.");
            $("span#organization_name_error").css("visibility", "visible");
        } else {
            $("span#organization_name_error").text("");
            $("span#organization_name_error").css("visibility", "hidden");
        }
               

    });
    $("input[name='lender[displayLenderOrganizationName]']").trigger('change');

   	$("input[name='Lender[displayLenderAddress]']").bind('change', function() {
	var	y_n = $("input[name='lender[displayLenderAddress]']:checked").val();
	if (y_n == 1) {
	if (
		($(".lender.primary.address_line_1").val() == "") || 
		($(".lender.primary.postal_code").val() == "") || 
		($(".lender.primary.city").val() == "") || 
		($(".lender.primary.country_id option:selected").text() == "Please select")
	) {
		
		$("span#display_address_error").text("Please provide a complete address.");
		$("span#display_address_error").css("visibility", "visible");
		
	} else {
		$("span#display_address_error").text("");
		$("span#display_address_error").css("visibility", "hidden");
	}
	}
	
	});
	$("input[name='lender[displayLenderAddress]']").trigger('change');
	
	$("input[name='lender[displayLenderName]']").bind('change', function() {
		
    var y_n = $("input[name='lender[displayLenderName]']:checked").val();
	if (y_n == 1) {
		 $("span#display_name_selection").html("Yes");
			if (
				($("input#lender_first_name").val() == "") || 
				($("input#lender_last_name").val() == "") 
			) {
				
				$("span#public_display_name_error").text("Please provide a complete name.");
				$("span#public_display_name_error").css("visibility", "visible");
			
			} else {
				$("span#public_display_name_error").text("");
				$("span#public_display_name_error").css("visibility", "hidden");
			}
	} else if (y_n == 0) {
		 $("span#display_name_selection").html("No");
	}
	
	});
$("input[name='lender[displayLenderName]']").trigger('change');

$("#lender_age_18_or_more").bind('change', function() {
        if ($("#lender_age_18_or_more").is (':checked')) {
            $("span#18_selection").html("Yes");
        } else {
            $("span#18_selection").html("No");
        }

    });
    $("#lender_age_18_or_more").trigger('change');

    $("#lender_goodwill").bind('change', function() {
        if ($("#lender_goodwill").is (':checked')) {
            $("span#goodwill_selection").html("Yes");
        } else {
            $("span#goodwill_selection").html("No");
        }

    });
    $("#lender_goodwill").trigger('change');

    $("#lender_borrower_contact_by_home_phone").bind('change', function() {
        if ($("#lender_borrower_contact_by_home_phone").is (':checked')) {
            $("span#home_phone_contact_permission_selection").html("Yes");
        } else {
            $("span#home_phone_contact_permission_selection").html("No");
        }
    });
    $("#lender_borrower_contact_by_home_phone").trigger('change');


    $("#lender_borrower_contact_by_cell_phone").bind('change', function() {
        if ($("#lender_borrower_contact_by_cell_phone").is (':checked')) {
            $("span#cell_phone_contact_permission_selection").html("Yes");
        } else {
            $("span#cell_phone_contact_permission_selection").html("No");
        }
    });
    $("#lender_borrower_contact_by_cell_phone").trigger('change');

    $("#lender_borrower_contact_by_alternative_phone").bind('change', function() {
        if ($("#lender_borrower_contact_by_alternative_phone").is (':checked')) {
            $("span#alternative_phone_contact_permission_selection").html("Yes");
        } else {
            $("span#alternative_phone_contact_permission_selection").html("No");
        }
    });
    $("#lender_borrower_contact_by_alternative_phone").trigger('change');


    $("#lender_borrower_contact_by_Facebook").bind('change', function() {

        $("span#facebook_selection").html($(this).val());
    });
    $("#lender_borrower_contact_by_Facebook").trigger('change');

    $("#lender_borrower_contact_by_Twitter").bind('change', function() {

        $("span#twitter_selection").html($(this).val());
    });
    $("#lender_borrower_contact_by_Twitter").trigger('change');

    $("#lender_borrower_contact_by_Instagram").bind('change', function() {

        $("span#instagram_selection").html($(this).val());
    });
    $("#lender_borrower_contact_by_Instagram").trigger('change');

    $("#lender_borrower_contact_by_LinkedIn").bind('change', function() {

        $("span#linkedin_selection").html($(this).val());
    });

    $("#lender_borrower_contact_by_LinkedIn").trigger('change');

    $("#lender_borrower_contact_by_Other_Social_Media").bind('change', function() {

        $("span#other_media_selection").html($(this).val());
    });

    $("#lender_borrower_contact_by_Other_Social_Media").trigger('change');

    $("#lender_borrower_contact_by_Other_Social_Media_Access").bind('change', function() {

        $("span#other_media_access_selection").html($(this).val());
    });
    
    $("#lender_borrower_contact_by_Other_Social_Media_Access").trigger('change');

    $("input[name='lender[b_comes_to_which_address]']").bind('change', function() {

        var y_n = $("input[name='lender[b_comes_to_which_address]']:checked").val();
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
    $("input[name='lender[b_comes_to_which_address]']").trigger('change');

    $("input[name='lender[b_returns_to_which_address]']").bind('change', function() {

        var y_n = $("input[name='lender[b_returns_to_which_address]']:checked").val();
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

    $("input[name='lender[b_returns_to_which_address]']").trigger('change');

    $("#lender_public_display_home_phone").bind('change', function() {

        if (((($("#lender_public_display_home_phone").prop ('checked'))) ) && ((($("#lender_home_phone").val() == ''))) ){

            $("span#home_phone_error").text("Whoops! Don't forget your home phone.");
            $("span#home_phone_error").css("visibility", "visible");
        } else {

            $("span#home_phone_error").text("");
            $("span#home_phone_error").css("visibility", "hidden");
        }
        if ($("#lender_public_display_home_phone").prop ('checked')) {
            $("span#display_home_phone_selection").html("Yes");
        } else {
            $("span#display_home_phone_selection").html("No");
        }

    });

    $("#lender_public_display_home_phone").trigger('change');

    $("#lender_public_display_cell_phone").bind('change', function() {

        if (((($("#lender_public_display_cell_phone").prop('checked'))) ) && ((($("#lender_cell_phone").val() == ''))) ){

            $("span#cell_phone_error").text("Whoops! Don't forget your cell phone.");
            $("span#cell_phone_error").css("visibility", "visible");
        } else {

            $("span#cell_phone_error").text("");
            $("span#cell_phone_error").css("visibility", "hidden");
        }

        if ($("#lender_public_display_cell_phone").prop ('checked')) {
            $("span#display_cell_phone_selection").html("Yes");
        } else {
            $("span#display_cell_phone_selection").html("No");
        }

    });

    $("#lender_public_display_cell_phone").trigger('change');

    $("#lender_public_display_alternative_phone").bind('change', function() {

        if (((($("#lender_public_display_alternative_phone").prop ('checked'))) ) && ((($("#lender_alternative_phone").val() == ''))) ){

            $("span#alternative_phone_error").text("Whoops! Don't forget your alternative phone.");
            $("span#alternative_phone_error").css("visibility", "visible");
        } else {

            $("span#alternative_phone_error").text("");
            $("span#alternative_phone_error").css("visibility", "hidden");
        }
        if ($("#lender_public_display_alternative_phone").prop ('checked')) {
            $("span#display_alternative_phone_selection").html("Yes");
        } else {
            $("span#display_alternative_phone_selection").html("No");
        }
    });

    $("#lender_public_display_alternative_phone").trigger('change');



    $("#lender_home_phone").bind('change', function() {

               $("span#home_phone_error").text("");
                $("span#home_phone_error").css("visibility", "hidden");
        
        if ($("#lender_home_phone").val() !=  '')  {
            if (($("#lender_home_phone").val() == $("#lender_cell_phone").val())  ||
                ($("#lender_home_phone").val() == $("#lender_alternative_phone").val()))   {

                $("span#home_phone_error").text("Home phone should be distinct from others.");
                $("span#home_phone_error").css("visibility", "visible");
            } 
        }

        if (($("#lender_home_phone").val() ==  '') && ($("#lender_public_display_home_phone").prop ('checked') > -1)) {
            $("span#home_phone_error").text("Empty Home phone will not be displayed.");
            $("span#home_phone_error").css("visibility", "visible");
        }         

        $("span#home_phone_contact_selection").html($(this).val());
        $("span#contact_home_phone").html($(this).val());
        $("span#home_phone_selection").html($(this).val());

    });

    $("#lender_home_phone").trigger('change');


    $("#lender_cell_phone").bind('change', function() {

        $("span#cell_phone_error").text("");
        $("span#cell_phone_error").css("visibility", "hidden");
        if ($("#lender_cell_phone").val() !=  '')  {
            if (($("#lender_cell_phone").val() == $("#lender_home_phone").val())  ||
                ($("#lender_cell_phone").val() == $("#lender_alternative_phone").val()))   {

                $("span#cell_phone_error").text("Cell phone should be distinct from others.");
                $("span#cell_phone_error").css("visibility", "visible");
            } 
        }

        if (($("#lender_cell_phone").val() ==  '') && ($("#lender_public_display_cell_phone").prop ('checked') > -1)) {
            $("span#cell_phone_error").text("Empty Cell phone will not be displayed.");
            $("span#cell_phone_error").css("visibility", "visible");
        } 
        $("span#cell_phone_contact_selection").html($(this).val());
        $("span#contact_cell_phone").html($(this).val());
        $("span#cell_phone_selection").html($(this).val());
    });

    $("#lender_cell_phone").trigger('change');

    $("#lender_alternative_phone").bind('change', function() {

          $("span#alternative_phone_error").text("");
          $("span#alternative_phone_error").css("visibility", "hidden");
          if ($("#lender_alternative_phone").val() !=  '')  {
            if (($("#lender_alternative_phone").val() == $("#lender_home_phone").val())  ||
                ($("#lender_alternative_phone").val() == $("#lender_cell_phone").val()))   {

                $("span#alternative_phone_error").text("Alternative phone should be distinct from others.");
                $("span#alternative_phone_error").css("visibility", "visible");
            } 
        }
        if (($("#lender_alternative_phone").val() ==  '') && ($("#lender_public_display_alternative_phone").prop ('checked') > -1)) {
            $("span#alternative_phone_error").text("Empty Alternative phone will not be displayed.");
            $("span#alternative_phone_error").css("visibility", "visible");
        } 
        $("span#alternative_phone_contact_selection").html($(this).val());
        $("span#contact_alternative_phone").html($(this).val());
        $("span#alternative_phone_selection").html($(this).val());
    });

    $("#lender_alternative_phone").trigger('change');


    $("#lender_category_id").bind('change', function() {
        var cat_cmb = $( "select#lender_category_id option:selected" ).text();

        if (cat_cmb == "Other") {

            $("#other_category").css("display", "inline-table");

        } else {
            $("#other_category").css('display', 'none');
        }

    });

    $("#lender_category_id").trigger('change');

    
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

    $("#lender_other_describe_yourself").bind('change', function() {
        $("span#describe_yourself").html($(this).val());
    });
    $("#lender_other_describe_yourself").trigger('change');
    

   	$("select#lender_contact_describe_id").bind('change', function() {
	
		var contact_describe_id_str = $("select#lender_contact_describe_id option:selected").text();
		if (contact_describe_id_str == "Other") {
			$("div#other_describe_yourself").css("display", "inline");
			$("span#contact_describe_id").html(contact_describe_id_str);
		} else {
			$("div#other_describe_yourself").css("display", "none");
			$("#lender_other_describe_yourself").val("");

		}
		if (contact_describe_id_str != "Please select") {
		
		$("span#contact_describe_id").html(contact_describe_id_str);
		
		}
	});
	$("select#lender_contact_describe_id").trigger('change');
 

    $("input#lender_first_name").bind('change', function() {
        $("span#first_name_selection").html($(this).val());
    });
    $("input#lender_first_name").trigger('change');
  
    
    $("input#lender_mi").bind('change', function() {
        $("span#mi_selection").html($(this).val());
    });
    $("input#lender_mi").trigger('change');


    $("input#lender_last_name").bind('change', function() {
        $("span#last_name_selection").html($(this).val());
    });
    $("input#lender_last_name").trigger('change');

    $("input[name='lender[notify_borrowers]']").bind('change', function() {
        var y_n = $("input[name='lender[notify_borrowers]']:checked").val();
        if (y_n == 1) {
            $("span#category_notification_selection").html("Yes");
        } else {
            $("span#category_notification_selection").html("No");
        }

    });
    $("input[name='lender[notify_lenders]']").trigger('change');

  






    $("input[name='lender[useWhichContactAddress]']").bind('change', function() {
      /*  $("div#contactAddressWhich").css("display", "none");
        $("div#contactAddressOnly").css("display", "none");
        $("div#contactAddressWithAlternative").css("display", "none"); */
        var y_n = $("input[name='lender[useWhichContactAddress]']:checked").val();
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
    $("input[name='lender[useWhichContactAddress]']").trigger('change');

    $("input[name='lender[borrower_contact_by_email]']").bind('change', function() {
        $("span#email2_contact_error").css("visibility", "hidden");
        $("span#email2_contact_error").text("");
        var y_n = $("input[name='lender[borrower_contact_by_email]']:checked").val();
        if (y_n == 0) {
            $("span#borrower_contact_by_email_selection").html("Neither Email");
        } else if (y_n == 1){
            $("span#borrower_contact_by_email_selection").html("Either Email");
            if ($("#lender_email_alternative").val() == '') {
                $("span#email2_contact_error").css("visibility", "visible");
                $("span#email2_contact_error").text("Please provide an alternative email");
            } else {
                $("span#email2_contact_error").css("visibility", "hidden");
                $("span#email2_contact_error").text("");
            }
        } else if (y_n == 2){
            $("span#borrower_contact_by_email_selection").html("Use Alternative Email");
            if ($("#lender_email_alternative").val() == '') {
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
    $("input[name='lender[borrower_contact_by_email]']").trigger('change');


    $("#lender_email_alternative").bind('change', function() {
        $("span#email_alternative_selection").html($(this).val());
    });
    $("#lender_email_alternative").trigger('change');

   
    $("#lender_category_id").bind('change', function() {
        var item_cat = $( "#lender_category_id option:selected" ).text();
        $("span#category_selection").html(item_cat);
    });
    $("#lender_category_id").trigger('change');

    $("#lender_other_item_category").bind('change', function() {
        $("span#other_item_category_selection").html($(this).val());
    });
    $("#lender_other_item_category").trigger('change');

    $("#lender_item_model").bind('change', function() {
        $("span#item_model_selection").html($(this).val());
    });
    $("#lender_item_model").trigger('change');

    $("#lender_item_description").bind('change', function() {
        $("span#item_description_selection").html($(this).val());
    });
    $("#lender_item_description").trigger('change');

    $("#lender_item_condition_id").bind('change', function() {
        var item_cat = $( "#lender_item_condition_id option:selected" ).text();
        $("span#item_condition_selection").html(item_cat);
    });
    $("#lender_item_condition_id").trigger('change');

    $("#lender_item_image_caption").bind('change', function() {
        $("span#image_caption_selection").html($(this).val());
    });
    $("#lender_item_image_caption").trigger('change');


    $("#lender_item_count").bind('change', function() {
        $("span#item_count_selection").html($(this).val());
    });
    $("#lender_item_count").trigger('change');

    $("input[name='lender[for_free]']").bind('change', function() {
        var y_n = $("input[name='lender[for_free]']:checked").val();
        if (y_n == 1) {
            $("span#for_free_selection").html("Yes");
        } else if (y_n == 0){
            $("span#for_free_selection").html("No");
        }
    });
    $("input[name='lender[for_free]']").trigger('change');

    $("input[name='lender[available_for_purchase]']").bind('change', function() {
        var y_n = $("input[name='lender[available_for_purchase]']:checked").val();
        if (y_n == 1) {
            $("span#purchase_selection").html("Yes");
        } else if (y_n == 0){
            $("span#purchase_selection").html("No");
        }
    });
    $("input[name='lender[available_for_purchase]']").trigger('change');

    $("#lender_available_for_purchase_amount").bind('change', function() {
        $("span#purchase_amount_selection").html($(this).val());
    });
    $("#lender_available_for_purchase_amount").trigger('change');



  $("#lender_security_deposit_amount").bind('change', function() {
        $("span#security_deposit_amount_selection").html($(this).val());
    });
    $("#lender_security_deposit_amount").trigger('change');

  $("input[name='lender[security_deposit]']").bind('change', function() {
        var y_n = $("input[name='lender[security_deposit]']:checked").val();
        if (y_n == 1) {
            $("span#security_deposit_selection").html("Yes");
        } else if (y_n == 0){
            $("span#security_deposit_selection").html("No");
        }
  });



    $("input[name='lender[small_fee]']").bind('change', function() {
        var y_n = $("input[name='lender[small_fee]']:checked").val();
        if (y_n == 1) {
            $("span#small_borrowing_fee_selection").html("Yes");
        } else if (y_n == 0){
            $("span#small_borrowing_fee_selection").html("No");
        }
    });
    $("input[name='lender[small_fee]']").trigger('change');

    $("#lender_small_fee_amount").bind('change', function() {
        $("span#small_fee_amount_selection").html($(this).val());
    });
    $("#lender_small_fee_amount").trigger('change');

    $("input[name='lender[available_for_donation]']").bind('change', function() {
        var y_n = $("input[name='lender[available_for_donation]']:checked").val();
        if (y_n == 1) {
            $("span#donation_selection").html("Yes");
        } else if (y_n == 0){
            $("span#donation_selection").html("No");
        }
    });
    $("input[name='lender[available_for_donation]']").trigger('change');

    $("input[name='lender[donate_anonymous]']").bind('change', function() {
        var y_n = $("input[name='lender[donate_anonymous]']:checked").val();
        if (y_n == 1) {
            $("span#anon_donations_selection").html("Yes");
        } else if (y_n == 0){
            $("span#anon_donations_selection").html("No");
        }
    });
    $("input[name='lender[donate_anonymous]']").trigger('change');
    
    $("input[name='lender[trade]']").bind('change', function() {
        var y_n = $("input[name='lender[trade]']:checked").val();
        if (y_n == 1) {
            $("span#trade_selection").html("Yes");
        } else if (y_n == 0){
            $("span#trade_selection").html("No");
        }
    });
    $("input[name='lender[trade]']").trigger('change');

    $("#lender_trade_item").bind('change', function() {
        $("span#trade_item_selection").html($(this).val());
    });
    $("#lender_trade_item").trigger('change');


   $("input[name='lender[thirdPartyPresenceL2B]']").bind('change', function() {
        var y_n = $("input[name='lender[thirdPartyPresenceL2B]']:checked").val();
        if (y_n == 1) {
            $("span#l2b_third_party_selection").html("Yes");
        } else if (y_n == 0){
            $("span#l2b_third_party_selection").html("No");
        }
    });
    $("input[name='lender[thirdPartyPresenceL2B]']").trigger('change');  

   $("input[name='lender[lenderThirdPartyChoiceL2B]']").bind('change', function() {
        var y_n = $("input[name='lender[lenderThirdPartyChoiceL2B]']:checked").val();
        if (y_n == 1) {
            $("span#l2b_your_choice_delivery_selection").html("Yes");
        } else if (y_n == 0){
            $("span#l2b_your_choice_delivery_selection").html("No");
        }
    });
    $("input[name='lender[lenderThirdPartyChoiceL2B]']").trigger('change');

 $("input[name='lender[thirdPartyPresenceB2L]']").bind('change', function() {
        var y_n = $("input[name='lender[thirdPartyPresenceB2L]']:checked").val();
        if (y_n == 1) {
            $("span#b2l_third_party_present_selection").html("Yes");
        } else if (y_n == 0){
            $("span#b2l_third_party_present_selection").html("No");
        }
    });
    $("input[name='lender[thirdPartyPresenceB2L]']").trigger('change');

 $("input[name='lender[lenderThirdPartyChoiceB2L]']").bind('change', function() {
        var y_n = $("input[name='lender[lenderThirdPartyChoiceB2L]']:checked").val();
        if (y_n == 1) {
            $("span#b2l_third_your_choice_selection").html("Yes");
        } else if (y_n == 0){
            $("span#b2l_third_your_choice_selection").html("No");
        }
    });
    $("input[name='lender[lenderThirdPartyChoiceB2L]']").trigger('change');

 $("input[name='lender[agreedThirdPartyChoiceB2L]']").bind('change', function() {
        var y_n = $("input[name='lender[agreedThirdPartyChoiceB2L]']:checked").val();
        if (y_n == 1) {
            $("span#b2l_third_mutual_selection").html("Yes");
        } else if (y_n == 0){
            $("span#b2l_third_mutual_selection").html("No");
        }
    });
    $("input[name='lender[agreedThirdPartyChoiceB2L]']").trigger('change');







   $("input[name='lender[willPickUpPreferredLocationB2L]']").bind('change', function() {
        var y_n = $("input[name='lender[willPickUpPreferredLocationB2L]']:checked").val();
        if (y_n == 1) {
            $("span#borrower_pick_up_selection").html("Yes");
        } else if (y_n == 0){
            $("span#borrower_pick_up_selection").html("No");
        }
    });
    $("input[name='lender[willPickUpPreferredLocationB2L]']").trigger('change');

   $("input[name='lender[agreedThirdPartyChoiceL2B]']").bind('change', function() {
        var y_n = $("input[name='lender[agreedThirdPartyChoiceL2B]']:checked").val();
        if (y_n == 1) {
            $("span#l2b_agreed_delivery_selection").html("Yes");
        } else if (y_n == 0){
            $("span#l2b_agreed_delivery_selection").html("No");
        }
    });
    $("input[name='lender[agreedThirdPartyChoiceL2B]']").trigger('change');










 $("input[name='lender[meetBorrowerAtAgreedB2L]']").bind('change', function() {
        var y_n = $("input[name='lender[meetBorrowerAtAgreedB2L]']:checked").val();
        if (y_n == 1) {
            $("span#b2lborrower_returns_to_agreed_selection").html("Yes");
        } else if (y_n == 0){
            $("span#b2lborrower_returns_to_agreed_selection").html("No");
        }
    });
    $("input[name='lender[meetBorrowerAtAgreedB2L]']").trigger('change');

  $("input[name='lender[willDeliverToBorrowerPreferredL2B]']").bind('change', function() {
        var y_n = $("input[name='lender[willDeliverToBorrowerPreferredL2B]']:checked").val();
        if (y_n == 1) {
            $("span#l2b_preferred_selection").html("Yes");
        } else if (y_n == 0){
            $("span#l2b_preferred_selection").html("No");
        }
    });
    $("input[name='lender[willDeliverToBorrowerPreferredL2B]']").trigger('change');

 $("input[name='lender[meetBorrowerAtAgreedL2B]']").bind('change', function() {
        var y_n = $("input[name='lender[meetBorrowerAtAgreedL2B]']:checked").val();
        if (y_n == 1) {
            $("span#l2b_agreed_selection").html("Yes");
        } else if (y_n == 0){
            $("span#l2b_agreed_selection").html("No");
        }
    });
    $("input[name='lender[meetBorrowerAtAgreedL2B]']").trigger('change');

    $("input[name='lender[agreed_number_of_days]']").bind('change', function() {
        var y_n = $("input[name='lender[agreed_number_of_days]']:checked").val();
        if (y_n == 1) {
            $("span#number_of_days_selection").html("Yes");
        } else if (y_n == 0){
            $("span#number_of_days_selection").html("No");
        }
    });
    $("input[name='lender[agreed_number_of_days]']").trigger('change');

    $("input[name='lender[agreed_number_of_hours]']").bind('change', function() {
        var y_n = $("input[name='lender[agreed_number_of_hours]']:checked").val();
        if (y_n == 1) {
            $("span#number_of_hours_selection").html("Yes");
        } else if (y_n == 0){
            $("span#number_of_hours_selection").html("No");
        }
    });
    $("input[name='lender[agreed_number_of_hours]']").trigger('change');

    $("input[name='lender[indefinite_duration]']").bind('change', function() {
        var y_n = $("input[name='lender[indefinite_duration]']:checked").val();
        if (y_n == 1) {
            $("span#indefinite_selection").html("Yes");
        } else if (y_n == 0){
            $("span#indefinite_selection").html("No");
        }
    });
    $("input[name='lender[indefinite_duration]']").trigger('change');

    $("input[name='lender[present_during_borrowing_period]']").bind('change', function() {
        var y_n = $("input[name='lender[present_during_borrowing_period]']:checked").val();
        if (y_n == 1) {
            $("span#present_during_borrowing_period_selection").html("Yes");
        } else if (y_n == 0){
            $("span#present_during_borrowing_period_selection").html("No");
        }
    });
    $("input[name='lender[present_during_borrowing_period]']").trigger('change');

    $("input[name='lender[entire_period]']").bind('change', function() {
        var y_n = $("input[name='lender[entire_period]']:checked").val();
        if (y_n == 1) {
            $("span#entire_period_selection").html("Yes");
        } else if (y_n == 0){
            $("span#entire_period_selection").html("No");
        }
    });
    $("input[name='lender[entire_period]']").trigger('change');

    $("input[name='lender[partial_period]']").bind('change', function() {
        var y_n = $("input[name='lender[partial_period]']:checked").val();
        if (y_n == 1) {
            $("span#partial_period_selection").html("Yes");
        } else if (y_n == 0){
            $("span#partial_period_selection").html("No");
        }
    });
    $("input[name='lender[partial_period]']").trigger('change');

    $("input[name='lender[provide_proper_use_training]']").bind('change', function() {
        var y_n = $("input[name='lender[provide_proper_use_training]']:checked").val();
        if (y_n == 1) {
            $("span#proper_use_selection").html("Yes");
        } else if (y_n == 0){
            $("span#proper_use_selection").html("No");
        }
    });
    $("input[name='lender[provide_proper_use_training]']").trigger('change');

    $("#lender_specific_conditions").bind('change', function() {
        $("span#specific_conditions_selection").html($(this).val());
    });
    $("#lender_specific_conditions").trigger('change');

  

//* Beginning of contact address */

   /*   $("name^='lender[primary_address]'").trigger('change'); */

	$(".lender.primary.address_line_1").bind('change', function() {
		address1 = $(this).val();
		$("span#address_1_selection").html($(this).val());
	});
	$(".lender.primary.address_line_1").trigger('change');

	$(".lender.primary.address_line_2").bind('change', function() {
		address2 = $(this).val();
		$("span#address_2_selection").html($(this).val());
	});
	$(".lender.primary.address_line_2").trigger('change');

	$(".lender.primary.province").bind('change', function() {
		province = $(this).val();
		$("span#province_selection").html($(this).val());

	});
	$(".lender.primary.province").trigger('change');

	$(".lender.primary.city").bind('change', function() {
		city = $(this).val();
		$("span#city_selection").html($(this).val());

	});
	$(".lender.primary.city").trigger('change');

	$(".lender.primary.postal_code").bind('change', function() {
		postal_code = $(this).val();
		$("span#postal_code_selection").html($(this).val());

	});
	$(".lender.primary.postal_code").trigger('change');

	$(".lender.primary.us_state_id").bind('change', function() {

		state_cmb = $(".lender.primary.state_id option:selected").text();
		
		if (state_cmb != 'Please select') {
		$("span#us_state_selection").html(state_cmb);
		$("span#us_state_selection").html("Region Placeholder");
		}

	});
	$(".lender.primary.us_state_id").trigger('change');


	$(".lender.primary.country_id").bind('change', function() {

		var country_text = $(".lender.primary.country_id option:selected").text();
		$("span#country_selection").html(country_text);
		if ((country_text != 'United States') || (country_text == 'Please select')) {
		$(".lender.primary.us_state_id option[value='99']" ).attr( "selected", "selected" );
			$("span#us_state_selection").html('');
			$("div#choose_us_state").css("display", "none");
			$("div#provide_country_state").css("display", "inline");


		} else {

			$("div#provide_country_state").css("display", "none");
			$("div#choose_us_state").css("display", "inline");
		}

	});
	$(".lender.primary.country_id").trigger('change');

	$(".lender.primary.region").bind('change', function() {
		$("span#region_selection").html($(this).val());
	});
	$(".lender.primary.region").trigger('change');

 /*Beginning of Alternative Address*/
	
	$("select.lender.alternative.country_id").bind('change', function() {

		var country_text = $("select.lender.alternative.country_id option:selected").text();
		$("span#country_alternative_selection").html(country_text);
		if ((country_text != 'United States') || (country_text == 'Please select')) {
		$("select.lender.alternative.us_state_id option[value='99']" ).attr( "selected", "selected" );
			$("span#state_alternative_selection").html('');
			$("div#choose_us_state_alternative").css("display", "none");
			$("div#provide_country_state_alternative").css("display", "inline");


		} else {

			$("div#provide_country_state_alternative").css("display", "none");
			$("div#choose_us_state_alternative").css("display", "inline");
		}

	});
	$("select.lender.alternative.country_id").trigger('change');
	
	
	$("input.lender.alternative.region").bind('change', function() {
		$("span#region_alternative_selection").html($(this).val());
	});
	$("input.lender.alternative.region").trigger('change');
	
	$("select.lender.alternative.us_state_id").bind('change', function() {
		var tmpID = $("select.lender.alternative.us_state_id option:selected").text();
		$("span#state_alternative_selection").html(tmpID);
		});
	$("select.lender.alternative.us_state_id").trigger('change');



	$(".lender.alternative.address_line_1").bind('change', function() {
		$("span#address_1_alternative_selection").html($(this).val());
	});
	$(".lender.alternative.address_line_1").trigger('change');

	$(".lender.alternative.address_line_2").bind('change', function() {
		$("span#address_2_alternative_selection").html($(this).val());
	});
	$(".lender.alternative.address_line_2").trigger('change');

	$(".lender.alternative.province").bind('change', function() {
		$("span#province_alternative_selection").html($(this).val());
	});
	$(".lender.alternative.province").trigger('change');

	$(".lender.alternative.city").bind('change', function() {
		$("span#city_alternative_selection").html($(this).val());
	});
	$(".lender.alternative.city").trigger('change');
	
	$(".lender.alternative.postal_code").bind('change', function() {
		$("span#postal_code_alternative_selection").html($(this).val());
	});
	$(".lender.alternative.postal_code").trigger('change');



});

var whichUserType = "lender";
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
    var use_which_ca = $("input[name='lender[useWhichContactAddress]']:checked").val();
	if ((use_which_ca == 1) || (use_which_ca == 2)) {

	if	( ($("#lender_address_line_1_alternative").val() == "") || 
		  ($("#lender_postal_code_alternative").val() == "") || 
		($("#lender_city_alternative").val() == "") || 
		($("#lender_country_id_alternative option:selected").text() == "Please select"))  {
			return_value = false;
		}	
}	

	return return_value;
}

function checkLLegal() {

    var notChecked = true;
    var legal_18 = $("#lender_age_18_or_more");
    var legal_goodwill = $("#lender_goodwill");

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
    var whichType = 'lender';
    var item_count_element = $("#" + whichType + "_item_count");
    var item_count_value = item_count_element.val();
    var bad_count = isNaN(item_count_value);
    $("span#item_description_error").css("visibility", "hidden");
    $("span#item_count_error").css("visibility", "hidden");
    $("span#item_condition_id_error").css("visibility", "hidden");
    $("span#category_id_error").css("visibility", "hidden");

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
    if  ($("#" + whichType + "_category_id option:selected").text() == 'Please select') {
        $("span#category_id_error").css("visibility", "visible");
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
		alert("You have selected to provide an Alternative address with incomplete content.  Please go to '2. Your Borrowers Contact Preferences' to correct this matter.");
        $("span#whichContactAddressError").css("visibility", "visible");
        $("div#table_alternative_address_input").css("display", "block");
        location.href = "#menu_item_2";
       
        return;
    } else {
        
        $("#lender_is_active").val('1');
        $("form.lender_offering").submit();
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
    
    var home_phone_contact = $("#lender_home_phone");
    var cell_phone_contact = $("#lender_cell_phone");
    var alternative_phone_contact = $("#lender_alternative_phone");

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
	
	y_n = $("input[name='lender[displayLenderOrganizationName]']:checked").val();
	if ((y_n == 1) && ($("#lender_organization_name").val() == "")) {
		$("span#organization_name_error").text("Please provide an organization name.");
		$("span#organization_name_error").css("visibility", "visible");
		foundInvalid = false;
	} 

	y_n = $("input[name='lender[displayLenderAddress]']:checked").val();
	if (y_n == 1) {
	if (
		($(".lender.primary.address_line_1").val() == "") || 
		($(".lender.primary.postal_code").val() == "") || 
		($(".lender.primary.city").val() == "") || 
		($(".lender.primary.country_id option:selected").text() == "Please select")
	) {
		
		$("span#display_address_error").text("Please provide a complete address.");
		$("span#display_address_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	}
	
	y_n = $("input[name='lender[displayLenderName]']:checked").val();
	if (y_n == 1) {
	if (
		($("#lender_first_name").val() == "") || 
		($("#lender_last_name").val() == "") 
	) {
		
		$("span#public_display_name_error").text("Please provide a complete name.");
		$("span#public_display_name_error").css("visibility", "visible");
		foundInvalid = false;
	} 
	}
		
	
	
if ($("select#lender_contact_describe_id option:selected").text() == "Please select") {
		$("#describe_yourself_combo_error").text("Please choose an option to describe yourself.");
		$("#describe_yourself_combo_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if (($("select#lender_contact_describe_id option:selected").text() == "Other") && ($("#lender_other_describe_yourself").val() == "")) {

		$("#other_describe_yourself_error").text("Other description is required.");
		$("#other_describe_yourself_error").css("visibility", "visible");
		foundInvalid = false;
	} else {
		$("#other_describe_yourself_error").text("");
		$("#other_describe_yourself_error").css("visibility", "hidden");
	}
	if ($("#lender_first_name").val() == "") {
		$("#first_name_error").text("First name is required.");
		$("#first_name_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($("#lender_last_name").val() == "") {
		$("#last_name_error").text("Last name is required.");
		$("#last_name_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".lender.primary.city").val() == "") {
		$("#city_error").text("City name is required.");
		$("#city_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".lender.primary.address_line_1").val() == "") {
		$("#address_line_1_error").text("Address Line 1 is required.");
		$("#address_line_1_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".lender.primary.postal_code").val() != "") {
		var re = /^[A-Za-z]+$/;
		var hold_postal_value = $(".lender.primary.postal_code").val();
		if (re.test(hold_postal_value)) {
			$("#postal_code_error").text("Please verify your postal code, it should contain at least one numeric value.");
			$("#postal_code_error").css("visibility", "visible");
			foundInvalid = false;
		}
	}

	if ($(".lender.primary.postal_code").val() == "") {
		$("#postal_code_error").text("Postal code is required.");
		$("#postal_code_error").css("visibility", "visible");
		foundInvalid = false;
	}

	if ($(".lender.primary.country_id option:selected").text() == "Please select") {
		$("#country_error").text("Please select a Country.");
		$("#country_error").css("visibility", "visible");
		foundInvalid = false;
	}



	if ( ($(".lender.primary.country_id option:selected").text() != "Please select")  || ($(".lender.primary.country_id option:selected").text() != "United States") ) {  
		if  ($("input#lender.primary.region").val() == "") {
			$("#state_error").text("Please provide a Region.");
			$("#state_error").css("visibility", "visible");
			foundInvalid = false;
	}
	}
	if ((($(".lender.primary.us_state_id option:selected").text() == "Please select") || ($(".lender.primary.us_state_id option:selected").val() == '')) && ($(".lender.primary.country_id option:selected").text() == "United States")) {

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





