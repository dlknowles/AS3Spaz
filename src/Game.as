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
	
	/**
	 * ...
	 * @author Lee
	 */
	public class Game extends Sprite 
	{
        public static const GAME_OVER:String = "gameOver";
        
        private var tileArray:Array;
        private var scale:int = 1;
                
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
            
            setTiles();
            drawTiles();
        }
        
        private function setTiles():void 
        {
            tileArray = new Array();
            
            var row:Array;
            for (var y:int = 0; y < Constants.NUMROWS; ++y) {
                row = new Array();
                
                for (var x:int = 0; x < Constants.NUMCOLUMNS; ++x) {
                    row[x] = new Tile(Math.random() * Constants.NUMCOLORS, scale, scale);
                }
                
                tileArray[y] = row;
            }
            
            trace(tileArray);
        }
        
        private function drawTiles():void 
        {
            var offsetX:int = (Main.mStarling.stage.stageWidth - (Constants.NUMCOLUMNS * 32)) / 2;
            var offsetY:int = 64;
            
            for (var y:int = 0; y < Constants.NUMROWS; ++y) {
                for (var x:int = 0; x < Constants.NUMCOLUMNS; ++x) {
                    tileArray[y][x].x = ((32 * scale) * x) + offsetX;
                    tileArray[y][x].y = ((32 * scale) * y) + offsetY;
                    addChild(tileArray[y][x]);
                }
            }
        }       
        
	}
	
}