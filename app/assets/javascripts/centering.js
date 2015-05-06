$(document).ready(function() {


	$.fn.center = function() {

		
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
 		var div_height = $("div.form_wrapper").height();
 		element.css("height", div_height);
 		element.css('border', '2px solid #4A572B');
	};

	$("div.form_wrapper").center();
	$("form").center_form();
  
});