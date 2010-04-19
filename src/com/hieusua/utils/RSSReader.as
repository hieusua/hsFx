package com.hieusua.utils
{
	import com.hieusua.vo.RSSItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="getFeedComplete", type="com.hieusua.core.RSSReader")]
	[Event(name="getFeedError", type="com.hieusua.core.RSSReader")]
	public class RSSReader extends EventDispatcher
	{
		public static const GET_FEED_COMPLETE: String = "getFeedComplete";
		public static const GET_FEED_ERROR: String = "getErrorComplete";
		private var httpService: HTTPService;
		public var lastResult: XML;
		public var items: Array;
		private var timer: Timer;
		
		// for RSS 1.0
		namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
	    use namespace rdf;
	    namespace purl = "http://purl.org/rss/1.0/";
	    use namespace purl;
	    namespace dc = "http://purl.org/dc/elements/1.1/";
	    use namespace dc;

		public function RSSReader()
		{
			httpService = new HTTPService();
			httpService.url = "";
			httpService.resultFormat = "e4x";
			httpService.addEventListener( ResultEvent.RESULT, feedLoadCompleteHandler );
			httpService.addEventListener( FaultEvent.FAULT, feedLoadFaultHandler );
			timer = new Timer( 300000, 0 );
			timer.addEventListener( TimerEvent.TIMER, timerHandler );
		}
		
		public function set refreshTime( value: int ): void {
			timer.stop();
			timer.delay = value;
			timer.start();
		}
		
		private function timerHandler( event: TimerEvent ): void {
			refresh();
		}
		
		public function set url( value: String ): void {
			httpService.url = value;
		}
		
		public function get url(): String {
			return httpService.url == "" ? "NO FEED URL" : httpService.url;
		}
		
		public function getFeed( url: String = "" ): void {
			if ( url == null ) return;
			if ( url != "" )
				httpService.url = url;
			if ( httpService.url == "" ) return;
			timer.stop();
			httpService.send( {random:Math.random()} );
			timer.start();
		}
		
		public function refresh(): void {
			if ( httpService.url == "" )
				return;
			httpService.send();
		}
		
		private function feedLoadCompleteHandler( event: ResultEvent ): void {
			lastResult = XML(event.result);
			var xmlList: XMLList;
			var i:int;
			var newItem: RSSItem;
			if ( lastResult != null ) xmlList = lastResult..item;
			items = [];
			for ( i = 0; i < xmlList.length(); i++ ) {
				newItem = new RSSItem( );
				newItem.data = xmlList[i];
				items.push( newItem );
			}
			dispatchEvent( new Event( GET_FEED_COMPLETE ) );
		}
		
		private function feedLoadFaultHandler( event: FaultEvent ): void {
			dispatchEvent( new Event( GET_FEED_ERROR ) );
		}

	}
}