package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Levels 
	{
		public var levels : Array;
		public var goals : Array;
		public var levelText : Array;
		
		public var playState : PlayState;
		
		public static var w:uint = CC.WHITE;
		public static var r:uint = CC.RED;
		public static var g:uint = CC.GREEN;
		public static var b:uint = CC.BLUE;
		public static var rg:uint = CC.YELLOW;
		public static var rb:uint = CC.PURPLE;
		public static var gb:uint = CC.TEAL;
		
		public function Levels() 
		{
			playState = FlxG.state as PlayState;
			levels = new Array(10);
			goals = new Array(10);
			levelText = new Array(10);
			Level1();
			Level2();
			Level3();
			Level4();
			Level5();
			Level6();
		}
		
		public function Level1() {
			
			var level : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	w,	rg,	0,	0,	0],
			[0,	0,	w,	0,	0,	w,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			var goal : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			levelText[1] = "Bridge the gap";
			levels[1] = level;
			goals[1] = goal;
		}
		
		public function Level2() {
			var level : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	r,	w,	w,	r,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			var goal : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			levelText[2] = "Bridge with Red";
			levels[2] = level;
			goals[2] = goal;
		}
		
		public function Level3() {
			var level : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	rb,	0,	0,	rb,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	g,	w,	w,	g,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			var goal : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			levelText[3] = "Bridge with the contained colors.  White contains all colors.";
			levels[3] = level;
			goals[3] = goal;
		}
		
		public function Level4() {
			var level : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	r,	0,	r,	0,	0,	0],
			[0,	0,	rg,	0,	rb,	rg,	0,	0],
			[0,	0,	b,	w,	0,	b,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			var goal : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	1,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			levelText[4] = "Getting trickier";
			levels[4] = level;
			goals[4] = goal;
		}
		
		public function Level5() {
			var level : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	r,	0,	0,	r,	0,	0],
			[0,	0,	gb,	0,	0,	gb,	0,	0],
			[0,	0,	g,	w,	w,	g,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			var goal : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			levelText[5] = "Push it up";
			levels[5] = level;
			goals[5] = goal;
		}
		
		public function Level6() {
			var level : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	g,	0,	0,	r,	0,	0],
			[0,	gb,	w,	0,	0,	w,	rb,	0],
			[0,	0,	0,	w,	w,	r,	0,	0],
			[0,	0,	g,	0,	0,	r,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			var goal : Array = [
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0],
			[0,	0,	1,	0,	0,	1,	0,	0],
			[0,	0,	0,	0,	0,	0,	0,	0]];
			
			levelText[6] = "Keep going";
			levels[6] = level;
			goals[6] = goal;
		}
		
	
		
		
		public function loadLevel(lev:int) {
			var level : Array = levels[lev];
			var goals : Array = goals[lev];
			
			playState.levelText = levelText[lev];
			
			for (var y:int = 0; y < 6; y++ ) {
				for (var x:int = 0; x < 8; x++) {
					if(level[y][x] != 0){
						if (goals[y][x] == 1) {
							playState.placeGoalPoint(x, y, level[y][x]);
						}
						else {
							playState.placeNewSquare(x, y, 1, level[y][x]);
						}
					}
				}
			}
			
		}
		
		
		
	}

}