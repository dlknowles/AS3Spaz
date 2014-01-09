package  
{
	import flash.automation.KeyboardAutomationAction;
	/**
	 * Defines a Level object. Mostly for convenience so we don't have
	 * to remember what's in each level string.
	 * @author Lee
	 */
	public final class Level 
	{
		// Private variables
		private var map:Array;
		private var maxTurns:int;
		private var maxColors:int;
		private var maxGems:int;
		private var dynamite:int;
		private var concrete:int;
		private var acidFlasks:int;
		private var spazArray:Array;
		private var jsonStr:String;
		// End private variables
		
		// Public properties
		public function get Map():Array { return this.map; }
		public function get MaxTurns():int { return this.maxTurns; }
		public function get MaxColors():int { return this.maxColors; }
		public function get MaxGems():int { return this.maxGems; }
		public function get Dynamite():int { return this.dynamite; }
		public function get Concrete():int { return this.concrete; }
		public function get AcidFlasks():int { return this.acidFlasks; }
		public function get SpazArray():Array { return this.spazArray; }
		public function get JSONString():String { return this.jsonStr; }
		// End public properties
						
		public function Level(jsonString:String)
		{	
			map = new Array();
			maxTurns = 0;
			maxColors = 0;
			maxGems = 0;
			dynamite = 0;
			concrete = 0;
			acidFlasks = 0;
			spazArray = new Array();
			jsonStr = jsonString;
			
			initializeFromJSON();
		}
		
		private function initializeFromJSON():void 
		{
			var obj:Object = JSON.parse(jsonStr);
			
			if (obj.hasOwnProperty("map")) map = obj.map;			
			if (obj.hasOwnProperty("maxTurns")) maxTurns = obj.maxTurns;			
			if (obj.hasOwnProperty("maxColors")) maxColors = obj.maxColors;			
			if (obj.hasOwnProperty("maxGems")) maxGems = obj.maxGems;			
			if (obj.hasOwnProperty("dynamite")) dynamite = obj.dynamite;
			if (obj.hasOwnProperty("concrete")) concrete = obj.concrete;
			if (obj.hasOwnProperty("acidFlasks")) acidFlasks = obj.acidFlasks;
			if (obj.hasOwnProperty("spazArray")) spazArray = obj.spazArray;
		}
	}

} 