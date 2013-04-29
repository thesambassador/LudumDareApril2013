package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Grid 
	{
		public var members : Array;
		public var width : int;
		public var height : int;
		public var gridSize : int;
		public var showGridlines : Boolean;
		
		public var gridLines : FlxSprite;
		public var gridColor : uint = 0xFFFFFFFF;
		
		public var goals : Array;
		
		public function Grid(w:int, h:int)
		{
			width = w;
			height = h;
			
			gridSize = CC.GRIDSIZE;
			
			gridLines = createGridLines();
			//FlxG.state.add(gridLines);
			
			goals = new Array();
			
			members = new Array(width);
			for (var x:int = 0; x < width; x++) {
				members[x] = new Array(height);
			}
		}
		
		public function setAt(x:int, y:int, obj:Object) {
			members[x][y] = obj;
		}
		
		public function setGoalAt(x:int, y:int, obj:Object) {
			setAt(x, y, obj);
			goals.push(obj);
		}
		
		public function getColorAt(x:int, y:int) : uint {
			var square : Square = members[x][y] as Square;
			if(square != null)
				return square.targetColor;
				
			return 0;
		}
		
		//returns true if the color at x,y CONTAINS the target color (white contains all colors)
		public function compareColorAt(x:int, y:int, targetColor :uint) : Boolean{
			//return (getColorAt(x, y) & targetColor) != 0;
			var col : uint = getColorAt(x, y);
			if (col == 0) return false;
			
			//var xor : uint = col ^ targetColor;
			
 			return (col | targetColor) == targetColor;
		}
		
		public function createGridLines() : FlxSprite {
			var returned : FlxSprite = new FlxSprite();
			returned.makeGraphic(CC.VISIBLEWIDTH, CC.VISIBLEHEIGHT, 0xff000000);
			var bitmap : BitmapData = returned.framePixels;
			
			//horizontal lines
			for (var y : int = 0; y < CC.VISIBLEHEIGHT; y += gridSize) {
				for (var x : int = 0; x < CC.VISIBLEWIDTH; x++) {
					bitmap.setPixel(x, y, gridColor);
					bitmap.setPixel(x, y + gridSize - 1, gridColor);
				}
			}
			
			//verticle lines
			for (var x : int = 0; x < CC.VISIBLEWIDTH; x += gridSize) {
				for (var y : int = 0; y < CC.VISIBLEHEIGHT; y++) {
					bitmap.setPixel(x, y, gridColor);
					bitmap.setPixel(x+gridSize-1, y, gridColor);
				}
			}
			
			return returned;			
		}
		
		public function resolveGoals() : void {
			if (goals.length % 2 != 0) return;
			var goalCopy : Array = goals.slice();
			
			//pull out all goals of the same color, there is assumed to be an EVEN number of goals of the same color (1 white, 1 red, and 1 green is invalid)
			for (var i:int = 0; i < goalCopy.length; i++) {
				var goal1 : Square = goalCopy[i] as Square;
				if (goal1.goalCompleted) continue;
				var goal2 : Square;
				for (var j:int = i+1; j < goalCopy.length; j++) {
					goal2 = goalCopy[j] as Square;
					if (goal2.goalCompleted) continue;
					if (goal1.targetColor == goal2.targetColor) {

						if (checkPath(goal1, goal2)) {

							//goalCopy.splice(i, 1);
							//goalCopy.splice(j, 1);
							
							goal1.goalCompleted = true;
							goal2.goalCompleted = true;
							
							i = 0;
							break;
						}
					}
				}
			}
			
		}
		
		public function get levelComplete() : Boolean {
			for each(var goal : Square in goals) {
				if (goal.alive) {
					return false;
				}
			}
			return true;
		}
		
		public function checkPath(goal1:Square, goal2:Square) : Boolean {
			var start : FlxPoint = goal1.gridPoint;
			var end : FlxPoint = goal2.gridPoint;
			var color : uint = goal1.targetColor;
			
			var result : Boolean = visitSquare(start.x, start.y, color, goal1, goal2)
			if (!result) unmarkAll();
			return result;
			
		}
		
		public function visitSquare(x:int, y:int, color:uint, start : Square, goal : Square) : Boolean {
			var square : Square = members[x][y];
			if (square.marked) return false;
			if (square == goal) {
				square.kill();
				return true;
			}
			
			if (square.isGoalPoint && square != start) return false;
			
			square.marked = true;
			
			
			for each(var neighbor : FlxPoint in getValidNeighbors(x, y, color)) {
				if (visitSquare(neighbor.x, neighbor.y, color, start, goal)) {
					square.kill();
					return true;
				}
			}
			
			return false;
		}
		
		public function removeSquare(x:int, y:int) {
			var square :Square = members[x][y] as Square;
			if (square != null) square.kill;
			
			members[x][y] = null;
		}
		
		public function getValidNeighbors(x:int, y:int, color:uint) : Array{
			var returned : Array = new Array();
			
			if(x != width-1)
				if (compareColorAt(x + 1, y, color))
					returned.push(new FlxPoint(x + 1, y));
					
			if(x != 0)
				if (compareColorAt(x - 1, y, color))
					returned.push(new FlxPoint(x - 1, y));
					
			if(y != 0)
				if (compareColorAt(x, y -1, color))
					returned.push(new FlxPoint(x, y-1));
			
			if(y != height-1)
				if (compareColorAt(x, y + 1, color))
					returned.push(new FlxPoint(x, y+1));
			
			
			return returned;
		}
		
		public function unmarkAll() : void {
			for (var x:int = 0; x < width; x++) {
				for (var y:int = 0; y < height; y++) {
					var square : Square = members[x][y] as Square;
					if (square != null) {
						square.marked = false;
					}
				}
			}
			
			
		}

		
		public function comparePoints(p1:FlxPoint, p2:FlxPoint) : Boolean {
			return p1.x == p2.x && p1.y == p2.y;
		}
		
	}

}