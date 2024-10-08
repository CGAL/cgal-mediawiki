<?php
# This file was automatically generated by the MediaWiki 1.39.8
# installer. If you make manual changes, please keep track in case you
# need to recreate them later.
#
# See docs/Configuration.md for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# https://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
if ( !defined( 'MEDIAWIKI' ) ) {
	exit;
}


## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgSitename = "CGAL developers wiki"; # CGAL-EDIT

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs
## (like /w/index.php/Page_title to /wiki/Page_title) please see:
## https://www.mediawiki.org/wiki/Manual:Short_URL
$wgScriptPath       = "/CGAL/Members/w";

# http://www.mediawiki.org/wiki/Manual:$wgUsePathInfo
# Whether to use 'pretty' URLs, e.g. index.php/Page_title
$wgUsePathInfo = true;
## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
# Virtual path. This directory MUST be different from the one used in $wgScriptPath
$wgArticlePath = '/CGAL/Members/wiki/$1';

## The protocol and server name to use in fully-qualified URLs
$wgServer = getenv('MEDIAWIKI_SITE_SERVER'); # CGAL-EDIT

## The URL path to static resources (images, scripts, etc.)
$wgResourceBasePath = $wgScriptPath;

## The URL paths to the logo.  Make sure you change this from the default,
## or else you'll overwrite your logo when you upgrade!
$wgLogos = [
	'1x' => "https://cgal.geometryfactory.com/img/cgal-dev-wiki-logo2.png",  # CGAL-EDIT
	'icon' => "https://cgal.geometryfactory.com/img/cgal-dev-wiki-logo2.png",  # CGAL-EDIT
#	'1x' => "$wgResourceBasePath/resources/assets/change-your-logo.svg",
#	'icon' => "$wgResourceBasePath/resources/assets/change-your-logo.svg",
];

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = true; # UPO

$wgEmergencyContact = "Laurent.Rineau@geometryfactory.com"; # CGAL-EDIT
$wgPasswordSender = "root@cgal.geometryfactory.com"; # CGAL-EDIT
$wgPasswordSenderName = "CGAL Developers Wiki Administrator"; # CGAL-EDIT

## There are many more options for fine tuning available see
## /includes/DefaultSettings.php

## UPO means: this is also a user preference option

## https://www.mediawiki.org/wiki/Manual:Configuration_settings#Email_notification_(Enotif)_settings
$wgEnotifUserTalk = true; # UPO  # CGAL-EDIT
$wgEnotifWatchlist = true; # UPO # CGAL-EDIT
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = "mysql";
$wgDBserver = "db";
$wgDBname = "mediawiki";
$wgDBuser = "mediawiki";
$wgDBpassword = "mediawiki";

# MySQL specific settings
$wgDBprefix = "cgal_members_";

# MySQL table options to use during installation or update
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=binary";

# Shared database table
# This has no effect unless $wgSharedDB is also set.
$wgSharedTables[] = "actor";

## Shared memory settings
$wgMainCacheType = CACHE_ACCEL;
$wgMemCachedServers = [];

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";
$wgUploadPath       = "/CGAL/Members/wiki-images";

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = false;

# Periodically send a pingback to https://www.mediawiki.org/ with basic data
# about this MediaWiki instance. The Wikimedia Foundation shares this data
# with MediaWiki developers to help guide future development efforts.
$wgPingback = true;

# Site language code, should be one of the list in ./includes/languages/data/Names.php
$wgLanguageCode = "en";

# Time zone
$wgLocaltimezone = 'Europe/Paris'; # CGAL-EDIT

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publicly accessible from the web.
#$wgCacheDirectory = "$IP/cache";

$wgSecretKey = false; ## TODO: set a secret key # CGAL-EDIT




## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = "en_US.utf8";  # CGAL-EDIT

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = false; # CGAL-EDIT

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

# The following permissions were set based on your choice in the installer
$wgGroupPermissions['*']['edit'] = false;

## Default skin: you can change the default skin. Use the internal symbolic
## names, e.g. 'vector' or 'monobook':
$wgDefaultSkin = "vector-2022"; # CGAL-EDIT

