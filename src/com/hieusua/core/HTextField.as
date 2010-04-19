package com.hieusua.core
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class HTextField extends TextField
	{
		private var tfmt: TextFormat;
		private var _text: String;
		private var _htmlText: String;
		private var isHTML: Boolean;
		
		private var isFormatChanged: Boolean;
		
		public function HTextField( text: String = "", fontFamily: String = "Arial", fontSize: int = 12, fontColor: int = 0xFFFFFF, fontWeight: Boolean = false )
		{
			super();
			_text = "";
			_htmlText = "";
			isHTML = false;
			tfmt = new TextFormat( fontFamily, fontSize, fontColor, fontWeight, false, false );
			tfmt.align = TextFormatAlign.RIGHT;
			isFormatChanged = true;
			this.cacheAsBitmap = true;
			this.embedFonts = true;
			this.text = text;
			validateProperties();
		}
		
		public function set fontFamily( value: String ): void {
			tfmt.font = value;
			isFormatChanged = true;
			validateProperties();
		}
		
		public function get fontFamily(): String {
			return tfmt.font;
		}
		
		public function set fontSize( value: int ): void {
			tfmt.size = value;
			isFormatChanged = true;
			validateProperties();
		}
		
		public function get fontSize(): int {
			return int(tfmt.size);
		}
		
		public function set fontWeight( value: Boolean ): void {
			if ( value != tfmt.bold ) {
				tfmt.bold = value;
				isFormatChanged = true;
				validateProperties();
			}
			/* switch ( value ) {
				case "bold":
					tfmt.bold = true;
					isFormatChanged = true;
					break;
				case "normal":
					tfmt.bold = false;
					isFormatChanged = true;
					break;
				default:
					return;
			} */
			validateProperties();
		}
		
		override public function set text(value:String):void {
			super.text = value;
			_text = value;
			isHTML = false;
			validateProperties();
		}
		
		override public function set htmlText(value:String):void {
			super.htmlText = value;
			_htmlText = value;
			isHTML = true;
			validateProperties();
		}
		
		protected function validateProperties(): void {
			if ( isFormatChanged ) {
				this.setTextFormat( tfmt );
				this.defaultTextFormat = tfmt;
				isFormatChanged = false;
			}
			
			this.width = this.getLineMetrics( 0 ).width + 4;
			this.height = this.getLineMetrics( 0 ).height + 4;
		}
	}
}