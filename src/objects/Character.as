package objects 
{
	import starling.display.Sprite;
	import utils.Constants;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class Character extends GameObject 
	{
		
		
		public function Character(tile:Tile, texturePrefix:String) 
		{
			super(tile, texturePrefix);
		}
		
		protected function move(newTile:Tile):void
		{
			//if (this.CurrentTile.ColorIndex == newTile.ColorIndex)
			//{
				this.CurrentTile = newTile;
				//this.IsMoving = true;
								
				this.x = CurrentTile.x;
				this.y = CurrentTile.y;
			//}
		}
              
		public function MoveUp():void 
		{
			if (this.CurrentTile.Row > 0) move(Game.TileArray[this.CurrentTile.ID - Constants.NUMCOLUMNS]);
		} 
		
		public function MoveDown():void 
		{
			if (this.CurrentTile.Row < Constants.NUMROWS - 1) move(Game.TileArray[this.CurrentTile.ID + Constants.NUMCOLUMNS]);
		}
		
		public function MoveLeft():void 
		{
			if (this.CurrentTile.Column > 0) move(Game.TileArray[this.CurrentTile.ID - 1]);
		}
		 
		public function MoveRight():void 
		{
			if (this.CurrentTile.Column < Constants.NUMCOLUMNS - 1) move(Game.TileArray[this.CurrentTile.ID + 1]);
		}
	}

}