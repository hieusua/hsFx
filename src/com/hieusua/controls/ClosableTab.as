package com.hieusua.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import mx.controls.tabBarClasses.Tab;
	
	import mx.core.mx_internal;

	public class ClosableTab extends mx.controls.tabBarClasses.Tab
	{
		public static const CLOSE_TAB:String = "closeTab";
        
        [Embed("../assets/images/closeBtnUnfocus.png")]
        public var CloseBtnUnfocus:Class;
		
		[Embed("../assets/images/closeBtnNormal.png")]
        public var CloseBtnNormal:Class;
        
        private var closeIconUnfocus:DisplayObject;
        private var closeIcon:DisplayObject;
        private var isOver:Boolean = false;
        
        
        use namespace mx_internal;
		
		public function ClosableTab()
		{
			super();
			closeIconUnfocus = addChild( new CloseBtnUnfocus() );
			
		}
		
		override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void {
            super.updateDisplayList( unscaledWidth, unscaledHeight );
           	try{
                removeChild( this.closeIconUnfocus );
            }
            catch ( e:Error ) {}
            closeIconUnfocus = addChild( new CloseBtnUnfocus() );
            
            try {
                removeChild( this.closeIcon );
            }
            catch ( e:Error ){}
            closeIcon = addChild( new CloseBtnNormal() );
            if ( !isOver ) {
                closeIcon.visible = false;
            }
                       
            
            this.textField.x -= 10;
            closeIcon.x = unscaledWidth - 16;
            closeIcon.y = ( unscaledHeight - 10 ) >> 1;
            closeIconUnfocus.x = unscaledWidth - 16;
            closeIconUnfocus.y = ( unscaledHeight - 10 ) >> 1;
        }
        
        override protected function clickHandler(event:MouseEvent):void{
            try {
                var rect:Rectangle = new Rectangle( closeIcon.x, closeIcon.y, closeIcon.width, closeIcon.height );
                if( rect.contains( event.localX, event.localY ) ) {
                    dispatchEvent(new Event( ClosableTab.CLOSE_TAB ) );
                    event.stopImmediatePropagation();
                }
                else{
                    super.clickHandler( event );
                }
            }
            catch( e:Error ) {
                super.clickHandler( event );
            }
            
        }

        
        override protected function measure():void{
            super.measure();
            measuredMinWidth += 16;
            measuredWidth += 16;
        }
        
        override protected function rollOverHandler( event:MouseEvent ):void {
            isOver = true;
            super.rollOverHandler( event );    
        }
        
        override protected function rollOutHandler( event:MouseEvent ):void {
            isOver = false;
            super.rollOutHandler( event );    
        }


		
	}
}