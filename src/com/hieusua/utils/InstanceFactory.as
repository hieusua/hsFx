package com.hieusua.utils
{
	public class InstanceFactory
	{
		public static const SINGLETON: String = "singleton";
		public static const NORMAL: String = "normal";
		
		/* private static var _instance: InstanceFactory; */
		
		private static var repository: Array = new Array();
		
		/* public static function getInstance(): InstanceFactory {
			if ( _instance == null )
				_instance = new InstanceFactory();
			return _instance; 
		} */
		
		public function InstanceFactory()
		{
			/* repository = [];
			_instance = this; */
		}
		
		/**
		 * 
		 * @param classObj
		 * 		a Class definition of newly creating object
		 * @param type
		 * 		SINGLETON: 	Looking for existing object first, return if any,
		 * 					otherwise return new one.
		 * 		NORMAL:		Create immediately
		 * @return 
		 * 		new object of given Class
		 */
		public static function getClassInstance( classObj: Class, type: String = SINGLETON ): * {
			var o:Object;
			
			if ( classObj == null ) return null;
			
			switch ( type ) {
				case SINGLETON:
					// search for existing one
					for each ( o in repository ) {
						if ( o.classObj == classObj ) {
							if ( o.instance == null ) {
								o.instance = new classObj();
							}
							return o.instance;
						}
					}
					
					// create new one at first time
					o = { classObj: classObj, instance: new classObj() };
					repository[ repository.length ] = o;
					return o.instance;
					break;
				case NORMAL:
					return new classObj();
			}
		} 
	}
}