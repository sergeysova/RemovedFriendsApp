package  {
	import flash.display.MovieClip;
	
	public class FriendsList {
		private var list:MovieClip;
		private var count:Number;
		
		public function FriendsList( l:MovieClip ) {
			list = l;
			count = 0;
		}
		
		public function Add( name:String, image:* ):void {
			var temp:Friend = new Friend();
			temp.ff.text = name;
			temp.x = 25;
			temp.y = ( 47 + 10 ) * count;
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
