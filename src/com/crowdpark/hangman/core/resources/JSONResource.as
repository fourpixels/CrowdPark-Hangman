package com.crowdpark.hangman.core.resources 
{
	import com.crowdpark.hangman.core.resources.base.ResourceBase;
	import flash.events.Event;
	import flash.net.URLLoader;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class JSONResource extends ResourceBase
	{
		
		private var _loader:URLLoader;
		
		public function JSONResource(id:String, url:String, callback:Function) 
		{
			super(id, url, callback, ResourceBase.TYPE_JSON);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_loader = new URLLoader(_request);
			toggleListeners(_loader, true);
		}
		
		override protected function doLoad():void 
		{
			_loader.load(_request);
		}
		
		override protected function onLoaderComplete(e:Event):void 
		{
			_data = JSON.parse(e.target.data);
			
			toggleListeners(_loader, false);
			super.onLoaderComplete(e);
		}
		
		override public function toString():String 
		{
			return "[JSONResource] " + _data;
		}
	}
}