<?php

class CSettingsUpdate extends Controller
{
	public function ActionDefault()
	{
		$log = "";
		
		header("Content-type: application/json; charset=utf8");
		$json = (object)array(
			'data' => (object)array(),
			'response' => (object)array()
		);
		
		$received = isset($this->request->post['received']) ? $this->request->post['received'] : false;
		$uid = isset($this->request->post['uid']) ? $this->request->post['uid'] : -1;
		
		if ( !$received ) {
			die( json_encode(array('error'=>'12', 'error_msg'=>'Not received friends')) );
		}
		
		$friendslist = (object)$this->vk->api('storage.get',array('key'=>'friendlist', 'v'=>'3.0', 'uid'=>$uid) );
		
		$log .= date("Y-m-d H:i:s") . " VK: storage.get (key: friendlist, v: 3.0, uid: ".$uid.") \r\n";
		
		if ( !$friendslist->response ) {
			$json->firstRun = true;
			$json->deleted = array();
			$json->r = $this->vk->api('storage.set', array('key'=>'friendlist', 'value'=>str_replace(',', '-', $received), 'v'=>'3.0', 'uid'=>$uid) );
			$log .= date("Y-m-d H:i:s") . " VK: storage.set (key: friendlist, value: ".str_replace(',', '-', $received).", v: 3.0, uid: ".$uid.") \r\n";
		} else {
			$saved = explode(',', str_replace('i', ',', $friendslist->response));
			$current = explode(',', $received);
			$deleted = array();
			foreach ( $saved as $u ) {
				if ( !in_array($u, $current) ) {
					$deleted[] = (integer)$u;
				}
			}
			$json->deleted = $deleted;
		}
		
		file_put_contents(DIR_PACKAGE.'api.log', file_get_contents(DIR_PACKAGE. 'api.log') . $log );
		echo json_encode($json);
	}
	
	public function ActionSave() {
		header("Content-type: application/json; charset=utf8");
		$json = (object)array(
			'data' => (object)array(),
			'response' => (object)array()
		);
		
		$received = isset($this->request->post['received']) ? $this->request->post['received'] : false;
		$uid = isset($this->request->post['uid']) ? $this->request->post['uid'] : -1;
		
		if ( !$received ) {
			die( json_encode(array('error'=>'12', 'error_msg'=>'Not received friends')) );
		}
		
		$r = $this->vk->api('storage.set', array('key'=>'friendlist', 'value'=>str_replace(",", 'i', $received), 'v'=>'3.0', 'uid'=>$uid) );
		$log .= date("Y-m-d H:i:s") . " VK: storage.set (key: friendlist, value: ".str_replace(",", 'i', $received).", v: 3.0, uid: ".$uid.") \r\n";
		
		if ( !$r ) {
			$json->error = 15;
		}
		echo json_encode($json);
		
		file_put_contents(DIR_PACKAGE.'api.log', file_get_contents(DIR_PACKAGE. 'api.log') . $log );
	}
}