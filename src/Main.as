package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
    import starling.core.Starling;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class Main extends Sprite 
	{
        private var mStarling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
            startup();
			
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
        private function startup():void 
        {
             // These settings are recommended to avoid problems with touch handling
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            // Create a Starling instance that will run the "Game" class
            mStarling = new Starling(Game, stage);
            
            // show the stats window (draw calls, memory)
            mStarling.showStats = true;
            
            // set antialiasing (higher the better quality but slower performance)
            mStarling.antiAliasing = 2;
            
            // start the code in the Game class...
            mStarling.start();
        }
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
            
            // kills Starling
            mStarling.dispose();
		}
		
	}
	
}