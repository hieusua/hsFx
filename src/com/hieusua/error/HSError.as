package com.hieusua.error
{
	import mx.resources.ResourceBundle;
	import mx.utils.StringUtil;
	
	public class HSError extends Error
	{
		public static const SINGLETON_EXCEPTION:String = "HS001";
		public static const INVOKE_ABSTRACT_FUNCTION:String = "HS002";
		public static const INVOKE_FORBIDDEN_FUNCTION:String = "HS003";
		public static const HTTP_SERVICE_ERROR:String = "HS004";
		public static const ERROR_5:String = "HS005";
		
		public static var errorMessage:Object = {
			HS001:"Only one {0} instance can be instantiated.",
			HS002:"Function {0}.{1} is an abstract function",
			HS003:"Function {0}.{1} is no longer ready to use",
			HS004:"{0}: {1}",
			HS005:""
			
		};
		
		
		public function HSError( errorCode : String, ... rest )
		{
			super( formatMessage( errorCode, rest.toString() ) );
		}
		
		private function formatMessage( errorCode : String, ... rest ) : String
		{
			//var message : String =  StringUtil.substitute( resourceBundle.getString( errorCode ), rest );
			var message : String = StringUtil.substitute( errorMessage[ errorCode ], rest );
			
			return StringUtil.substitute( "{0}: {1}", errorCode, message);
		}
		
	}
}