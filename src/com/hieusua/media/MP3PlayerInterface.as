package com.hieusua.media
{
	public interface MP3PlayerInterface
	{
		function loadSong( url: String ): void;
		function get progress(): Number;
		
		function play(): void;
		function pause(): void;
		function stop(): void;
		function get isPlaying(): Boolean;
		
	}
}