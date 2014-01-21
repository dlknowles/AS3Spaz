package 
{
	import objects.BlockerSpaz;
	import objects.ChangerSpaz;
	import objects.GameItem;
	import objects.Player;
	import objects.Spaz;
	import utils.SpazFactory;
	import objects.Tile;
	import starling.core.Starling;
	import starling.display.Button;
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
		public static const TURN_TAKEN:String = "turnTaken";
		public static const GEM_COLLECTED:String = "gemCollected";
		public static const LEVEL_COMPLETE:String = "levelComplete";
		
		public static var CurrentLevel:int = 0;
		public static var NumLives:int = 5;
		//public static var Score:int = 0;
        public static var TileArray:Vector.<Tile>;
		public static var ItemArray:Vector.<GameItem>;
		public static var SpazArray:Vector.<Spaz>;
		public static var ObstacleArray:Vector.<GameItem>;
		public static var GamePlayer:Player;
		
		private var thisLevel:Level;
		private var scoreText:TextField;
		private var turnText:TextField;
		private var gemText:TextField;
		private var dynamiteButton:Button;
		private var concreteButton:Button;
		private var acidButton:Button;
		private static var numTurns:int;
                
		public function Game() 
		{
            init();
        }
        
        private function init():void 
        {			
			thisLevel = new Level(Constants.LEVELS[CurrentLevel]);  
			
			numTurns = thisLevel.MaxTurns;
			
            setTiles();
			setPlayer();
			setGameItems();
			setSpazArray();
			drawStatusArea();
						
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);			
			addEventListener(Game.TURN_TAKEN, onTurnTaken);
			addEventListener(Game.GEM_COLLECTED, onGemCollected);
			addEventListener(Spaz.SPLIT_SPAZ, onSpazSplit);
			addEventListener(Spaz.OBSTACLE_ADDED, onObstacleAdded);
			
			printGems();
        }
		
		private function printGems():void 
		{
			var gemStr:String = "gems on tiles: ";
			for (var i:int; i < ItemArray.length; ++i)
			{
				if (ItemArray[i].ItemType == int(Constants.ITEM_TYPES.GEM))
				{
					gemStr += ItemArray[i].CurrentTile.ID + " (active: " + ItemArray[i].IsActive + ", visible: " + ItemArray[i].visible + "), ";
				}
			}			
			trace(gemStr);
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
			GamePlayer = new Player(playerTile);
			
			drawPlayer();
		}
		
		private function drawPlayer():void 
		{
			GamePlayer.x = GamePlayer.CurrentTile.x;
			GamePlayer.y = GamePlayer.CurrentTile.y;
			
			addChild(GamePlayer);
		}
		
		private function setGameItems():void 
		{			
			ObstacleArray = new Vector.<GameItem>();
			ItemArray = new Vector.<GameItem>();
			var i:int = 0;
			
			for (i = 0; i < thisLevel.Dynamite; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEM_TYPES.DYNAMITE));
			}
			
			for (i = 0; i < thisLevel.Concrete; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEM_TYPES.CONCRETE));			
			}
			
			for (i = 0; i < thisLevel.AcidFlasks; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEM_TYPES.ACIDFLASK));			
			}
			
			for (i = 0; i < thisLevel.MaxGems; ++i)
			{
				addGameItem(Utilities.GetRandomTile(), int(Constants.ITEM_TYPES.GEM));
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
		
		public function AddSpaz(newSpaz:Spaz):void
		{
			SpazArray.push(newSpaz);
			newSpaz.x = newSpaz.CurrentTile.x;
			newSpaz.y = newSpaz.CurrentTile.y;
			addChild(newSpaz);
		}
		
		public function AddObstacle(newObstacle:GameItem):void
		{
			ObstacleArray.push(newObstacle);
			newObstacle.x = newObstacle.CurrentTile.x;
			newObstacle.y = newObstacle.CurrentTile.y;
			addChild(newObstacle);
		}
		
		private function setSpazArray():void 
		{
			SpazArray = new Vector.<Spaz>();
			
			for (var i:int = 0, len:int = thisLevel.SpazArray.length; i < len; ++i)
			{
				AddSpaz(SpazFactory.GetSpaz(int(thisLevel.SpazArray[i])));
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
            
			scoreText = new TextField(q.width, 40, "Score: " + GamePlayer.Score, Constants.NORMALFONT, Constants.NORMALFONTSIZE, 0xffffff, true);
			scoreText.x = Constants.PADDING;
			scoreText.y = Constants.PADDING;
            scoreText.vAlign = VAlign.TOP;
            scoreText.hAlign = HAlign.LEFT;
            addChild(scoreText);
			
			drawItemButtons();
			
			gemText = new TextField(q.width, 40, "Gems Collected: " + GamePlayer.NumGems + " of " + thisLevel.MaxGems, Constants.NORMALFONT, Constants.NORMALFONTSIZE, 0xffffff);
			gemText.x = Constants.PADDING;
			gemText.y = Constants.STAGEHEIGHT - Constants.PADDING - 40;
			gemText.vAlign = VAlign.TOP;
			gemText.hAlign = HAlign.LEFT;
			addChild(gemText);
			
			turnText = new TextField(q.width, 40, "Turns: " + numTurns, Constants.NORMALFONT, Constants.NORMALFONTSIZE, 0xffffff, true);
			turnText.x = Constants.PADDING;
			turnText.y = gemText.y - 40;
            turnText.vAlign = VAlign.TOP;
            turnText.hAlign = HAlign.LEFT;
            addChild(turnText);
		}
		
		private function drawItemButtons():void 
		{
			dynamiteButton = new Button(Root.assets.getTexture("button_normal"));
			concreteButton = new Button(Root.assets.getTexture("button_normal"));
			acidButton = new Button(Root.assets.getTexture("button_normal"));
			
			dynamiteButton.x = Constants.PADDING;
			dynamiteButton.y = Constants.PADDING + scoreText.height;
			dynamiteButton.width = Constants.ITEMBUTTONWIDTH;			
			
			addChild(dynamiteButton);
			
			concreteButton.x = dynamiteButton.x + dynamiteButton.width;
			concreteButton.y = Constants.PADDING + scoreText.height;
			concreteButton.width = Constants.ITEMBUTTONWIDTH;
			
			addChild(concreteButton);
			
			acidButton.x = concreteButton.x + concreteButton.width;
			acidButton.y = concreteButton.y;
			acidButton.width = Constants.ITEMBUTTONWIDTH;
			
			addChild(acidButton);
			
			setItemButtonText();
		}
		
		private function setItemButtonText():void 
		{
			dynamiteButton.text = "D: " + GamePlayer.CurrentInventory.dynamite;
			concreteButton.text = "C: " + GamePlayer.CurrentInventory.concrete;
			acidButton.text = "A: " + GamePlayer.CurrentInventory.acidFlask;
		}
		
		private function updateScore():void 
		{
			scoreText.text = "Score: " + GamePlayer.Score;
		}
		
		private function updateTurns():void 
		{
			turnText.text = "Turns: " + numTurns;
		}
		
		private function updateGems():void 
		{
			gemText.text = "Gems Collected: " + GamePlayer.NumGems + " of " + thisLevel.MaxGems;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var key:int = e.keyCode;
			
			if (key == Constants.KEYS.W || key == Constants.KEYS.UP)
			{
				if (!GamePlayer.IsMoving) GamePlayer.MoveUp();
			}
			
			if (key == Constants.KEYS.A || key == Constants.KEYS.LEFT)
			{
				if(!GamePlayer.IsMoving) GamePlayer.MoveLeft();				
			}
			
			if (key == Constants.KEYS.S || key == Constants.KEYS.DOWN) 
			{
				if(!GamePlayer.IsMoving) GamePlayer.MoveDown();
			}
			
			if (key == Constants.KEYS.D || key == Constants.KEYS.RIGHT) 
			{
				if(!GamePlayer.IsMoving) GamePlayer.MoveRight();
			}
			
			updateScore();
			updateGems();
			setItemButtonText();
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			GamePlayer.IsMoving = false;
		}
		
		private function onTurnTaken(e:Event):void 
		{
			trace("entering onTurnTaken()");
			// if all turns have been taken, trigger game over
			if (--numTurns == 0) 
			{
			    removeEventListeners();
				dispatchEventWith(Game.GAME_OVER, true, GamePlayer.Score);
			}
			else // otherwise, decrement the turns and let the spazes do their updates
			{
				trace("updating turns...");
				updateTurns();
				
				for (var i:int = 0, len:int = SpazArray.length; i < len; ++i)
				{
					SpazArray[i].Update();
				}
			}
		}
		
		private function onGemCollected(e:Event):void 
		{
			if (GamePlayer.NumGems == thisLevel.MaxGems) 
			{
			    removeEventListeners();
				dispatchEventWith(Game.LEVEL_COMPLETE, true, GamePlayer.Score);
			}
			else updateScore();
			
			printGems();
		}
		
		private function onSpazSplit(e:Event, newSpaz:Spaz):void 
		{
			AddSpaz(newSpaz);
		}
		
		private function onObstacleAdded(e:Event, newObstacle:GameItem):void 
		{
			AddObstacle(newObstacle);
		}
	}
	
}