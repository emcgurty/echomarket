/* https://www.zipcodeapi.com/Examples */

	$(function() {
		// IMPORTANT: Fill in your client key
		
		var clientKey = "js-rhQ4Mz8kbmEhRFpXMEUwAAPdCWIeFX17fRc1rklCH0UyGjwtXqZy1OLDKuRqrSyG";
		var cache = {};
		var container = $("table.personal");
	
		var errorDiv = container.find("span#postal_code_error");
		errorDiv.css("visibility", "visible");
	
		
		/** Handle successful response */
		function handleResp(data)
		{
			

			// Check for error
			if (data.error_msg)  { 
			    alert(data.error_msg); 
				errorDiv.text(data.error_msg); }
			else {
			var mystr = "";
			 $.each( data.zip_codes, function( i, zip ) {
             	 mystr = mystr + ":" + zip.zip_code;
        
      });	// Set city and state
				 container.find("input[name='communities[city]']").val(mystr);
				/* container.find("input[name='state']").val(data.state); */
			}
		}
		
		// Set up event handlers
		container.find("input[name='communities[postal_code]']").change(function() {
		
		/* 	var distance = container.find("input[name='communities[distance]']").val(); */
		var distance = 10;
			// Get zip code
			var zipcode = $(this).val().substring(0, 5);
			
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
					var url = "https://www.zipcodeapi.com/rest/"+clientKey +"/radius.json/"+ zipcode +  "/" +  distance + "/mile";
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
	

	
	
