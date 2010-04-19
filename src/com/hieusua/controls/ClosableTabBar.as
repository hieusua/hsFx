package com.hieusua.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	import mx.containers.ViewStack;
	import mx.controls.TabBar;
	import mx.core.ClassFactory;
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.core.IUIComponent;


	public class ClosableTabBar extends mx.controls.TabBar
	{
		public function ClosableTabBar()
		{
			super();
			
			use namespace mx_internal;
			
			navItemFactory = new ClassFactory( ClosableTab );
		}
		
		override protected function createNavItem(
                                        label:String,
                                        icon:Class = null):IFlexDisplayObject {
                                            
            var ifdo:IFlexDisplayObject = super.createNavItem( label, icon );
            ifdo.addEventListener( ClosableTab.CLOSE_TAB, fhCloseTab );
            //ifdo.addEventListener( MouseEvent.MOUSE_DOWN, tryDrag );
            //ifdo.addEventListener( MouseEvent.MOUSE_UP, removeDrag );
            return ifdo;
        }
        
        /* private function tryDrag( e:MouseEvent ):void {
            e.target.addEventListener( MouseEvent.MOUSE_MOVE, doDrag );
        }
        
        private function removeDrag( e:MouseEvent ):void {
            e.target.removeEventListener( MouseEvent.MOUSE_MOVE, doDrag );
        } */
        public function fhCloseTab( event:Event ):void {
            var index:int = getChildIndex( DisplayObject( event.currentTarget ) );
            
            if ( index == 0 )
            	return;
            
            if( dataProvider is IList ) {
                dataProvider.removeItemAt( index );
            }
            else if( dataProvider is ViewStack ) {
                dataProvider.removeChildAt( index );
            }
        }
        
        /* private function doDrag(event:MouseEvent):void{
                var ds:DragSource = new DragSource();
                ds.addData(event.currentTarget,'tabDrag');
                DragManager.doDrag(IUIComponent(event.target),ds,event);                        
        }
        
        private function onDragEnter(event:DragEvent):void{
            if(event.dragSource.hasFormat('tabDrag')){
                DragManager.acceptDragDrop(IUIComponent(event.target));
            }
        } */
        
        /* private function onDragDrop(event:DragEvent):void{
            var d:ClosableTab = ClosableTab(event.dragSource.dataForFormat('tabDrag'));
            var childrenArr:Array = new Array();
            d.x = mouseX;
            //d.x = DragManager.dragProxy.x;
            for(var i:Number=0; i<numChildren; i++){
                var childRef:DisplayObject = getChildAt(i);
                childrenArr.push(childRef);    
            }
            childrenArr.sortOn("x",Array.NUMERIC);
            childrenArr[0].x=0;
            for(var c:Number = 1; c<childrenArr.length; c++){
                childrenArr[c].x = childrenArr[c-1].x+childrenArr[c-1].width;
            }
        }  */
		
	}
	
	
	
}