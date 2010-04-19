package com.hieusua.controls
{
	import mx.controls.Label;

	public class MultilineLabel extends Label
	{
		public function MultilineLabel()
		{
			super();
		}
		
		/**
	     *  @private
	     */
	    override protected function createChildren():void
	    {
	        super.createChildren();
	
	        textField.wordWrap = true;
	    }

		
	}
}