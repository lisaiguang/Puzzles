package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block2;

	public class Block2 extends Block
	{
		public function Block2()
		{
			_pos2 = _pos1 = [
				[1,1, 1,2, 2,1, 3,1, 3,2],
				[1,1, 1,3, 2,1, 2,2, 2,3],
				[1,1, 1,2, 2,2, 3,1, 3,2],
				[1,1, 1,2, 1,3, 2,1, 2,3]
			];
			
			_bmp = new Bitmap(new block2);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .25);
			addChild(_bmp);
		}
	}
}