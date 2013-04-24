package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block1;

	public class Block1 extends Block
	{
		public function Block1()
		{
			super();
			
			_pos2 = _pos1 = [
				[1,1, 2,1, 3,1],
				[1,1, 1,2, 1,3],
				[1,1, 2,1, 3,1],
				[1,1, 1,2, 1,3],
			];
			
			_bmp = new Bitmap(new block1);
			_bmp.x = -_bmp.width*_bmpXS;
			_bmp.y = -_bmp.height*_bmpYS;
			addChild(_bmp);
		}
	}
}