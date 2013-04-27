package
{
	import org.flixel.*;
	import org.flixel.system.FlxDebugger;

	public class PlayState extends FlxState
	{
		
		public var pauseMenu : FlxGroup;
		public var debugDiag : FlxDebugger;
		
		
		override public function create():void
		{
			FlxG.mouse.hide();
			//basic initialization
			FlxG.bgColor = 0xff000000;
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
		
			pauseMenu = new FlxGroup();
		}
		
		override public function update():void {

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