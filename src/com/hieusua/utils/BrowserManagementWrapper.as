package com.hieusua.utils
{
	
	import com.hieusua.error.HSError;
	
	import flash.events.EventDispatcher;
	
	import mx.events.BrowserChangeEvent;
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.utils.URLUtil;
	
	public class BrowserManagementWrapper extends EventDispatcher
	{
		
		protected static var _instance:BrowserManagementWrapper;
		
		public function BrowserManagementWrapper( initParam:Object = null )
		{
			bm = BrowserManager.getInstance();
			if ( initParam != null && initParam.hasOwnProperty( "title" ) ) {
				init( initParam.title );
			}
			else {
				init( "" );
			}
			
			if ( _instance == null )
				_instance = this;
			else
				throw new HSError( HSError.SINGLETON_EXCEPTION, "BrowserManagementWrapper" );;
		}
		
		public static function getInstance( initParam:Object = null ):BrowserManagementWrapper {
			if (!_instance)
				_instance = new BrowserManagementWrapper( initParam );
			return _instance;
		}
		
		public var bm:IBrowserManager;
		
		private var _title:String = "";
		
		private function init( t:String ):void {
			//bm = BrowserManager.getInstance();
			bm.init( "", t );
			this.title = t;
			bm.addEventListener(BrowserChangeEvent.URL_CHANGE, fhURLChanged );
			
			//ChangeWatcher.watch( modelLocator, "mainState", fhMainStateChanged );
		}
		
		public function set title( value:String ):void {
			_title = value;
			bm.setTitle( value );
		}
		
		public function get title():String {
			return _title;
		}
		
		/* private function fhMainStateChanged( event:PropertyChangeEvent ):void {
			paramFromObject = { mode: modelLocator.arrNav[ modelLocator.mainState ].fragment };
		} */
		
		private function fhURLChanged( event:BrowserChangeEvent ):void {
			//parseCurrentURL();
			bm.setTitle( title );
		}
		
		/* public function parseCurrentURL():void {
			var stateTo:int = 0;
			var a:Object = param;
			for ( ; stateTo < modelLocator.arrNav.length; stateTo ++ ) {
				if ( modelLocator.arrNav[ stateTo ].fragment == param.mode )
					break; 
			}
			if ( stateTo < modelLocator.arrNav.length ) {
				var changeMainEvent:ChangeMainViewEvent = new ChangeMainViewEvent( stateTo, null );
				changeMainEvent.dispatch();
			}
		} */
		
		public function get param():Object {
			return URLUtil.stringToObject(bm.fragment, "&");
		}
		
		public function set paramFromObject(o:Object):void {
			bm.setFragment(URLUtil.objectToString(o));
		}
		
		public function set paramFromString(str:String):void {
			bm.setFragment(str);
		}
		
	}
}
