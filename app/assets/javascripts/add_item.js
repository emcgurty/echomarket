function addItem(){
	
	var foundIncomplete = false;
	$("span#incomplete_information_error").css("visibility", "hidden");
	/*  f l a : all blank*/
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

function submitNewBL(rdt, u_id, which, s_id)  {
	 	
	    $("[id*='_h']").trigger('change');
	    var queryString = '';
	    /*    match 'community_member/update_row/(:fi)/(:m)/(:la)/(:al)/(:ci)/(:com_id)/(:is_c)'=> "community_member#update_row", :as=> :community_member_update_row */
		if (is_c == 1)  {
		var my_alias_str = 	$("span#thisFirstName" + rdt).text() + $("span#thisMI" + rdt).text() + $("span#thisLastName" + rdt).text();
		queryString = "/community_member/update_row/" + $("span#thisFirstName" + rdt).text() +"/" + 
		$("span#thisMI" + rdt).text() + "/" + $("span#thisLastName" + rdt).text() + "/" + my_alias_str + "/" + c_id + "/" + com_id + "/" + is_c;
		} else {
			queryString = "/community_member/update_row/" + $("span#thisFirstName" + rdt).text() +"/" + 
		$("span#thisMI" + rdt).text() + "/" + $("span#thisLastName" + rdt).text() +"/" + $("span#thisAlias" + rdt).text() +"/" + c_id + "/" + com_id + "/" + is_c;
		}
		window.location.replace(queryString);
}

function update_row(myThis,rct) {
	
 
	if (myThis.id == "which_email_h"){
		$("span#thisEmail"+rct).text(myThis.value);	
	}  else	if (myThis.id == "which_category_id_h") {
		$("span#thisCID"+rct).text(myThis.value);	
	}  else	if (myThis.id == "which_item_description_h") {
		$("span#thisItem"+rct).text(myThis.value);	
	}  else {}
	}





