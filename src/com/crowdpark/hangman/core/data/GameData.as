package com.crowdpark.hangman.core.data 
{
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GameData implements IDisposable 
	{
		
		public static const MAX_ERRORS:uint = 7;
		
		private var _words:Vector.<String>;
		private var _currentWord:String;
		
		private var _wins:uint;
		private var _loses:uint;
		
		private var _errors:uint;
		
		public function GameData(words:Array) 
		{
			_words = Vector.<String>(words);
		}
		
		
		public function newRound():void {
			_currentWord = _words[Math.floor(Math.random() * _words.length)].toUpperCase();
			_errors = 0;
		}
		
		
		/*** Public Getters ***/
		
		/**
		 * I use getters instead of public variables because this way debugging is easy and there could be more complex structure:
		 * If needed, setters can dispatch events for more dynamci and global passing the variables.
		 */
		
		public function get loses():uint 
		{
			return _loses;
		}
		
		public function set loses(value:uint):void 
		{
			_loses = value;
		}
		
		public function get wins():uint 
		{
			return _wins;
		}
		
		public function set wins(value:uint):void 
		{
			_wins = value;
		}
		
		public function get errors():uint 
		{
			return _errors;
		}
		
		public function set errors(value:uint):void 
		{
			_errors = value;
		}
		
		public function get currentWord():String 
		{
			return _currentWord;
		}
		
		/* INTERFACE com.crowdpark.hangman.core.interfaces.IDisposable */
		
		public function dispose():void 
		{
			_words = null;
		}
	}
}