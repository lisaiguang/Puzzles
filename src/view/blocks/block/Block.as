package view.blocks.block
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	public class Block extends Sprite
	{
		private static const _blockSize:uint = 150;
		protected var _pos1:Array, _pos2:Array;
		protected var _bmp:Bitmap, _bmpXS:Number = 0.5, _bmpYS:Number = 0.5;
		private var _sp:uint, _fz:uint;

		public function get sp():uint
		{
			return _sp;
		}

		public function get fz():uint
		{
			return _fz;
		}

		private static const dropShadow:DropShadowFilter = new DropShadowFilter(5.0,45, 0x333333,1.0,5.0,5.0,1.2);
		private static const glow:GlowFilter = new GlowFilter(0x333333);
		
		public function Block()
		{
		}
		
		public function up():void
		{
			scaleX = scaleY = 1.12;
		}
		
		public function down():void
		{
			scaleX = scaleY = 1;
		}
		
		public function get isTweening():Boolean
		{
			return _tween && _tween._active;
		}
		
		public function shuipin(dt:Number = 0):void
		{
			if(_tween && _tween._active)
			{
				return;
			}
			
			_sp=(_sp+1)%2;
			
			if(_sp == 0)
			{
				if(_fz==0 || _fz==2)
				{
					_tween = TweenLite.to(this,dt,{rotationY:(rotationY+180)%360}); 
				}
				else
				{
					_tween = TweenLite.to(this,dt,{rotationX:(rotationX+180)%360});
					_fz = (_fz+2) %4;
				}
			}
			else if(_sp == 1)
			{
				if(_fz==0 || _fz==2)
				{
					_tween = TweenLite.to(this,dt,{rotationY:(rotationY+180)%360});
				}
				else
				{
					_tween = TweenLite.to(this,dt,{rotationX:(rotationX+180)%360});
					_fz = (_fz+2) %4;
				}
			}
		}
		
		private var _tween:TweenLite;
		public function fanzhuan(dt:Number = 0, times:int = 1):void
		{
			if(_tween && _tween._active)
			{
				return;
			}
			var tfz:int = (_fz+1*times)%_pos1.length;
			if(tfz < 0)tfz=_pos1.length+tfz;
			_fz = tfz;
			_tween = TweenLite.to(this,dt,{rotation:rotation + 90*times});
		}
		
		public function restore():void
		{
			if(_sp == 1)
			{
				shuipin();
			}
			
			if(_fz > 0)
			{
				fanzhuan(0, _pos1.length - _fz);
			}
		}
		
		public function positions():Array
		{
			if(!_pos1)return null;
			if(_sp == 0)
			{
				return _pos1[_fz]
			}
			else
			{
				return _pos2[_fz];
			}
		}
		
		private var _gridX:uint,_gridY:uint;
		
		public function get gridY():uint
		{
			return _gridY;
		}
		
		public function set gridY(value:uint):void
		{
			_gridY = value;
		}
		
		public function get gridX():uint
		{
			return _gridX;
		}
		
		public function set gridX(value:uint):void
		{
			_gridX = value;
		}
		
		public function get relativeY():Number
		{
			var txs:Number;
			
			if(_sp == 0)
			{
				if(_fz == 0)
				{
					txs = _bmpYS;
				}
				else if(_fz == 1)
				{
					txs = _bmpXS;
				}
				else if(_fz == 2)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 3)
				{
					txs = 1 - _bmpXS;
				}
			}
			else
			{
				if(_fz == 0)
				{
					txs = _bmpYS;
				}
				else if(_fz == 1)
				{
					txs = 1-_bmpXS;
				}
				else if(_fz == 2)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 3)
				{
					txs = _bmpXS;
				}
			}
			
			return y - txs * height / scaleY;
		}
		
		public function set relativeY(value:Number):void
		{
			var txs:Number;
			
			if(_sp == 0)
			{
				if(_fz == 0)
				{
					txs = _bmpYS;
				}
				else if(_fz == 1)
				{
					txs = _bmpXS;
				}
				else if(_fz == 2)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 3)
				{
					txs = 1 - _bmpXS;
				}
			}
			else
			{
				if(_fz == 0)
				{
					txs = _bmpYS;
				}
				else if(_fz == 1)
				{
					txs = 1-_bmpXS;
				}
				else if(_fz == 2)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 3)
				{
					txs = _bmpXS;
				}
			}
			
			y = value + txs * height / scaleY;
		}
		
		public function get relativeX():Number
		{
			var txs:Number;
			
			if(_sp == 0)
			{
				if(_fz == 0)
				{
					txs = _bmpXS;
				}
				else if(_fz == 1)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 2)
				{
					txs = 1 - _bmpXS;
				}
				else if(_fz == 3)
				{
					txs = _bmpYS;
				}
			}
			else
			{
				if(_fz == 0)
				{
					txs = 1-_bmpXS;
				}
				else if(_fz == 1)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 2)
				{
					txs = _bmpXS;
				}
				else if(_fz == 3)
				{
					txs = _bmpYS;
				}
			}
			
			return x - txs * width / scaleX;
		}
		
		public function set relativeX(value:Number):void
		{
			var txs:Number;
			
			if(_sp == 0)
			{
				if(_fz == 0)
				{
					txs = _bmpXS;
				}
				else if(_fz == 1)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 2)
				{
					txs = 1 - _bmpXS;
				}
				else if(_fz == 3)
				{
					txs = _bmpYS;
				}
			}
			else
			{
				if(_fz == 0)
				{
					txs = 1-_bmpXS;
				}
				else if(_fz == 1)
				{
					txs = 1 - _bmpYS;
				}
				else if(_fz == 2)
				{
					txs = _bmpXS;
				}
				else if(_fz == 3)
				{
					txs = _bmpYS;
				}
			}
			
			x = value + txs * width / scaleX;
		}
	}
}