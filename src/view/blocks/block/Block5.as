package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block5;

	public class Block5 extends Block
	{
		public function Block5()
		{
			_pos1 = [
				[1,1, 1,2, 2,2, 2,3],
				[1,2, 2,1, 2,2, 3,1],
				[1,1, 1,2, 2,2, 2,3],
				[1,2, 2,1, 2,2, 3,1],
			]; 
			
			_pos2 = [
				[1,2, 1,3, 2,1, 2,2],
				[1,1, 2,1, 2,2, 3,2],
				[1,2, 1,3, 2,1, 2,2],
				[1,1, 2,1, 2,2, 3,2],
			];
			
			_bmp = new Bitmap(new block5);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}