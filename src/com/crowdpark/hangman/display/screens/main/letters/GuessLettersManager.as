package com.crowdpark.hangman.display.screens.main.letters 
{
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GuessLettersManager extends Sprite implements IDisposable 
	{
		
		private const POSITION:Point = new Point(10, 46);
		
		private var _word:String;
		private var _letters:Vector.<GuessLetter>;
		private var _container:Sprite;
		
		public function GuessLettersManager() 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			_letters = new Vector.<GuessLetter>();
			
			_container = new Sprite();
			_container.x = POSITION.x;
			_container.y = POSITION.y;
			addChild(_container);
		}
		
		public function set word(value:String):void 
		{
			_word = value;
			
			checkBoxesLength();
		}
		
		private function checkBoxesLength():void 
		{
			var total:uint = _word.length;
			
			// there are not enough symbols created - we need more; create add to stage and push
			if (_letters.length < total) {
				var totalNew:uint = total - _letters.length;
				for (var i:int = 0; i < totalNew; i++) 
				{
					var letter:GuessLetter = new GuessLetter(_container, _letters.length);
					_letters.push(letter);
				}
			}
			
			// if we set word with less letters than the previous one, we have more letters than we need
			var totalMore:uint = Math.max(0, _letters.length - total);
			
			for (var j:int = 0; j < _letters.length; j++) // cycle through all that we have
			{
				if (j < _letters.length - totalMore) { // we need this one
					_letters[j].show();
					_letters[j].empty();
				} else {
					_letters[j].hide(); // we don't need this one - simply hide it and reuse it later on
				}
			}
		}
		
		public function openLetters(letter:String):uint {
			var totalMatches:uint;
			
			var total:uint = _word.length;
			for (var i:int = 0; i < total; i++) 
			{
				if (_word.charAt(i) == letter) {
					_letters[i].setLetter(letter);
					totalMatches++;
				}
			}
			
			return totalMatches;
		}
		
		public function wordGuessed():Boolean {
			var total:uint = _word.length;
			for (var i:int = 0; i < total; i++) 
			{
				if (_letters[i].isEmpty())
					return false;
			}
			
			return true;
		}
		
		/* INTERFACE com.crowdpark.hangman.core.interfaces.IDisposable */
		
		public function dispose():void 
		{
			
		}
	}
}