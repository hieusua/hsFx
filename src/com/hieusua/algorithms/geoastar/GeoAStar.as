package com.hieusua.algorithms.geoastar
{
	import com.hieusua.algorithms.IGraph;
	
	import flash.utils.Dictionary;
	
	public class GeoAStar
	{
		private var _graph:GeoGraph;
		private var _heuristicFunc:Function;
		private var openSet:Array;
		private var closedSet:Array;
		private var cameFrom:Dictionary;
		private var gScore:Dictionary;
		private var fScore:Dictionary;
		
		public function GeoAStar()
		{
			cameFrom = new Dictionary();
			gScore = new Dictionary();
			fScore = new Dictionary();
			
			//graph = new GeoGraph();
		}
		
		public function set graph( value:IGraph ):void {
			_graph = GeoGraph( value );
		}
		
		public function set heuristicFunc( value:Function ):void {
			_heuristicFunc = value;
		}
		
		public function execute( a:String, b:String ):Array {
			if ( a == null || b == null || _heuristicFunc == null )
				return [];
			var tentativeIsBetter:Boolean = true;
			var tentativeGScore:Number = 0;
			var nodeA:GeoGraphNode = GeoGraphNode( _graph.getNode( a ) );
			var nodeB:GeoGraphNode = GeoGraphNode( _graph.getNode( b ) );
			var nodeX:GeoGraphNode = null;
			if ( nodeA == null || nodeB == null )
				return [];
			
			gScore[ nodeA ] = 0;
			fScore[ nodeA ] = _heuristicFunc( nodeA, nodeB );//GeoAStar.hValue( nodeA, nodeB ); 
			openSet = [nodeA];
			closedSet = [];
			
			
			while ( openSet != [] ) {
				nodeX = lowestFScoreNode();
				
				if ( nodeX == nodeB ) {
					return reconstructPath( nodeA, nodeB );
				}
				openSet.splice( openSet.indexOf( nodeX ), 1 );
				closedSet[ closedSet.length ] = nodeX;
				for each ( var next:GeoGraphNode in nodeX.arrNextNode ) {
					// in closedSet
					if ( closedSet.indexOf( next ) >= 0 )
						continue;
					tentativeGScore = gScore[ nodeX ] + nodeX.costTo( next );
					
					// not in openSet
					if ( openSet.indexOf( next ) < 0 ) {
						openSet[ openSet.length ] = next;
						tentativeIsBetter = true;
					}
					// in openSet
					else {
						tentativeIsBetter = ( tentativeGScore < gScore[ next ] );
					}
					
					if ( tentativeIsBetter ) {
						cameFrom[ next ] = nodeX;
						gScore[ next ] = tentativeGScore;
						fScore[ next ] = gScore[ next ] + _heuristicFunc( next, nodeB );//GeoAStar.hValue( next, nodeB ); 
					}
				}
			}
			return [];
		}
		
		public function reconstructPath( nodeA:GeoGraphNode, nodeB:GeoGraphNode ):Array {
			var ret:Array = [];
			var nodeX:GeoGraphNode = nodeB;
			//var length:Number = 0;
			while ( nodeX != nodeA ) {
				ret.unshift( nodeX );
				nodeX = cameFrom[nodeX];
				//length += nodeX.costTo( ret[0] );
			}
			ret.unshift( nodeA );
			return ret;
		}
		
		public function lowestFScoreNode():GeoGraphNode {
			if ( openSet == [] ) return null;
			var ret:GeoGraphNode = openSet[0];
			//var fScore1:Number = 0;
			//var fScore2:Number = 0;
			for ( var i:int = 1; i < openSet.length; i++ ) {
				//fScore1 = fScore[ret];
				//fScore2 = fScore[openSet[i]];
				ret = ( fScore[ret] <= fScore[openSet[i]] ) ? ret : openSet[i];
			}
			
			return ret;
		}
		
		public static function hValue( a:GeoGraphNode, b:GeoGraphNode ):Number {
			if ( a == null || b == null ) return -1;
			return Math.sqrt( (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y) );
		}
		

	}
}