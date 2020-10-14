# Creating a Content Security Policy

## What would you do to build a CSP for your website?

### Interactive Generation
Automatic: For a more interactive way of building your policy, use report-uri's CSP generator as it's a great tool that you can use to experiment with various CSP settings without having to type them out manually. 

### Manual Design
When creating a CSP policy, I would recommend setting the default-src directive to 'self'. This ensures all resources by default will only be allowed to load from your website and nowhere else. If all the content (scripts, images, media...) is hosted on your site, this is all you'll need to set. If you load some of the content on your site from external sources (for example, images from a hosting site such as imgur.com), you can adjust the rest of the directives according to your needs.

When setting up the script-src directive and its sources, you should pay special attention to what you're allowing to load. 

If you're loading a script from an external source such as a CDN, make sure you're specifying the full URL of the script or a nonce/SHA hash of it and not just the hostname where it's hosted at, unless you're 100% sure no scripts that could be used to bypass your policy are hosted there. 

For example, if you're including jQuery from cdnjs on your website, you should include the full URL of the script (script-src cdnjs.cloudflare.com/ajax/.../jquery.min.js) or the SHA256 hash in your policy. Most CDNs allow you to get the script hash somewhere on their site. For example, on cdnjs, you can get it by clicking "Copy SRI" on the Copy dropdown.

### Inline JavaScript
If you need to include inline JavaScript or stylesheets in your website, you'll need to set up a nonce generator on the server-side, or compute SHA hashes of your inline scripts and then include them in your policy. 

There are loads of great libraries for most languages that allow you to do this with minimal effort. For example, if you're working with an Express-based website, I would recommend using the helmet-csp module available on npm, which randomly generates the nonce for you. 

If you're looking to hash your inline scripts, you can use an online tool such as report-uri.com's hash generator or you can use a tool such as AutoCSP to automatically generate your hashes for you.
