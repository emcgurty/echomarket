/* https://www.zipcodeapi.com/Examples */

	$(function() {
		// IMPORTANT: Fill in your client key
		var clientKey = "js-rhQ4Mz8kbmEhRFpXMEUwAAPdCWIeFX17fRc1rklCH0UyGjwtXqZy1OLDKuRqrSyG";
		alert("hit1");
		var cache = {};
		var container = $("table.personal");
		alert(container);
		var errorDiv = container.find("span#postal_code_error");
		errorDiv.css("visibility", "visible");
		alert(errorDiv);
		
		/** Handle successful response */
		function handleResp(data)
		{
			// Check for error
			if (data.error_msg)
				errorDiv.text(data.error_msg);
			else if ("city" in data)
			{
				// Set city and state
				container.find("input[name='communities[city]']").val(data.city);
				/* container.find("input[name='state']").val(data.state); */
			}
		}
		
		// Set up event handlers
		// $("#users_password_confirmation").change(function() {
		container.find("input[name='communities[postal_code]']").change(function() {
			alert("hit change1");
			// Get zip code
			var zipcode = $(this).val().substring(0, 5);
			alert(zipcode);
			alert((zipcode.length == 5 && /^[0-9]+$/.test(zipcode)));
			if (zipcode.length == 5 && /^[0-9]+$/.test(zipcode))
			{
				// Clear error
					errorDiv.text("");
				
				// Check cache
				if (zipcode in cache)
				{
					handleResp(cache[zipcode]);
				}
				else
				{
					// Build url
					alert("build_url");
					var url = "https://www.zipcodeapi.com/rest/"+clientKey+"/info.json/" + zipcode + "/radians";
					
				// Make AJAX request
					$.ajax({
						"url": url,
						"dataType": "json"
					}).done(function(data) {
						handleResp(data);
						
						// Store in cache
						cache[zipcode] = data;
					}).fail(function(data) {
						if (data.responseText && (json = $.parseJSON(data.responseText)))
						{
							// Store in cache
							cache[zipcode] = json;
							
							// Check for error
							if (json.error_msg)
								errorDiv.text(json.error_msg);
						}
						else
							errorDiv.text('Request failed.');
					});
				} 
			}
		});
	$("input[name='communities[postal_code]']").trigger('change');	
	});
	
	
	
	