# Enabled skins.
# The following skins were automatically enabled:
#wfLoadSkin( 'MinervaNeue' ); # CGAL-EDIT
#wfLoadSkin( 'MonoBook' ); # CGAL-EDIT
#wfLoadSkin( 'Timeless' ); # CGAL-EDIT
wfLoadSkin( 'Vector' );

# Enabled extensions. Most of the extensions are enabled by adding
# wfLoadExtension( 'ExtensionName' );
# to LocalSettings.php. Check specific extension documentation for more details.
# The following extensions were automatically enabled:
wfLoadExtension( 'CiteThisPage' );
wfLoadExtension( 'CodeEditor' );
wfLoadExtension( 'Interwiki' );
wfLoadExtension( 'Math' );
wfLoadExtension( 'ParserFunctions' );
wfLoadExtension( 'Renameuser' );
wfLoadExtension( 'ReplaceText' );
wfLoadExtension( 'SyntaxHighlight_GeSHi' );
wfLoadExtension( 'TemplateData' );
wfLoadExtension( 'VisualEditor' );
wfLoadExtension( 'WikiEditor' );


# End of automatically generated settings.
# Add more configuration options below.

wfLoadExtension( 'VisualEditor' );
wfLoadExtension( 'SemanticMediaWiki' );
enableSemantics( '' );
wfLoadExtension( 'PageForms' );
wfLoadExtension( 'SemanticWatchlist' );
wfLoadExtension( 'ConfirmAccount' );
wfLoadExtension( 'Interwiki' );
$wgLocalInterwiki   = $wgSitename;

wfLoadExtension( 'Renameuser' );
wfLoadExtension( 'UserMerge' );
require_once "$IP/extensions/BacktickCode/BacktickCode.php";
wfLoadExtension( 'MagicNoCache' );
wfLoadExtension( 'Math' );
wfLoadExtension( 'ParserFunctions' );
wfLoadExtension( 'SyntaxHighlight_GeSHi' );
wfLoadExtension( 'UrlGetParameters' );
wfLoadExtension( 'DiscussionThreading' );
wfLoadExtension( 'ParserFunctions' );
wfLoadExtension( 'DismissableSiteNotice' );
wfLoadExtension( 'WikiMarkdown' );
$wgAllowMarkdownExtra = true; // allows usage of Parsedown Extra
#$wgAllowMarkdownExtended = true; // allows usage of Parsedown Extended

# See ConfirmAccount extension below
#$wgGroupPermissions['*'    ]['createaccount']   = true;
$wgGroupPermissions['*'    ]['read']            = true;
$wgGroupPermissions['*'    ]['edit']            = false;
$wgGroupPermissions['*'    ]['createpage']      = false;
$wgGroupPermissions['*'    ]['createtalk']      = false;
$wgGroupPermissions['*'    ]['writeapi']         = false;

$wgGroupPermissions['user' ]['createtalk']       = false;
$wgGroupPermissions['cgaleditor' ]['createtalk']       = true;

/** This is a flag to determine whether or not to check file extensions on upload. */
$wgFileExtensions = array('svg', 'png', 'gif', 'jpg', 'jpeg', 'doc', 'xls', 'mpp', 'pdf', 'ppt', 'tiff', 'bmp', 'docx', 'xlsx', 'pptx', 'ps', 'psd', 'swf', 'fla', 'mp3', 'mp4', 'm4v', 'mov', 'avi', 'txt', 'h', 'cpp', 'tgz', 'tar.gz');
$wgCheckFileExtensions = true;

/**
 * If this is turned off, users may override the warning for files not covered
 * by $wgFileExtensions.
 */
$wgStrictFileExtensions = false;

# Enable subpages in the main namespace
$wgNamespacesWithSubpages[NS_MAIN] = true;

/**
 * Namespace aliases
 * These are alternate names for the primary localised namespace names, which
 * are defined by $wgExtraNamespaces and the language file. If a page is
 * requested with such a prefix, the request will be redirected to the primary
 * name.
 *
 * Set this to a map from namespace names to IDs.
 * Example:
 *    $wgNamespaceAliases = array(
 *        'Wikipedian' => NS_USER,
 *        'Help' => 100,
 *    );
 */
$wgNamespaceAliases = array(
   'File' => NS_FILE,
);

/** Use RC Patrolling to check for vandalism */
$wgUseRCPatrol = false;

