package com.hieusua.media
{
	import flash.events.Event;

	public class MP3PlayerEvent extends Event
	{
		public static const PLAY: String = "play";
		public static const PAUSE: String = "pause";
		public static const STOP: String = "stop";
		public static const LOAD_BEGIN: String = "loadBegin";
		public static const LOAD_COMPLETE: String = "loadComplete";
		public static const SOUND_COMPLETE: String = "soundComplete";
		
		public function MP3PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}