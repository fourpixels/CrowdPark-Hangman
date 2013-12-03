package com.crowdpark.hangman.core.resources 
{
	import com.crowdpark.hangman.core.resources.base.ResourceBase;
	import flash.events.Event;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class SoundResource extends ResourceBase 
	{
		
		private var _sound:Sound;
		
		public function SoundResource(id:String, url:String, callback:Function) 
		{
			super(id, url, callback, ResourceBase.TYPE_MP3);
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_sound = new Sound();
			toggleListeners(_sound, true);
		}
		
		override protected function doLoad():void 
		{
			_sound.load(_request);
		}
		
		override protected function onLoaderComplete(e:Event):void 
		{
			toggleListeners(_sound, false);
			super.onLoaderComplete(e);
		}
		
		public function get sound():Sound 
		{
			return _sound;
		}
	}
}