/** Use new page patrolling to check new pages on Special:Newpages */
$wgUseNPPatrol = false;

# Namespace for CGAL Editors
# create namespace
define("NS_EDITORS",100);
define("NS_EDITORS_TALK",101);
$wgExtraNamespaces[NS_EDITORS] = "Editors";
$wgExtraNamespaces[NS_EDITORS_TALK] = "Editors_talk";
# protect namespace
$wgNamespaceProtection[NS_EDITORS] = Array("editeditors");
$wgNamespacesWithSubpages[NS_EDITORS] = true;
$wgGroupPermissions['*']['editeditors'] = false;
$wgGroupPermissions['cgaleditor']['editeditors'] = true;
$wgContentNamespaces[] = NS_EDITORS;

$messages['group-cgaleditor'] = 'CGAL Editors';
$messages['right-editeditors'] = 'Edit pages of the Editors: namespace';

$wgSyntaxHighlightDefaultLang = "cpp-qt";

/** Should we allow the user's to select their own skin that will override the default? */
$wgAllowUserSkin = false;

/**
 * Enable interwiki transcluding.  Only when iw_trans=1.
 */
$wgEnableScaryTranscluding = true;

/**
 * Filename for debug logging. See http://www.mediawiki.org/wiki/How_to_debug
 * The debug log file should be not be publicly accessible if it is used, as it
 * may contain private data. 
 */
# $wgDebugLogFile         = '/tmp/wiki-log';
$wgShowExceptionDetails = true;
/** Make users use autonumbering by default */
$wgDefaultUserOptions ['numberheadings'] = 1;

/** Determines if the mime type of uploaded files should be checked */
$wgVerifyMimeType= false;

$wgGroupPermissions['*']['interwiki'] = false;
$wgGroupPermissions['sysop']['interwiki'] = true;

# Bureaucrat settings
$wgGroupPermissions['bureaucrat']['delete'] = true;
$wgGroupPermissions['bureaucrat']['block'] = true;
$wgGroupPermissions['bureaucrat']['editinterface'] = true;

# Extension UserMerge
$wgGroupPermissions['bureaucrat']['usermerge'] = true;

# Disable reading by anonymous users
$wgGroupPermissions['*']['read'] = false;

# Extension ConfirmAccount
$wgMakeUserPageFromBio = true;
$wgAutoWelcomeNewUsers = true;
$wgUseRealNamesOnly = true;
$wgAutoUserBioText = "(This text was send by the user for his/her account creation request.)";
$wgConfirmAccountContact = "info@cgal.org";
$wgWhitelistRead = [
	'Special:RequestAccount',
	'MediaWiki:Common.css',
	'MediaWiki:Common.js'
	];
$wgGroupPermissions['cgaleditor']['confirmaccount'] = true;
$wgGroupPermissions['cgaleditor']['confirmaccount-notify'] = true;
$wgAllowAccountRequestFiles = false;
$wgAccountRequestMinWords = 5;
$wgConfirmAccountRequestFormItems['UserName']['enabled'] = false;
$wgConfirmAccountRequestFormItems['TermsOfService']['enabled'] = false;
$wgConfirmAccountRequestFormItems['Biography']['minWords'] = 20;

# SVG support
$wgMaxShellMemory = 512000;
$wgAllowTitlesInSVG = true;
$wgSVGConverter = 'ImageMagick';
$wgSVGConverters = array(
			 'ImageMagick' => '/usr/bin/convert -background white -geometry $width $input PNG:$output',
			 'rsvg' => '$path/rsvg -w$width -h$height $input $output',
			 );

# Thanks to http://stackoverflow.com/questions/13349142/disabling-user-accounts-in-mediawiki
# https://www.mediawiki.org/wiki/Manual:$wgBlockDisablesLogin
$wgBlockDisablesLogin = true;

# https://semantic-mediawiki.org/wiki/Help:Configuration#smwgQConceptCaching
$mwgQConceptCaching = CONCEPT_CACHE_NONE;

# http://www.mediawiki.org/wiki/Manual:Job_queue#Updating_links_tables_when_a_template_changes
$wgJobRunRate = 10;


# https://www.mediawiki.org/wiki/Extension:DismissableSiteNotice
$wgMajorSiteNoticeID = 1;
$wgDismissableSiteNoticeForAnons = false;
