<?
	define('EN', 'english');
	define('DE', 'german');

	$lang = $_GET['lang'] == DE?DE:EN;
	$page = isset($_GET['page'])?strtolower($_GET['page']):"about";
	
	function tagLine()
	{
		return text('Low-barrier primary school lessons', 'Barrierearme Grundschul&uuml;bungen');
	}

	function text($englishString, $germanString)
	{
		global $lang;
		echo $lang == EN?$englishString:$germanString;
	}

	function linkParameters($pageParameter, $langParameter)
	{
		global $lang;
		global $page;
		return $_SERVER["SCRIPT_NAME"]
			."?page=".($pageParameter!=""?$pageParameter:$page)
			."&amp;lang=".($langParameter!=""?$langParameter:$lang);
	}
	
	function conditionalSelectedClass($pageLink)
	{
		global $page;
		return $page == $pageLink?" class=\"selected\"":"";
	}
	
	function writeContent()
	{
		global $page;
		global $lang;

		switch ($page)
		{
			case 'screenshots':
?>
				<h2><? text('Screenshots', 'Bildschirmfotos'); ?></h2>
				<div id="screenshotthumbs">
					<a href="screenshot_<?=$lang?>_step01.png"><img src="screenshotthumb_step01.png" width="120" height="92" alt="Step 1" /><br />
						<? text('Step', 'Schritt'); ?> 1 asdfasdf
					</a>
				</div>
<?
			break;
			case 'license':
?>
				<h2><? text('License', 'Lizenz'); ?></h2>
				<p>
					Touch'n'learn - <? tagLine() ?><br />
					Copyright (C) 1998, 2007 by Alessandro Portale<br />
					<a class="external" href="http://touchandlearn.sourceforge.net/<? text('', '?lang=german'); ?>">http://touchandlearn.sourceforge.net/</a>
				</p>
				<? text('', '<p><em>Der folgende Lizenztext ist in seiner englischen Originalfassung aufgef&uuml;hrt, da die <a class="external" href="http://www.gnu.de/gpl-ger.html">deutsche &Uuml;bersetzung</a> nicht offiziell oder im rechtlichen Sinne anerkannt ist.</em></p>'); ?>
				<p>Touch'n'learn is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.</p>
				<p>Touch'n'learn is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the <a class="external" href="http://www.gnu.org/copyleft/gpl.html">GNU General Public License</a> for more details.</p>
<?
			break;
			default:
?>
				<h2><? text('About', '&Uuml;ber'); ?></h2>
<?
		};
	}
	
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?
	$textColor = "#330000";
	$contentBackgroundColor = "#ffffee";
?><html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="author" content="Alessandro Portale" />
		<meta name="description" content="Touch 'n learn - <? tagLine(); ?>" />
		<meta name="keywords" content="learn, education, handicapped, application, tool, app, free, freeware" />
		<title>Touch'n'learn - <? tagLine() ?></title>
		<style type="text/css" media="all">
			@import "style.css";
		</style>
	</head>
	<body>
		<div id="page">
			<div id="header">
				<div id="title">Touch'n'learn</div><div id="tagline"><? tagLine() ?></div>
				<a href="<?=linkParameters("","english")?>"><img src="flagEnglish<? text('_selected', ''); ?>.png" width="26" height="17" alt="English" /></a><a href="<?=linkParameters("","german")?>"><img src="flagGerman<? text('', '_selected'); ?>.png" width="26" height="17" alt="Deutsch" /></a>
			</div>
			<div id="navigation">
				<ul id="navigationlist"><li><a href="<?=linkParameters("about","")?>"<?=conditionalSelectedClass("about")?>><? text('About', '&Uuml;ber'); ?></a></li><li><a href="<?=linkParameters("lessons","")?>"<?=conditionalSelectedClass("lessons")?>><? text('Lessons', '&Uuml;bungen'); ?></a></li><li><a href="<?=linkParameters("screenshots","")?>"<?=conditionalSelectedClass("screenshots")?>><? text('Screenshots', 'Bildschirmfotos'); ?></a></li><li><a href="<?=linkParameters("license","")?>"<?=conditionalSelectedClass("license")?>><? text('License', 'Lizenz'); ?></a></li></ul>
				<a class="external" href="http://www.google.com"><? text('Download', 'Herunterladen'); ?></a>
				<a class="external" href="http://sourceforge.net"><img src="http://sourceforge.net/sflogo.php?group_id=209276&amp;type=1" width="88" height="31" alt="SF.net Logo" /></a>
				<a class="external" href="http://sourceforge.net/projects/touchandlearn/"><? text('SF project page', 'SF Projekt-Seite'); ?></a>
			</div>
			<div id="content">
<?=writeContent();
?>
			</div>
			<div id="footer">
			</div>
		</div>
	</body>
</html>