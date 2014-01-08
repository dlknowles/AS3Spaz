package 
{
	import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.events.Event;
	import utils.Constants;
    
    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.formatString;
	
	/**
	 * Entry point for the app
	 * @author Lee
	 */
    [SWF(frameRate="30", backgroundColor="#000000")]
	public class Main extends Sprite 
	{
        // Embed the Ubuntu font. 
        [Embed(source = "/../bin/fonts/Ubuntu-R.ttf", embedAsCFF = "false", fontFamily = "Ubuntu")]
        private static const UbuntuRegular:Class;
        
        // Embed startup image for SD screens
        [Embed(source = "/startup.jpg")]
        private static var Background:Class;
        
        // Embed startup image for HD screens
        [Embed(source = "/startupHD.jpg")]
        private static var BackgroundHD:Class;
        
        // save Starling object
        public static var mStarling:Starling;
        
        
		public function Main():void 
		{
            // set general properties
            var stageWidth:int = Constants.STAGEWIDTH;
            var stageHeight:int = Constants.STAGEHEIGHT;
            var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
            
            // not necessary on iOS. Saves a lot of memory!
            Starling.handleLostContext = !iOS;
			Starling.multitouchEnabled = false;
			            
            // create a suitable viewport for the screen size
            //
            // we develop the game in a "fixed" coordinate system of 480x320; the game
            // might run on a device with a different resolution; for that case, we zoom
            // the viewport to the optimal size for any display and load the optimal textures.
            var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, stageWidth, stageHeight),
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
                ScaleMode.SHOW_ALL);
            
            // create the Asset Manager, which handles all required assets for this resolution
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640
            var appDir:File = File.applicationDirectory;
            trace("appDir: " + appDir.nativePath);
            var assets:AssetManager = new AssetManager(scaleFactor);
            
			assets.verbose = Capabilities.isDebugger;
            assets.enqueue(
                appDir.resolvePath(formatString("fonts/x{0}", scaleFactor)),
                appDir.resolvePath(formatString("textures/x{0}", scaleFactor))
            );
            
            // While Stage3D is initializing, the screen will be blank. To avoid any flickering,
            // we display a startup image now and remove it below when Starling is ready to go.
            var backgroundClass:Class = scaleFactor == 1 ? Background : BackgroundHD;
            var background:Bitmap = new backgroundClass();
            
            Background = BackgroundHD = null;  // these are not needed anymore since we set backgroundClass.
            
            background.x = viewPort.x;
            background.y = viewPort.y;
            background.width = viewPort.width;
            background.height = viewPort.height;
            background.smoothing = true;
            addChild(background);
			
            // launch Starling
            mStarling = new Starling(Root, stage, viewPort);
            mStarling.stage.stageWidth = stageWidth;    // <- same size on all devices
            mStarling.stage.stageHeight = stageHeight;  // <- ditto...
            mStarling.simulateMultitouch = false;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED,
                function(event:Object, app:Root):void 
                {
                    mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
                    removeChild(background);
                    background = null;
                    
                    var bgTexture:Texture = Texture.fromEmbeddedAsset(backgroundClass, false, false, scaleFactor);
                    
                    app.start(bgTexture, assets);
                    mStarling.start();
                });
                
            // when the game becomes inactive, we pause Starling; otherwise, the enter frame event would report
            // a very long 'passedTime' when the app is reactivated.
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, 
                function(e:*):void { mStarling.start(); } );
                
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE,
                function(e:*):void { mStarling.stop(true); } );
		}
		
        
		
	}
	
}