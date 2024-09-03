$(document).ready(function () {
    if (!getCookie("gdpr-consent")) {
        $("#gdpr-banner").show();
    }

    $("#accept-all-cookies").click(function (e) {
        e.preventDefault();
        var analyticsConsent = true;
        
        // Store consent in cookies
        setCookie("gdpr-consent", true, 365);
        setCookie("accept-all-cookies", analyticsConsent, 365);

        $("#gdpr-banner").hide();
    });

    $("#reject-non-essential-cookies").click(function (e) {
        e.preventDefault();
        var adsConsent = true;// $("#reject-non-essential-cookies").is(":checked");

        // Store consent in cookies
        setCookie("gdpr-consent", true, 365);
        setCookie("reject-non-essential-cookies", adsConsent, 365);

        $("#gdpr-banner").hide();
    });
});

function setCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
