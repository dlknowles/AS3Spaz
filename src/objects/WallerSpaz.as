package objects 
{
	import utils.Constants;
	/**
	 * ...
	 * @author Lee
	 */
	public class WallerSpaz extends Spaz 
	{
		
		public function WallerSpaz(tile:Tile) 
		{
			super(tile, Constants.SPAZ_TYPES.WALLER, "waller");
			
		}
		
		override public function Update():void 
		{
			super.Update();
			
			var prevTileID:int = CurrentTile.ID;
			
			if (TryMove())
			{
				// if moves, place a wall				
				trace("putting up a wall...");
				
				dispatchEventWith(OBSTACLE_ADDED, true, new GameItem(Game.TileArray[prevTileID], int(Constants.ITEM_TYPES.WALL)));
			}
		}
	}

}