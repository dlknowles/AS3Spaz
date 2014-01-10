package objects 
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
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
			
			movie.addEventListener(TouchEvent.TOUCH, function(e:TouchEvent):void {
				var t:Touch = e.getTouch(DisplayObject(e.target));
				
				if (t) {
					switch(t.phase) {
						case TouchPhase.BEGAN:
							//trace("BEGIN " + e.target + " " + e.currentTarget + " " + t.target);
							CurrentTile.Increment();
							break;
						case TouchPhase.ENDED:
							//trace("END " + e.target + " " + e.currentTarget + " " + t.target);
							break;
						case TouchPhase.HOVER:
							//trace("HOVER " + e.target + " " + e.currentTarget + " " + t.target);                        
							break;
						default:
							//trace("Something else: " + t.phase);
					}
				}
			});
        }
		
		private function buildTexture():void 
		{					
			var playerTexture:Vector.<Texture>;
			
			playerTexture = Root.assets.getTextures("player");
			
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
		
		// TODO: The move isn't working
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