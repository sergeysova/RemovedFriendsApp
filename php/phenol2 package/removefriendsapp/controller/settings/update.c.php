<?php

class CSettingsUpdate extends Controller
{
	public function ActionDefault()
	{
		header("Content-type: application/json; charset=utf8");
		$json = (object)array(
			'data' => (object)array(),
			'response' => (object)array()
		);
		
		$received = isset($this->request->post['received']) ? $this->request->post['received'] : false;
		
		if ( !$received ) {
			die( json_encode(array('error'=>'12', 'error_msg'=>'Not received friends')) );
		}
		
		$friendslist = (object)$this->vk->api('storage.get',array('key'=>'friendlist', 'v'=>'5.7'));
		
		if ( !$friendslist->response ) {
			$json->firstRun = true;
			$json->deleted = array();
			$json->r = $this->vk->api('storage.set', array('key'=>'friendlist', 'value'=>$received, 'v'=>'5.7'));
		} else {
			$saved = explode(',', $friendslist->response);
			$current = explode(',', $received);
			$deleted = array();
			foreach ( $saved as $u ) {
				if ( !in_array($u, $current) ) {
					$deleted[] = (integer)$u;
				}
			}
			$json->deleted = $deleted;
		}
		
		
		echo json_encode($json);
	}
	
	public function ActionSave() {
		header("Content-type: application/json; charset=utf8");
		$json = (object)array(
			'data' => (object)array(),
			'response' => (object)array()
		);
		
		$received = isset($this->request->post['received']) ? $this->request->post['received'] : false;
		if ( !$received ) {
			die( json_encode(array('error'=>'12', 'error_msg'=>'Not received friends')) );
		}
		
		$r = $this->vk->api('storage.set', array('key'=>'friendlist', 'value'=>$received, 'v'=>'5.7'));
		echo json_encode($json);
	}
}