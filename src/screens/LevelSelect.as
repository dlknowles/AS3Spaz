package screens 
{
	import starling.display.Button;
	import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import utils.Constants;
	
	/**
     * ...
     * @author Lee
     */
    public class LevelSelect extends Sprite 
    {
        public static const SELECT_LEVEL:String = "selectLevel";
		        
        public function LevelSelect() 
        {
            init();
        }
        
        private function init():void 
        {
            var textField:TextField = new TextField(250, 50, "Select a Level",
                "Verdana", Constants.TITLEFONTSIZE, 0x000000);
            textField.x = (Constants.STAGEWIDTH - textField.width) / 2;
            textField.y = 50;
            addChild(textField);
			
			var livesTextField:TextField = new TextField(Constants.STAGEWIDTH / 2, 64, "Lives: " + Game.NumLives, Constants.NORMALFONT);
			livesTextField.x = 16;
			livesTextField.y = 16;
			livesTextField.vAlign = VAlign.TOP;
			livesTextField.hAlign = HAlign.LEFT;
			addChild(livesTextField);
            
			drawLevelButtons();
        }
		
		private function drawLevelButtons():void 
		{
			// TODO: Limit the levels to those the user has completed and the one he is has to finish to continue.
			// TODO: Make the level selection prettier.
			var numLevels:int = Constants.LEVELS.length;
			var x:Number = 0;
			var y:Number = Constants.STAGEHEIGHT * 0.25;
			
			for (var i:int; i < numLevels; ++i)
			{
				if (i % 5 == 0) 
				{
					y += 32;
					x = 32;
				}
				else
				{
					x += 32;
				}
				drawLevelButton(x, y, i);
			}
		}
		
		private function drawLevelButton(x:Number, y:Number, level:int):void 
		{
			var text:String = int(level + 1).toString(10);
			var button:Button = new Button(Root.assets.getTexture("button_normal"), text);
			button.width = 32;
            button.fontName = "Ubuntu";
            button.fontSize = 16;
            button.x = x;
            button.y = y;
            button.addEventListener(Event.TRIGGERED, function():void {
				 dispatchEventWith(SELECT_LEVEL, true, level);
			});
            addChild(button);
		}
    }
}