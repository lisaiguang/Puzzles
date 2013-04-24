package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block8;

	public class Block8 extends Block
	{
		public function Block8()
		{
			_pos2 = _pos1 = [
				[1,3, 2,1, 2,2, 2,3, 3,3],
				[1,1, 1,2, 1,3, 2,2, 3,2],
				[1,1, 2,1, 2,2, 2,3, 3,1],
				[1,2, 2,2, 3,1, 3,2, 3,3],
			];
			
			_bmp = new Bitmap(new block8);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}