package
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="800", height="600", backgroundColor="#000000")] //Set the size and color of the Flash file

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(CC.WINDOWWIDTH / CC.WINDOWSCALE, CC.WINDOWHEIGHT / CC.WINDOWSCALE, PlayState, CC.WINDOWSCALE); //Create a new FlxGame object and load "PlayState"
			this.forceDebugger = true;
			this.useSystemCursor = true;
			
		}
	}
}
