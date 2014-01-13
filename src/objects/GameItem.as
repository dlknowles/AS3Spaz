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
				case int(Constants.ITEMTYPES.DYNAMITE):
					typeStr = "dynamite";
					
					break;
				case int(Constants.ITEMTYPES.CONCRETE):
					typeStr = "concrete";
					
					break;
				case int(Constants.ITEMTYPES.ACIDFLASK):
					typeStr = "acidFlask";
					
					break;
				case int(Constants.ITEMTYPES.GEM):
					typeStr = "gem";
					
					break;
				default:
					//throw new ArgumentError("Invalid item type: "  + type);
			}
			super(tile, typeStr);
			typeString = typeStr;
			this.itemType = type;
		}
		
		public function Deactivate():void 
		{
			visible = false;
			IsActive = false;
		}
		
		public function Reactivate(tile:Tile, type:int):void 
		{
			CurrentTile = tile;
			itemType = type;
			
			buildTexture(typeString);
			
			visible = true;
			IsActive = true;
		}
	}

}