package 
{
	import objects.Tile;
	import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Quad;
	import starling.events.Event;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.utils.HAlign;
    import starling.utils.VAlign;
	import utils.Constants;
	import utils.Utilities;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class Game extends Sprite 
	{
        public static const GAME_OVER:String = "gameOver";
		public static var CurrentLevel:int = 0;
		public static var NumLives:int = 5;
        
        private var tileArray:Array;
		private var thisLevel:Level;
                
		public function Game() 
		{
            init();
        }
        
        private function init():void 
        {
            // Entry point    
            var q:Quad = new Quad(Main.mStarling.stage.stageWidth, 32, 0x333333);
            addChild(q);
            
            var tField:TextField = new TextField(Main.mStarling.stage.stageWidth - 16, 32, "Score: 00000", "Ubuntu", 16, 0xffffff, true);
            tField.vAlign = VAlign.CENTER;
            tField.hAlign = HAlign.RIGHT;
            addChild(tField);
			
			thisLevel = new Level(Constants.LEVELS[CurrentLevel]);  
            setTiles();
            drawTiles();
        }
		
		private function setTiles():void 
		{
			tileArray = new Array();
			var mapArray:Array = thisLevel.Map;
			var row:int = 0;
			var col:int = 0;
			var colorIndex:int = 0;
			
			for (var i:int = 0, len:int = thisLevel.Map.length; i < len; ++i)
			{
				colorIndex = Utilities.GetRandomInt(0, thisLevel.MaxColors);
				tileArray.push(new Tile(i, col, row, colorIndex, thisLevel.MaxColors, mapArray[i]));
				
				if (++col / Constants.NUMCOLUMNS == 1)
				{
					++row;
					col = 0;
				}
			}
		}
		 
		private function drawTiles():void 
		{
			var offsetX:int = (Main.mStarling.stage.stageWidth - (Constants.NUMCOLUMNS * tileArray[0].width));
            var offsetY:int = 16;
			
			for (var i:int = 0, len:int = tileArray.length; i < len; ++i)
			{
				tileArray[i].x = tileArray[i].Column * tileArray[i].width + offsetX;
				tileArray[i].y = tileArray[i].Row * tileArray[i].height + offsetY;
				addChild(tileArray[i]);
			}
		}
	}
	
}