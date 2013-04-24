package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block12;

	public class Block12 extends Block
	{
		public function Block12()
		{
			_pos1 = [
				[1,2, 2,2, 3,2, 4,1, 4,2],
				[1,1, 1,2, 1,3, 1,4, 2,4],
				[1,1, 1,2, 2,1, 3,1, 4,1],
				[1,1, 2,1, 2,2, 2,3, 2,4],
			];
			
			_pos2 = [
				[1,1, 1,2, 2,2, 3,2, 4,2],
				[1,1, 1,2, 1,3, 1,4, 2,1],
				[1,1, 2,1, 3,1, 4,1, 4,2],
				[1,4, 2,1, 2,2, 2,3, 2,4],
			];
			
			_bmp = new Bitmap(new block12);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .75);
			addChild(_bmp);
		}
	}
}