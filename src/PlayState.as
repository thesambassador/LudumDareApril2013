package
{
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
	import org.flixel.system.FlxDebugger;

	public class PlayState extends FlxState
	{
		public var pauseMenu : FlxGroup;
		public var debugDiag : FlxDebugger;
		
		public var grid : Grid;
		
		public var gridLines : FlxSprite;
		public var gridSize : int = CC.GRIDSIZE;
		
		public var squareGroup : FlxGroup;
		public var colorPicker : ColorPicker;
		
		public var mouseX : int = 0;
		public var mouseY : int = 0;
		
		public var shouldClear : Boolean = false;
		public var state = "level";
		
		public var levelEndTimer : int = -1;
		public var levelEndTime : int = 60;
		
		public var levels : Levels;
		public var curLevel : int = 6;
		
		public var levelText : String = "";
		public var text : FlxText;
		public var tutorialText : FlxText;
		public var tutorial : Array;
		public var tutorialStage = 0;
		
		public static var selected : Square;
		
		public var background : FlxButton;
		
		override public function create():void
		{

			tutorial = new Array();
			tutorial.push("Click a solid square");
			tutorial.push("Select a color");
			tutorial.push("Click an adjacent square");
			tutorial.push("Bridge the two black-centered squares, hit R to restart");
			
			text = new FlxText(0, CC.VISIBLEHEIGHT - 50, CC.VISIBLEWIDTH, levelText);
			text.alignment = "center";
			text.size = 15;
			add(text);
			
			tutorialText = new FlxText(0, 50, CC.VISIBLEWIDTH, "" );
			tutorialText.alignment = "center";
			tutorialText.size = 15;
			add(tutorialText);
			
			//basic initialization
			FlxG.mouse.show();
			FlxG.bgColor = 0xff000000;
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			
			grid = new Grid(CC.GRIDWIDTH, CC.GRIDHEIGHT);

			squareGroup = new FlxGroup();
			add(squareGroup);
			
			colorPicker = new ColorPicker();
			add(colorPicker);
			
			levels = new Levels();
			
			levels.loadLevel(curLevel);
			
			pauseMenu = new FlxGroup();
			
			FlxG.watch(this, "mouseX", "MouseX");
			FlxG.watch(this, "mouseY", "MouseY");

			FlxG.watch(ColorPicker, "picked", "picked");
		}
		
		
		public function placeGoalPoint(gridX : int, gridY : int, color : uint) {
			var newSquare : Square = new Square(gridX * gridSize, gridY * gridSize, gridSize, color);
			newSquare.clickable = false;
			newSquare.isGoalPoint = true;;
			
			squareGroup.add(newSquare);
			grid.setGoalAt(gridX, gridY, newSquare);
		}
		
		public function placeNewSquare(gridX : int, gridY : int, size:int, color : uint) : Square{
			var newSquare : Square = new Square(gridX * gridSize, gridY * gridSize, size * gridSize, color);
			squareGroup.add(newSquare);
			
			grid.setAt(gridX, gridY, newSquare);
			grid.resolveGoals();
			
			return newSquare;
		}
		
		public function placeSquare(square : Square, fromSquare : Square, gridX : int, gridY : int) : Square {
			square.x = gridX * gridSize;
			square.y = gridY * gridSize;
			
			square.offset.x = square.x - fromSquare.x;
			square.offset.y = square.y - fromSquare.y;
			
			squareGroup.add(square);
			//squareGroup.members.reverse();
			grid.setAt(gridX, gridY, square);
			grid.resolveGoals();
			return square;
		}
		
		override public function update():void {
			text.text = levelText;
			if (state == "level") {
				if (curLevel == 1) {
					tutorialText.text = tutorial[tutorialStage];
				}
				if (FlxG.keys.justPressed("R")) {
					clearLevel();
					curLevel -= 1;
				}
				else{
					var mousePos : FlxPoint = FlxG.mouse.getWorldPosition();
					mouseX = mousePos.x;
					mouseY = mousePos.y;
					
					if (grid.levelComplete) {
						clearLevel();
						
					}
					
					if (shouldClear) {
						squareGroup.clear();
						//remove(squareGroup);
						//squareGroup = new FlxGroup();

						
						state = "endLevel";
						levelEndTimer = levelEndTime;
						shouldClear = false;
					}
					
					for each(var square : Square in squareGroup.members) {
						if (!square.alive) {
							squareGroup.remove(square,true);
						}
						else {
							shouldClear = false;
							break;
						}
						shouldClear = true;
					}
				}
			}
			else if (state == "endLevel") {
				levelEndTimer -= 1;
				if (levelEndTimer <= 0) {
					state = "level";
					
					if (curLevel == 1) {
						tutorialText.kill();
					}
					
					curLevel += 1;
					
					levels.loadLevel(curLevel);
				}
			}
				
				
			if (FlxG.mouse.justPressed()) {
				mouseClick();
			}
			
			if (FlxG.keys.justPressed("P")) {
				FlxG.paused = !FlxG.paused;
			}
			
			if (FlxG.paused) {
				pauseMenu.update();
				return;
			}
			
			super.update();

		}
		
		public function clearLevel() : void {
			for each(var square : Square in squareGroup.members) {
				if(square != null)
					square.kill();
			}
			grid = new Grid(CC.GRIDWIDTH, CC.GRIDHEIGHT);
		}
		
		public function mouseClick() :void {
			var clickedSquare : Square = getClickedSquare();
			var mouseGrid : FlxPoint = snapToGridPoint(FlxG.mouse.getWorldPosition());
			
			//we didn't click on a square
			if (clickedSquare == null) {
				//if we have a square selected already, and a color picked, we might want to place a new square
				if (selected != null && ColorPicker.picked != 0) {
					var selectedGrid : FlxPoint = snapToGrid(selected.x, selected.y);
					//check to see if this is a valid place to place a new square, given the selected square's grid location
					if (selected.isValidSplitPoint(mouseGrid)){
						placeSquare(selected.splitSquare(ColorPicker.picked), selected, mouseGrid.x, mouseGrid.y);
						if (curLevel == 1 && tutorialStage == 2) tutorialStage ++;
						selected = null;
						ColorPicker.picked = 0;
					}
				}
				selected = null;
				ColorPicker.picked = 0;
				colorPicker.hide();
			}
			//we did click on a clickable square
			else{
				//no selection, select the clicked square
				if (selected == null || ColorPicker.picked == 0) {
					if (curLevel == 1 && tutorialStage == 0) tutorialStage ++;
					selected = clickedSquare;
					ColorPicker.picked = 0;
					colorPicker.show(selected.x, selected.y, selected.red, selected.green, selected.blue);
				}
				//selection is set, and we've clicked on a square
				else {
					//if we have a color picked, should we put the current color in?
					if (ColorPicker.picked != 0 && selected.isValidSplitPoint(mouseGrid)) {
						//only merge if the target square doens't have the picked color already
						var t : uint = ColorPicker.picked & clickedSquare.targetColor;
						if (t != ColorPicker.picked) {
							clickedSquare.absorbSquare(selected, ColorPicker.picked);
							grid.resolveGoals();
						}
					}
					
					if (clickedSquare != selected) {
						PlayState.selected = null;
						ColorPicker.picked = 0;
						colorPicker.hide();
					}
					
				}
			}
			
		}
		
		public function getClickedSquare() : Square {
			for each(var square : Square in squareGroup.members) {
				if (square.clickable && square.overlapsPoint(FlxG.mouse.getWorldPosition())) {
					return square;
				}
			}
			return null;
		}
		
		public function snapToGridPoint(point : FlxPoint) : FlxPoint {
			return snapToGrid(point.x, point.y);
		}
		
		public function snapToGrid(x:int, y:int) : FlxPoint {
			
			var returned : FlxPoint = new FlxPoint(int(x / gridSize), int(y/gridSize));

			return returned;
		}
		
		override public function draw():void {
			if (FlxG.paused) {
				pauseMenu.draw();
			}
			super.draw();
		}
		
	}
}