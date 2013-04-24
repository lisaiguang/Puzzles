package view.wait
{
	import data.StaticTable;
	
	import lsg.WaitingUI;
	
	public class WaitingView extends WaitingUI
	{
		public function WaitingView()
		{
			x = (StaticTable.STAGE_WIDTH - width)*.5;
			y = (StaticTable.STAGE_HEIGHT - height)*.5;
			super();
		}
	}
}