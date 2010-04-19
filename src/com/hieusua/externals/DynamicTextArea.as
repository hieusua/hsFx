package com.hieusua.externals {
  	import flash.events.Event;
  	import mx.controls.TextArea;
 
  	public class DynamicTextArea extends TextArea {
		public function DynamicTextArea(){
	      	super();
	      	super.horizontalScrollPolicy = "off";
	      	super.verticalScrollPolicy = "off";
	      	this.addEventListener(Event.CHANGE, adjustHeightHandler);
    	}
	    private function adjustHeightHandler( event:Event ):void {
	      	if ( height <= textField.textHeight + textField.getLineMetrics(0).height ) {
	        	height = textField.textHeight;     
	        	validateNow();
	      	}
	    }
	    override public function set text(val:String):void{
	      	textField.text = val;
	      	validateNow();
	      	height = textField.textHeight;
	      	validateNow();
	    }
	    override public function set htmlText( value:String ):void {
	      	textField.htmlText = value;
	      	validateNow();
	      	height = textField.textHeight;
	      	validateNow();
	    }
	    override public function set height( value:Number ):void {
	      	if ( textField == null ) {
	        	if ( height <= value ) {
	          		super.height = value;
        		}
	      	}
	      	else{       
	        	var currentHeight:uint = textField.textHeight + textField.getLineMetrics(0).height;
	        	if ( currentHeight <= super.maxHeight ) {
	          		if ( textField.textHeight != textField.getLineMetrics(0).height ) {
	            		super.height = currentHeight;
	          		}        
	        	}
	        	else {
	            	super.height = super.maxHeight;         
	        	}  
	      	}
	    }
	    override public function get text():String {
	        return textField.text;
	    }
	    override public function get htmlText():String {
	        return textField.htmlText;
	    }
   
	    override public function set maxHeight( value:Number ):void {
	      super.maxHeight = value;
	    }
  	}
}