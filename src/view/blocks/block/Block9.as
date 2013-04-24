package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block9;

	public class Block9 extends Block
	{
		public function Block9()
		{
			_pos1 = [
				[1,1, 2,1, 3,1, 4,1, 2,2],
				[1,2, 2,1, 2,2, 2,3, 2,4],
				[1,3, 1,2, 2,2, 2,2, 4,2],
				[1,1, 1,2, 1,3, 1,4, 2,3],
			];
			
			_pos2 = [
				[1,1, 2,1, 3,1, 3,2, 4,1],
				[1,3, 2,1, 2,2, 2,3, 2,4],
				[1,2, 2,1, 2,2, 3,2, 4,2],
				[1,1, 1,2, 1,3, 1,4, 2,2],
			];
			
			_bmp = new Bitmap(new block9);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .3);
			addChild(_bmp);
		}
	}
}