package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Sam Tregillus
	 */
	public class Square extends FlxButton
	{
		public var borderWidth : int = 5;
		public var borderColor : uint = 0xFF222222;
		
		public var border : FlxSprite;
		public function Square(sX : int, sY: int, w:int, col:uint ) 
		{
			super(sX, sY);
			onOver = mouseOver;
			onDown = mouseClick;
			makeGraphic(w, w, col);
			
			border = new FlxSprite(sX - borderWidth, sY - borderWidth);
			border.makeGraphic(2 * borderWidth + w, 2 * borderWidth + w, borderColor);
			
		}
		
		
		override public function update() : void {
			if (PlayState.selected == this) { 
				
			}
			else {
				
			}
			
			if (onScreen()) {
				var asdf = 5;
			}
			super.update();
		}
		
		override public function draw() : void {
			if (PlayState.selected == this) {
				border.draw();
			}
			super.draw();
			
		}
		
		public function mouseOver() : void {
		}
		
		public function mouseClick() : void {
			PlayState.selected = this;
		}
		
	}

}