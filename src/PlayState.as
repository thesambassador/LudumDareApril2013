package
{
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import org.flixel.*;
	import org.flixel.system.FlxDebugger;

	public class PlayState extends FlxState
	{
		
		public var pauseMenu : FlxGroup;
		public var debugDiag : FlxDebugger;
		
		public var grid : FlxSprite;
		public var gridSize : int = 100;
		
		public var mouseX : int = 0;
		public var mouseY : int = 0;
		
		public static var selected : Square;
		
		override public function create():void
		{
			FlxG.mouse.show();
			//basic initialization
			FlxG.bgColor = 0xff000000;
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			
			grid = createGrid(gridSize, 0x202020);
			this.add(grid);

			placeSquare(1, 2, 2, 0xFFFFFFFF);
			
			placeSquare(3, 1, 1, 0xFF0000FF);
			
			pauseMenu = new FlxGroup();
			
			FlxG.watch(this, "mouseX", "MouseX");
			FlxG.watch(this, "mouseY", "MouseY");
		}
		
		public function createGrid(gridSize:int, gridColor : uint) : FlxSprite {
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
		
		public function placeSquare(gridX : int, gridY : int, size:int, color : uint) {
			var newSquare : Square = new Square(gridX * gridSize, gridY * gridSize, size * gridSize, color);
			add(newSquare);
		}
		
		override public function update():void {
			var mousePos : FlxPoint = FlxG.mouse.getWorldPosition();
			mouseX = mousePos.x;
			mouseY = mousePos.y;
			
			if (FlxG.keys.justPressed("P")) {
				FlxG.paused = !FlxG.paused;
			}
			
			if (FlxG.paused) {
				pauseMenu.update();
				return;
			}
			
			super.update();

		}
		
		override public function draw():void {
			if (FlxG.paused) {
				pauseMenu.draw();
			}
			super.draw();
		}
		
	}
}