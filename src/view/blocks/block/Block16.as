package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block16;

	public class Block16 extends Block
	{
		public function Block16()
		{
			_pos1 = [
				[1,2, 1,3, 2,1, 2,2, 3,2],
				[1,1, 2,1, 2,2, 2,3, 3,2],
				[1,2, 2,2, 2,3, 3,1, 3,2],
				[1,2, 2,1, 2,2, 2,3, 3,3],
			];
			
			_pos2 = [
				[1,2, 2,1, 2,2, 3,2, 3,3],
				[1,3, 2,1, 2,2, 2,3, 3,2],
				[1,1, 1,2, 2,2, 2,3, 3,2],
				[1,2, 2,1, 2,2, 2,3, 3,1],
			];
			
			_bmp = new Bitmap(new block16);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}