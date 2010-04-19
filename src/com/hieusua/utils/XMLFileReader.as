package com.hieusua.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	[Bindable]
	public class XMLFileReader
	{
		public var lastResult: XML;
		
		public var url: String = "";
		
		private var listResultCallback: Array;
		private var listErrorCallback: Array;
		
		public function setURL( value: String ): XMLFileReader {
			url = value;
			return this;
		}
		
		
		public function XMLFileReader()
		{
			listResultCallback = [];
			listErrorCallback = [];
			
		}
		
		public function load( url: String ): XMLFileReader {
			if ( url == null )
				return this;
			this.url = url;
			var request:URLRequest = new URLRequest( url );
			request.method = URLRequestMethod.GET;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener( Event.COMPLETE, xmlLoadCompleteHandler );
			urlLoader.addEventListener( IOErrorEvent.IO_ERROR, xmlLoadErrorHandler );
			urlLoader.load( request );
			return this;
		}
		
		public function result( callback: Function ): XMLFileReader {
			if ( callback == null ) return this;
			for ( var i: int = 0; i < listResultCallback.length; i++ ) {
				if ( listResultCallback[i] is Function ) {
					if ( listResultCallback[i] == callback )
						return this;
				}
			}
			listResultCallback.push( callback );
			return this;
		}
		
		public function error( callback: Function ): XMLFileReader {
			if ( callback == null ) return this;
			for ( var i: int = 0; i < listErrorCallback.length; i++ ) {
				if ( listErrorCallback[i] is Function ) {
					if ( listErrorCallback[i] == callback )
						return this;
				}
			}
			listErrorCallback.push( callback );
			return this;
		}
		
		private function xmlLoadCompleteHandler( event: Event ): void {
			lastResult = new XML( event.target.data );
			for ( var i: int = 0; i < listResultCallback.length; i++ ) {
				if ( listResultCallback[i] is Function ) {
					listResultCallback[i].apply( null, [this] );
				}
			}
		}
		
		private function xmlLoadErrorHandler( event: IOErrorEvent ): void {
			for ( var i: int = 0; i < listErrorCallback.length; i++ ) {
				if ( listErrorCallback[i] is Function ) {
					Function( listErrorCallback[i] ).apply();
				}
			}
		}

	}
}