package com.hieusua.controls
{
	import com.hieusua.skins.LeftSideButtonSkin;
	
	import mx.controls.TabBar;
	import mx.core.ClassFactory;
	import mx.core.mx_internal;

	public class VerticalTabBar extends TabBar
	{
		
		public function VerticalTabBar()
		{
			super();
			direction = "vertical";
			use namespace mx_internal;
			navItemFactory = new ClassFactory( VerticalTab );
			//setStyle( "buttonStyleName", VerticalButtonBarButtonSkin );
			
			
		}
		
	}
}