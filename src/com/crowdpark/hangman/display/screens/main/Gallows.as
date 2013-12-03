package com.crowdpark.hangman.display.screens.main 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class Gallows
	{
		
		private var _sprite:MovieClip;
		
		public function Gallows(sprite:MovieClip)
		{
			_sprite = sprite;
			
			reset();
		}
		
		public function goto(progress:uint):void {
			if (progress == 0)
				reset();
			else
				_sprite.gotoAndStop(Math.max(1, (progress - 1) * 5));
		}
		
		public function reset():void {
			_sprite.gotoAndStop('empty');
		}
	}
}