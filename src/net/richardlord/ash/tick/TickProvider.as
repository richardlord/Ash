package net.richardlord.ash.tick
{
	/**
	 * @author richard
	 */
	public interface TickProvider
	{
		function add( listener : Function ) : void;
		function remove( listener : Function ) : void;
		
		function start() : void;
		function stop() : void;
	}
}
