package 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author thangnq
	 */
	
	public class Bullet extends FlxSprite
	{
		public var dir:String;
		public var damage:uint;
		
		[Embed(source = "data/bullet_red.png")]
		private var bulletImg:Class;
		
		public function Bullet(x:Number, y:Number, dir:String, damage:uint) 
		{
			super(x, y, bulletImg);
			this.dir = dir;
			this.damage = damage;
		}
		
		override public function update():void 
		{
			if (dir == "left")
			{
				velocity.x = -350;
			}
			else if (dir == "right")
				velocity.x = 350;
				
			if (x > 640)
				kill();
				
			super.update();
		}
	}

}