package com.hieusua.algorithms.geoastar
{
	import com.hieusua.algorithms.IGraph;
	import com.hieusua.algorithms.IGraphNode;

	public class GeoGraph implements IGraph
	{
		public var _arrNode:Array;
		
		public function GeoGraph()
		{
			_arrNode = [];
		}
		
		public function set arrNode( value:Array ):void {
			_arrNode = value;
		}
		
		public function get arrNode():Array {
			return _arrNode;
		}
		
		public function clearGraph():void {
			_arrNode = [];
		}
		
		public function createNewNode( id:String ):IGraphNode {
			
			var newNode:GeoGraphNode = GeoGraphNode( getNode( id ) );
			if ( newNode != null )
				return newNode;
			newNode = new GeoGraphNode( id );
			_arrNode[ _arrNode.length ] = newNode;
			return newNode;
		}
		
		public function getNode( id:String ):IGraphNode {
			for ( var i:int = 0; i < _arrNode.length; i++ ) {
				if ( _arrNode[i].id == id ) {
					return _arrNode[i];
				}
			}
			return null;
		}
		
		public function deleteNodeByID( id:String ):void {
			var node:IGraphNode = getNode( id );
			if ( node != null )
				deleteNode( node );
		}
		
		public function deleteNode( node:IGraphNode ):void {
			for ( var i:int = 0; i < _arrNode.length; i++ ) {
				if ( node == _arrNode[i] ) {
					for each ( var o:GeoGraphNode in node.arrNextNode ) {
						node.removeNextNode( o );
						o.removeNextNode( node );
					}
					_arrNode.splice( i, 1 );
					break;
				}
			}
		}
		
		public function config( confStr:String ):void {
			var lines:Array = confStr.split( "\n" );
			var lineElements:Array = [];
			var numLines:int =  lines.length;
			var currNode:GeoGraphNode = null;
			var currNextNode:GeoGraphNode = null;
			var i:int = 0;
			
			for ( i = 0; i < numLines; i++ ) {
				if ( String(lines[i]) == "edge" )
					break;
				lineElements = ( String( lines[i] ) ).split( " " );
				currNode = GeoGraphNode( createNewNode( lineElements[0] ) );
				currNode.x = Number(lineElements[1]);
				currNode.y = Number(lineElements[2]);
			}
			
			i++;
			
			for ( ; i < numLines; i++ ) {
				lineElements = ( String( lines[i] ) ).split( " " );
				
				currNode = GeoGraphNode( createNewNode( lineElements[0] ) );
				for ( var j:int = 1; j < lineElements.length; j++ ) {
					currNextNode = GeoGraphNode( createNewNode( lineElements[j] ) );
					currNode.addNextNode( currNextNode );
					currNextNode.addNextNode( currNode );
				}
			}
		}

	}
}