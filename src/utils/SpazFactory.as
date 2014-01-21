package utils 
{
	import objects.BlockerSpaz;
	import objects.ChangerSpaz;
	import objects.GroundPounderSpaz;
	import objects.LobberSpaz;
	import objects.Spaz;
	import objects.SplitterSpaz;
	import objects.WallerSpaz;
	/**
	 * ...
	 * @author Lee
	 */
	public class SpazFactory 
	{
		public static function GetSpaz(spazType:int):Spaz
		{
			switch (spazType) 
			{
				case int(Constants.SPAZ_TYPES.BLOCKER):
					return new BlockerSpaz(Utilities.GetRandomTile());
					break;
				case int(Constants.SPAZ_TYPES.CHANGER):
					return new ChangerSpaz(Utilities.GetRandomTile());
					break;
				case int(Constants.SPAZ_TYPES.WALLER):
					return new WallerSpaz(Utilities.GetRandomTile());
					break;
				case int(Constants.SPAZ_TYPES.GOUND_POUNDER):
					return new GroundPounderSpaz(Utilities.GetRandomTile());
					break;
				case int(Constants.SPAZ_TYPES.LOBBER):
					return new LobberSpaz(Utilities.GetRandomTile());
					break;
				case int(Constants.SPAZ_TYPES.SPLITTER):
					return new SplitterSpaz(Utilities.GetRandomTile());
					break;
				default:
					return null;
			}
		}
		
	}

}