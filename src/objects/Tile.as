package objects 
{
	import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.core.Starling;
	import utils.Constants;
    
	/**
     * ...
     * @author Lee
     */
    public class Tile extends Sprite
    {                
        private var movie:MovieClip;
                
        // The current tile frame index (indicates what color is displayed.
        // NOTE: Tiles are listed in ABC order... (See spritesheet.xml for tile names)
        private var colorIndex:int;   
		private var id:int;
		private var column:int;
		private var row:int;
		private var mapValue:int;
		private var maxColors:int;
		
		public function get ColorIndex():int { return this.colorIndex; }
		public function get ID():int { return this.id; }
		public function get Column():int { return this.column; }
		public function get Row():int { return this.row; }
		public function get MapValue():int { return this.mapValue; }
		public function get MaxColors():int { return this.maxColors; }
		
		public function Tile(id:int, col:int, row:int, colorIndex:int, maxColors:int, mapValue:int)
		{
			this.id = id;
			this.column = col;
			this.row = row;
			this.colorIndex = colorIndex;
			this.mapValue = mapValue;
			this.maxColors = maxColors;
			
			init();
		}
		
        private function init():void 
        {   
			if (maxColors > Constants.NUMCOLORS) maxColors = Constants.NUMCOLORS;
			if (colorIndex >= maxColors) colorIndex = 0;
			
			buildTileTexture();
        }
		
		private function buildTileTexture():void 
		{					
			var tileTextures:Vector.<Texture>;
			
			if (this.mapValue == 1) {
				tileTextures = Root.assets.getTextures("tile");
			}
			else {
				tileTextures = new Vector.<Texture>();
				tileTextures.push(Root.assets.getTexture("blank"));
			}
			
			movie = new MovieClip(tileTextures, 10);
            movie.loop = true;
            movie.pause();
            movie.currentFrame = this.mapValue == 1 ? colorIndex : 0;
            movie.addEventListener(TouchEvent.TOUCH, onTouch);
            addChild(movie);
            
            Starling.juggler.add(movie);
		}
                
        private function onTouch(e:TouchEvent):void 
        {
			// No interaction allowed unless the map value is set to 1.
			if (this.mapValue == 1)
			{
				var t:Touch = e.getTouch(DisplayObject(e.target));
				
				if (t) {
					switch(t.phase) {
						case TouchPhase.BEGAN:
							//trace("BEGIN " + e.target + " " + e.currentTarget + " " + t.target);
							Increment();
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
			}
        }
		        
        public function Increment():void 
        {
            colorIndex = movie.currentFrame;
            
            if (++colorIndex == maxColors) {
                colorIndex = 0;
            }
            
            movie.currentFrame = colorIndex;
			
			dispatchEventWith(Game.TURN_TAKEN, true);
        }   
   
    }
    
}