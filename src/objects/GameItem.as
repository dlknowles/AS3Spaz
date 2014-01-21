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
	public class GameItem extends GameObject
	{
		private var itemType:int;	
		private var typeString:String;
		
		public function get ItemType():int { return itemType; }
		
		public function GameItem(tile:Tile, type:int) 
		{			
			var typeStr:String;
			switch (type) 
			{
				case int(Constants.ITEM_TYPES.DYNAMITE):
					typeStr = "dynamite";
					
					break;
				case int(Constants.ITEM_TYPES.CONCRETE):
					typeStr = "concrete";
					
					break;
				case int(Constants.ITEM_TYPES.ACIDFLASK):
					typeStr = "acidFlask";
					
					break;
				case int(Constants.ITEM_TYPES.GEM):
					typeStr = "gem";
					
					break;
				case int(Constants.ITEM_TYPES.WALL):
					typeStr = "wall";
					
					break;
				case int(Constants.ITEM_TYPES.CRATER):
					typeStr = "crater";
					
					break;
				case int(Constants.ITEM_TYPES.BLOB):
					typeStr = "blob";
					
					break;
				default:
					//throw new ArgumentError("Invalid item type: "  + type);
			}
			super(tile, typeStr);
			typeString = typeStr;
			this.itemType = type;
		}
				
		public function ReactivateAs(tile:Tile, type:int):void 
		{
			super.Reactivate(tile);
			
			itemType = type;			
			buildTexture(typeString);
		}
	}

}