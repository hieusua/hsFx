package com.hieusua.preloaders {
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import mx.preloaders.*;
	
	[SWF(width="400", height="150")]
	public class Preloader05 extends Sprite implements IPreloaderDisplay
	{
		//[Embed(source="assets/images/chatIcon.png")]
		private var ChatIcon:Class;
		
		private var dropShadow:DropShadowFilter;
		
		private var progressBar:Sprite;
		
		private var percentTextFormat:TextFormat;
		private var percentText:TextField;
		
		private var loadingTextFormat:TextFormat;
		private var loadingText:TextField;
		
		// Define a Loader control to load the SWF file.
        private var dpbImageControl:flash.display.Loader;
		
		private var sparkle:Sprite = new Sprite();
		
		public function Preloader05()
		{
			super();
			dropShadow = new DropShadowFilter( 0, 0, 0, 1, 8, 8 );
			this.filters = [ dropShadow ];
		}
		
		public function initialize():void {
			this.x = stage.stageWidth / 2 - 200;
			this.y = 150;
			var panel:Sprite = new Sprite();
			panel.graphics.beginFill( 0xFFFFFF );
			panel.graphics.drawRoundRect( 0, 0, 300, 50, 10, 10 );
			panel.graphics.endFill();
			panel.x = 50;
			panel.y = 40;
			
			var bitmap:Bitmap = new ChatIcon();
			bitmap.y = 25;
			bitmap.x = 10;
			
			progressBar = new Sprite();
			progressBar.x = 120;
			progressBar.y = 70;
			//progress = 0.1;
			
			percentTextFormat = new TextFormat( "Arial", 28, 0x2277AA, true, null, null, null, null, TextFormatAlign.RIGHT );
			percentTextFormat.letterSpacing = -1;
			percentText = new TextField();
			percentText.selectable = false;
			percentText.defaultTextFormat = percentTextFormat;
			percentText.x = 245;
			percentText.y = 40;
			percentText.scaleY = 1.5;
			percentText.text = String( int( progressBar.width / 1.5 ) );
			
			loadingTextFormat = new TextFormat( "Verdana", 14, 0x0077AA, true );
			loadingText = new TextField();
			loadingText.selectable = false;
			loadingText.defaultTextFormat = loadingTextFormat;
			loadingText.text = "Loading";
			loadingText.x = 120;
			loadingText.y = 45;
			
			
			addChild( panel );
			addChild( progressBar );
			/* addChild( sparkle ); */
			addChild( percentText );
			addChild( loadingText );
			addChild( bitmap );
			
		}
		
		public function set progress( value:Number ):void {
			progressBar.graphics.beginFill( 0x2277AA );
			progressBar.graphics.drawRoundRect( 0, 0, 150 * value, 15, 5, 5 );
			progressBar.graphics.endFill();
			if ( percentText != null )
				percentText.text = String( int( value * 100 ) );
		}
		
		// After the SWF file loads, set the size of the Loader control.
        private function loader_completeHandler(event:Event):void
        {
            /* addChild(dpbImageControl);
            dpbImageControl.width = 400;
            dpbImageControl.height= 150;
            dpbImageControl.x = 100;
            dpbImageControl.y = 100; */
        } 
		
		public function set preloader(preloader:Sprite):void {
            // Listen for the relevant events
            preloader.addEventListener(
                ProgressEvent.PROGRESS, handleProgress); 
            preloader.addEventListener(
                Event.COMPLETE, handleComplete);
    
            /* preloader.addEventListener(
                FlexEvent.INIT_PROGRESS, handleInitProgress);
            preloader.addEventListener(
                FlexEvent.INIT_COMPLETE, handleInitComplete); */
        }
        
        private function handleProgress( event:ProgressEvent ):void {
        	progress = ( event.target.loaderInfo.bytesLoaded / event.target.loaderInfo.bytesTotal );
        	/* if ( event.target.loaderInfo.bytesLoaded == event.target.loaderInfo.bytesTotal ) {
        		var evt:Event = new Event( Event.COMPLETE );
        		dispatchEvent( evt );
        	} */
        }
        
        private function handleComplete( event:Event ):void {
        	var timer:Timer = new Timer(2000,1);
            timer.addEventListener(TimerEvent.TIMER, dispatchComplete);
            timer.start();  
        	//Tweener.addTween( this, {y: this.y - 100, alpha: 0, time: 2 } );
        }
        
        private function dispatchComplete( event:TimerEvent ):void {
        	dispatchEvent( new Event( Event.COMPLETE ) );
        }
        // Implement IPreloaderDisplay interface
    
        public function get backgroundColor():uint {
            return 0;
        }
        
        public function set backgroundColor(value:uint):void {
        }
        
        public function get backgroundAlpha():Number {
            return 0;
        }
        
        public function set backgroundAlpha(value:Number):void {
        }
        
        public function get backgroundImage():Object {
            return undefined;
        }
        
        public function set backgroundImage(value:Object):void {
        }
        
        public function get backgroundSize():String {
            return "";
        }
        
        public function set backgroundSize(value:String):void {
        }
    
        public function get stageWidth():Number {
            return 200;
        }
        
        public function set stageWidth(value:Number):void {
        }
        
        public function get stageHeight():Number {
            return 200;
        }
        
        public function set stageHeight(value:Number):void {
        }
	}
}
