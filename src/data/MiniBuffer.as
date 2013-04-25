package data
{
	import flash.net.SharedObject;
	
	public class MiniBuffer
	{
		public static var model:int;
		public static var cookies:SharedObject;
		
		public static function Init():void
		{
			cookies = SharedObject.getLocal("scores");
			if(!cookies.data.levelId)cookies.data.levelId=1;
			if(!cookies.data.unlocklevelId)cookies.data.unlocklevelId=1;
			if(!cookies.data.newbie)MiniBuffer.cookies.data.newbie=false;
			if(!cookies.data.purchased)MiniBuffer.cookies.data.purchased=[];
		}
	}
}