/*
Author: LestaD
test visitor: TalasD
*/
package com.app {
	import com.vk.*;
	import com.vk.api.serialization.json.*;
	import flash.net.*;
	import flash.errors.*;
	import flash.net.URLRequest;
	import flash.display.*;
	import flash.events.*;
	
	public class AppAPI {
		private var gameServer:String = "http://removefriendsapp.lestad.net/";
		private var gameApi:String = "settings/update";
		
		private var uLoader:URLLoader;
		private var uRequest:URLRequest;
		private var uOnComplete:Function;
		private var uOnError:Function;
		
		public function AppAPI() {
			
		}
		
		public function call(method:String, data:Object, onComplete:Function = null, onError:Function = null):void {
			uOnComplete = onComplete;
			uOnError = onError;
			uLoader = new URLLoader();
			
			method = method.split(".").join("/");
			
			var uri:String = String( gameServer + method + "?h=" + new Date().getTime() );
			trace(uri);
			uRequest = new URLRequest( uri );
			var uVars:URLVariables = new URLVariables();
			for ( var j:Object in data ) {
				uVars[j] = data[j];
			}
			
			uRequest.method = URLRequestMethod.POST;
			uRequest.data = uVars;
			uLoader.addEventListener(Event.COMPLETE, this.callComplete );
			uLoader.addEventListener(IOErrorEvent.IO_ERROR, this.callError );
			uLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.callError2 );
			uLoader.load( uRequest );
		}
		
		private function removeEventListeners():void {
			uLoader.removeEventListener(Event.COMPLETE, this.callComplete );
			uLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.callError );
			uLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.callError );
		}
		
		private function callComplete(e:Event):void {
			trace("Server response:", uLoader.data );
			var d:Object = JSON.decode(uLoader.data);
			if ( d.error ) {
				uOnError(d);
			} else {
				uOnComplete(d);
			}
			removeEventListeners();
		}
		
		private function callError(e:Event):void {
			uOnError({error: 900, error_msg: "IO Error !"}); //Method call error! 
			removeEventListeners();
		}
		
		private function callError2(e:Event):void {
			uOnError({error: 902, error_msg: "Security error!"}); //Method call error! 
			removeEventListeners();
		}
	}
	
}



/*

we CAN'T trace OBJECTS!!! Mother of God1

*/