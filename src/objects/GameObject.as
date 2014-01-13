package objects 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class GameObject extends Sprite 
	{
		public var CurrentTile:Tile;	
        protected var movie:MovieClip;
		public var IsActive:Boolean;
		
		public function GameObject(tile:Tile, texturePrefix:String) 
		{
			this.CurrentTile = tile;
			this.IsActive = true;
			buildTexture(texturePrefix);			
		}
		
		protected function buildTexture(texturePrefix:String):void 
		{					
			var playerTexture:Vector.<Texture>;
			
			playerTexture = Root.assets.getTextures(texturePrefix);
			
			movie = new MovieClip(playerTexture, 10);
            movie.loop = true;
            movie.pause();
            movie.currentFrame = 0;			
            addChild(movie);
            
            Starling.juggler.add(movie);
			
			movie.addEventListener(TouchEvent.TOUCH, function(e:TouchEvent):void {
				var t:Touch = e.getTouch(DisplayObject(e.target));
				
				if (t && t.phase == TouchPhase.BEGAN) {
					CurrentTile.Increment();
				}
			});
		}
		
	}

}