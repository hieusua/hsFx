package com.hieusua.media
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	[Event( name="play", type="com.hieusua.media.MP3PlayerEvent" )]
	[Event( name="pause", type="com.hieusua.media.MP3PlayerEvent" )]
	[Event( name="stop", type="com.hieusua.media.MP3PlayerEvent" )]
	[Event( name="loadBegin", type="com.hieusua.media.MP3PlayerEvent" )]
	[Event( name="loadComplete", type="com.hieusua.media.MP3PlayerEvent" )]
	[Event( name="soundComplete", type="com.hieusua.media.MP3PlayerEvent" )]
	public class MP3Player extends EventDispatcher implements MP3PlayerInterface
	{
		private var soundFactory:Sound;
		private var soundChannel:SoundChannel;
		
		private var _maxLength:Number;
		private var _position:Number;
		
		private var _isPlaying: Boolean;
		private var _isLoaded:Boolean;
		
		public function MP3Player()
		{
			soundChannel = new SoundChannel();
			_isLoaded = false;
			_isPlaying = false;
			_position = 0;
			_maxLength = 0;
		}
		
		public function playSoundAsset( soundAsset: Sound ): void {
			if ( soundAsset == null ) return;
			soundFactory = soundAsset;
			if ( !_isPlaying ) {
				soundChannel = soundFactory.play( _position );
				soundChannel.addEventListener(Event.SOUND_COMPLETE, fhSoundChannelComplete);
				_isPlaying = true;
				dispatchEvent( new MP3PlayerEvent( MP3PlayerEvent.PLAY ) );
			}
		}
		
		public function loadSongAsset( soundAsset: Sound ): void {
			stop();
			if ( soundAsset == null ) return;
			if ( soundFactory != null ) {
				soundFactory.removeEventListener( Event.OPEN, fhSoundOpen );
				soundFactory.removeEventListener( ProgressEvent.PROGRESS, fhSoundLoadProgress );
				soundFactory.removeEventListener( Event.COMPLETE, fhSoundLoadComplete );
			}
			soundFactory = soundAsset;
		}

		public function loadSong(url:String):void
		{
			// clear prev state
			stop();
			_isLoaded = false;
			
			
			// load new sound
			if ( url == null )
				return;
			if ( soundFactory != null ) {
				soundFactory.removeEventListener( Event.OPEN, fhSoundOpen );
				soundFactory.removeEventListener( ProgressEvent.PROGRESS, fhSoundLoadProgress );
				soundFactory.removeEventListener( Event.COMPLETE, fhSoundLoadComplete );
			}
			soundFactory = new Sound();
			soundFactory.addEventListener( Event.OPEN, fhSoundOpen );
			soundFactory.addEventListener( ProgressEvent.PROGRESS, fhSoundLoadProgress );
			soundFactory.addEventListener( Event.COMPLETE, fhSoundLoadComplete );
			
			var req:URLRequest = new URLRequest( url );
			soundFactory.load( req );
			
		}
		
		public function get progress():Number
		{
			return 0;
		}
		
		public function play():void
		{
			if ( !_isPlaying ) {
				if ( soundFactory == null ) return;
				soundChannel = soundFactory.play( _position );
				soundChannel.addEventListener(Event.SOUND_COMPLETE, fhSoundChannelComplete);
				_isPlaying = true;
				dispatchEvent( new MP3PlayerEvent( MP3PlayerEvent.PLAY ) );
			}
		}
		
		public function pause():void
		{
			if ( !_isPlaying )
				return;
			_position = soundChannel.position;
			soundChannel.stop();
			_isPlaying = false;
			dispatchEvent( new MP3PlayerEvent( MP3PlayerEvent.PAUSE ) );
		}
		
		public function stop():void
		{
			if ( !_isPlaying )
				return;
			_position = 0;
			soundChannel.stop();
			_isPlaying = false;
			dispatchEvent( new MP3PlayerEvent( MP3PlayerEvent.STOP ) );
		}
		
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		public function get isLoaded():Boolean {
			return _isLoaded;
		}
		
		public function get maxLength():Number {
			return _maxLength;
		}
		
		
		
		private function fhSoundChannelComplete( event:Event ):void {
			_isPlaying = false;
			_position = 0;
			dispatchEvent(new MP3PlayerEvent( MP3PlayerEvent.SOUND_COMPLETE));
		}
		
		private function fhSoundOpen( event:Event ):void {
			dispatchEvent( new MP3PlayerEvent( MP3PlayerEvent.LOAD_BEGIN ) );
		}
		
		private function fhSoundLoadProgress( event:ProgressEvent ):void {
			_maxLength = event.target.length * event.bytesTotal / event.bytesLoaded;
			//dispatchEvent( new MP3ProgressEvent( _maxLength ) );
		}
		
		private function fhSoundLoadComplete( event:Event ):void {
			_maxLength = event.target.length;
			_isLoaded = true;
			dispatchEvent( new MP3PlayerEvent( MP3PlayerEvent.LOAD_COMPLETE ) );
		}
		
	}
}