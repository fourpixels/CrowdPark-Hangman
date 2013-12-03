package com.crowdpark.hangman.sounds 
{
	import com.crowdpark.hangman.core.resources.ResourceManager;
	import com.crowdpark.hangman.core.resources.SoundResource;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class SoundsManager 
	{
		
		private var _click:Sound;
		private var _win:Sound;
		private var _lose:Sound;
		
		public function SoundsManager(resources:ResourceManager) 
		{
			_click	= (resources.getResource(ResourceManager.SOUND_CLICK) as SoundResource).sound;
			_win	= (resources.getResource(ResourceManager.SOUND_WIN) as SoundResource).sound;
			_lose	= (resources.getResource(ResourceManager.SOUND_LOSE) as SoundResource).sound;
		}
		
		public function playClick():void {
			_click.play();
		}
		
		public function playWin():void {
			_win.play();
		}
		
		public function playLose():void {
			_lose.play();
		}
	}
}