package com.crowdpark.hangman.display.screens.main.letters 
{
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GuessLetter implements IDisposable 
	{
		
		private const WIDTH:uint = 30;
		
		private var _graphic:Sprite; // com.GuessLetter
		private var _container:DisplayObjectContainer;
		private var _letter:TextField;
		
		public function GuessLetter(container:DisplayObjectContainer, index:uint)
		{
			var letterGraphicClass:Class = ApplicationDomain.currentDomain.getDefinition('com.GuessLetter') as Class;
			_graphic	= new letterGraphicClass();
			
			_graphic.x	= index * WIDTH;
			_container	= container;
			
			initialize();
		}
		
		private function initialize():void 
		{
			_letter = _graphic.getChildByName('tf_letter') as TextField;
			_container.addChild(_graphic);
			
			setLetter('A');
		}
		
		public function setLetter(letter:String):void {
			_letter.text = letter;
		}
		
		public function empty():void {
			_letter.text = '';
		}
		
		public function isEmpty():Boolean {
			return _letter.text == '';
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
			
		}
	}
}