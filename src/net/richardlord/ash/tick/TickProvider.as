package net.richardlord.ash.tick
{
	public interface TickProvider
	{
		function add( listener : Function ) : void;
		function remove( listener : Function ) : void;
		
		function start() : void;
		function stop() : void;
	}
}
