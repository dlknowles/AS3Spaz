package objects 
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import utils.Utilities;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class Spaz extends Character 
	{		
		public static const OBSTACLE_ADDED:String = "obstacleAdded";
		public static const SPLIT_SPAZ:String = "splitSpaz";
		
		protected var ChanceToAct:Number = 0.5;		
		protected var spazType:int;
		
		public function get SpazType():int { return spazType; }
		
		public function Spaz(tile:Tile, type:int, texturePrefix:String = "spaz") 
		{
			super(tile, texturePrefix);
			//super(tile, "spaz");
			spazType = type;
		}
		
		public function Update():void 
		{
		}
		
		protected function TryMove():Boolean 
		{
			var dieRoll:Number = Math.random();
				
			trace("spaz die roll: " + dieRoll);
			
			if (dieRoll > ChanceToAct)
			{
				trace("attempting to move");
				var previousTileID:int = CurrentTile.ID
				
				move(Utilities.GetRandomAdjacentTile(this.CurrentTile));
				
				// if a move was made, return true
				if (CurrentTile.ID != previousTileID) return true;
			}
			
			// if we get this far, no move was made. return false.
			return false;
		}
		
		override protected function move(newTile:Tile):void 
		{
			if (newTile.ID != CurrentTile.ID && !Utilities.IsTileOccupied(newTile, true))
			{
				// if so, set the color of the new tile to match the old tile
				newTile.SetColor(CurrentTile.ColorIndex);
				// and make the move.
				super.move(newTile);
			}
		}
	}

}