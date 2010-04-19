package com.hieusua.controls
{
	import mx.controls.DataGrid;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.events.ListEvent;
	import flash.geom.Point;
	import mx.events.DragEvent;
	import mx.managers.DragManager;

	public class DisabledKeyDataGrid extends DataGrid
	{
		public function DisabledKeyDataGrid()
		{
			super();
		}
		
	    override protected function dragEnterHandler(event:DragEvent):void
	    {
	    	event.ctrlKey = false;
	    	super.dragEnterHandler(event);
	    }
	
	    override protected function dragOverHandler(event:DragEvent):void
	    {
	        event.ctrlKey = false;
	        super.dragOverHandler(event);
	    }
		
	}
}