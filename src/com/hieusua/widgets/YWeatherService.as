package com.hieusua.widgets
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class YWeatherService implements IResponder 
	{
		
		public var responder:IResponder;
		public var service:HTTPService;
		
		public var param:Object;
		
		[Bindable]
		public var unit:String = "C";
		
		[Bindable]
		public var dayNight:String = "d";
		
		[Bindable]
		public var resultXML:XML;
		
		private var tempResultXML:XML;
		
		private namespace yweather = "http://xml.weather.yahoo.com/ns/rss/1.0";
			use namespace yweather;
		
		public function YWeatherService( )
		{
			this.service = new HTTPService();
			service.method = "GET";
			service.resultFormat = "e4x";
			service.url="http://weather.yahooapis.com/forecastrss";
			param = { p:"", u:"c" };
		}
		
		public function set degreeUnit( value:String ):void {
			if ( value == "f" || value == "F" ) {
				param.u = "f";
				unit = "F";
			}
			else {
				param.u = "c";
				unit = "C";
			}
		}
		
		public function set position( value:String ):void {
			param.p = value;
		}
		
		public function request( position:String = "" ):void {
			if ( position != "" )
				param.p = position;
			if ( param.p == "" )
				return;
			var token:AsyncToken = service.send( param );
			token.addResponder( this );
		}
		
		public function result( event:Object ):void {
			tempResultXML = XML( event.result );
			if ( !isNaN( Number( tempResultXML.channel.item.yweather::condition.@temp ) ) )
				resultXML = tempResultXML;
			calcDayNight();
		}
		
		private function calcDayNight():void {
			if ( resultXML == null )
				return;
			var sunrise:String = resultXML.channel.yweather::astronomy.@sunrise;
			var sunset:String = resultXML.channel.yweather::astronomy.@sunset;
			var now:String = resultXML.channel.item.pubDate;
			var temp:int = now.indexOf( ":" );
			if ( temp <= 2 )
				return;
			now = now.slice( temp - 2, temp + 6 );
			if ( now.charAt( 0 ) == " " )
				now = now.slice( 1 );
			// after noon, compare with sunset
			if ( now.slice( now.length - 2 ) == "pm" ) {
				if ( now.slice( 0, now.length - 3 ) <= sunset.slice( 0, sunset.length - 3 ) )
					dayNight = "d";
				else
					dayNight = "n";
			}
			// before noon, compare with sunrise
			else {
				if ( now.slice( 0, now.length - 3 ) <= sunrise.slice( 0, sunrise.length - 3 ) )
					dayNight = "n";
				else
					dayNight = "d";
			}
		}
		
		public function fault( event:Object ):void {
			
		}
		
	}
}