package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block11;

	public class Block11 extends Block
	{
		public function Block11()
		{
			_pos1 = [
				[1,2, 1,3, 1,4, 2,1, 2,2],
				[1,1, 2,1, 3,1, 3,2, 4,2],
				[1,3, 1,4, 2,1, 2,2, 2,3],
				[1,1, 2,1, 2,2, 3,2, 4,2],
			];
			
			_pos2 = [
				[1,1, 1,2, 2,2, 2,3, 2,4],
				[1,2, 2,2, 3,1, 3,2, 4,1],
				[1,1, 1,2, 1,3, 2,3, 2,4],
				[1,2, 2,1, 2,2, 3,1, 4,1],
			];
			
			_bmp = new Bitmap(new block11);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .375);
			addChild(_bmp);
		}
	}
}