package view.help
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import data.MiniBuffer;
	import data.StaticTable;
	
	import lsg.BtnReturn;
	import lsg.bmp.help;
	import lsg.bmp.helpContinue;
	
	import view.blocks.BlocksView;
	import view.menu.MenuView;
	
	public class HelpView extends Sprite
	{
		private var _btnReturn:BtnReturn, _btnContinue:Sprite;
		
		public function HelpView()
		{
			addChild(new Bitmap(new help));
			_btnReturn = new BtnReturn;
			_btnReturn.x = StaticTable.STAGE_WIDTH - _btnReturn.width - 10;
			_btnReturn.y = StaticTable.STAGE_HEIGHT - _btnReturn.height - 10;
			addChild(_btnReturn);
			_btnReturn.addEventListener(MouseEvent.CLICK, onReturn);
			
			_btnContinue=new Sprite;
			_btnContinue.addChild(new Bitmap(new helpContinue));
			_btnContinue.x=(StaticTable.STAGE_WIDTH - _btnContinue.width)*.5;
			_btnContinue.y=(StaticTable.STAGE_HEIGHT - _btnContinue.height);
			addChild(_btnContinue);
			
			_btnContinue.addEventListener(MouseEvent.CLICK, onContinue);
		}
		
		protected function onContinue(event:MouseEvent):void
		{
			MiniBuffer.cookies.data.newbie = false;
			MidLayer.CloseWindow(HelpView);
			MidLayer.ShowWindow(BlocksView);
		}
		
		protected function onReturn(event:MouseEvent):void
		{
			MidLayer.CloseWindow(HelpView);
			MidLayer.ShowWindow(MenuView);
		}
	}
}