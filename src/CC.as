package  
{
	import org.flixel.FlxPoint
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class CC 
	{
		public static var WINDOWWIDTH : Number = 800; //actual size of window
		public static var WINDOWHEIGHT : Number = 600;
		public static var WINDOWSCALE : Number = 1; //scale of window
		public static var VISIBLEWIDTH : Number = WINDOWWIDTH / WINDOWSCALE;
		public static var VISIBLEHEIGHT : Number = WINDOWHEIGHT / WINDOWSCALE;
		
		public static var RED : uint = 0xff0000;
		public static var GREEN : uint = 0x00ff00;
		public static var BLUE : uint = 0x0000ff;
		public static var WHITE : uint = 0xffffff;
		public static var BLACK : uint = 0x000000;
		
		public static var PURPLE : uint = RED + BLUE;
		public static var TEAL : uint = GREEN + BLUE;
		public static var YELLOW : uint = RED + GREEN;
		
		public static var GRIDSIZE : int = 100;
		public static var GRIDWIDTH : int = CC.VISIBLEWIDTH / GRIDSIZE;
		public static var GRIDHEIGHT : int = CC.VISIBLEHEIGHT / GRIDSIZE;
		
		public static function xor(a:Boolean, b:Boolean) {
			return !(a && b) && (a || b);
		}
		
		public static function snapToGridPoint(point : FlxPoint) : FlxPoint {
			return snapToGrid(point.x, point.y);
		}
		
		public static function snapToGrid(x:int, y:int) : FlxPoint {
			
			var returned : FlxPoint = new FlxPoint(int(x / GRIDSIZE), int(y/GRIDSIZE));

			return returned;
		}
	}

}