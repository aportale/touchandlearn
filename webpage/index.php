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
		return $lang == EN?$englishString:$germanString;
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
	
	function screenShot($imageBaseName, $imageCaption)
	{
		return "<a href=\"screenshot_$imageBaseName.png\"><img src=\"screenshot_".$imageBaseName."_thumb.png\" width=\"100\" height=\"80\" alt=\"$imageCaption\" /><br />$imageCaption</a>\n";
	}
	
	function writeContent()
	{
		global $page;
		global $lang;

		switch ($page)
		{
			case 'screenshots':
?>
				<h2><?= text('Screenshots', 'Bildschirmfotos') ?></h2>
				<div id="screenshotthumbs">
					<?= screenShot("menu1", text("Menu page 1", "Men&uuml; Seite 1")) ?>
					<?= screenShot("menu2", text("Menu page 2", "Men&uuml; Seite 2")) ?>
					<?= screenShot("counting", text("Counting", "Z&auml;hlen")) ?>
					<?= screenShot("addition", text("Addition", "Addition")) ?>
					<?= screenShot("subtraction", text("Subtraction", "Subtraktion")) ?>
					<?= screenShot("reading", text("Reading words", "W&ouml;rter lesen")) ?>
					<?= screenShot("spelling", text("Spelling", "Buchstabieren")) ?>
					<?= screenShot("readingclock1", text("Reading clock", "Uhr lesen")) ?>
					<?= screenShot("readingclock2", text("Reading clocks", "Uhren lesen")) ?>
					<?= screenShot("readingnotes", text("Reading notes", "Noten lesen")) ?>
					<?= screenShot("readingintervals", text("Reading intervals", "Intervalle lesen")) ?>
					<?= screenShot("playingnotes", text("Playing notes", "Noten spielen")) ?>
				</div>
<?
			break;
			case 'license':
?>
				<h2><?= text('License', 'Lizenz'); ?></h2>
				<p>
					Touch'n'learn - <?= tagLine() ?><br />
					Copyright (C) 1998, 2007 by Alessandro Portale<br />
					<a class="external" href="http://touchandlearn.sourceforge.net/<?= text('', '?lang=german'); ?>">http://touchandlearn.sourceforge.net/</a>
				</p>
				<?= text('', '<p><em>Der folgende Lizenztext ist in seiner englischen Originalfassung aufgef&uuml;hrt, da die <a class="external" href="http://www.gnu.de/gpl-ger.html">deutsche &Uuml;bersetzung</a> nicht offiziell oder im rechtlichen Sinne anerkannt ist.</em></p>'); ?>
				<p>Touch'n'learn is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.</p>
				<p>Touch'n'learn is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the <a class="external" href="http://www.gnu.org/copyleft/gpl.html">GNU General Public License</a> for more details.</p>
<?
			break;
			default:
?>
				<h2><?= text('About', '&Uuml;ber'); ?></h2>
				<?= text('<p>An educative software for physically challenged children which is completely usable with a touch screen. The elements of the user interface are big and clear.</p><p>It was created during a practical semestre. Since a few years, the <a href="http://www.luckenberger-schule.de/">Luckenberger elementary school</a> in <a href="http://www.stadt-brb.de/stadt-brandenburg/">Brandenburg an der Havel</a> integrates physically challenged children into the lessons. This software was concepted together with Heiko Nachtigall, the vice president of the school.</p><p>When a physically challenged child has problems using pen and paper or other pedagogical material, it may happen that th child stays behind other children with its learning pensum. Using the hands when is are very essential for learning at the age of 6 or 7. A learning program which is really easy to use with a touch screen and has big and uncomplicated user interface elements could maybe compensate those motorical problems a little bit.</p>',
'<p>Ein Lernprogramm für körperlich behinderte Grundschulkinder, das für die Benutzung mit einem Touchscreen geeignet ist. Die Bedienelemente sind groß und deutlich.</p><p>Das Programm enstand im Zuge eines Praktikumssemesters. Die <a href="http://www.luckenberger-schule.de/">Luckenberger Grundschule</a> in <a href="http://www.stadt-brb.de/stadt-brandenburg/">Brandenburg an der Havel</a> integriert seit einigen Jahren körperlich behinderte und lernbehinderte Kinder in den Schulalltag. Zusammen mit Herrn Heiko Nachtigall, dem stellvertretenden Schulleiter der Schule, wurde es konzipiert.</p><p>Ein körperlich behindertes Kind kann, wenn es Schwierigkeiten im Umgang mit Stift und Papier oder pädagogischem Spielzeug hat, in den frühen Grundschuljahren evtl. mit dem Lernpensum zurück bleiben. Das Be-"greifen" spielt beim Lernen eine wichtige Rolle. Ein leicht per Touchscreen bedienbares Lernprogramm mit großen Bedienelementen kann diese motorischen Schwierigkeiten eventuell teilweise kompensieren.</p>') ?>
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
		<meta name="description" content="Touch 'n learn - <?= tagLine(); ?>" />
		<meta name="keywords" content="learn, education, handicapped, application, tool, app, free, freeware" />
		<title>Touch'n'learn - <?= tagLine() ?></title>
		<style type="text/css" media="all">
			@import "style.css";
		</style>
	</head>
	<body>
		<div id="page">
			<div id="header">
				<div id="title">Touch'n'learn</div><div id="tagline"><?= tagLine() ?></div>
				<a href="<?=linkParameters("","english")?>"><img src="flagEnglish<?= text('_selected', ''); ?>.png" width="26" height="17" alt="English" /></a><a href="<?=linkParameters("","german")?>"><img src="flagGerman<?= text('', '_selected'); ?>.png" width="26" height="17" alt="Deutsch" /></a>
			</div>
			<ul id="navigationlist">
				<li><a href="<?=linkParameters("about","")?>"<?=conditionalSelectedClass("about")?>><?= text('About', '&Uuml;ber'); ?></a></li><li><a href="<?=linkParameters("screenshots","")?>"<?=conditionalSelectedClass("screenshots")?>><?= text('Screenshots', 'Bildschirmfotos'); ?></a></li><li><a class="external" href="http://www.google.com"><?= text('Download', 'Herunterladen'); ?></a></li><li><a href="<?=linkParameters("license","")?>"<?=conditionalSelectedClass("license")?>><?= text('License', 'Lizenz'); ?></a></li><li><a class="external" href="http://sourceforge.net/projects/touchandlearn/"><?= text('SF project page', 'SF Projekt-Seite'); ?></a></li></ul>
			<div id="content">
<?=writeContent();?>

			</div>
			<div id="footer">
				<a class="external" href="http://sourceforge.net"><img src="http://sourceforge.net/sflogo.php?group_id=209276&amp;type=1" width="88" height="31" alt="SF.net Logo" /></a>
			</div>
		</div>
	</body>
</html>