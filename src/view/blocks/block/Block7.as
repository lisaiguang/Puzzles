package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block7;

	public class Block7 extends Block
	{
		public function Block7()
		{
			_pos1 = [
				[1,2, 2,2, 3,1, 3,2],
				[1,1, 1,2, 1,3, 2,3],
				[1,1, 1,2, 2,1, 3,1],
				[1,1, 2,1, 2,2, 2,3],
			];
			
			_pos2 = [
				[1,1, 1,2, 2,2, 3,2],
				[1,1, 1,2, 1,3, 2,1],
				[1,1, 2,1, 3,1, 3,2],
				[1,3, 2,1, 2,2, 2,3],
			];
			
			_bmp = new Bitmap(new block7);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .75);
			addChild(_bmp);
		}
	}
}