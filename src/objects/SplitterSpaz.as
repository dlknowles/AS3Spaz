package objects 
{
	import utils.Constants;
	/**
	 * ...
	 * @author Lee
	 */
	public class SplitterSpaz extends Spaz 
	{
		
		protected var maxSize:int = 10;
		protected var currentSize:int = 1;
		
		public function SplitterSpaz(tile:Tile) 
		{
			super(tile, Constants.SPAZ_TYPES.SPLITTER, "splitter");			
		}
		
		override public function Update():void 
		{
			super.Update();
			
			var previousTile:Tile = CurrentTile;
			
			if (TryMove())
			{
				// if moves, grow in size.
				if (++currentSize > maxSize)
				{
					trace("splitter is splitting...");
					// once size exceeds maxSize, split and make another splitter on the previous tile.					
					// Game.AddSpaz(new SplitterSpaz(previousTile));
					dispatchEventWith(SPLIT_SPAZ, true, new SplitterSpaz(previousTile));
										
					currentSize = 1;
				}
			}
		}
	}

}