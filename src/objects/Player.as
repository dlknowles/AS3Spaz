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
				
				if (t && t.phase == TouchPhase.BEGAN) {
					CurrentTile.Increment();
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
			// TODO: Add Gems as a collectible item
			var item:GameItem;
			
			for (var i:int = 0, len:int = Game.ItemArray.length; i < len; ++i)
			{
				item = Game.ItemArray[i];
				
				if (item.CurrentTile.ID == this.CurrentTile.ID)
				{
					if (item.IsActive)
					{
						switch (item.ItemType) 
						{
							case int(Constants.ITEMTYPES.DYNAMITE):
								++this.CurrentInventory.dynamite;
								this.Score += Constants.BASEITEMPOINTS;
								item.Deactivate();
								
								break;
								
							case int(Constants.ITEMTYPES.CONCRETE):
								++this.CurrentInventory.concrete;
								this.Score += Constants.BASEITEMPOINTS;
								item.Deactivate();
								
								break;
								
							case int(Constants.ITEMTYPES.ACIDFLASK):
								++this.CurrentInventory.acidFlask;
								this.Score += Constants.BASEITEMPOINTS;
								item.Deactivate();
								
								break;
								
							case int(Constants.ITEMTYPES.GEM):
								++this.NumGems;
								this.Score += Constants.GEMPOINTS;
								item.Deactivate();
								trace("Gem collected. You now have " + NumGems + ".");
								dispatchEventWith(Game.GEM_COLLECTED, true);
								
								break;
								
							default:
								// do nothing for now.
								trace("Attempting to collect an invalid item type: " + item.ItemType);
						}
						
						trace("Player inventory is now: ");
						trace(" dynamite: " + CurrentInventory.dynamite);
						trace(" concrete: " + CurrentInventory.concrete);
						trace(" acidFlask: " + CurrentInventory.acidFlask);
					}
					
					break;
				}
			}
		}
		
		private function move(newTile:Tile):void
		{
			if (this.CurrentTile.ColorIndex == newTile.ColorIndex)
			{
				this.CurrentTile = newTile;
				this.IsMoving = true;
				
				collectTileItems();
				
				this.x = CurrentTile.x;
				this.y = CurrentTile.y;
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
			if (this.CurrentTile.Column < Constants.NUMCOLUMNS - 1) move(Game.TileArray[this.CurrentTile.ID + 1]);
		}
	}

}