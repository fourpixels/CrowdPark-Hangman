package com.crowdpark.hangman.core.controller 
{
	import com.crowdpark.hangman.core.data.GameData;
	import com.crowdpark.hangman.core.data.GameState;
	import com.crowdpark.hangman.core.events.GameEvent;
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	import com.crowdpark.hangman.core.resources.ResourceManager;
	import com.crowdpark.hangman.display.screens.ScreensManager;
	import com.crowdpark.hangman.sounds.SoundsManager;
	
	// flash things
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GameController extends EventDispatcher implements IDisposable 
	{
		
		private var _screens:ScreensManager;
		private var _resources:ResourceManager;
		
		private var _data:GameData;
		private var _sounds:SoundsManager;
		
		private var _state:String;
		private var _stage:Stage;
		
		/**
		 * The controller usually works with provided resources, that come from factories, so it's more independent.
		 * Not fully implemented such a thing, but I think it's close enough :)
		 */
		
		public function GameController(screens:ScreensManager, resources:ResourceManager, stage:Stage)
		{
			super();
			
			_screens	= screens;
			_resources	= resources;
			_stage		= stage;
		}
		
		/**
		 * Externally started
		 */
		public function start():void 
		{
			_data = new GameData(_resources.getResource(ResourceManager.WORDS).data as Array);
			_sounds = new SoundsManager(_resources);
			
			_screens.initialize();
			_screens.addEventListener(GameEvent.PLAY_CLICKED, onPlayClicked);
			_screens.main.keyboard.addEventListener(GameEvent.LETTER_CLICKED, onLetterClicked);
			
			setState(GameState.INTRO);
		}
		
		
		private function onStageClicked(e:MouseEvent):void 
		{
			if (_state == GameState.END) {
				newRound();
			}
		}
		
		private function setState(state:String):void 
		{
			_state = state;
			
			switch (_state) {
				case GameState.INTRO:
					_screens.showIntro();
					break;
				case GameState.PLAYING:
					_screens.showMain();
					break;
				case GameState.END:
					_screens.main.keyboard.disableAll();
					break;
			}
		}
		
		private function onLetterClicked(e:GameEvent):void 
		{
			if (_state != GameState.PLAYING)
				return;
			
			var totalMatches:uint = _screens.main.guessLetters.openLetters(String(e.data));
			
			_sounds.playClick();
			
			if (totalMatches == 0) {
				onPlayerError();
			} else {
				onPlayerCorrect();
			}
		}
		
		private function onPlayerError():void
		{
			_data.errors++;
			_screens.main.gallows.goto(_data.errors);
			
			if (_data.errors == GameData.MAX_ERRORS) {
				setState(GameState.END);
				_sounds.playLose();
				_screens.showEnd(false);
				_data.loses++;
				_screens.background.setScore(_data.wins, _data.loses);
			}
		}
		
		private function onPlayerCorrect():void {
			if (_screens.main.guessLetters.wordGuessed()) {
				setState(GameState.END);
				_sounds.playWin();
				_screens.showEnd(true);
				_data.wins++;
				_screens.background.setScore(_data.wins, _data.loses);
			}
		}
		
		private function onPlayClicked(e:GameEvent):void 
		{
			newRound();
			_screens.showMain();
		}
		
		private function newRound():void {
			_data.newRound();
			_screens.main.gallows.reset();
			_screens.main.guessLetters.word = _data.currentWord;
			_screens.main.keyboard.enableAll();
			
			setState(GameState.PLAYING);
			
			//trace ('GameController :: newRound started; current word: ', _data.currentWord);
		}
		
		
		/* INTERFACE com.crowdpark.hangman.core.interfaces.IDisposable */
		
		public function dispose():void 
		{
			_data.dispose();
			_data = null;
			
			// here everything can be cleared if needed, I haven't written all the code as I don't find it neccesary for such a project that doesn't stop :)
		}
	}
}