package view.blocks
{
	CONFIG::ios
		{
			import com.adobe.ane.productStore.ProductEvent;
			import com.adobe.ane.productStore.ProductStore;
			import com.adobe.ane.productStore.TransactionEvent;
			
			import flash.geom.Matrix;
			
			import data.staticObj.EnumString;
			
			import lsg.bmp.weibo;
			
			import view.wait.WaitingView;
		}
		
		import com.greensock.TweenLite;
	import com.urbansquall.ginger.AnimationBmp;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import data.MiniBuffer;
	import data.StaticTable;
	import data.staticObj.BlockDesc;
	import data.staticObj.EnumMusic;
	import data.staticObj.MapDesc;
	
	import lsg.bmp.featureArea;
	import lsg.bmp.hongshu;
	import lsg.bmp.hongshu1;
	import lsg.bmp.hongshu2;
	import lsg.bmp.hongshu3;
	import lsg.bmp.newbie1;
	import lsg.bmp.newbie2;
	import lsg.btn.BtnJiemi;
	import lsg.btn.BtnMenu;
	import lsg.btn.BtnReset;
	
	import music.SoundPlayer;
	
	import utils.LazySprite;
	
	import view.blocks.block.Block;
	import view.blocks.block.Block1;
	import view.blocks.block.Block10;
	import view.blocks.block.Block11;
	import view.blocks.block.Block12;
	import view.blocks.block.Block13;
	import view.blocks.block.Block14;
	import view.blocks.block.Block15;
	import view.blocks.block.Block16;
	import view.blocks.block.Block17;
	import view.blocks.block.Block18;
	import view.blocks.block.Block2;
	import view.blocks.block.Block3;
	import view.blocks.block.Block4;
	import view.blocks.block.Block5;
	import view.blocks.block.Block6;
	import view.blocks.block.Block7;
	import view.blocks.block.Block8;
	import view.blocks.block.Block9;
	import view.menu.MenuView;
	import view.help.FinishView;
	import lsg.bmp.bg31;
	import lsg.bmp.bg22;
	import lsg.bmp.bg21;
	import lsg.bmp.bg11;
	import lsg.bmp.bg12;
	
	public class BlocksView extends LazySprite
	{
		private var _btnMenu:BtnMenu, _btnReset:BtnReset, _btnJiemi:BtnJiemi, _btnWeibo:Sprite;
		private var _bmpFanzhuan90:Rectangle, _bmpFanzhuan180:Rectangle, _bmpFanZhuan270:Rectangle, _bmpShuipin:Rectangle;
		private var _mapAreaTop:Number, _mapAreaBottom:Number;
		private var _soundSelect:SoundPlayer, _soundRotation:SoundPlayer, _soundBite:SoundPlayer;
		private var _isNewBie:int;
		public function BlocksView(id:int = 1)
		{
			if(!MiniBuffer.cookies.data.newbie)
			{
				if(id==1)
				{
					_isNewBie=1;
				}
				else
				{
					MiniBuffer.cookies.data.newbie=true;
				}
			}
			
			_soundSelect = StaticTable.GetSoundPlayer(EnumMusic.SELECT);
			_soundRotation = StaticTable.GetSoundPlayer(EnumMusic.ROTATION);
			_soundBite = StaticTable.GetSoundPlayer(EnumMusic.BITE);
			
			var _buttonPaddingLeft:int = 0;
			
			_btnMenu = new BtnMenu;
			_btnMenu.x = StaticTable.STAGE_WIDTH - _btnMenu.width - _buttonPaddingLeft;
			_btnMenu.y = 0;
			addChild(_btnMenu);
			_btnMenu.addEventListener(MouseEvent.CLICK, onMenu);
			_btnMenu.addEventListener(MouseEvent.MOUSE_DOWN, onStopEvent);
			
			_btnReset = new BtnReset;
			_btnReset.x = _btnMenu.x - _btnReset.width - _buttonPaddingLeft;
			_btnReset.y = _btnMenu.y;
			addChild(_btnReset);
			_btnReset.addEventListener(MouseEvent.CLICK, onReset);
			_btnReset.addEventListener(MouseEvent.MOUSE_DOWN, onStopEvent);
			
			CONFIG::ios
				{
					_btnJiemi = new BtnJiemi;
					_btnJiemi.x = _btnReset.x - _btnJiemi.width - _buttonPaddingLeft;
					_btnJiemi.y = _btnMenu.y;
					_btnJiemi.addEventListener(MouseEvent.CLICK, onJiemi);
					_btnJiemi.addEventListener(MouseEvent.MOUSE_DOWN, onStopEvent);
					
					productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_SUCCESS, purchaseTransactionSucceeded);
					productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_CANCEL, purchaseTransactionCanceled);
					productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_FAIL, purchaseTransactionFailed);
					productStore.addEventListener(ProductEvent.PRODUCT_DETAILS_SUCCESS,productDetailsSucceeded);
					productStore.addEventListener(ProductEvent.PRODUCT_DETAILS_FAIL, productDetailsFailed);
					var vector:Vector.<String>=new <String>["weiyou.jiemi"];
					TweenLite.delayedCall(2, productStore.requestProductsDetails, [vector]);
					
					if(sUI.isSupported)
					{
						_btnWeibo = new Sprite;
						_btnWeibo.scaleX = _btnWeibo.scaleY = 1.5;
						_btnWeibo.addChild(new Bitmap(new weibo));
						_btnWeibo.x = _btnJiemi.x - _btnWeibo.width - _buttonPaddingLeft - 10;
						_btnWeibo.y = _btnJiemi.y - 5;
						addChild(_btnWeibo);
						_btnWeibo.addEventListener(MouseEvent.CLICK, onWeiboClick);
					}
				}
				
				_mapAreaTop = _btnReset.y + _btnReset.height;
			
			var bmpArea:Bitmap = new Bitmap(new featureArea);
			bmpArea.x = (StaticTable.STAGE_WIDTH - bmpArea.width) *.5;
			bmpArea.y = StaticTable.STAGE_HEIGHT - bmpArea.height - 10;
			addChild(bmpArea);
			
			_bmpFanZhuan270=new Rectangle;
			_bmpFanZhuan270.x=bmpArea.x;
			_bmpFanZhuan270.y=bmpArea.y;
			_bmpFanZhuan270.width=bmpArea.width/3;
			_bmpFanZhuan270.height=bmpArea.height/2;
			
			_bmpFanzhuan180=new Rectangle;
			_bmpFanzhuan180.x=_bmpFanZhuan270.x + _bmpFanZhuan270.width;
			_bmpFanzhuan180.y=_bmpFanZhuan270.y;
			_bmpFanzhuan180.width=_bmpFanZhuan270.width;
			_bmpFanzhuan180.height=_bmpFanZhuan270.height;
			
			_bmpFanzhuan90=new Rectangle;
			_bmpFanzhuan90.x=_bmpFanzhuan180.x + _bmpFanzhuan180.width;
			_bmpFanzhuan90.y=_bmpFanzhuan180.y;
			_bmpFanzhuan90.width=_bmpFanzhuan180.width;
			_bmpFanzhuan90.height=_bmpFanzhuan180.height;
			
			_bmpShuipin=new Rectangle;
			_bmpShuipin.x=_bmpFanZhuan270.x;
			_bmpShuipin.y=_bmpFanZhuan270.y + _bmpFanZhuan270.height;
			_bmpShuipin.width=bmpArea.width;
			_bmpShuipin.height=bmpArea.height/2;
			
			_mapAreaBottom = bmpArea.y;
			
			initMap(id);
			addEventListener(Event.ENTER_FRAME, onFrameIn);
		}
		
		CONFIG::ios
			{
				private var sUI:SocialUI=new SocialUI(SocialServiceType.SINAWEIBO);
				protected function onWeiboClick(event:MouseEvent):void
				{
					StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
					var b:BitmapData = new BitmapData(StaticTable.STAGE_WIDTH/2, StaticTable.STAGE_HEIGHT/2, true, 0x0);
					var maxtrix:Matrix = new Matrix();
					maxtrix.scale(0.5,0.5);
					b.draw(this, maxtrix);
					sUI.addURL(StaticTable.STR_DIC[EnumString.APP_URL]);
					sUI.setMessage(_isFinish?"哈哈，这颗红薯被我挖出来了！(关卡：" + _mapDesc.id+")":"这个红薯我怎么也挖不出来，请大家帮帮我吧！(关卡：" + _mapDesc.id + ")");
					sUI.addImage(b);
					sUI.launch();
					event.stopPropagation();
				}
				
				protected function onJiemi(event:MouseEvent):void
				{
					StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
					MidLayer.DisableMouse();
					MidLayer.ShowWindow(WaitingView);
					productStore.makePurchaseTransaction("weiyou.jiemi",1);
				}
				
				private var productStore:ProductStore = new ProductStore;
				protected function productDetailsFailed(e:ProductEvent):void
				{
				}
				
				protected function productDetailsSucceeded(e:ProductEvent):void
				{
					addChild(_btnJiemi);
				}
				
				protected function purchaseTransactionFailed(event:TransactionEvent):void
				{
					MidLayer.EnableMouse();
					MidLayer.CloseWindow(WaitingView);
				}
				
				protected function purchaseTransactionCanceled(event:TransactionEvent):void
				{
					MidLayer.EnableMouse();
					MidLayer.CloseWindow(WaitingView);
				}
				
				protected function purchaseTransactionSucceeded(event:TransactionEvent):void
				{
					MidLayer.EnableMouse();
					MidLayer.CloseWindow(WaitingView);
					for(var i:int = 0; i < _mapDesc.blocks.length; i++)
					{
						var blockDesc:BlockDesc = _mapDesc.blocks[i];
						var block:Block = _blocks[i];
						block.restore();
						if(blockDesc.finalSp == 1)
						{
							block.shuipin();
						}
						if(blockDesc.finalFz)
						{
							block.fanzhuan(0, blockDesc.finalFz);
						}
						putBlockIn(block, blockDesc.finalX - 1, blockDesc.finalY - 1);
					}
					showSuccess();
					event.stopPropagation();
				}
			}
			
			protected function onStopEvent(event:MouseEvent):void
			{
				event.stopImmediatePropagation();
			}
			
			private var _putBlockIn:Boolean = false;
		protected function onFrameIn(event:Event):void
		{
			if(_putBlockIn)
			{
				if(_curBlock && !_curBlock.isTweening)
				{
					_putBlockIn = false;
					onFangxia();
				}
			}
			
			if(_lights)
			{
				_lights.update(MidLayer.ELAPSED);
				_lights.x = hs.x;
				_lights.y = hs.y;
			}
		}
		
		protected function onFangxia():void
		{
			if(_curBlock)
			{
				var startx:Boolean = true;
				for(var i:int = _curBlock.gridX; i != _curBlock.gridX || startx; i = (i+1)%_poses.length)
				{
					startx=false;
					var starty:Boolean = true;
					for(var j:int = _curBlock.gridY; j != _curBlock.gridY || starty; j = (j+1)%_poses[i].length)
					{
						starty=false;
						var isOkay:Boolean = true;
						var positions:Array = _curBlock.positions();
						for(var g:int = 0; g<positions.length; g+=2)
						{
							var gx:uint = i + positions[g] - 1;
							var gy:uint = j + positions[g+1] - 1;
							if(gx >= _poses.length || gy >= _poses[0].length || !_poses[gx][gy])
							{
								isOkay=false;
								break;
							}
						}
						if(isOkay)
						{
							_curBlock.down();
							putBlockIn(_curBlock, i, j);
							_curBlock = null;
							_soundSelect.play();
							if(_isNewBie)displayHelp(_isNewBie);
							break;
						}
					}
					if(!_curBlock)
					{
						var success:Boolean = true;
						for(j = 0; j < _mapDesc.hw; j++)
						{
							for(g = 0; g < _mapDesc.hh; g++)
							{
								if(_poses[_mapDesc.hx - 1 + j][_mapDesc.hy - 1 + g] == false) 
								{
									success = false;
								}
							}
						}
						if(success)
						{
							showSuccess();
						}
						break;
					}
				}
				
				if(_curBlock)
				{
					_curBlock.down();
					_curBlock.restore();
					if(_curSp)_curBlock.shuipin();
					if(_curFz)_curBlock.fanzhuan(0,_curFz);
					putBlockIn(_curBlock, _curGridX, _curGridY);
					_curBlock = null;
					_soundSelect.play();
				}
			}
		}
		
		private var bitsHs:Array;
		private var _lights:AnimationBmp;
		private const _hsScale:Number = 1.3;
		private var _isFinish:Boolean;
		private function showSuccess():void
		{
			if(_isFinish)return;
			_isFinish=true;
			saveLevel(_mapDesc.id + 1);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMapSelect);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.CLICK, onNext);
			
			StaticTable.GetSoundPlayer(EnumMusic.YAHOO).play();
			
			_lights = StaticTable.GetAniBmpByName("Light");
			_lights.scaleX = _lights.scaleY = 2;
			addChild(_lights);
			
			bitsHs=[];
			bitsHs.push(new hongshu1);
			bitsHs.push(new hongshu2);
			bitsHs.push(new hongshu3);
			
			addChild(hs);
			TweenLite.to(hs, 1, {onComplete:onBits, delay:1, scaleX:_hsScale, scaleY:_hsScale, rotation:0, x:StaticTable.STAGE_WIDTH*.5, y:StaticTable.STAGE_HEIGHT*.5 - 200});
		}
		
		private function saveLevel(id:int):void
		{
			if(StaticTable.GetMapDesc(id) == null) id=1;
			MiniBuffer.cookies.data.levelId = id;
			if(MiniBuffer.cookies.data.unlocklevelId<MiniBuffer.cookies.data.levelId)MiniBuffer.cookies.data.unlocklevelId = MiniBuffer.cookies.data.levelId;
			MiniBuffer.cookies.flush();
		}
		
		protected function onBits():void
		{
			if(bitsHs && bitsHs.length > 0)
			{
				_soundBite.play();
				var bd:BitmapData = bitsHs.shift();
				hsBmp.bitmapData = bd;
				TweenLite.delayedCall(0.5, onBits);
			}
		}
		
		protected function onNext(event:MouseEvent):void
		{
			TweenLite.killTweensOf(hs);
			removeEventListener(Event.ENTER_FRAME, onFrameIn);
			removeEventListener(MouseEvent.CLICK, onNext);
			
			if(MiniBuffer.cookies.data.levelId == 1)
			{
				AddFinish();
				TweenLite.to(this, 1.2, {alpha:0, onComplete:onShineFinish});
			}
			else
			{
				MidLayer.ShowWindowObj(BlocksView,{params:[MiniBuffer.cookies.data.levelId]});
			}
		}
		
		private function AddFinish():void
		{
			MidLayer.ShowWindow(FinishView);
			MidLayer.SwapWindows(FinishView, BlocksView);
		}
		
		private function onShineFinish():void
		{
			MidLayer.CloseWindow(BlocksView);
		}
		
		private var _mapDesc:MapDesc;
		private const _gridSize:uint = 153;
		private const blockClass:Array = [Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8, Block9, Block10, Block11, Block12, Block13, Block14, Block15, Block16, Block17, Block18];
		private var _startX:Number, _startY:Number;
		private var _poses:Array, _blocks:Vector.<Block> = new Vector.<Block>;
		private var hs:Sprite, hsBmp:Bitmap;
		private function initMap(id:int):void
		{
			_mapDesc = StaticTable.GetMapDesc(id);
			
			if(_mapDesc.type == 1)
			{
				_startX = (StaticTable.STAGE_WIDTH - 624) * .5;
				_startY = _mapAreaTop + (_mapAreaBottom - _mapAreaTop - 628) * .5;
				addChildAt(new Bitmap(_mapDesc.bg == 1?new bg11:new bg12), 0);
				_poses = [
					[true,true,true,true],[true,true,true,true],[true,true,true,true],[true,true,true,true],
				];
			}
			else if(_mapDesc.type == 2)
			{
				_startX = (StaticTable.STAGE_WIDTH - 624) * .5;
				_startY = _mapAreaTop + (_mapAreaBottom - _mapAreaTop - 628) * .5;;
				addChildAt(new Bitmap(_mapDesc.bg == 1?new bg21:new bg22), 0);
				_poses = [
					[false,true,true,true],[true,true,true,true],[true,true,true,true],[true,true,true,true],
				];
			}
			else if(_mapDesc.type == 3)
			{
				_startX = (StaticTable.STAGE_WIDTH - 624) * .5;
				_startY = _mapAreaTop + (_mapAreaBottom - _mapAreaTop - 774) * .5;;
				addChildAt(new Bitmap(new bg31), 0);
				_poses = [
					[true,true,true,true,true],[true,true,true,true,true],[true,true,true,true,true],[true,true,true,true,true],
				];
			}
			
			_startX += 5;
			_startY += 5;
			
			hsBmp  = new Bitmap(new hongshu);
			hsBmp.x = -hsBmp.width*.5;
			hsBmp.y = -hsBmp.height*.5;
			hs=new Sprite;
			hs.addChild(hsBmp);
			
			var offsetX:Number=1, offsetY:Number=0.5;
			if(_mapDesc.hh == 2 && _mapDesc.hw == 1)
			{
				hs.rotation=90;
				offsetX=.5;
				offsetY=1;
			}
			else if(_mapDesc.hh == 2 && _mapDesc.hw == 2)
			{
				hs.scaleY = 2;
				offsetX=1;
				offsetY=1;
			}
			
			hs.x = _startX + (_mapDesc.hx - 1 + offsetX)*_gridSize;
			hs.y = _startY + (_mapDesc.hy - 1 + offsetY)*_gridSize;
			addChild(hs);
			
			for(var i:int = 0; i < _mapDesc.blocks.length; i++)
			{
				var blockDesc:BlockDesc = _mapDesc.blocks[i];
				var block:Block = new blockClass[blockDesc.id - 1]();
				addChild(block);
				if(blockDesc.shuipin)
				{
					block.shuipin();
				}
				block.fanzhuan(0, blockDesc.fanzhuan);
				putBlockIn(block, blockDesc.x - 1, blockDesc.y - 1);
				_blocks.push(block);
				block.mouseChildren = block.mouseEnabled = false;
				TweenLite.from(block, .4, {rotation:Math.random()*180, z:-600, delay:.75 + i*.2});
			}
			
			if(_isNewBie)
			{
				TweenLite.delayedCall(1.8, displayHelp,[1]);
			}
			
			TweenLite.delayedCall(1.8, addEventListener, [MouseEvent.MOUSE_DOWN, onMapSelect]);
			TweenLite.delayedCall(1.8, addEventListener, [MouseEvent.MOUSE_UP, onMouseUp]);
		}
		
		private var _newbieBmp:Bitmap;
		private function displayHelp(type:uint):void
		{
			if(_newbieBmp)MidLayer.layer.removeChild(_newbieBmp);
			_isNewBie=type;
			if(_isNewBie==1)
			{
				var bd:BitmapData = new newbie1;
				_newbieBmp = new Bitmap(bd);
				_newbieBmp.y=360;
				_newbieBmp.x=30;
				MidLayer.layer.addChild(_newbieBmp);
			}
			else if(_isNewBie==2)
			{
				bd = new newbie2;
				_newbieBmp = new Bitmap(bd);
				_newbieBmp.y = 120;
				_newbieBmp.x = 50;
				MidLayer.layer.addChild(_newbieBmp);
			}
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if(_curBlock)
			{
				_putBlockIn = true;
			}
		}
		
		private var inShuiPin:Boolean, inFanZhuan90:Boolean, inFanZhuan180:Boolean, inFanZhuan270:Boolean;
		protected function onMouseMove(e:MouseEvent):void
		{	
			if(_curBlock)
			{
				_curBlock.x = e.stageX / StaticTable.SCALE_X;
				_curBlock.y = e.stageY / StaticTable.SCALE_Y;
				resetBlockGridXY(_curBlock, 0.5);
				const delayMove:Number = .35;
				
				if(checkIn(_curBlock.x, _curBlock.y, _bmpFanzhuan90))
				{
					if(!inFanZhuan90)
					{
						inFanZhuan90 =true;
						TweenLite.delayedCall(delayMove, exeFanzhuan90);
					}
				}
				else
				{
					if(inFanZhuan90)
					{
						inFanZhuan90 = false;
					}
				}
				
				if(checkIn(_curBlock.x, _curBlock.y, _bmpShuipin))
				{
					if(!inShuiPin)
					{
						inShuiPin = true;
						TweenLite.delayedCall(delayMove, exeShuipin);
					}
				}
				else
				{
					if(inShuiPin)
					{
						inShuiPin = false;
					}
				}
				
				if(checkIn(_curBlock.x, _curBlock.y, _bmpFanzhuan180))
				{
					if(!inFanZhuan180)
					{
						inFanZhuan180 =true;
						TweenLite.delayedCall(delayMove, exeFanzhuan180);
					}
				}
				else
				{
					if(inFanZhuan180)
					{
						inFanZhuan180 = false;
					}
				}
				
				if(checkIn(_curBlock.x, _curBlock.y, _bmpFanZhuan270))
				{
					if(!inFanZhuan270)
					{
						inFanZhuan270 =true;
						TweenLite.delayedCall(delayMove, exeFanzhuan270);
					}
				}
				else
				{
					if(inFanZhuan270)
					{
						inFanZhuan270 = false;
					}
				}
			}
		}
		
		private function checkIn(cx:Number, cy:Number, bmp:Rectangle):Boolean
		{
			return (cx >= bmp.x && cx <= bmp.x + bmp.width && cy >= bmp.y && cy <= bmp.y + bmp.height)
		}
		
		private function exeFanzhuan270():void
		{
			if(_isNewBie>2)return;
			if(_isNewBie == 1 || _isNewBie==2)_isNewBie++;
			
			if(_curBlock && checkIn(_curBlock.x, _curBlock.y, _bmpFanZhuan270))
			{
				_curBlock.fanzhuan(0.4, -1);
				_soundRotation.play();
			}
		}
		
		private function exeFanzhuan180():void
		{
			if(_isNewBie)return;
			
			if(_curBlock && checkIn(_curBlock.x, _curBlock.y, _bmpFanzhuan180))
			{
				_curBlock.fanzhuan(0.4, 2);
				_soundRotation.play();
			}
		}
		
		private function exeFanzhuan90():void
		{
			if(_isNewBie)return;
			
			if(_curBlock && checkIn(_curBlock.x, _curBlock.y, _bmpFanzhuan90))
			{
				_curBlock.fanzhuan(0.4);
				_soundRotation.play();
			}
		}
		
		private function exeShuipin():void
		{
			if(_isNewBie == 1 || _isNewBie == 2)return;
			if(_isNewBie==3)_isNewBie++;
			
			if(_curBlock && checkIn(_curBlock.x, _curBlock.y, _bmpShuipin))
			{
				_curBlock.shuipin(0.4);
				_soundRotation.play();
			}
		}
		
		private var _curBlock:Block, _curGridX:uint, _curGridY:uint, _curFz:int, _curSp:int;
		protected function onMapSelect(e:MouseEvent):void
		{
			var tname:String = (e.target as DisplayObject).name;
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if(!_curBlock)
			{
				var gx:uint = (e.stageX / StaticTable.SCALE_X - _startX) / _gridSize + 1;
				var gy:uint = (e.stageY / StaticTable.SCALE_Y - _startY) / _gridSize + 1;
				if(gx >= 0 && gy >= 0 && gx <= _poses.length && gy <= _poses[0].length)
				{
					
					for(var i:int = 0; i < _blocks.length; i++)
					{
						var block:Block = _blocks[i];
						var positions:Array = block.positions();
						for(var j:int = 0; j<positions.length; j+=2)
						{
							var px:uint = block.gridX + positions[j];
							var py:uint = block.gridY + positions[j+1];
							if(gx == px && gy == py)
							{
								if(_isNewBie)
								{
									if(_isNewBie == 1)
									{
										if(!(block is Block3))continue;
									}
									else if(_isNewBie == 2)
									{
										if(!(block is Block7))continue;
									}
									else if(_isNewBie == 3)
									{
										_isNewBie = 2;
										if(!(block is Block7))continue;
									}
								}
								
								_curBlock = block;
								_curBlock.up();
								addChild(_curBlock);
								for(var g:int = 0; g < positions.length; g+=2)
								{
									_poses[_curBlock.gridX + positions[g] - 1][_curBlock.gridY + positions[g+1] - 1]=true;
								}
								break;
							}
						}
						if(_curBlock)
						{
							_curGridX = _curBlock.gridX;
							_curGridY = _curBlock.gridY;
							_curFz = _curBlock.fz;
							_curSp = _curBlock.sp;
							_soundSelect.play();
							onMouseMove(e);
							break;
						}
					}
				}
			}
		}
		
		private function putBlockIn(block:Block, gx:uint, gy:uint):void
		{
			block.gridX = gx;
			block.gridY = gy;
			block.relativeX = _startX + block.gridX*_gridSize;
			block.relativeY = _startY + block.gridY*_gridSize;
			var positions:Array = block.positions();
			for(var j:int = 0; j<positions.length; j+=2)
			{
				var px:uint = positions[j] - 1;
				var py:uint = positions[j+1] - 1;
				_poses[block.gridX + px][block.gridY + py] = false;
			}
		}
		
		private function resetBlockGridXY(block:Block, offset:Number = 0):void
		{
			block.gridX = (block.relativeX - _startX)/_gridSize + offset;
			block.gridY = (block.relativeY - _startY)/_gridSize + offset;
			if(block.gridX < 0)block.gridX = 0;
			if(block.gridX >= _poses.length)block.gridX = _poses.length - 1;
			if(block.gridY < 0)block.gridY = 0;
			if(block.gridY >= _poses[0].length)block.gridY = _poses[0].length - 1;
		}
		
		protected function onReset(event:MouseEvent):void
		{
			StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
			MidLayer.CloseWindow(BlocksView);
			MidLayer.ShowWindowObj(BlocksView, {params:[_mapDesc.id]});
			event.stopPropagation();
		}
		
		protected function onMenu(event:MouseEvent):void
		{
			StaticTable.GetSoundPlayer(EnumMusic.CLICK).play();
			MidLayer.CloseWindow(BlocksView);
			MidLayer.ShowWindow(MenuView);
			event.stopPropagation();
		}
	}
}