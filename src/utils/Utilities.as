package utils 
{
	/**
	 * ...
	 * @author Lee
	 */
	public class Utilities 
	{
		public static function GetRandomInt(min:int, max:int):int 
		{
			return Math.floor(Math.random() * (max - min) + min);
		}
		
	}

}