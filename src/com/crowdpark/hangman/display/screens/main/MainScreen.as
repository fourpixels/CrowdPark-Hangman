package com.crowdpark.hangman.display.screens.main 
{
	import com.crowdpark.hangman.display.screens.base.ScreenBase;
	import com.crowdpark.hangman.display.screens.main.keyboard.GameKeyboard;
	import com.crowdpark.hangman.display.screens.main.letters.GuessLettersManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class MainScreen extends ScreenBase
	{
		
		private var _gallows:Gallows;
		private var _guessLetters:GuessLettersManager;
		private var _keyboard:GameKeyboard;
		
		public function MainScreen(graphic:Sprite, container:DisplayObjectContainer)  
		{
			super(graphic, container);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_gallows = new Gallows(_graphic.getChildByName('mc_gallows') as MovieClip);
			
			_guessLetters = new GuessLettersManager();
			_container.addChild(_guessLetters);
			
			_keyboard = new GameKeyboard();
			_container.addChild(_keyboard);
		}
		
		override public function show():void 
		{
			super.show();
		}
		
		public function get guessLetters():GuessLettersManager 
		{
			return _guessLetters;
		}
		
		public function get gallows():Gallows 
		{
			return _gallows;
		}
		
		public function get keyboard():GameKeyboard 
		{
			return _keyboard;
		}
	}
}