package objects 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	import utils.Constants;
	/**
	 * ...
	 * @author Lee
	 */
	public class Player extends Sprite
	{
		public var CurrentTile:Tile;	
        private var movie:MovieClip;
		
		public var CurrentInventory:Inventory;
		public var Score:int;
		public var NumGems:int;
		public var IsMoving:Boolean;
		
		public function Player(tile:Tile, inventory:Inventory = null) 
		{
			if (inventory == null) inventory = new Inventory(0, 0, 0);
			this.CurrentTile = tile;
			this.CurrentInventory = inventory;
			
			init();
		}
		
		
        private function init():void 
        {   
			this.Score = 0;
			this.NumGems = 0;
			this.IsMoving = false;
			
			buildTexture();
        }
		
		private function buildTexture():void 
		{					
			var playerTexture:Vector.<Texture>;
			
			playerTexture = Root.assets.getTextures("gem");
			
			movie = new MovieClip(playerTexture, 10);
            movie.loop = true;
            movie.pause();
            movie.currentFrame = 0;			
            addChild(movie);
            
            Starling.juggler.add(movie);
		}
		
		private function collectTileItems():void 
		{
			// TODO: Implement Player.collectTileItems()
		}
		
		private function move(newTile:Tile):void
		{
			if (this.CurrentTile.ColorIndex == newTile.ColorIndex)
			{
				this.CurrentTile = newTile;
				this.IsMoving = true;
				
				collectTileItems();
			}
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
			if (this.CurrentTile.Column > Constants.NUMCOLUMNS - 1) move(Game.TileArray[this.CurrentTile.ID + 1]);
		}
	}

}