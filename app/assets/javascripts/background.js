$( document ).ready(function() {

    var c = document.createElement('canvas');
    if (c.getContext('2d'))
    {
        var ctx = c.getContext('2d');
        var cw = c.width = 840;
        var ch = c.height = 600;
        ctx.globalAlpha = 0.4;

        ctx.strokeStyle = "#D5BDBD";
        ctx.lineWidth = 2;
        var dash = 6;
        var radius = 5;
        var start_arc = 840/2;
        var y_arc = 580;
        radius = radius + 1;
        dash = dash +4;
        ctx.setLineDash([dash,2]);
        var i = 19;
        var n = 1;

        while( i > n )  {

            radius = radius + 1;
            dash = dash +4;
            ctx.setLineDash([dash,2]);
            ctx.beginPath();
            ctx.arc(start_arc, y_arc ,Math.pow(radius, 2), 1.25*Math.PI, 1.75*Math.PI, false);
            ctx.stroke();
            ctx.save();
            n = n + 1;
        }
        ctx.save();


        document.body.style.background = 'url(' + c.toDataURL() + ') no-repeat fixed center';
    }

});