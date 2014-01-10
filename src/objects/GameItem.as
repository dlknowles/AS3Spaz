package objects 
{
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.events.TouchEvent;
    import starling.events.Touch;
    import starling.events.TouchPhase;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.core.Starling;
	
	import utils.Constants;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class GameItem extends Sprite
	{
		private var itemType:int;
        private var movie:MovieClip;
		
		public var CurrentTile:Tile;
		public var IsActive:Boolean;
		
		public function get ItemType():int { return itemType; }
		
		
		public function GameItem(tile:Tile, type:int) 
		{
			this.CurrentTile = tile;
			this.IsActive = true;
			this.itemType = type;
			
			init();
		}
		
		private function init():void 
		{
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
			var itemTexture:Vector.<Texture>;
			
			switch (itemType) 
			{
				case int(Constants.ITEMTYPES.DYNAMITE):
					itemTexture = Root.assets.getTextures("dynamite");
					
					break;
				case int(Constants.ITEMTYPES.CONCRETE):
					itemTexture = Root.assets.getTextures("concrete");
					
					break;
				case int(Constants.ITEMTYPES.ACIDFLASK):
					itemTexture = Root.assets.getTextures("acidFlask");
					
					break;
				case int(Constants.ITEMTYPES.GEM):
					itemTexture = Root.assets.getTextures("gem");
					
					break;
				default:
					trace("Invalid item type in GameItem.buildTexture(): " + itemType)
			}
			
			
			movie = new MovieClip(itemTexture, 10);
            movie.loop = true;
            movie.pause();
            movie.currentFrame = 0;			
            addChild(movie);
            
            Starling.juggler.add(movie);
		}
		
		public function Deactivate():void 
		{
			//stage.removeChild(this);
			this.visible = false;
			this.IsActive = false;
		}
		
		public function Reactivate(tile:Tile, type:int):void 
		{
			this.CurrentTile = tile;
			this.itemType = type;
			
			buildTexture();
			
			this.visible = true;
			this.IsActive = true;
		}
	}

}