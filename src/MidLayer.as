package
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class MidLayer extends Sprite
	{
		static private var _layer:DisplayObjectContainer;

		public static function get layer():DisplayObjectContainer
		{
			return _layer;
		}
		
		public function MidLayer()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.ENTER_FRAME, onFrameIn);
		}
		
		public static var ELAPSED:int;
		public static var TIMESTAMP:int;
		protected function onFrameIn(event:Event):void
		{
			var ts:int = getTimer();
			ELAPSED = ts - TIMESTAMP;
			TIMESTAMP = ts;
		}
		
		protected function onAddToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			_layer = this;
		}
		
		static public function DisableMouse():void
		{
			_layer.mouseChildren = _layer.mouseEnabled = false;
		}
		
		static public function EnableMouse():void
		{
			_layer.mouseChildren = _layer.mouseEnabled = true;
		}
		
		static public function ShowWindow(cls:Class, zhezhao:Boolean = false):void
		{
			ShowWindowObj(cls,{});
		}
		
		static public function SwapWindows(cls1:Class, cls2:Class):void
		{
			if(HasWindow(cls1) && HasWindow(cls2))
			{
				var v1:DisplayObject = _dic[cls1];
				var v2:DisplayObject = _dic[cls2];
				_layer.swapChildren(v1,v2);
			}
		}
		
		static private var _dic:Dictionary = new Dictionary;
		static private var _dicObj:Dictionary = new Dictionary;
		static public function ShowWindowObj(cls:Class, obj:Object):void
		{
			if(HasWindow(cls))CloseWindow(cls);
			_dicObj[cls] = obj;
			
			var v:DisplayObject;
			if(obj.params)
			{
				var params:Array = obj.params;
				switch(params.length)
				{
					case 0:
						v = new cls();
						break;
					case 1:
						v = new cls(params[0]);
						break;
					case 2:
						v = new cls(params[0],params[1]);
						break;
					case 3:
						v = new cls(params[0],params[1],params[2]);
						break;
					case 4:
						v = new cls(params[0],params[1],params[2],params[3]);
						break;
					default:
						throw new Error("params: can't support more than 4 params");
				}
			}
			else
			{
				v = new cls();
			}
			
			_layer.addChild(v);
			_dic[cls] = v;
			
			if("autoInit" in v)
			{
				v["autoInit"]();
			}
		}
		
		static public function CloseWindow(cls:Class):void
		{
			if(HasWindow(cls))
			{
				var v:DisplayObject = _dic[cls];
				_layer.removeChild(v);
				delete _dic[cls];
				
				var obj:Object = _dicObj[cls];
				if(obj.callback)
				{
					obj.callback();
				}

				delete _dicObj[cls];
			}
		}
		
		static public function HasWindow(cls:Class):Boolean
		{
			return _dic[cls]?true:false;
		}
	}
}