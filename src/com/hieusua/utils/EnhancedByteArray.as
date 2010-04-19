package com.hieusua.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class EnhancedByteArray extends ByteArray
	{
		protected var tempBA:ByteArray;
		
		public function EnhancedByteArray()
		{
			super();
			endian = Endian.LITTLE_ENDIAN;
		}
		
		public function writeNBytesString( str:String, n:int = 32 ):void {
			tempBA = new ByteArray();
			tempBA.writeUTFBytes( str );
			for ( var i:int = 0; i < 8; i ++ )
				tempBA.writeInt( 0 );
			writeBytes( tempBA, 0, n );
		}
		
		
	}
}