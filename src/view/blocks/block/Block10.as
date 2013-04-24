package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block10;

	public class Block10 extends Block
	{
		public function Block10()
		{
			_pos1 = [
				[1,2, 2,1, 2,2, 3,1, 3,2],
				[1,1, 1,2, 1,3, 2,2, 2,3],
				[1,1, 1,2, 2,1, 2,2, 3,1],
				[1,1, 1,2, 2,1, 2,2, 2,3],
			];
			
			_pos2 = [
				[1,1, 1,2, 2,1, 2,2, 3,2],
				[1,1, 1,2, 1,3, 2,1, 2,2],
				[1,1, 2,1, 2,2, 3,1, 3,2],
				[1,2, 1,3, 2,1, 2,2, 2,3],
			];
			
			_bmp = new Bitmap(new block10);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}