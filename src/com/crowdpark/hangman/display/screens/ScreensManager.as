package com.crowdpark.hangman.display.screens 
{
	import com.crowdpark.hangman.core.events.GameEvent;
	import com.crowdpark.hangman.display.background.GameBackground;
	import com.crowdpark.hangman.display.screens.end.EndScreen;
	import com.crowdpark.hangman.display.screens.intro.IntroScreen;
	import com.crowdpark.hangman.display.screens.main.MainScreen;
	
	// flash things
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class ScreensManager extends EventDispatcher
	{
		
		// common
		private var _background:GameBackground;
		private var _container:DisplayObjectContainer;
		
		// screens
		private var _end:EndScreen;
		private var _main:MainScreen;
		private var _intro:IntroScreen;
		
		/**
		 * Simple class that manages common visuals.
		 * Most of them have getters as I don't feel need to write all the logic here, for such small project.
		 * 
		 * Instantiates graphics from loaded swf and adds them in container, whatever it is.
		 */
		
		public function ScreensManager(container:DisplayObjectContainer) 
		{
			_container = container;
		}
		
		public function initialize():void {
			initializeBackground();
			initializeScreens();
		}
		
		private function initializeBackground():void 
		{
			var backgroundClass:Class = ApplicationDomain.currentDomain.getDefinition('com.GameBackground') as Class;
			_background = new GameBackground(new backgroundClass(), _container);
		}
		
		private function initializeScreens():void {
			var introScreenClass:Class = ApplicationDomain.currentDomain.getDefinition('com.IntroScreenGraphics') as Class;
			_intro = new IntroScreen(new introScreenClass(), _container);
			_intro.addEventListener(GameEvent.PLAY_CLICKED, onPlayClicked);
			
			var mainScreenClass:Class = ApplicationDomain.currentDomain.getDefinition('com.MainScreenGraphics') as Class;
			_main = new MainScreen(new mainScreenClass(), _container);
			_intro.addEventListener(GameEvent.PLAY_CLICKED, onPlayClicked);
			
			var endScreenClass:Class = ApplicationDomain.currentDomain.getDefinition('com.EndScreenGraphics') as Class;
			_end = new EndScreen(new endScreenClass(), _container);
			_end.addEventListener(GameEvent.PLAY_CLICKED, onPlayClicked);
			
			_main.hide();
		}
		
		
		/**
		 * Common functions to manage multiple screens at once.
		 */
		public function showIntro():void {
			_intro.show();
			_main.hide();
			_end.hide();
		}
		
		public function showMain():void {
			_intro.hide();
			_main.show();
			_main.keyboard.show();
			_end.hide();
		}
		
		public function showEnd(won:Boolean):void {
			if (won) {
				_end.showWin();
			} else {
				_end.showLose();
			}
		}
		
		
		
		private function onPlayClicked(e:GameEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.PLAY_CLICKED));
		}
		
		
		
		public function get main():MainScreen 
		{
			return _main;
		}
		
		public function get intro():IntroScreen 
		{
			return _intro;
		}
		
		public function get background():GameBackground 
		{
			return _background;
		}
	}
}