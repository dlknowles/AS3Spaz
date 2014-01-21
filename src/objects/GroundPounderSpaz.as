package objects 
{
	import utils.Constants;
	/**
	 * ...
	 * @author Lee
	 */
	public class GroundPounderSpaz extends Spaz 
	{
		
		public function GroundPounderSpaz(tile:Tile) 
		{
			super(tile, Constants.SPAZ_TYPES.GROUND_POUNDER, "groundpounder");
			
		}
		
		override public function Update():void 
		{
			super.Update();
			
			var prevTileID:int = CurrentTile.ID;
			
			if (TryMove())
			{
				// if moves, place a hole
				trace("pounding the ground...");
				
				dispatchEventWith(OBSTACLE_ADDED, true, new GameItem(Game.TileArray[prevTileID], int(Constants.ITEM_TYPES.CRATER)));
			}
		}
	}

}