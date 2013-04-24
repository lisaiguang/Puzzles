package
{
	import com.greensock.plugins.ColorMatrixFilterPlugin;
	import com.greensock.plugins.EndArrayPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import data.MiniBuffer;
	import data.MiniSingals;
	import data.StaticTable;
	import data.message.PauseReq;
	
	CONFIG::android
		{
			import flash.display.Bitmap;
			import lsg.bmp.Default;
			import com.greensock.TweenLite;
		}
	
	import view.menu.MenuView;
	
	
	[SWF(frameRate="30")]
	public class Puzzles extends Sprite
	{
		private var _midLayer:MidLayer = new MidLayer;
		
		
		public function Puzzles()
		{
			TweenPlugin.activate([ColorMatrixFilterPlugin, EndArrayPlugin]);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			StaticTable.Init();
			MiniBuffer.Init();
			
			addChild(_midLayer);
			_midLayer.scaleX = StaticTable.SCALE_X = stage.fullScreenWidth / StaticTable.STAGE_WIDTH;
			_midLayer.scaleY = StaticTable.SCALE_Y = stage.fullScreenHeight / StaticTable.STAGE_HEIGHT;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void { 
					NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
				});
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void {
					MiniSingals.OnPauseReq.dispatch(new PauseReq);
					NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
				});
		}
		
		protected function onAddToStage(event:flash.events.Event):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddToStage);
			
			CONFIG::ios
				{
					MidLayer.ShowWindow(MenuView);
				}
			CONFIG::android
				{
					var bmp:Bitmap = new Bitmap(new Default);
					bmp.scaleX = StaticTable.SCALE_X;
					bmp.scaleY = StaticTable.SCALE_Y;
					addChild(bmp);
					TweenLite.delayedCall(2, function():void{MidLayer.ShowWindow(MenuView);removeChild(bmp);}, [bmp]);
				}
		}
	}
}