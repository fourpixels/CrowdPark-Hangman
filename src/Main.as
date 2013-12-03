package 
{
	import com.crowdpark.hangman.Hangman;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	
	[SWF(width = "310", height = "450", frameRate = "60", backgroundColor = "#000000")]
	public class Main extends Sprite 
	{
		
		private var _hangman:Hangman;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Hangman instance is DisplayObject as we need stage for mouse click (on game end)
			_hangman = new Hangman();
			addChild(_hangman);
			
			_hangman.start();
		}
	}
}