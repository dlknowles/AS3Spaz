package  
{
    import flash.system.System;
	import screens.LevelDetails;
	import screens.LevelSelect;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
	import utils.Constants;
    import utils.ProgressBar;
	import screens.Menu;
	
	/**
     * ...
     * @author Lee
     */
    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
        private var mActiveScene:Sprite;
        
        public function Root() 
        {
            addEventListener(Menu.START_GAME, onStartGame);
            addEventListener(Game.GAME_OVER, onGameOver);
			addEventListener(LevelSelect.SELECT_LEVEL, onSelectLevel);
			addEventListener(LevelDetails.START_LEVEL, onStartLevel);
			addEventListener(Game.LEVEL_COMPLETE, onLevelComplete);
        }
        
        public function start(background:Texture, assets:AssetManager):void 
        {
            // the asset manager is saved as a static variable. this allows us to easily access
            // all the assets from everywhere by simply calling "Root.assets"
            sAssets = assets;
            
            // the background is passed into this method for 2 reasons:
            //
            // 1. We need it right away, otherwise we have an empty frame.
            // 2. The Startup class can decide on the right image, depending on the device.
            addChild(new Image(background));
            
            // The asset manager contains all the raw asset data, but has not created the textures
            // yet. This takes some time (the assets might be loaded from disk or even via the
            // network), during which we display a progress indicator.
            var progressBar:ProgressBar = new ProgressBar(175, 20);
            progressBar.x = (background.width - progressBar.width) / 2;
            progressBar.y = (background.height - progressBar.height) / 2;
            //progressBar.y = background.height * 0.85;
            addChild(progressBar);
            
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                progressBar.ratio = ratio;
                
                // a progress bar should always show the 100% for a while,
                // so we show the main menu only after a short delay.
                
                if (ratio == 1) 
                    Starling.juggler.delayCall(function():void
                    {
                        progressBar.removeFromParent(true);
                        showScene(Menu);
                        
                        // now would be a good time for a clean up
                        System.pauseForGCIfCollectionImminent(0);
                        System.gc();
                    }, .15);
            });
        }
        
        private function onGameOver(e:Event, score:int):void 
        {
			// TODO: Add a Game Over screen and show that instead of the Level Selection screen.
            trace("Game Over! Score: " + score);
			--Game.NumLives;
            switch (Constants.MODE) 
			{
				case "development":
					showScene(LevelSelect);
					break;
				default:
					dispatchEventWith(LevelSelect.SELECT_LEVEL, true, Game.CurrentLevel)
			}
        }
		
		private function onLevelComplete(e:Event, score:int):void 
		{
			// TODO: Add a Game Over screen and show that instead of the Level Selection screen.
            trace("You completed Level " + int(Game.CurrentLevel + 1).toString(10) + " with a score of " + score + "!");
            //showScene(LevelSelect);
			
			switch (Constants.MODE) 
			{
				case "development":
					showScene(LevelSelect);
					break;
				default:
					dispatchEventWith(LevelSelect.SELECT_LEVEL, true, ++Game.CurrentLevel)
			}
		}
        
        private function onStartGame(e:Event, mode:String):void 
        {
            trace("Game Starts! Going to level selector... GameMode: " + mode);
			Game.CurrentLevel = 0;
            switch (Constants.MODE) 
			{
				case "development":
					showScene(LevelSelect);
					break;
				default:
					showScene(LevelDetails);
			}            
        }
        
		private function onSelectLevel(e:Event, level:int):void 
		{
			trace("Selected Level: " + int(level + 1).toString(10));
			Game.CurrentLevel = level;
			showScene(LevelDetails);
		}
		
		private function onStartLevel(e:Event):void 
		{
			trace("Starting Level " + int(Game.CurrentLevel + 1).toString(10));
			showScene(Game);
		}
		
		
		
		
        private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
        
        public static function get assets():AssetManager { return sAssets; }
    }

}