<?php

define("APP_ID",		'4144124',	true);
define("APP_SECRET",	'9Rx9rPWJIveJCAFETf2U',	true);
define("LINK_AUTH",		'https://oauth.vk.com/access_token?client_id=' . APP_ID . '&client_secret=' . APP_SECRET . '&grant_type=client_credentials', true);
define("LINK_API",		'https://api.vk.com/method/', true);


class PackageRemovefriendsapp extends \System\Package
{
	private $access_token = false;
	
	public function onRun($args)
	{
		include DIR_PACKAGE . 'vkapi.class.php';
		
		$this->vk = new vkapi(APP_ID, APP_SECRET);
		
		//$this->cache->Enable(DIR_PACKAGE);
		//$this->db->init();
		
		/*
		$lang = $this->detector->LanguageMatchBest(array(
			'ru'=>array('ru','uk')
		), 'en');
		*/
		
		//$this->locale->folder = DIR_PACKAGE . 'i10n' . DS;
		//$this->locale->setLanguage($lang);
		//$this->locale->add('common');
		//$this->view->folder = DIR_PACKAGE . 'view' . DS;
		
		$this->detector->runControllerScheme($args);
	}
}