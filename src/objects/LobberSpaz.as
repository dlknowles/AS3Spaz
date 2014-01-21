package objects 
{
	import utils.Constants;
	import utils.Utilities;
	/**
	 * ...
	 * @author Lee
	 */
	public class LobberSpaz extends Spaz 
	{
		
		public function LobberSpaz(tile:Tile) 
		{
			super(tile, Constants.SPAZ_TYPES.LOBBER, "lobber");
			
		}
		
		override public function Update():void 
		{
			super.Update();
			// TODO: Implement LobberSpaz.Update()
			
			// roll for a chance to lob a blob at a random tile
			var dieRoll:Number = Math.random();
			
			if (dieRoll > ChanceToAct)
			{
				// get a random tile, and place a blob on it
				var newTile:Tile = Utilities.GetRandomTile();
								
				dispatchEventWith(OBSTACLE_ADDED, true, new GameItem(newTile, int(Constants.ITEM_TYPES.BLOB)));
			}
		}
	}

}