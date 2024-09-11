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

        loadAllCookies();

        $("#gdpr-banner").hide();
    });

    $("#reject-non-essential-cookies").click(function (e) {
        e.preventDefault();
        var adsConsent = true;// $("#reject-non-essential-cookies").is(":checked");

        // Store consent in cookies
        setCookie("gdpr-consent", true, 365);
        setCookie("reject-non-essential-cookies", adsConsent, 365);

        loadOnlyNecessaryCookies();

        $("#gdpr-banner").hide();
    });
});

function loadAllCookies() {
    // script 'Share This'
    loadStLightScript();

    // Load Google Analytics
    loadGoogleAnalyticsScript('UA-8531953-1', 'remembermethursday.org');
}

function loadOnlyNecessaryCookies() {
    // script 'Share This'
    loadStLightScript();
}

function loadStLightScript() {
    if (!document.getElementById('shareThisScript')) {
        var script = document.createElement('script');
        script.id = 'loadStLightScript'; // Give an ID to avoid multiple loads
        script.type = 'text/javascript';
        script.src = 'https://ws.sharethis.com/button/buttons.js'; // Load ShareThis JS
        document.body.appendChild(script);

        script.onload = function () {
            stLight.options({ publisher: '127b4c89-1c34-4e68-b933-85623e8ca959' });
        };
        console.log('ShareThis script loaded');
    }
}

function loadGoogleAnalyticsScript(trackingId, domain) {
    var script = document.createElement('script');
    script.id = 'loadGoogleAnalyticsScript';
    script.type = 'text/javascript';
    var scriptContent = `
        window.ga = window.ga || function () { (ga.q = ga.q || []).push(arguments) };
        ga.l = +new Date;
        ga('create', 'UA-8531953-1', 'auto', { 'allowLinker': true });
        ga('require', 'linker');
        ga('linker:autoLink', ['remembermethursday.org']);
        ga('send', 'pageview');
    `;
    script.text = scriptContent;
    document.body.appendChild(script);
    console.log('Google Analytics script loaded');
}







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
