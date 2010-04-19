package com.hieusua.utils
{
	import mx.collections.ArrayCollection;
	
	public class MixFactory
	{
		public function MixFactory()
		{
		}
		
		public static function convertToArrayCollection( obj:Object ):ArrayCollection {
			if ( obj == null ) {
				return new ArrayCollection();
			}
			else if ( obj is ArrayCollection ) {
				return obj as ArrayCollection;
			}
			else if ( obj is Array ) { 
				return new ArrayCollection( obj as Array );
			}
			else {
				return new ArrayCollection( [ obj ] ); 
			}
		}

	}
}