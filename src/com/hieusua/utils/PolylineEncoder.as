package com.hieusua.utils
{
	public class PolylineEncoder
	{
		public static const INIT_VALUE:Number = -179.9832104;
		
		private static var arrTmp:Array = [];
		
		private static function e5AndRound( value:Number ):int {
			return Math.round( value * 100000 );
		}
		
		private static function convertToBinaryStr( value:int ):String {
			var ret:String = "";
			var flag:int = 1;
			for ( var i:int = 0; i < 32; i++ ) {
				if ( value & flag )
					ret = "1" + ret;
				else
					ret = "0" + ret;
				flag <<= 1;
			}
			return ret;
		}
		
		private static function encodeOneValue( value:Number ):String {
			var tmp:int;
			var i:int;
			var ret:String = "";
			
			// step 2
			tmp = e5AndRound( value );
			// step 3 is skipped coz that's default of as3 data storing method
			// step 4
			tmp <<= 1;
			
			// step 5
			if ( tmp & 0x80000000 )
				tmp = tmp ^ 0xFFFFFFFF;
			
			// step 6, 7 & 8
			arrTmp = [];
			while ( tmp != 0 ) {
				arrTmp.push( ( tmp & 0x1F ) | 0x20 );
				tmp = ( tmp & ~0x1F ) >> 5;
				
			}
			arrTmp[ arrTmp.length - 1 ] -= 0x20;
			
			
			// step 9 & 10
			for ( i = 0; i < arrTmp.length; i++ ) {
				ret += String.fromCharCode( arrTmp[ i ] + 63 );
			}
			return ret;
		}
		
		public static function encodePolyline( arrPoints:Array ):String {
			var ret:String = "";
			var offsetLat:Number = 0;
			var offsetLng:Number = 0;
			
			ret += encodeOneValue( arrPoints[ 0 ].lat() );
			ret += encodeOneValue( arrPoints[ 0 ].lng() );
			
			for ( var i:int = 1; i < arrPoints.length; i++ ) {
				ret += encodeOneValue( arrPoints[ i ].lat() - arrPoints[ i - 1 ].lat() );
				ret += encodeOneValue( arrPoints[ i ].lng() - arrPoints[ i - 1 ].lng() );
			}
			
			return ret;
		}

	}
}