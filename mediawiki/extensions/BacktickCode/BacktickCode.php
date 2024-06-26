<?php
/**
 * @author Joel Thornton <mediawiki@joelpt.net>
 * @license https://www.gnu.org/copyleft/gpl.html GNU General Public License 2.0 or later
 */

if(!defined('MEDIAWIKI')) {
    die("This is an extension to the MediaWiki package and cannot be run standalone.");
}

// Register as an extention
$wgExtensionCredits['parserhook'][] = array(
        'name' => 'BacktickCode',
        'version' => '1.1',
        'url' => 'https://www.mediawiki.org/wiki/Extension:BacktickCode',
        'author' => array('Joel Thornton', 'Sk4p'),
        'description' => 'Allows to show text as <code> between backticks (`)',
);

// Register hooks
$wgHooks['InternalParseBeforeLinks'][] = function( &$parser, &$text, &$stripState ) {
        // We replace '`...`' by '<code>...</code>' and '\`' by '`'.

        // This is hard, because MediaWiki itself uses backticks in
        // the `UNIQ and QINU` blocks.  We find that when we just
        // change pairs of ` `, we break the stripstate badly.  So
        // first we're going to "hide" those by turning the backticks
        // into tildes.
        //
        $fixprefix = preg_replace('/`/', '~', Parser::MARKER_PREFIX);
        $fixsuffix = preg_replace('/`/', '~', Parser::MARKER_SUFFIX);

        $text = str_replace(Parser::MARKER_PREFIX, $fixprefix, $text);
        $text = str_replace(Parser::MARKER_SUFFIX, $fixsuffix, $text);

        // Now that those are tildes, we can do the replace.  We check
        // for \x7f to ensure our pair of backticks isn't spanning a
        // UNIQ/QINU set.
        $text = preg_replace('/([^\\\\]|^)`([^`\x7f]*)`/', '$1<code>$2</code>', $text);
        $text = preg_replace('/\\\\\`/', '`', $text);

        // Now put the prefix/suffixes back to normal.
        $text = str_replace($fixprefix, Parser::MARKER_PREFIX, $text);
        $text = str_replace($fixsuffix, Parser::MARKER_SUFFIX, $text);

        return true;
};
