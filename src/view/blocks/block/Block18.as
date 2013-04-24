package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block18;

	public class Block18 extends Block
	{
		public function Block18()
		{
			_pos1 = [
				[1,1, 1,2, 1,3, 2,3, 3,3],
				[1,1, 1,2, 1,3, 2,1, 3,1],
				[1,1, 2,1, 3,1, 3,2, 3,3],
				[1,3, 2,3, 3,1, 3,2, 3,3],
			];
			
			_pos2 = [
				[1,3, 2,3, 3,1, 3,2, 3,3],
				[1,1, 1,2, 1,3, 2,3, 3,3],
				[1,1, 1,2, 1,3, 2,1, 3,1],
				[1,1, 2,1, 3,1, 3,2, 3,3],
			];
			
			_bmp = new Bitmap(new block18);
			_bmp.x = -_bmp.width*(_bmpXS = .25);
			_bmp.y = -_bmp.height*(_bmpYS = .75);
			addChild(_bmp);
		}
	}
}