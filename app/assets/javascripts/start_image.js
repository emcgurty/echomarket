$( document ).ready(function() {

    $("form#start_image").css("display", "none");

    function getWaves() {
        var c = document.getElementById("myCanvas");
        var ctx = c.getContext("2d");
        ctx.strokeStyle = "#2F4F4F";
        ctx.lineWidth = 3;
        var dash = 6;
        var radius = 5;
        var start_arc = 940/2;
        var y_arc = 625;
        radius = radius + 1;
        dash = dash +4;
        ctx.setLineDash([dash,2]);
        var i = 21;
        var n = 1;



        while( i > n )  {

            radius = radius + 1;
            dash = dash + 4;
            ctx.setLineDash([dash,2]);
            ctx.beginPath();
            ctx.arc(start_arc, y_arc ,Math.pow(radius, 2), 1.25*Math.PI, 1.75*Math.PI, false);
            ctx.stroke();
            ctx.save();
            n = n + 1;
        }
        ctx.save();
        return false;

    }


    function drawTextAlongArc(context, str, centerX, centerY, radius, angle){
        context.save();
        context.translate(centerX, centerY);
        context.rotate(-1 * angle / 2);
        context.rotate(-1 * (angle / str.length) / 2);
        for (var n = 0; n < str.length; n++) {
            context.rotate(angle / str.length);
            context.save();
            context.translate(0, -0.30 * radius);
            var char1 = str[n];
            context.fillText(char1, 0, 0);
            context.restore();
        }
        context.restore();
    }

    var angle = Math.PI;
    var radius = 350;
    var centerX = 960/2;
    var centerY = 400-120;
    var c = document.getElementById("myCanvas");
    

    if ( c.getContext && c.getContext( "2d" ) ) {
        $("form#start_image").css("display", "block");
        var ctx = c.getContext("2d");
        getWaves();
        ctx.font = '52pt sans-serif';
        ctx.fillStyle  = 'indigo';
        ctx.weight = 'bold';
        ctx.textAlign = "center";
        ctx.lineWidth = 5;
        //    ctx.strokeStyle = 'black';


        drawTextAlongArc(ctx, "  THE  ", centerX, centerY, radius, angle);

        centerY = 525-120;
        radius = 350;
        ctx.font = '70pt sans-serif';
        ctx.lineWidth = 7;

        drawTextAlongArc(ctx, " ECHO ", centerX, centerY, radius, angle);

        centerY = 675-120;
        radius = 375;
        ctx.font = '52pt sans-serif';
        ctx.lineWidth = 5;

        drawTextAlongArc(ctx, "MARKET", centerX, centerY, radius, angle);

        ctx.save();

    } else {

   
        window.location.replace("home/welcome");



    }

});



