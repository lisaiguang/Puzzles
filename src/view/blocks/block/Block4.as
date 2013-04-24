package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block4;

	public class Block4 extends Block
	{
		public function Block4()
		{
			_pos2 = _pos1 = [
				[1,1, 2,1, 3,1, 4,1],
				[1,1, 1,2, 1,3, 1,4],
				[1,1, 2,1, 3,1, 4,1],
				[1,1, 1,2, 1,3, 1,4],
			];
			
			_bmp = new Bitmap(new block4);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}