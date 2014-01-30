package com.app {
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
	import com.controls.MLoader;
	
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
				var url:String = image as String;
				trace("avatar loading: ", url);
				temp.addChild( new MLoader(url) );
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
