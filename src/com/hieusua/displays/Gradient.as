package com.hieusua
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	public class Gradient
	{
		public static var instance:Gradient = new Gradient();
		
		public var matrix:Matrix;
		
		private var radPerDegree:Number = Math.PI / 180;
		
		public function Gradient()
		{
			matrix = new Matrix();
			
			if ( instance == null )
				instance = this;
		}
		
		public function drawLinearRect( g:Graphics, x:Number, y:Number, width:Number, height:Number, angle:Number = 0, colors:Array = null, alphas:Array = null, ratios:Array = null ):void {
			var i:int = 0;
			// adjust colors array
			if ( colors == null || colors == [] ) {
				colors = [ 0xFFFFFF, 0x000000 ];
				alphas = [ 1, 1 ];
				ratios = [ 0, 255 ];
			}
			else if ( colors.length == 1 ) {
				colors[1] = colors[0];
				
			}
			
			// adjust alphas
			if ( alphas == null ) alphas = [];
			for ( i = alphas.length; i < colors.length; i++ ) {
				alphas[i] = 1;
			}
			
			// adjust ratios
			if ( ratios == null ) ratios = [0];
			for ( i = 0; i < ratios.length; i++ ) {
				ratios[i] = int( ratios[i] * 255 );
				if ( ratios[i] > 255 ) ratios[i] = 255;
			}
			
			for ( ; i < colors.length; i++ ) {
				ratios[i] = ratios[i - 1] + ( 255 - ratios[i - 1] ) / ( colors.length - ratios.length );
			}
			
			
			// adjust angle
			angle = ( angle % 360 ) * radPerDegree;
			
			// create gradient box
			matrix.createGradientBox( width, height, angle, 0, 0 );
			
			// draw
			g.beginGradientFill( GradientType.LINEAR, colors, alphas, ratios, matrix );
			g.drawRect( x, y, width, height );
			g.endFill(); 
		}

	}
}