package com.crowdpark.hangman.core.resources 
{
	import com.crowdpark.hangman.core.resources.base.ResourceBase;
	
	// flash things
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class ResourceManager extends EventDispatcher
	{
		
		public static const WORDS:String = 'words';
		public static const ASSETS:String = 'assets';
		public static const SOUND_CLICK:String = 'sound_click';
		public static const SOUND_LOSE:String = 'sound_lose';
		public static const SOUND_WIN:String = 'sound_win';
		
		private const CONFIG_URL:String = 'data/config.json';
		
		private var _resources:Object;
		private var _config:JSONResource;
		
		
		
		/**
		 * I don't really know why some of the resources were not ok for import (I had problems with sounds maybe because of bitrate?)
		 * and I didn't know if you wanted external loading (as you sent me some of the content as separate files).
		 * 
		 * So I did a basic ResourceManager class, which loads config file with all the external resources that needs to be loaded.
		 * Then they are loaded via separate classes because of their loading type.
		 * 
		 * This way future extension of the the load list will be easy.
		 * 
		 * After everything is loaded - event is dispatched.
		 */
		
		public function ResourceManager() 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			_resources = new Object();
			_config = new JSONResource(CONFIG_URL, CONFIG_URL, onConfigLoaded);
		}
		
		
		/*** Public Functions ***/
		
		
		public function load():void {
			_config.load();
		}
		
		private function onConfigLoaded():void
		{
			var data:Object = _config.data;
			
			for each (var item:Object in data)
			{
				var resource:ResourceBase;
				
				var url:String = item.url;
				if (url.indexOf(ResourceBase.TYPE_JSON) != -1) {
					resource = new JSONResource(item.id, item.url, onResourceLoaded);
				} else if (url.indexOf(ResourceBase.TYPE_MP3) != -1) {
					resource = new SoundResource(item.id, item.url, onResourceLoaded);
				} else if (url.indexOf(ResourceBase.TYPE_SWF) != -1) {
					resource = new SWFResource(item.id, item.url, onResourceLoaded);
				} else {
					// further resources can be handled
					throw new Error('ResourceManager :: onConfigLoaded -> unable to load file of unknown type (' + url + ')');
				}
				
				_resources[item.id] = resource;
				resource.load();
			}
		}
		
		/**
		 * Single resource load handler; check if all are loaded or wait for others
		 */
		private function onResourceLoaded():void 
		{
			var loaded:Boolean = true;
			
			for each (var resource:ResourceBase in _resources)
			{
				if (!resource.isLoaded) {
					loaded = false;
					break;
				}
			}
			
			if (loaded) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
		/**
		 * Function to get a resource by ID. I've added them as constants above, as I think moving everything to separate file
		 * will make things more complex for this small project.
		 * 
		 * @param			id			<String>		- The ID of the resource.
		 * 
		 * @return						<ResourceBase>	- The added resource no matter if it's loaded or not.
		 */
		public function getResource(id:String):ResourceBase {
			return _resources[id];
		}
	}
}