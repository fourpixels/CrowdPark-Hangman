package com.crowdpark.hangman.core.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GameEvent extends Event 
	{
		
		public static const PLAY_CLICKED:String = 'events.intro.play.clicked';
		public static const LETTER_CLICKED:String = 'events.main.letter.clicked';
		
		private var _data:Object;
		
		public function GameEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		override public function clone():Event 
		{
			return new GameEvent(type, data, bubbles, cancelable);
		}
	}
}