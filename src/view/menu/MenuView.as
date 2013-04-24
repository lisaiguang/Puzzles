package view.menu
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import data.MiniBuffer;
	import data.StaticTable;
	import data.staticObj.EnumMusic;
	
	import lsg.bmp.MenuBg;
	import lsg.bmp.MenuBoy;
	import lsg.bmp.MenuButtons;
	import lsg.bmp.MenuTitle;
	
	import view.blocks.BlocksView;
	import view.help.HelpView;
	import view.select.SelectView;
	
	CONFIG::ios
		{
			import data.staticObj.EnumString;
			import lsg.bmp.weibo;
		}
	public class MenuView extends Sprite
	{
		private var _bg:Bitmap, _boy:Sprite, _buttons:Sprite, _title:Bitmap, _weiboSprite:Sprite;
		public function MenuView()
		{
			_bg = new Bitmap(new MenuBg);
			addChild(_bg);
			
			var boy:Bitmap = new Bitmap(new MenuBoy);
			boy.y = -boy.height;
			_boy = new Sprite;
			_boy.y = 800;
			_boy.addChild(boy);
			addChild(_boy);
			_boy.rotation = -180;
			TweenLite.to(_boy, .5, {rotation:0, delay:1.1, ease:Back.easeOut});
			
			var buttons:Bitmap = new Bitmap(new MenuButtons);
			buttons.x = -buttons.width*.5;
			buttons.y = -buttons.height;
			_buttons = new Sprite;
			_buttons.y = StaticTable.STAGE_HEIGHT;
			_buttons.x = StaticTable.STAGE_WIDTH*.5;
			_buttons.addChild(buttons);
			addChild(_buttons);
			_buttons.rotation = 180;
			_buttons.addEventListener(MouseEvent.CLICK, onClick);
			TweenLite.to(_buttons, .6, {rotation:0, delay:0.5, ease:Back.easeOut});
			
			_title = new Bitmap(new MenuTitle);
			_title.x = (StaticTable.STAGE_WIDTH - _title.width)*.5;
			_title.y = -_title.height;
			addChild(_title);
			TweenLite.to(_title, .5, {y:0, delay:.5, ease:Back.easeOut});
			
			CONFIG::ios
				{
					if(sUI.isSupported)
					{
						var weiboBmp:Bitmap = new Bitmap(new weibo);
						weiboBmp.scaleX = weiboBmp.scaleY = 1.5;
						weiboBmp.x = -weiboBmp.width * .5;
						weiboBmp.y = -weiboBmp.height * .5;
						_weiboSprite = new Sprite;
						_weiboSprite.x = StaticTable.STAGE_WIDTH - weiboBmp.width * .5 - 40;
						_weiboSprite.y = StaticTable.STAGE_HEIGHT + weiboBmp.height * .5;
						_weiboSprite.addChild(weiboBmp);
						_weiboSprite.addEventListener(MouseEvent.CLICK, onWeiboClick);
						addChild(_weiboSprite);
						TweenLite.to(_weiboSprite, .3, {delay:1.6, y:StaticTable.STAGE_HEIGHT - weiboBmp.height * .5 - 40});
						TweenLite.to(_weiboSprite, .3, {delay:2.1, rotation:360});
					}
				}
		}
		
		CONFIG::ios
			{
				protected var sUI:SocialUI=new SocialUI(SocialServiceType.SINAWEIBO);
				protected function onWeiboClick(event:MouseEvent):void
				{
					StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
					sUI.setMessage("我正在IPhone上挖红薯呢！");
					sUI.addURL(StaticTable.STR_DIC[EnumString.APP_URL]);
					sUI.launch();
				}
			}
			
			protected function onClick(e:MouseEvent):void
			{
				var cx:Number = e.stageX / StaticTable.SCALE_X;
				var cy:Number = e.stageY / StaticTable.SCALE_Y;
				
				if(checkIn(cx,cy,_buttons))
				{
					cy = cy - _buttons.y + _buttons.height;
					if(cy < 140)
					{
						StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
						MidLayer.CloseWindow(MenuView);
						MidLayer.ShowWindowObj(BlocksView, {params:[MiniBuffer.cookies.data.levelId]});
					}
					else if(cy > 150 && cy < 300)
					{
						StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
						MidLayer.CloseWindow(MenuView);
						MidLayer.ShowWindow(SelectView);
					}
					else if(cy < 450)
					{
						StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
						MidLayer.CloseWindow(MenuView);
						MidLayer.ShowWindow(HelpView);
					}
				}
			}
			
			public static function checkIn(cx:Number, cy:Number, bmp:DisplayObject):Boolean
			{
				return (cx >= bmp.x -  bmp.width * .5 && cx <= bmp.x + bmp.width * .5 && cy >= bmp.y - bmp.height && cy <= bmp.y )
			}
	}
}