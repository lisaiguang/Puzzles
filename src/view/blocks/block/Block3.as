package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block3;

	public class Block3 extends Block
	{
		public function Block3()
		{
			_pos2 = _pos1 = [
				[1,2, 2,1, 2,2, 3,2],
				[1,1, 1,2, 1,3, 2,2],
				[1,1, 2,1, 3,1, 2,2],
				[1,2, 2,1, 2,2, 2,3],
			];
			
			_bmp = new Bitmap(new block3);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .75);
			addChild(_bmp);
		}
	}
}