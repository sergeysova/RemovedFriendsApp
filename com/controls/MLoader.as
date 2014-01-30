package com.controls {
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	
	public class MLoader extends Loader {
		private var _url:String;
		
		
		public function MLoader( url:String ) {
			_url = url;
			
			var request:URLRequest = new URLRequest();
			var context:LoaderContext = new LoaderContext();
			
			context.checkPolicyFile = false;
			request.url = url;
			
			this.load(request, context);
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete( event:Event )
		{
			this.removeEventListener(Event.COMPLETE, onComplete);
			dispatchEvent(event);
		}
		
		public function get url():String
		{
			return _url;
		}

	}
	
}
