package com.hieusua.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class HTimer extends Timer
	{
		public var callback:Function;
		public var params:Array;
		
		public function HTimer(delay:Number, callback:Function, params:Array = null, repeatCount:int=0)
		{
			super(delay, repeatCount);
			this.callback = callback;
			this.params = params;
			addEventListener( TimerEvent.TIMER, timerHandler );
			addEventListener( TimerEvent.TIMER_COMPLETE, timerCompleteHandler );
		}
		
		private function timerHandler( event:TimerEvent ):void {
			callback.apply( null, params );
			
		}
		
		private function timerCompleteHandler( event:TimerEvent ):void {
			clearAll();
		}
		
		private function clearAll():void {
			removeEventListener( TimerEvent.TIMER, timerHandler );
			this.callback = null;
			this.params = null;
			removeEventListener( TimerEvent.TIMER_COMPLETE, timerCompleteHandler );
		}
		
		public function release():void {
			stop();
			clearAll();
		}
	}
}