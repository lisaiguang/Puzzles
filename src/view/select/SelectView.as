package view.select
{
	import com.greensock.TweenLite;
	import com.greensock.easing.ElasticOut;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import data.MiniBuffer;
	import data.StaticTable;
	import data.staticObj.EnumMusic;
	import data.staticObj.MapDesc;
	
	import lsg.BtnPage;
	import lsg.BtnReturn;
	import lsg.bmp.SelectBg;
	import lsg.bmp.SelectMuBan;
	import lsg.bmp.SelectZhi1;
	import lsg.bmp.SelectZhi2;
	
	import view.blocks.BlocksView;
	import view.menu.MenuView;
	
	public class SelectView extends Sprite
	{
		private var _unlockBoxes:Array=[];
		private var _unlockBoxesId:Array=[];
		private var muban:Bitmap, _startId:int;
		
		public function SelectView(startId:int = 1)
		{
			_startId = startId;
			
			var bmp:Bitmap = new Bitmap(new SelectBg);
			addChild(bmp);
			
			muban = new Bitmap(new SelectMuBan);
			muban.x = (StaticTable.STAGE_WIDTH - muban.width)*.5 + 15;
			muban.y = -muban.height;
			addChild(muban);
			
			TweenLite.to(muban, 0.5, {y:0, ease:ElasticOut, onComplete:makeZhis}); 
		}
		
		private function makeZhis():void
		{
			var bd:BitmapData = new SelectZhi1;
			var bd2:BitmapData = new SelectZhi2;
			var openId:int = MiniBuffer.cookies.data.unlocklevelId;

			for(var i:int = 0; i<9 && _startId+i <= openId; i++)
			{
				var md:MapDesc = StaticTable.GetMapDesc(_startId + i);
				if(!md)break;
				
				var spt:Sprite = new Sprite;
				spt.name=md.id+"";
				
				var type:int = Math.random() < 0.5?1:2;
				var bmp:Bitmap = new Bitmap(type==1?bd:bd2);
				bmp.scaleX = bmp.scaleY = 1.05;
				bmp.x = -bmp.width*.5 + 10;
				bmp.y = -bmp.height*.5 + 10;
				spt.addChild(bmp);
				
				spt.x = (i%3)*(bmp.width + 10) + bmp.width*.5 - 25 + muban.x;
				spt.y=int(i/3)*(bmp.height - 4) + bmp.height*.5 + 30 + (type==1?0:5);
				spt.rotationZ = (Math.random() - .5) * 10;
				addChild(spt);
				spt.addEventListener(MouseEvent.CLICK, onMouseClick);
				
				var cls:Class = getDefinitionByName("lsg.bmp.privew" + (_startId + i)) as Class;
				bmp=new Bitmap(new cls);
				bmp.x = -73;
				bmp.y = -66 + (type==2?-1:0);
				spt.addChild(bmp);
			}
			
			const btnY:uint = 730;
			
			if(_startId < 10)
			{
				if(_startId + 8 < openId)
				{
					var btn:BtnPage = new BtnPage;
					btn.x = (StaticTable.STAGE_WIDTH - btn.width)*.5;
					btn.y=btnY;
					addChild(btn);
					btn.addEventListener(MouseEvent.CLICK,onNext);
				}
			}
			else
			{
				if(_startId + 8 < openId)
				{
					btn = new BtnPage;
					btn.x = (StaticTable.STAGE_WIDTH - btn.width*2 - 80)*.5 + btn.width;
					btn.y=btnY;
					btn.rotationY = 180;
					addChild(btn);
					btn.addEventListener(MouseEvent.CLICK,onPrev);
					
					var btn1:BtnPage = new BtnPage;
					btn1.x = btn.x + 80;
					btn1.y=btnY;
					addChild(btn1);
					btn1.addEventListener(MouseEvent.CLICK,onNext);
				}
				else
				{
					btn = new BtnPage;
					btn.x = (StaticTable.STAGE_WIDTH - btn.width)*.5 + btn.width;
					btn.y=btnY;
					btn.rotationY = 180;
					addChild(btn);
					btn.addEventListener(MouseEvent.CLICK,onPrev);
				}
			}
			
			var btnReturn:BtnReturn = new BtnReturn;
			btnReturn.x = StaticTable.STAGE_WIDTH - btnReturn.width - 10;
			btnReturn.y = StaticTable.STAGE_HEIGHT - btnReturn.height - 10;
			addChild(btnReturn);
			btnReturn.addEventListener(MouseEvent.CLICK, onReturn);
		}
		
		protected function onReturn(event:MouseEvent):void
		{
			StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
			MidLayer.CloseWindow(SelectView);
			MidLayer.ShowWindow(MenuView);
		}
		
		protected function onPrev(event:MouseEvent):void
		{
			StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
			MidLayer.ShowWindowObj(SelectView,{params:[_startId - 9]});
		}
		
		protected function onNext(event:MouseEvent):void
		{
			StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
			MidLayer.ShowWindowObj(SelectView,{params:[_startId + 9]});
		}
		
		protected function onMouseClick(e:MouseEvent):void
		{
			StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
			var spt:Sprite = e.currentTarget as Sprite;
			var id:uint = uint(spt.name);
			MidLayer.CloseWindow(SelectView);
			MidLayer.ShowWindowObj(BlocksView,{params:[id]});
		}
	}
}