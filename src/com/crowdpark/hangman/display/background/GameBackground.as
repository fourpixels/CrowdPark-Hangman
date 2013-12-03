package com.crowdpark.hangman.display.background 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GameBackground 
	{
		
		private var _graphic:Sprite;
		private var _score:TextField;
		private var _container:DisplayObjectContainer;
		
		public function GameBackground(graphic:Sprite, conatiner:DisplayObjectContainer) 
		{
			_graphic = graphic;
			_container = conatiner;
			_container.addChild(_graphic);
			
			_score = _graphic.getChildByName('tf_score') as TextField;
		}
		
		
		public function setScore(wins:uint, loses:uint):void {
			_score.text = 'Won: ' + wins + ' Lost: ' + loses;
		}
	}
}