package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*;
	
	public class Bullet extends FlxSprite 
	{
		
		public function Bullet(x: Number, y: Number, velocityX: Number, velocityY: Number)
		{
			super(x, y);
			makeGraphic(10, 4, 0xFFFF0000);
			velocity.x = velocityX;
			velocity.y = velocityY;
		}
		
		override public function update():void
		{
			if (x > 650)
				kill();
			
			super.update();
		}
	}

}