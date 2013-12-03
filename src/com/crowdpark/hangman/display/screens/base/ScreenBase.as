package com.crowdpark.hangman.display.screens.base 
{
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class ScreenBase extends EventDispatcher implements IDisposable
	{
		
		protected var _graphic:Sprite;
		protected var _container:DisplayObjectContainer;
		
		public function ScreenBase(graphic:Sprite, container:DisplayObjectContainer) 
		{
			_graphic	= graphic;
			_container	= container;
			
			_container.addChild(_graphic);
			
			initialize();
		}
		
		// override
		protected function initialize():void {
			
		}
		
		public function show():void {
			_graphic.visible = true;
		}
		
		public function hide():void {
			_graphic.visible = false;
		}
		
		/* INTERFACE com.crowdpark.hangman.core.interfaces.IDisposable */
		
		public function dispose():void 
		{
			_graphic = null;
			_container = null;
		}
	}
}