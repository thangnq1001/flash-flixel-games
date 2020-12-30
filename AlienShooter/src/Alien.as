package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	public class Alien extends FlxSprite 
	{
		[Embed(source = "data/Alien.png")]
		private var ImgAlien:Class;
		public var hp: int;
		
		public function Alien(x: Number, y: Number):void 
		{
			super(x, y, ImgAlien);
			velocity.x = -200;
		}
		
		override public function update():void
		{
			super.update();
			velocity.y = Math.cos(x / 50) * 300;
			
			if (x < -36)
				kill();
		}
	}

}