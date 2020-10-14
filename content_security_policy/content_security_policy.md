# Content Security Policy

## What is CSP?
Content Security Policy, or CSP, is a policy usually sent via an HTTP response header from the webserver to your browser when requesting a page that describes which sources of content the browser should allow to be loaded in, and which ones should be blocked. In case an XSS or data injection vulnerability is found in a website, CSP is designed to prevent this vulnerability from being exploited until it's properly patched, and should serve as an extra layer of protection, not as your only line of defense. 

A CSP policy can also be included within the page's HTML source code, using the <meta> tag, such as this:
<meta http-equiv="Content-Security-Policy" content="script-src 'none'; object-src 'none';">

## Fetch Directives
The CSP specification contains quite a few fetch directives. Fetch directives control the locations from which certain resource types may be loaded. There are further details on content security policies here: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy. Some common directives are:

* default-src - As the name states, this directive is used as the default, which means if a certain resource is trying to be loaded and there isn't a directive specified for its type, it falls back to default-src to verify if it's allowed to load.

* script-src - This directive specifies the sources wherefrom JavaScript scripts can be loaded and executed. 

* connect-src - This directive specifies to which locations can JavaScript code perform AJAX requests (think XMLHTTPRequest or fetch).

* style-src / img-src / font-src / media-src - These directives specify from which locations CSS stylesheets, images, fonts and media files (audio/video) respectively can be loaded

* frame-src / child-src - This directive defines which locations can be embedded on the webpage via (i)frames.

* report-uri - This is a special directive that will instruct the browser report all violations of your Content Security Policy via a POST request to a particular URL. This is useful if you're trying to find potential code injection vulnerabilities or locations where your CSP may break the functionality of your website. This directive is deprecated and will soon be replaced by the report-to directive
