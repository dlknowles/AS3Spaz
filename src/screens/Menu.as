package screens
{
    import starling.display.Button;
	import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
	import starling.utils.VAlign;
	import utils.Constants;
	
	/**
     * ...
     * @author Lee
     */
    public class Menu extends Sprite 
    {
        public static const START_GAME:String = "startGame";
        
        public function Menu() 
        {
            init();
        }
        
        private function init():void 
        {
            var textField:TextField = new TextField(Constants.STAGEWIDTH - 32, 250, "GettingStarted",
                "Verdana", Constants.TITLEFONTSIZE, 0x000000);
			textField.vAlign = VAlign.TOP
            textField.x = (Constants.STAGEWIDTH - textField.width) / 2;
            textField.y = 50;
            addChild(textField);
            
            var button:Button = new Button(Root.assets.getTexture("button_normal"), "Start");
            button.fontName = "Ubuntu";
            button.fontSize = 16;
            button.x = int((Constants.STAGEWIDTH - button.width) / 2);
            button.y = Constants.STAGEHEIGHT * 0.75;
            button.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(button);
			
			var jsonStr:String = '{"map":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"maxTurns":25,"maxColors":3}';
			var level:Level = new Level(jsonStr);
			
			
        }
        
        private function onButtonTriggered():void 
        {
            dispatchEventWith(START_GAME, true, "classic");
        }
    }

}