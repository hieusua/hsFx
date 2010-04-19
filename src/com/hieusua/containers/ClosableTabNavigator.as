package com.hieusua.containers
{
	import mx.containers.TabNavigator;
	import com.hieusua.controls.ClosableTabBar;

	public class ClosableTabNavigator extends TabNavigator
	{
		override protected function createChildren():void{
            if ( !tabBar ) {
                tabBar = new ClosableTabBar();
                tabBar.name = "tabBar";
                tabBar.focusEnabled = false;
                tabBar.styleName = this;
    
                tabBar.setStyle( "borderStyle", "none" );
                tabBar.setStyle( "paddingTop", 0 );
                tabBar.setStyle( "paddingBottom", 0 );
                
                rawChildren.addChild( tabBar );
                
            }
            super.createChildren();
        }

		
	}
}