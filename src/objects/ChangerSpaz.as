package objects 
{
	import utils.Constants;
	import utils.Utilities;
	/**
	 * ...
	 * @author Lee
	 */
	public class ChangerSpaz extends Spaz 
	{
		
		public function ChangerSpaz(tile:Tile) 
		{
			super(tile, Constants.SPAZ_TYPES.CHANGER, "changer");			
		}
		
		override public function Update():void 
		{
			super.Update();
			TryMove();
		}
	}

}