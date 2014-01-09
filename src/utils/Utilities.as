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
			
			while ( (Game.TileArray[tileId].MapValue != 1) || (allowOccupied == false && IsTileOccupied(Game.TileArray[tileId])))
			{
				tileId = GetRandomInt(0, len);
			}
			
			return Game.TileArray[tileId];
		}
		
		public static function IsTileOccupied(tile:Tile, includeItems:Boolean = false):Boolean 
		{
			// TODO: Implement Utilities.IsTileOccupied()
			return false;
		}
	}

}