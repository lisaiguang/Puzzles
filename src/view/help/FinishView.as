package view.help
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import data.StaticTable;
	
	import lsg.BtnReturn;
	import lsg.bmp.allFinish;
	import lsg.bmp.clickFinish;
	import lsg.bmp.fj;
	import lsg.bmp.fjHand;
	import lsg.bmp.fjWords;
	
	import view.menu.MenuView;
	
	public class FinishView extends Sprite
	{
		private var _btnReturn:BtnReturn, _btnContinue:Sprite;
		private var _bmpFj:Bitmap, _fjHand:Sprite, _bmpWords:Bitmap;
		
		public function FinishView()
		{
			
			addChild(new Bitmap(new allFinish));
			_btnReturn = new BtnReturn;
			_btnReturn.x = StaticTable.STAGE_WIDTH - _btnReturn.width - 10;
			_btnReturn.y = StaticTable.STAGE_HEIGHT - _btnReturn.height - 10;
			addChild(_btnReturn);
			_btnReturn.addEventListener(MouseEvent.CLICK, onReturn);
			
			_btnContinue=new Sprite;
			_btnContinue.addChild(new Bitmap(new clickFinish));
			_btnContinue.x=(StaticTable.STAGE_WIDTH - _btnContinue.width)*.5;
			_btnContinue.y=(StaticTable.STAGE_HEIGHT - _btnContinue.height);
			addChild(_btnContinue);
			
			_bmpFj = new Bitmap(new fj);
			_bmpFj.x=407;
			_bmpFj.y=107;
			addChild(_bmpFj);
			
			_fjHand=new Sprite;
			var _bmpHand:Bitmap = new Bitmap(new fjHand);
			_bmpHand.x=-_bmpHand.width*.5;
			_bmpHand.y=-_bmpHand.height*.6;
			_fjHand.addChild(_bmpHand);
			_fjHand.x = 568 + _bmpHand.width*.5;
			_fjHand.y = 257 + _bmpHand.height*.6;
			addChild(_fjHand)
			
			_bmpWords = new Bitmap(new fjWords);
			_bmpWords.x=470;
			_bmpWords.y=11;
			TweenLite.delayedCall(4.5,AddWords);
			
			_btnContinue.addEventListener(MouseEvent.CLICK, onContinue);
			addEventListener(Event.ENTER_FRAME, onFrameIn);
		}
		
		private function AddWords():void
		{
			addChild(_bmpWords);
			TweenLite.delayedCall(3.5,RemoveWords);
		}
		
		private function RemoveWords():void
		{
			removeChild(_bmpWords);
			TweenLite.to(_bmpFj,5,{alpha:0});
			TweenLite.to(_fjHand,5,{alpha:0});
		}
		
		private var _direct:int = 1;
		protected function onFrameIn(event:Event):void
		{
			if(_fjHand.rotationZ > 10)_direct=-1;
			if(_fjHand.rotationZ < -10)_direct=1;
			_fjHand.rotationZ += _direct*1;
		}
		
		protected function onContinue(event:MouseEvent):void
		{
			navigateToURL(new URLRequest("https://itunes.apple.com/cn/app/yao-ni-da-ye/id631859685"));
		}
		
		protected function onReturn(event:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, onFrameIn);
			MidLayer.CloseWindow(FinishView);
			MidLayer.ShowWindow(MenuView);
		}
	}
}