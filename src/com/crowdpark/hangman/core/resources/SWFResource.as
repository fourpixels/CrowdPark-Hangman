package com.crowdpark.hangman.core.resources 
{
	import com.crowdpark.hangman.core.resources.base.ResourceBase;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class SWFResource extends ResourceBase 
	{
		
		private var _loader:Loader;
		
		public function SWFResource(id:String, url:String, callback:Function) 
		{
			super(id, url, callback, ResourceBase.TYPE_SWF);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_loader = new Loader();
			toggleListeners(_loader.contentLoaderInfo, true);
		}
		
		override protected function doLoad():void 
		{
			// we want to instantiate classes from loaded swf, so we need it in the same application domain
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(_request, context);
		}
		
		override protected function onLoaderComplete(e:Event):void 
		{
			toggleListeners(_loader, false);
			super.onLoaderComplete(e);
		}
	}
}