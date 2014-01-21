package objects 
{
	import utils.Constants;
	/**
	 * ...
	 * @author Lee
	 */
	public class BlockerSpaz extends Spaz
	{	
		public function BlockerSpaz(tile:Tile) 
		{
			super(tile, Constants.SPAZ_TYPES.BLOCKER, "blocker");
		}
		
	}

}