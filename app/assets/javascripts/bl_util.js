
function noNotContactAddress(myThis, whichType) {
    var whatValue = $(myThis).val();
    var useAddressAlternative = $('input#useWhichContactAddressAlternative').is(':checked');

    if ((whatValue == "1") || (whatValue == "2"  || useAddressAlternative)){
        $("div#table_alternative_address_input").css("display", "inline-table");

    } else {
        $("div#table_alternative_address_input").css("display", "inline-table");
    }
}

function presenceYes(myThis) {

    if (myThis.id == 'displayYesnotnecessaryradio') {
        $("#length_of_presence").css("display", "inline-table");

    } else {
        $("#length_of_presence").css("display", "none");

    }
    return false;

}

