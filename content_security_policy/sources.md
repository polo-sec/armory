# Sources

## What are CSP Sources?
After a directive in the policy comes a list of sources that specify wherefrom the particular resources are allowed to be loaded. Here are some of the most commonly used sources:

* * - This source is a wildcard, which means content for that specific directive can be loaded from anywhere. It's recommended not to use this source for script-src as it will essentially allow loading scripts from any URL.

* 'none' - This is the opposite of the wildcard (*) source as it fully disallows loading resources of the specified directive type from anywhere. For example, if you know you won't be serving certain content on your website, such as music or videos, you can just set the directive to 'none' in your CSP like so: media-src 'none'

* 'self' - This source allows you to load resources that are hosted on the same protocol (http/https), hostname (example.com), and port (80/443) as the website. For example, if you're accessing a site such as https://example.com and it has the CSP header set to default-src 'self', you won't be able to load any scripts, images or stylesheets from https://subdomain.example.com, http://example.com or https://example.org.

* 'unsafe-inline' - This source allows the use of inline stylesheets, inline JavaScript and event attributes like onclick. This source is considered unsafe and should be avoided.

* 'unsafe-eval' - This source allows additional JavaScript code to be executed using functions such as eval() by JS code that's already permitted within the policy. This is usually safe unless a vulnerability is found in the code that runs on the page or the script-src sources are very loose, for example allowing any script to be loaded from a CDN.

* example.com - This source would allow you to load resources from the domain example.com, but not its subdomains

* *.example.com - This source would allow you to load resources from all of the subdomains of example.com, but not the base domain.

* data: - Adding this source to a directive would allow resources to be loaded from a data: url. For script-src, this source is also considered unsafe and should be avoided. Here are some examples of data: urls:

    data:image/png;base64,iVBORw0KGgo...
    data:application/javascript,alert(1337)

There's also a couple of special sources, which are usually used in combination with some of the above to ensure only allowed resources are loaded, whilst maintaining convenience for the site owners.

* nonce-: This allows a resource to load if it has a matching nonce attribute. The nonce is a random string that is generated for every request. It is usually used for loading inline JS code or CSS styles. It needs to be unique for every request, as if a nonce is predictable, it can be bypassed.
For example, if a server sends the following header: script-src 'unsafe-inline' 'nonce-GJYTxu', the browser will only execute scripts that have the attribute set, like so: <script nonce="GJYTxu">alert(1)</script>

* sha256-: This is simply a SHA256 hash encoded via Base64 used as a checksum to verify that the content of the resource matches up with what's allowed by the server. Currently, sha256, sha384, and sha512 are by the CSP standard. This is usually used only for inline JS code or CSS styles but can be used to verify external scripts and/or stylesheets too. We can generate a SHA256 hash of an inline script we're intending to use by using a tool to generate it such as the one at report-uri.com or simply running it on a webpage with a restrictive CSP header and then extracting the hash from the console error.

For example, if we're looking to run the following JS on our website inline: alert(1337), we'll need to compute a SHA256 hash. I went ahead and did that, and the hash for the above code would be 'sha256-EKy4VsCHbHLlljt6SkTuD/eXpDbYHR1miZSY8h2DjDc='. Now we can add that to our policy, like so: script-src 'sha256-EKy4VsCHbHLlljt6SkTuD/eXpDbYHR1miZSY8h2DjDc='. Once that's added, the inline script should run as normal.
