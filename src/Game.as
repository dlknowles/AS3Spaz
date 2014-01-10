package 
{
	import objects.GameItem;
	import objects.Player;
	import objects.Tile;
	import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Quad;
	import starling.events.Event;
    import starling.display.Sprite;
	import starling.events.KeyboardEvent;
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
		//public static var Score:int = 0;
        public static var TileArray:Vector.<Tile>;
		public static var ItemArray:Vector.<GameItem>;
		
		private var gamePlayer:Player;
		private var thisLevel:Level;
		private var scoreText:TextField;
                
		public function Game() 
		{
            init();
        }
        
        private function init():void 
        {			
			thisLevel = new Level(Constants.LEVELS[CurrentLevel]);  
			
            setTiles();
			setPlayer();
			setGameItems();
			drawStatusArea();
						
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);			
        }
		
		private function setTiles():void 
		{
			TileArray = new Vector.<Tile>();
			var mapArray:Array = thisLevel.Map;
			var row:int = 0;
			var col:int = 0;
			var colorIndex:int = 0;
			var maxColors:int;
			var numTiles:int = Constants.NUMCOLUMNS * Constants.NUMROWS;
			
			// make sure the map array is the correct length
			while (mapArray.length < numTiles) mapArray.push(0);			
			while (mapArray.length > numTiles) mapArray.pop();
			
			// now loop through the map array to populate the tiles array for our game board
			for (var i:int = 0, len:int = mapArray.length; i < len; ++i)
			{
				// if the current index's value isn't 1, there's no need to calculate anything...
				if (mapArray[i] == 1)
				{
					colorIndex = Utilities.GetRandomInt(0, thisLevel.MaxColors);
					maxColors = thisLevel.MaxColors;
				}
				else
				{
					colorIndex = 0;
					maxColors = 0;
				}
				
				// push a new Tile into the tile array
				TileArray.push(new Tile(i, col, row, colorIndex, maxColors, mapArray[i]));
				
				// adjust the column and row counts as necessary
				if (++col / Constants.NUMCOLUMNS == 1)
				{
					// if at the last column, go to the first column of the next row.
					++row;
					col = 0;
				}
			}
			
			drawTiles();
		}
		 
		private function drawTiles():void 
		{
			var offsetX:int = (Main.mStarling.stage.stageWidth - (Constants.NUMCOLUMNS * TileArray[0].width));
            var offsetY:int = Constants.PADDING;
			
			for (var i:int = 0, len:int = TileArray.length; i < len; ++i)
			{
				TileArray[i].x = TileArray[i].Column * TileArray[i].width + offsetX;
				TileArray[i].y = TileArray[i].Row * TileArray[i].height + offsetY;
				addChild(TileArray[i]);
			}
		}
		
		private function setPlayer():void 
		{
			var playerTile:Tile = Utilities.GetRandomTile();
			
			// TODO: Set player's inventory from saved game data when available.
			gamePlayer = new Player(playerTile);
			
			drawPlayer();
		}
		
		private function drawPlayer():void 
		{
			gamePlayer.x = gamePlayer.CurrentTile.x;
			gamePlayer.y = gamePlayer.CurrentTile.y;
			
			addChild(gamePlayer);
		}
		
		private function setGameItems():void 
		{			
			ItemArray = new Vector.<GameItem>();
			var i:int = 0;
			
			for (i = 0; i < thisLevel.Dynamite; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEMTYPES.DYNAMITE));
			}
			
			for (i = 0; i < thisLevel.Concrete; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEMTYPES.CONCRETE));			
			}
			
			for (i = 0; i < thisLevel.AcidFlasks; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEMTYPES.ACIDFLASK));			
			}
			
			drawGameItems();
		}
		
		private function addGameItem(tile:Tile, type:int):void 
		{
			ItemArray.push(new GameItem(tile, type));	
		}
		
		private function drawGameItems():void 
		{
			for (var i:int = 0; i < ItemArray.length; ++i)
			{
				ItemArray[i].x = ItemArray[i].CurrentTile.x;
				ItemArray[i].y = ItemArray[i].CurrentTile.y;
				addChild(ItemArray[i]);
			}
		}
		
		private function drawStatusArea():void 
		{
			var statusWidth:int = Constants.STAGEWIDTH - (Constants.NUMCOLUMNS * TileArray[0].width);
			var q:Quad = new Quad(statusWidth, Constants.STAGEHEIGHT, 0x333333);
			q.alpha = 0.5;
			q.x = 0;
			q.y = 0;
            addChild(q);
            
			scoreText = new TextField(q.width, 64, "Score: " + gamePlayer.Score, Constants.NORMALFONT, 12, 0xffffff, true);
			scoreText.x = Constants.PADDING;
			scoreText.y = Constants.PADDING;
            scoreText.vAlign = VAlign.TOP;
            scoreText.hAlign = HAlign.LEFT;
            addChild(scoreText);
		}
		
		private function updateScore():void 
		{
			scoreText.text = "Score: " + gamePlayer.Score;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var key:int = e.keyCode;
			
			if (key == Constants.KEYS.W || key == Constants.KEYS.UP)
			{
				if (!gamePlayer.IsMoving) gamePlayer.MoveUp();
			}
			
			if (key == Constants.KEYS.A || key == Constants.KEYS.LEFT)
			{
				if(!gamePlayer.IsMoving) gamePlayer.MoveLeft();				
			}
			
			if (key == Constants.KEYS.S || key == Constants.KEYS.DOWN) 
			{
				if(!gamePlayer.IsMoving) gamePlayer.MoveDown();
			}
			
			if (key == Constants.KEYS.D || key == Constants.KEYS.RIGHT) 
			{
				if(!gamePlayer.IsMoving) gamePlayer.MoveRight();
			}
			
			updateScore();
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			gamePlayer.IsMoving = false;
		}
	}
	
}