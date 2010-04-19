package com.hieusua.utils
{
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	public class HFilters
	{
		public function HFilters()
		{
		}
		
		public static const lightShadow:DropShadowFilter = new DropShadowFilter( 1, 45, 0x000000/* 0x0088bb */, 1, 4, 4 );
		public static const mediumShadow:DropShadowFilter = new DropShadowFilter( 2, 45, 0x000000/* 0x0088bb */, 1, 8, 8 );
		
		public static const innerShadowFilter:DropShadowFilter = new DropShadowFilter( 2, 90, 0x999999/* 0x0088bb */, 1, 4, 4, 1, 1, true );
		public static const glowFilter:GlowFilter = new GlowFilter( 0xFFFFFF, 1, 8, 8, 2 );
		public static const bevelFilter:BevelFilter = new BevelFilter( 1, 90 );
	}
}