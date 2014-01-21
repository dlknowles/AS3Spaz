package objects 
{
	import starling.core.Starling;
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
	public class Player extends Character
	{
		
		public var CurrentInventory:Inventory;
		public var Score:int;
		public var NumGems:int;
		public var IsMoving:Boolean;
		
		public function Player(tile:Tile, inventory:Inventory = null) 
		{
			super(tile, "player");
			
			if (inventory == null) inventory = new Inventory(0, 0, 0);
			
			this.CurrentInventory = inventory;			
			init();
		}
		
		
        private function init():void 
        {   
			this.Score = 0;
			this.NumGems = 0;
			this.IsMoving = false;
			
			super.buildTexture("player");
			
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
							case int(Constants.ITEM_TYPES.DYNAMITE):
								++this.CurrentInventory.dynamite;
								this.Score += Constants.BASEITEMPOINTS;
								item.Deactivate();
								
								break;
								
							case int(Constants.ITEM_TYPES.CONCRETE):
								++this.CurrentInventory.concrete;
								this.Score += Constants.BASEITEMPOINTS;
								item.Deactivate();
								
								break;
								
							case int(Constants.ITEM_TYPES.ACIDFLASK):
								++this.CurrentInventory.acidFlask;
								this.Score += Constants.BASEITEMPOINTS;
								item.Deactivate();
								
								break;
								
							case int(Constants.ITEM_TYPES.GEM):
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
						
						/*
						trace("Player inventory is now: ");
						trace(" dynamite: " + CurrentInventory.dynamite);
						trace(" concrete: " + CurrentInventory.concrete);
						trace(" acidFlask: " + CurrentInventory.acidFlask);
						*/
					}
					
					break;
				}
			}
		}
		
		override protected function move(newTile:Tile):void 
		{
			
			if (CurrentTile.ColorIndex == newTile.ColorIndex)
			{
				super.move(newTile);
				
				IsMoving = true;
				collectTileItems();
			}
		}
		
	}

}