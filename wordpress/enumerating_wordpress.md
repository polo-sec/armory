# Enumerating WordPress

Put yourself in the Attackers mindset. The first thing we want to do is discover as much technical information regarding the site configuration as we can. This will help us when we move onto the actual attacking or exploitation phase.

## WordPress Core Version

Three simple methods can be used to determine the core version of WordPress.
Meta Generator

Check the HTML source of the page for a meta generator tag in the HEAD section of the HTML source.

This example is taken from the source of a default WP install of version 3.5.2 and twenty twelve theme. From the source HTML:

	<meta name="generator" content="WordPress 3.5.2" />

### Version in readme.html

If the meta tag has been disabled, check for the presence of /readme.html from root of the install. Early versions of WordPress had the version right there at the top of the ReadMe file, newer versions of WordPress have removed the version from the file.

### Version in HTML source of site

In the HTML source, the version is often appended as a parameter on links to javascript and css resources that the page is loading. Depending on the plugin, this will not always be the case, and sites that have minified js and css may not have these information leaks present.

### Security Vulnerabilities in WordPress Core

An attacker finds a site with an older WordPress Core version, this may be directly exploitable via a security vulnerability in the WordPress core. In addition, it is a clear indication the site is not being well maintained. In a poorly managed site other components (plugins / themes) may not have been updated. In this case, the chance of a successful attack has increased considerably.

## WordPress Plugin (and version) Enumeration

During WordPress Plugin Enumeration we attempt to find as many installed plugins as we can (even those that are disabled). Knowing the installed WordPress plugins may allow us to identify the version, and research whether it is vulnerable to known exploits.

    Passive analysis can be used to find plugins through regular HTTP requests to the WordPress site.
    Active enumeration is more aggressive and usually involves using a script or tool to perform hundreds or even thousands of mostly invalid HTTP requests.

Reading through the HTML source of the WordPress site can reveal installed plugins through javascript links, comments and resources such as CSS that are loaded into the page. These are the easiest plugins to discover and require no aggressive testing of the target site. Even the HTTP headers can reveal information, such as the X-Powered-By header that reveals the presence of the W3-Total-Cache plugin.

Some plugins do not leave traces in the HTML source. To find all the installed plugins you have to be more aggressive. A number of tools can brute force known plugin lists from the path /wp-content/plugins/ * plugin to test * /. The web server response will usually reveal valid directories (often with HTTP 403) as opposed to unknown directories on the web server with its HTTP response code.

Once you have a list of plugins that are present on the site, your WordPress scanner or manual requests can be used to determine the version of the plugin.

curl https://myvulnerablesite.com/wp-content/plugins/badplugin/readme.txt

In the readme.txt we can see the version of the plugin. Compare this against known exploits and we can get a good idea if the site is vulnerable without actually throwing the exploit.

## WordPress Theme Enumeration

As with plugins, WordPress themes can contain vulnerabilities that might expose the site to compromise. Themes are collections of PHP code with HTML and CSS resources. More complex themes have more included components and are more likely to introduce security vulnerabilities.

Enumeration of the theme is conducted similarly to detecting the plugins. The theme path is often visible in the HTML of the page source. The CSS file getting loaded from the theme will often reveal the path.

With the path we have the theme name, and we can load the readme.txt to confirm the theme in use and the version.

curl http://examplewp.com/wp-content/themes/Avada/readme.txt

An important consideration when testing for vulnerable WordPress Themes (and plugins) is a theme that is installed yet not active may still have code that is accessible and vulnerable. This is why brute force testing for theme paths is an important step when assessing an unknown WordPress installation.

## Enumerate Users

If we can gather valid usernames, then we can attempt password guessing attacks to brute force the login credentials of the site. Getting access to an administrator account on a WordPress installation provides the attacker with a full compromise of the site, database and very often remote code execution on the server through PHP code execution.

These user enumeration techniques have been reported to WordPress.org as security vulnerabilities, however, the developers do not classify the user name as sensitive and are willing to accept the risk over the increased usability. Such as advising the users when the user is wrong vs the password being wrong.

### Author Archives

In a default installation you should be able to find the users of a site by iterating through the user id's and appending them to the sites URL. For example /?author=1, adding 2 then 3 etc to the URL will reveal the users login id either through a 301 redirect with a Location HTTP Header

	curl http://wordpressexample.com/?author=1

### Enumerate Users through Guessing

Brute forcing the user name is possible using the login form as the response is different for a valid vs an invalid account.

