package com.crowdpark.hangman.display.screens.main.keyboard 
{
	import com.crowdpark.hangman.core.events.GameEvent;
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class GameKeyboard extends Sprite implements IDisposable 
	{
		
		private var _buttons:Vector.<KeyButton>;
		
		public function GameKeyboard() 
		{
			super();
			
			initialize();
		}
		
		private function initialize():void 
		{
			_buttons = new Vector.<KeyButton>();
			
			for (var i:int = 0; i < 26; i++) 
			{
				var key:KeyButton = new KeyButton(i);
				key.addEventListener(GameEvent.LETTER_CLICKED, onLetterClicked);
				addChild(key);
				_buttons.push(key);
			}
			
			hide();
		}
		
		private function onLetterClicked(e:GameEvent):void 
		{
			dispatchEvent(e.clone());
		}
		
		public function show():void {
			visible = true;
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function disableAll():void {
			var total:uint = _buttons.length;
			for (var i:int = 0; i < total; i++) 
			{
				_buttons[i].disable();
			}
		}
		
		public function enableAll():void {
			var total:uint = _buttons.length;
			for (var i:int = 0; i < total; i++) 
			{
				_buttons[i].enable();
			}
		}
		
		/* INTERFACE com.crowdpark.hangman.core.interfaces.IDisposable */
		
		public function dispose():void 
		{
			
		}
		
	}

}