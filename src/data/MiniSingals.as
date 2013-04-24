package data
{
	import data.message.PauseReq;
	import org.osflash.signals.Signal;

	public class MiniSingals
	{
		public static var OnPauseReq:Signal = new Signal(data.message.PauseReq);
	}
}