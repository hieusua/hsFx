package com.hieusua.vo
{
	import com.adobe.utils.DateUtil;
	
	[Bindable]
	public class RSSItem
	{
		public var _data: XML;
		public var imgSource: String = "";
		public var title: String = "";
		public var desc: String = "";
		private var _maxCharDesc: int = 0;
		public var pubDate: Date;
		
		// for RSS 1.0
		namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
	    use namespace rdf;
	    namespace purl = "http://purl.org/rss/1.0/";
	    use namespace purl;
	    namespace dc = "http://purl.org/dc/elements/1.1/";
	    use namespace dc;
		
		public function RSSItem( maxCharDesc: int = 250 )
		{
			this.maxCharDesc = maxCharDesc;
		}
		
		private function getFirstImageURL(): void {
			if ( _data == null ) return;
			var tempStr: String = _data.description;
			var i:int = 0;
			i = tempStr.indexOf( "img" );
			if ( i < 0 ) {
				imgSource = "";
				return;
			}
			i = tempStr.indexOf( "src", i );
			if ( i < 0 ) {
				imgSource = "";
				return;
			}
			i = tempStr.indexOf( "\"", i );
			if ( i < 0 ) {
				imgSource = "";
				return;
			}
			tempStr = tempStr.slice( i + 1 );
			
			i = tempStr.indexOf( ".jpg" );
			if ( i <= 0 ) i = tempStr.indexOf( ".png" );
			if ( i <= 0 ) i = tempStr.indexOf( ".gif" );
			if ( i > 0 ) {
				tempStr = tempStr.slice( 0, i + 4 );
			}
			
			imgSource = tempStr;
		}
		
		public function stripHTMLTags( input: String ): String {
			var ret: String = input.replace( /<[^<]+?>/g, " " );
			return input.replace( /<[^<]+?>/g, " " );
		}
		
		public function set maxCharDesc( value: int ): void {
			if ( value < 0 ) return;
			_maxCharDesc = value;
			if ( _data == null || !_data.hasOwnProperty( "description" ) ) return;
			generateDesc();
		}
		
		public function get data(): XML {
			return _data;
		}
		
		public function set data( value: XML ): void {
			_data = value;
			title = String(_data.title).replace( "\n", " " );
			generateDesc();
			getFirstImageURL();
			getDate();
			
		}
		
		private function getDate(): void {
			if ( _data.pubDate == undefined ) {
				// RSS 0.x
				if ( _data.date == undefined ) {
					pubDate = null;
				}
				// RSS 1.0
				else {
					pubDate = DateUtil.parseW3CDTF( _data.date );
				}
			}
			// RSS 2.0
			else {
				pubDate = DateUtil.parseRFC822( _data.pubDate );
			}
		}
		
		private function generateDesc(): void {
			var originalDescLength: int;
			desc = stripHTMLTags(_data.description.toString());
			originalDescLength = desc.length;
			desc = desc.slice( 0, _maxCharDesc );
			if ( desc.length < originalDescLength )
				desc = desc.concat( "..." );
		}
		
		

	}
}