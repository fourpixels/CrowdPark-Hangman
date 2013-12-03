package com.crowdpark.hangman 
{
	import com.crowdpark.hangman.display.screens.ScreensManager;
	import com.crowdpark.hangman.core.controller.GameController;
	import com.crowdpark.hangman.core.resources.ResourceManager;
	
	// flash things
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class Hangman extends Sprite
	{
		
		private var _screens:ScreensManager;
		private var _resources:ResourceManager;
		private var _controller:GameController;
		
		
		/**
		 * I don't think the project is big enough so I can use Factory, which I would normally do for classes creations.
		 * 
		 * I've done something similar and passed some resources so that the controller can run by itself no matter from where it's been called.
		 * GameData is locater there as I don't think global variables are good enough, especially for small projects.
		 */
		public function Hangman() 
		{
			
		}
		
		public function start():void
		{
			_screens = new ScreensManager(this); // passed this as a container
			
			_resources = new ResourceManager();
			_resources.addEventListener(Event.COMPLETE, onResourcesReady);
			
			_controller = new GameController(_screens, _resources, stage);
			
			_resources.load(); // will initialize flow (preloader screen could be added later on)
		}
		
		private function onResourcesReady(e:Event):void 
		{
			//trace ('Hangman :: onResourcesReady');
			// all resources has been loaded, it's time to start the controller
			
			_controller.start();
		}
	}
}