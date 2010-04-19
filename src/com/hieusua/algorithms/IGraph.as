package com.hieusua.algorithms
{
	public interface IGraph
	{
		//public var arrNode:IGraphNode;
		function set arrNode( value:Array ):void;
		function get arrNode():Array;
		
		function clearGraph():void;
		function config( confStr:String ):void;
		
		function createNewNode(  id:String  ):IGraphNode;
		function getNode( id:String ):IGraphNode;
		function deleteNodeByID( id:String ):void;
		function deleteNode( node:IGraphNode ):void;
	}
}