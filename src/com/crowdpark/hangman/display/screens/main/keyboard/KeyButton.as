package com.crowdpark.hangman.display.screens.main.keyboard 
{
	import com.crowdpark.hangman.core.events.GameEvent;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class KeyButton extends Sprite
	{
		private const POSITION:Point = new Point(100, 300);
		private const WIDTH:uint = 25;
		
		private var _graphic:Sprite;
		private var _field:TextField;
		
		private var _enabled:Boolean;
		
		public function KeyButton(index:uint) 
		{
			super();
			
			var keyGraphicClass:Class = ApplicationDomain.currentDomain.getDefinition('com.KeyButton') as Class;
			_graphic = new keyGraphicClass();
			addChild(_graphic);
			_graphic.x = POSITION.x + (index % 8) * WIDTH;
			_graphic.y = POSITION.y + Math.floor(index / 8) * WIDTH;
			
			// set letter
			_field = _graphic.getChildByName('tf_letter') as TextField;
			_field.text = String.fromCharCode(String('A').charCodeAt(0) + index);
			_field.mouseEnabled = false;
			
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, onButtonClicked);
			addEventListener(MouseEvent.MOUSE_OVER, onButtonOver);
			addEventListener(MouseEvent.MOUSE_OUT, onButtonOut);
			
			enable();
		}
		
		private function onButtonClicked(e:MouseEvent):void 
		{
			if (_enabled) {
				dispatchEvent(new GameEvent(GameEvent.LETTER_CLICKED, _field.text));
				disable();
			}
		}
		
		private function onButtonOver(e:MouseEvent):void 
		{
			if (_enabled)
				alpha = .9;
		}
		
		private function onButtonOut(e:MouseEvent):void 
		{
			if (_enabled)
				alpha = 1;
		}
		
		public function enable():void {
			alpha = 1;
			_enabled = buttonMode = true;
		}
		
		public function disable():void {
			alpha = .5;
			_enabled = buttonMode = false;
		}
	}
}