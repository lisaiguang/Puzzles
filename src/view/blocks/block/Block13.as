package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block13;

	public class Block13 extends Block
	{
		public function Block13()
		{
			_pos1 = [
				[1,2, 1,3, 2,2, 3,2, 4,1, 4,2],
				[1,1, 2,1, 2,2, 2,3, 2,4, 3,4],
				[1,2, 1,3, 2,2, 3,2, 4,1, 4,2],
				[1,1, 2,1, 2,2, 2,3, 2,4, 3,4],
			];
			
			_pos2 = [
				[1,1, 1,2, 2,2, 3,2, 4,2, 4,3],
				[1,4, 2,1, 2,2, 2,3, 2,4, 3,1],
				[1,1, 1,2, 2,2, 3,2, 4,2, 4,3],
				[1,4, 2,1, 2,2, 2,3, 2,4, 3,1],
			];
			
			_bmp = new Bitmap(new block13);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}