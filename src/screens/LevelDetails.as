package screens 
{
	import starling.display.Button;
	import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
	import utils.Constants;
	
	/**
     * A screen that shows the details for the selected level.
	 * It will contain the level number, items available, high scores, 
	 * a button to start the level and a button to go back to the
	 * level selector.
     * @author Lee
     */
    public class LevelDetails extends Sprite 
    {
        public static const START_LEVEL:String = "startLevel";
		public static var Level:int = 0;
		        
        public function LevelDetails() 
        {
            init();
        }
        
        private function init():void 
        {
            var textField:TextField = new TextField(250, 50, "Level " + int(Game.CurrentLevel + 1).toString(10),
                "Verdana", Constants.TITLEFONTSIZE, 0x0);
            textField.x = (Constants.STAGEWIDTH - textField.width) / 2;
            textField.y = 50;
            addChild(textField);
            
			drawUI();
        }
		
		private function drawUI():void 
		{
			// Close/Cancel button -- goes back to level selection
			var cancelButton:Button = new Button(Root.assets.getTexture("button_normal"), " X ");
			cancelButton.width = 32;
			cancelButton.height = 32;
			cancelButton.fontName = Constants.NORMALFONT;
			cancelButton.x = Constants.STAGEWIDTH - cancelButton.width - 16;
			cancelButton.y = 16;
			cancelButton.addEventListener(Event.TRIGGERED, function():void {
				dispatchEventWith(Menu.START_GAME, true, "classic");
			});
			addChild(cancelButton);
			
			// Play button -- starts the level
			var playButton:Button = new Button(Root.assets.getTexture("button_normal"), "Play!");
			playButton.fontName = Constants.NORMALFONT;
			playButton.x = Constants.STAGEWIDTH / 2 - playButton.width / 2;
			playButton.y = Constants.STAGEHEIGHT / 2;
			playButton.addEventListener(Event.TRIGGERED, function():void {
				dispatchEventWith(START_LEVEL, true);
			});
			addChild(playButton);
		}
		
		private function drawLevelButton(x:Number, y:Number, text:String, eventHandler:Function):void 
		{
			var text:String = int(Game.CurrentLevel + 1).toString(10);
			var button:Button = new Button(Root.assets.getTexture("button_normal"), text);
			button.width = 32;
            button.fontName = "Ubuntu";
            button.fontSize = 16;
            button.x = x;
            button.y = y;
            button.addEventListener(Event.TRIGGERED, function():void {
				 dispatchEventWith(START_LEVEL, true, Game.CurrentLevel);
			});
            addChild(button);
		}
    }
}