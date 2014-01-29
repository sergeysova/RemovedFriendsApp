package  {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.errors.*;
	import flash.events.*;
	import flash.net.URLLoaderDataFormat;
	import flash.display.BitmapData;
	import flash.system.LoaderContext;
	
	public class FriendsList {
		private var list:MovieClip;
		private var count:Number;
		
		public function FriendsList( l:MovieClip ) {
			list = l;
			count = 0;
		}
		
		public function Add( name:String, image:* = false ):void {
			var temp:Friend = new Friend();
			temp.ff.text = name;
			temp.x = 25;
			temp.y = ( 50 + 10 ) * count;
			
			if ( image ) {
				var loader:Loader;
				//function loadAvatar( url:String ) {
					var url:String = image as String;
					trace("avatar loading: ", url);
					loader = new Loader();
					loader.cacheAsBitmap = true;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event){
						trace("Avatar loaded...");
						temp.ff.appendText(" (");
						temp.ff.appendText(" " + loader.contentLoaderInfo.contentType);
						var imgss:Bitmap = loader.contentLoaderInfo.content as Bitmap;
						temp.ff.appendText(" -");
						imgss.x = 0;
						imgss.y = 0;
						imgss.visible = true;
						temp.addChild(loader);
						temp.ff.appendText(" )");
						trace("Load complete!");
					});
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
						function(e:Event){
							trace("Load error!");
							temp.ff.appendText(" IO Error");
						}
					);
					loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
						function(e:Event){
							trace("Load error!");
							temp.ff.appendText(" Security Error");
						}
					);
					var context:LoaderContext = new LoaderContext();
					context.checkPolicyFile = false;
					loader.load( new URLRequest( url + "?" + int(Math.random() * 100000) ), context );
				//}
				//loadAvatar(image);
			}
			
			list.addChild(temp);
			count++;
		}
		
		public function Clear():void {
			while ( list.numChildren > 0 ) {
				list.removeChildAt(0);
			}
			count = 0;
		}
	}
	
}
