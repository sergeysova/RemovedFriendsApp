package  {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.errors.*;
	import flash.events.*;
	
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
				function loadAvatar( url:String ) {
					trace("avatar loading: ", url);
					loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event){
						trace("Avatar loaded...");
						var img:Bitmap = loader.contentLoaderInfo.content as Bitmap;
						temp.addChild(img);
						trace("Load complete!");
					});
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
						function(e:Event){
							trace("Load error!");
						}
					);
					loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
						function(e:Event){
							trace("Load error!");
						}
					);
					loader.load( new URLRequest( url ) );
				}
				
				
				
				loadAvatar(image);
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
