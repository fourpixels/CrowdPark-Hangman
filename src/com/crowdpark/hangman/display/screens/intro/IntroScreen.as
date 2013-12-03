package com.crowdpark.hangman.display.screens.intro 
{
	import com.crowdpark.hangman.core.events.GameEvent;
	import com.crowdpark.hangman.display.screens.base.ScreenBase;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class IntroScreen extends ScreenBase
	{
		
		private var _playButton:Sprite;
		
		public function IntroScreen(graphic:Sprite, container:DisplayObjectContainer) 
		{
			super(graphic, container);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_playButton = _graphic.getChildByName('btn_play') as Sprite;
			_playButton.buttonMode = true;
			_playButton.addEventListener(MouseEvent.CLICK, onPlayClicked);
			_playButton.addEventListener(MouseEvent.ROLL_OVER, onPlayOver);
			_playButton.addEventListener(MouseEvent.ROLL_OUT, onPlayOut);
		}
		
		private function onPlayClicked(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.PLAY_CLICKED));
		}
		
		private function onPlayOver(e:MouseEvent):void 
		{
			_playButton.alpha = .9;
		}
		
		private function onPlayOut(e:MouseEvent):void 
		{
			_playButton.alpha = 1;
		}
	}
}