This can be performed manually to check a single user or using an automated tool such as Burp Intruder to cycle through thousands of possible usernames.

### Users listed in JSON API Endpoint

Using a json endpoint it may be possible to get a list of users on the site. This was restricted in version 4.7.1 to only show a user if configured, before that all users who had published a post were shown by default.

curl http://wordpressexample.com/wp-json/wp/v2/users

See the WordPress security testing tools below for automated user enumeration.

## Directory Indexing

directory indexing enabled on plugins directoryDirectory indexing is a function of the web server that allows you to view the contents of a directory in the web accessible path.

Viewing the contents of a directory allows an attacker to gather a lot of information about the installation such as installed plugins and themes without the need to brute force the paths.

To check for directory indexing you can browse to folder locations and see if you get a response that includes "Index Of" and a list of folders / files. Common locations to check would be:

/wp-content/
/wp-content/plugins/
/wp-content/themes/
/uploads/
/images/

If you can browse /wp-content/plugins/ - the enumeration of plugins and versions becomes much easier!

## Server Vulnerability Testing

In this phase, we move into testing network services rather than direct testing of the WordPress installation. Port scanning is the standard technique for the discovery of network services running on the server.

Services that might be present on a WordPress host:

    MySQL Server Remotely Accessible (port 3306)
    CPANEL administration login portal (port 2082 / 2083)
    Webmin administration (port 10000)
    FTP service for filesystem access
    SSH for remote control
    Other web services with admin or other sites (port 8080 / 8888 etc)

Any of the services may allow access or control of the server through either a security vulnerability or a compromised password. Port scanning can be conducted using the excellent Nmap Port Scanner or an alternative security tool.

Carrying on from our enumeration of network services using the port scanner, we could run vulnerability scans against the discovered services to identify exploitable services or other items of interest.

### OpenVAS Vulnerability Scanner

The Greenbone Vulnerability Manager (GVM) (previously known as OpenVAS) is one option, this is an open source vulnerability scanner that can be installed locally or enterprise appliances are also available from Greenbone Networks. We also host the open source OpenVAS scanner for testing internet accessible targets as part of our security testing platform.

### Nikto Vulnerability Scanner

Nikto is another vulnerability scanner that focuses on the discovery of known vulnerable scripts, configuration mistakes and other web server items of interest. The Nikto tool has been around for many years yet still has a place in the penetration testers toolbox.

Tools such as this throw tens of thousands of tests against target in an attempt to discover known vulnerabilities and other low hanging fruit. It is a noisy process filling the target system logs with 404's and other errors. Not recommended if you are going after a target ninja style (pentest / red team).

## WPScan

WPScan is a popular WordPress security testing tool that ties many of these simple enumeration techniques together. Enabling users to quickly enumerate a WordPress installation, it has a commercial license restricting use for testing your own WordPress sites and non-commercial usage.

It attempts to identify users, plugins, and themes, depending on the selected command line options, and also show vulnerabilities for each of the discovered plugins.

## Nmap NSE Scripts for WordPress

Nmap comes bundled with NSE scripts that extend the functionality of this popular port scanner. A few of the Nmap NSE scripts are particularly helpful for enumerating WordPress users, plugins, and themes using the same techniques we have previously discussed.

The best thing about this option is, if you have Nmap installed you already have these scripts ready to go.

WordPress Plugin and Theme Enum NSE ScriptWordPress Brute Force NSE Script
WordPress User Enum NSE Script
Example Plugin and Theme Enumeration

PORT   STATE SERVICE
80/tcp open  http
| http-wordpress-enum:
| Search limited to top 100 themes/plugins
|   plugins
|     akismet
|     contact-form-7 4.1 (latest version:4.1)
|     all-in-one-seo-pack  (latest version:2.2.5.1)
|     google-sitemap-generator 4.0.7.1 (latest version:4.0.8)
|     jetpack 3.3 (latest version:3.3)
|     wordfence 5.3.6 (latest version:5.3.6)
|     better-wp-security 4.6.4 (latest version:4.6.6)
|     google-analytics-for-wordpress 5.3 (latest version:5.3)
|   themes
|     twentytwelve
|_    twentyfourteen

## CMSMap

Another tool for enumeration of WordPress installations is CMSMap.

CMSMap tests WordPress as well as Joomla, Drupal, and Moodle.

As with any of these enumeration tools, it is crucial to keep it up to date. If the themes and plugins lists are not updated regularly, keep in mind that the latest components may not be detected.
