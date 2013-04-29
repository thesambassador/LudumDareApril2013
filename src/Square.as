package  
{
	import flash.text.ime.CompositionAttributeRange;
	import org.flixel.FlxButton;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sam Tregillus
	 */

	public class Square extends FlxSprite
	{	
		public static var numSquares : int = 0;
		public static var borderWidth : int = 5;
		public static var borderColor : uint = 0xFF222222;

		public var clickable : Boolean = true;
		public var isGoalPoint : Boolean = false;
		
		public var border : FlxSprite;

		public var startMarker : FlxSprite;
		
		public var gridPoint : FlxPoint;
		
		public var marked : Boolean = false;
		
		public var goalCompleted :Boolean = false;
		
		public var dying : Boolean = false;
		
		public var targetColor : uint;
		
		public function Square(sX : int, sY: int, w:int, col:uint) 
		{
			numSquares ++;
			super(sX, sY);
			//onOver = mouseOver;
			//onDown = mouseClick;

			gridPoint = CC.snapToGrid(sX, sY);
			
			makeGraphic(w, w, FlxG.WHITE);
			color = col;
			targetColor = col;

			startMarker = new FlxSprite(sX + 25, sY + 25);
			startMarker.makeGraphic(width / 2, height / 2, FlxG.BLACK);
			
			border = new FlxSprite(sX - borderWidth, sY - borderWidth);
			border.makeGraphic(2 * borderWidth + w, 2 * borderWidth + w, borderColor);
			
		}
		
		
		public function splitSquare(col : uint) {
			targetColor -= col;
			return new Square(0, 0, this.width, col);
		}
		
		public function absorbSquare(other : Square, col : uint) : void {
			other.targetColor -= col;
			this.targetColor += col;
		}
		
		//gets
		public function get red() : Boolean {
			var colors : Array = FlxU.getRGBA(targetColor);
			return colors[0] > 0;
		}		
		
		public function get green() : Boolean {
			var colors : Array = FlxU.getRGBA(targetColor);
			return colors[1] > 0;
		}		
		
		public function get blue() : Boolean {
			var colors : Array = FlxU.getRGBA(targetColor);
			return colors[2] > 0;
		}
		
		public function get singleColor() : Boolean {
			var r : Boolean = red;
			var g : Boolean = green;
			var b : Boolean = blue;
			
			if (r && g || r && b || g && b){
				return false;
			}
			
			return true;
		}
		
		//check to see if this is a valid place to place a new square, given the selected square's grid location
		public function isValidSplitPoint(point : FlxPoint) : Boolean {
			var selectedGrid : FlxPoint = CC.snapToGrid(this.x, this.y);
			
			if ((Math.abs(point.x - selectedGrid.x) == 1 && point.y == selectedGrid.y) || (Math.abs(point.y - selectedGrid.y) == 1 && point.x == selectedGrid.x)){
				return true;
			}
			return false;
		}
		
		//engine stuff
		override public function kill() : void {
			this.dying = true;
			this.startMarker.kill();
			this.border.kill();
			//super.kill();
		}
		
		override public function update() : void {
			if (color != targetColor) {
				var tColorParts : Array = FlxU.getRGBA(targetColor);
				var colorParts : Array = FlxU.getRGBA(color);
				
				var animFactor : Number = .05;
				
				var diffR = (tColorParts[0] - colorParts[0]) * animFactor ;
				var diffG = (tColorParts[1] - colorParts[1]) * animFactor ;
				var diffB = (tColorParts[2] - colorParts[2]) * animFactor ;
				
				var cur : uint = FlxU.makeColor(colorParts[0] + diffR, colorParts[1] + diffG, colorParts[2] + diffB) - 0xff000000;
				
				this.color = cur;
			}
			
			if (this.offset.x != 0 || this.offset.y != 0) {
				var speed : int = 10;
				
				if (Math.abs(this.offset.x) <= speed) this.offset.x = 0;
				else {
					var dir: int = 1;
					
					if (this.offset.x > 0) dir = -1;
					
					this.offset.x += dir * speed;
				}
				
				if (Math.abs(this.offset.y) <= speed) this.offset.y = 0;
				else {
					var dir: int = 1;
					
					if (this.offset.y > 0) dir = -1;
					
					this.offset.y += dir * speed;
				}
				
			}
			
			if (dying) {
				this.scale.x -= .04;
				this.scale.y -= .04;
				if (this.scale.x <= 0){ 
					super.kill();
					this.x = -200;
					this.y = -200;
				}
			}
			
			if (PlayState.selected == this) { 
				border.update();
			}
			else {
				
			}
			

			super.update();
		}
		
		
		override public function draw() : void {
			
			if (PlayState.selected == this) {
				//border.draw();
			}
			
			super.draw();

			if ((isGoalPoint || marked) && startMarker.alive) {
				startMarker.draw();
			}
			
		}
		
		
	}

}