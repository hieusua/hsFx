package com.hieusua.algorithms
{
	public interface IGraphNode
	{
		//var arrNextNode:Array;
		//var id:String;
		function numNextNode():int;
		function get arrNextNode():Array;
		function addNextNode( node:IGraphNode ):void;
		function removeNextNode( node:IGraphNode ):void;
		function nearestNode():IGraphNode;
		function costTo( node:IGraphNode ):Number;
		function toString():String;
	}
}