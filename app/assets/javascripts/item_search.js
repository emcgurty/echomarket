	$(document).ready(function() {

	
		var clientKey = "js-rhQ4Mz8kbmEhRFpXMEUwAAPdCWIeFX17fRc1rklCH0UyGjwtXqZy1OLDKuRqrSyG";		
		var cache = {};
		var cache_placeholder = '';
		var container = $("div.location");
		var errorDiv = container.find("span#echo_market_search_error");

		$("input#search_start_date").datepicker({
			dateFormat : "yy-mm-dd"
		});

		$("input#search_end_date").datepicker({
			dateFormat : "yy-mm-dd"
		});
		
		$("input[name='search[zip_code_radius]']").bind('change', function() {
			var test_is_checked = $("input[name='search[zip_code_radius]']:checked").val();
			if (test_is_checked) {
				$("input[name='search[postal_code]']").trigger('change');
			}

		});

		$("input#search_end_date.hasDatepicker").bind('change', function() {

			$("#start_date_error").css("visibility", "hidden");
			$("#end_date_error").css("visibility", "hidden");
			$("#start_date_error").text("");
			$("#end_date_error").text("");

			var start_date_value = $("input#search_start_date.hasDatepicker").val();
			var end_date_value = $(this).val();

			if ((start_date_value == '') && (end_date_value != '')) {
				$("#start_date_error").text("Now please provide a Start Date.");

				$("#start_date_error").css("visibility", "visible");
			} else if (start_date_value > end_date_value) {
				$("#start_date_error").text("Please provide a Start Date earlier than your End Date.");

				$("#start_date_error").css("visibility", "visible");
			}

		});

		$("input#search_start_date.hasDatepicker").bind('change', function() {

			$("#end_date_error").css("visibility", "hidden");
			$("#start_date_error").css("visibility", "hidden");
			$("#start_date_error").text("");
			$("#end_date_error").text("");

			var start_date_value = $(this).val();
			var end_date_value = $("input#search_end_date.hasDatepicker").val();

			if ((end_date_value == '') && (start_date_value != '')) {
				$("#end_date_error").text("Now please provide an End Date.");

				$("#end_date_error").css("visibility", "visible");
			} else if (start_date_value > end_date_value) {
				$("#end_date_error").text("Please provide an End Date later than your Start Date.");

				$("#end_date_error").css("visibility", "visible");
			}

		});

		$("input[name='search[postal_code]']").bind('change', function() {
			alert("postal code change");
			var distance = $("input[name='search[zip_code_radius]']:checked").val();
			

			if (distance) {
				 ///Get zip code
				var zipcode = $("input[name='search[postal_code]']").val().substring(0, 5);

				if (zipcode.length == 5 && /^[0-9]+$/.test(zipcode)) {

					cache_placeholder = zipcode + distance;
					alert(cache_placeholder);
					// Clear error

					// Check cache
					alert(cache);
					if ( cache_placeholder in cache) {
						
						handleResp(cache[zipcode]);
						
					} else {
						// Build url
						
						var url = "https://www.zipcodeapi.com/rest/" + clientKey + "/radius.json/" + zipcode + "/" + distance + "/mile";

						$.ajax({
							"url" : url,
							"dataType" : "json"
						}).done(function(data) {
							
							alert("okay next you should see data");
							alert(data);
							handleResp(data);

							// Store in cache
							cache[cache_placeholder] = data;
						}).fail(function(data) {
							alert("FAIL");
							if (data.responseText && ( json = $.parseJSON(data.responseText))) {
								// Store in cache
								cache[cache_placeholder] = json;

								// Check for error
								if (json.error_msg)
									errorDiv.text(json.error_msg);
							} else {
								errorDiv.text('Request failed.');
							}
						});
					}
				}
			}

		});

		$("input#search_start_date.hasDatepicker").trigger('change');
		$("input#search_end_date.hasDatepicker").trigger('change');
		$("input[name='search[postal_code]']").trigger('change');
		$("input[name='search[zip_code_radius]']").trigger('change');

		function handleResp(data) {
			alert("function within function?");
			var mystr = "";

			if (data) {
				alert(data);
				if (data.error_msg) {
					errorDiv.text(data.error_msg);
					alert(data.error_msg);
					
				}
				else {
					
					$.each(data.zip_codes, function(i, zip) {
						mystr = mystr + "'" + zip.zip_code + "',";
					alert(mystr);	
					});
					
					var set_hidden_field = $("input#search_found_zip_codes");
					alert(set_hidden_field);
					if (set_hidden_field) {
						alert("Setting hidden");
						alert(mystr);
						set_hidden_field.val() = mystr.chomp(",");
					} else {

					}

				}
			}
		}


	});

	function submitSearch() {

		var choose_l_or_b = $("input[name='search[lender_or_borrower]']:checked");
        
		$("span#echo_market_search_error").css("visibility", "hidden");
		if (!(choose_l_or_b.val())) {
			$("span#echo_market_search_error").text("From the above option 'Items to Borrow or items to Lend?', you need to choose to either search for what is being offered or what is needed.");
			$("span#echo_market_search_error").css("color", "red");
			$("span#echo_market_search_error").css("visibility", "visible");

		} else if (($("input#search_keyword").val() == "") && ($("input#search_postal_code").val() == "") && ($("input#search_start_date").val() == "") && ($("input#search_end_date").val() == "") && ($("select#search_category_id").val() == "")) {
			$("span#echo_market_search_error").text("You have to provide at least one search criteria.");
			$("span#echo_market_search_error").css("color", "red");
			$("span#echo_market_search_error").css("visibility", "visible");

		} else if ((($("input#search_start_date").val() != "") && ($("input#search_end_date").val() == "")) || (($("input#search_start_date").val() == "") && ($("input#search_end_date").val() != ""))) {
			$("span#echo_market_search_error").text("If you want to do a Date Create search, you have to provide both a Start Date and an End Date.");
			$("span#echo_market_search_error").css("color", "red");
			$("span#echo_market_search_error").css("visibility", "visible");

		} else {

			$("form.items_listing").submit();
		}

	}

	