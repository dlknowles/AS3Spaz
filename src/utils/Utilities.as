package utils 
{
	import objects.Tile;
	/**
	 * ...
	 * @author Lee
	 */
	public class Utilities 
	{
		public static function GetRandomInt(min:int, max:int):int 
		{
			return Math.floor(Math.random() * (max - min) + min);
		}
		
		public static function GetRandomTile(allowOccupied:Boolean = false, includeItems:Boolean = true):Tile 
		{
			var len:int = Game.TileArray.length;
			var tileId:int = GetRandomInt(0, len);
			
			while ((Game.TileArray[tileId].MapValue != 1) || (allowOccupied == false && IsTileOccupied(Game.TileArray[tileId], includeItems)))
			{
				tileId = GetRandomInt(0, len);
			}
			
			return Game.TileArray[tileId];
		}
		
		public static function IsTileOccupied(tile:Tile, includeItems:Boolean = false):Boolean 
		{
			var i:int, len:int;
			
			// check player
			if (Game.GamePlayer.CurrentTile.ID == tile.ID) return true;
			
			// go through spaz array
			for (i = 0, len = Game.SpazArray.length; i < len; ++i)
			{
				if (Game.SpazArray[i].CurrentTile.ID == tile.ID) return true;
			}
			
			// go through obstacle array
			for (i = 0, len = Game.ObstacleArray.length; i < len; ++i)
			{
				if (Game.ObstacleArray[i].CurrentTile.ID == tile.ID) return true;
			}
			
			// if includeItems, go through item array
			if (includeItems)
			{
				for (i = 0, len = Game.ItemArray.length; i < len; ++i)
				{
					if (Game.ItemArray[i].CurrentTile.ID == tile.ID) return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Tries to get a tile in a random direction (left, right, up, or down). If the direction is
		 * out of bounds of the tile array, returns the tile passed in.
		 * @param	currentTile
		 * @return
		 */
		public static function GetRandomAdjacentTile(currentTile:Tile):Tile
		{
			var newTileId:int = currentTile.ID;	// ID of tile to return. 
			var direction:int = Utilities.GetRandomInt(1, 5);	// direction of new tile
			
			// check the direction to make sure the move is in bounds.
			switch (direction) 
			{				
				case 1:	// right
					if (currentTile.Column < Constants.NUMCOLUMNS - 1) newTileId = currentTile.ID + 1;
					break;
				case 2:	// left
					if (currentTile.Column > 0) newTileId = currentTile.ID - 1;
					break;
				case 3:	// up
					if (currentTile.Row > 0) newTileId = currentTile.ID - Constants.NUMCOLUMNS;
					break;
				case 4:	// down
					if (currentTile.Row < Constants.NUMROWS - 1) newTileId = currentTile.ID + Constants.NUMCOLUMNS;
					break;
				default:
					// not moving, leave new tile id alone
			}
			
			return Game.TileArray[newTileId];
		}
	}

}