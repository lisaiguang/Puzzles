package view.blocks.block
{
	import flash.display.Bitmap;
	
	import lsg.bmp.block15;

	public class Block15 extends Block
	{
		public function Block15()
		{
			_pos2 = _pos1 = [
				[1,1, 2,1],
				[1,1, 1,2],
				[1,1, 2,1],
				[1,1, 1,2],
			];
			
			_bmp = new Bitmap(new block15);
			_bmp.x = -_bmp.width*(_bmpXS = .5);
			_bmp.y = -_bmp.height*(_bmpYS = .5);
			addChild(_bmp);
		}
	}
}