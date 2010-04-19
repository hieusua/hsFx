package com.hieusua.core
{
	public dynamic class HArray extends Array
	{
		
		public function HArray( numElements: int = 0, idName: String = "id" )
		{
			super(numElements);
			this.idName = idName;
		}
		
		/**
		 * idName is used for operations on array elements 
		 */
		private var _idName: String = "id";
		public function set idName( value: String ): void {
			if ( value != null && value != "" )
				_idName = value;
		}
		
		public function get idName(): String {
			return _idName;
		}
		
		
		public function getElement( id: String ): * {
			for ( var i: int = 0; i < this.length; i++ ) {
				if ( this[i][_idName] == id )
					return this[i];
			}
			return null;
		}
		
		public function addElement( element:* ): * {
			if ( element == undefined || element == null ) return null;
			for ( var i: int = 0; i < this.length; i++ ) {
				if ( this[i][_idName] == element[_idName] )
					return this[i];
			}
			push( element );
			return element;
		}
		
		public function removeElement( id: String ): void {
			for ( var i: int = 0; i < this.length; i++ ) {
				if ( this[i][_idName] == id )
					this.splice( i, 1 );
			}
		}
		
		AS3 override function push(...args):uint {
	        for (var i:* in args)
		    {
		        if ( getElement( args[i][_idName]) != null )
		        {
		            args.splice(i,1);
		        }
		    }
		    return (super.push.apply(this, args));
		} 
		
	}
}