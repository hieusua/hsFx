package com.hieusua.algorithms.geoastar
{
	import com.hieusua.algorithms.IGraphNode;
	
	public class GeoGraphNode implements IGraphNode
	{
		public var id:String;
		private var _arrNextNode:Array;
		public var x:Number = 0;
		public var y:Number = 0;
		
		//public var fScore:Number = -1;
		
		public function GeoGraphNode( id:String = "" )
		{
			this.id = id;
			_arrNextNode = [];
		}
		
		public function numNextNode():int {
			return _arrNextNode.length;
		}
		
		public function get arrNextNode():Array {
			return _arrNextNode;
		}
		
		public function addNextNode( node:IGraphNode ):void {
			if ( node == null ) return;
			if ( !(node is GeoGraphNode ) ) return;
			var len:int = arrNextNode.length;
			for ( var i:int = 0; i < len; i++ )
				if ( arrNextNode[i] == node ) return;
			arrNextNode[ len ] = node;
		}
		
		public function removeNextNode( node:IGraphNode ):void {
			if ( node == null ) return;
			if ( !(node is GeoGraphNode ) ) return;
			var len:int = arrNextNode.length;
			for ( var i:int = 0; i < len; i++ )
				if ( arrNextNode[i] == node ) 
					arrNextNode.splice( i, 1 );
		}
		
		public function nearestNode():IGraphNode {
			return null;
		}
		
		public function costTo( node:IGraphNode ):Number {
			if ( node == null ) return -1;
			if ( node == this ) return 0;
			var geoNode:GeoGraphNode = GeoGraphNode( node );
			return Math.sqrt( (x - geoNode.x) * (x - geoNode.x) + (y - geoNode.y) * (y - geoNode.y) );
		}
		
		public function toString():String {
			return id;
		}

	}
}