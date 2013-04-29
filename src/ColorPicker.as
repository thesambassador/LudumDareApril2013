package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class ColorPicker extends FlxGroup
	{
		public var rPick : FlxButton;
		public var gPick : FlxButton;
		public var bPick : FlxButton;
		
		public var rPosY : int = 0;
		public var gPosY : int = 25;
		public var bPosY : int = 50;
		
		public var size:int = 20;
		
		public static var picked : uint = 0;
		
		public function ColorPicker() 
		{
			
			rPick = new FlxButton();
			gPick = new FlxButton();
			bPick = new FlxButton();
			
			rPick.onDown = pickR;
			gPick.onDown = pickG;
			bPick.onDown = pickB;
			
			rPick.makeGraphic(size, size, 0xffff0000);
			gPick.makeGraphic(size, size, 0xff00ff00);
			bPick.makeGraphic(size, size, 0xff0000ff);
			
			add(rPick);
			add(gPick);
			add(bPick);
			
			hide();
		}
		
		public function show(x:int, y:int, r:Boolean = true, g:Boolean = true, b:Boolean = true) {
			rPick.x = x;
			gPick.x = x;
			bPick.x = x;
			
			rPick.y = rPosY + y;
			gPick.y = gPosY + y;
			bPick.y = bPosY + y;

			this.active = true;
			
			rPick.visible = r;
			rPick.active = r;
			
			gPick.visible = g;
			gPick.active = g; 
			
			bPick.visible = b;
			bPick.active = b;

		}
		
		public function hide() {
			var state:PlayState = (FlxG.state as PlayState);
			if (state.curLevel == 1 && state.tutorialStage == 1) state.tutorialStage ++;
			
			this.active = false;
			rPick.visible = false;
			rPick.active = false;
			
			gPick.visible = false;
			gPick.active = false; 
			
			bPick.visible = false;
			bPick.active = false;
		}
		
		public function pickR() {
			picked = CC.RED;
			hide();
		}
		
		public function pickG() {
			picked = CC.GREEN;
			hide();
		}
		
		public function pickB() {
			picked = CC.BLUE
			hide();
		}
		
	}

}