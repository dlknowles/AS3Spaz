package 
{
	import starling.events.Event;
    import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Lee
	 */
	public class Game extends Sprite 
	{
        
		public function Game() 
		{
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }
        
        private function onAdded(e:Event):void 
        {
            // Entry point
            
        }
		
	}
	
}