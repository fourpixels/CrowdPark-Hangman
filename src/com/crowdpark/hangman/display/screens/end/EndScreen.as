package com.crowdpark.hangman.display.screens.end 
{
	import com.crowdpark.hangman.core.events.GameEvent;
	import com.crowdpark.hangman.display.screens.base.ScreenBase;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class EndScreen extends ScreenBase
	{
		
		private var _win:TextField;
		private var _lose:TextField;
		
		public function EndScreen(graphic:Sprite, container:DisplayObjectContainer)
		{
			super(graphic, container);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_win = _graphic.getChildByName('tf_win') as TextField;
			_lose = _graphic.getChildByName('tf_lose') as TextField;
			_win.mouseEnabled = _lose.mouseEnabled = false;
			
			_graphic.addEventListener(MouseEvent.CLICK, onPlayAgainClicked);
		}
		
		public function showWin():void {
			super.show();
			_win.visible = true;
			_lose.visible = false;
		}
		
		public function showLose():void {
			super.show();
			_win.visible = false;
			_lose.visible = true;
		}
		
		private function onPlayAgainClicked(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.PLAY_CLICKED));
		}
	}
}