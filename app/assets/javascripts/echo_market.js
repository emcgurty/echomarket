$(document).ready(function() {

    $.fn.center = function () {
    
       $(this).css( "width: " + $("form").width() + "15px","height: " + $("form").height() + "15px" )
       var element = $(this);
        var e_width = element.width();
        var win_width = $(window).width();
        var left_margin_calc =  (win_width - e_width) / 2;
        element.css('margin-left', (left_margin_calc + "px"));
//    alert($("form").width() );
//    alert($("form").height() );

    };

    $.fn.center_form = function () {
        var element = $(this);
        var e_width = element.width();
        var win_width = $("div.form_wrapper").width();
        var left_margin_calc =  (win_width - e_width) / 2;
        element.css('margin-left', (left_margin_calc + "px"));

    };


    $("div.form_wrapper").center();

       
});

 

