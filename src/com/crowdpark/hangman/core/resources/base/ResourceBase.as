package com.crowdpark.hangman.core.resources.base 
{
	import com.crowdpark.hangman.core.interfaces.IDisposable;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Andrey Popov
	 */
	public class ResourceBase extends EventDispatcher implements IDisposable
	{
		public static const TYPE_JSON:String = 'json';
		public static const TYPE_MP3:String = 'mp3';
		public static const TYPE_SWF:String = 'swf';
		
		protected var _id:String;
		protected var _type:String;
		protected var _isLoading:Boolean;
		protected var _isLoaded:Boolean;
		protected var _request:URLRequest;
		protected var _data:Object;
		
		protected var _callback:Function;
		
		public function ResourceBase(id:String, url:String, callback:Function, type:String) 
		{
			_id			= id;
			_callback	= callback;
			_type		= type;
			
			_request = new URLRequest(url);
			
			initialize();
		}
		
		// override
		protected function initialize():void {
			
		}
		
		/*** Public Getters only! ***/
		
		public function get id():String				{	return _id;			}
		public function get type():String			{	return _type;		}
		public function get isLoaded():Boolean		{	return _isLoaded;	}
		public function get isLoading():Boolean 	{	return _isLoading;	}
		
		public function get data():Object 			{	return _data;		}
		public function get callback():Function 	{	return _callback;	}
		
		
		public function load():Boolean {
			if (!_isLoaded && !_isLoading) {
				_isLoading = true;
				doLoad();
				return true;
			}
			
			return false;
		}
		
		/**
		 * Actual loading function to be overriden.
		 */
		protected function doLoad():void {
			
		}
		
		/** Helper functions ***/
		protected function toggleListeners(loader:EventDispatcher, state:Boolean):void {
			if (!loader) // just in case
				return;
			
			if (state) {
				loader.addEventListener(Event.COMPLETE, onLoaderComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderError);
			} else {
				loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderError);
			}
		}
		
		protected function onLoaderComplete(e:Event):void 
		{
			_isLoading = false;
			_isLoaded = true;
			dispatchEvent(e);
			
			checkCallback();
		}
		
		protected function onLoaderError(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		protected function checkCallback():void 
		{
			if (_callback != null)
				_callback();
		}
		
		
		/* INTERFACE com.crowdpark.hangman.core.interfaces.IDisposable */
		
		public function dispose():void 
		{
			_data		= null;
			_callback	= null;
		}
	}
}