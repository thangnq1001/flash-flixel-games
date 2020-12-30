package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	
	import org.flixel.*
	
	public class Ship extends FlxSprite 
	{
		[Embed(source = "data/Ship.png")]
		private var ImgShip:Class;
		
		public var dead:Boolean = false;
		public var hp: int = 3;
		public function Ship() 
		{
			super(50, 50, ImgShip);
		}
		
		override public function update():void
		{
			super.update();
			
		/*	velocity.x = velocity.y = 0;
			
			if (FlxG.keys.W)
				velocity.y = -250;
				
			if (FlxG.keys.A)
				velocity.x = -250;
				
			if (FlxG.keys.S)
				velocity.y = 250;
				
			if (FlxG.keys.D)
				velocity.x = 250;*/
			
			acceleration.x = acceleration.y = 0;
			
			if (FlxG.keys.W)
				acceleration.y = -maxVelocity.y * 6;
				
			if (FlxG.keys.A)
				acceleration.x = -maxVelocity.x * 6;
				
			if (FlxG.keys.S)
				acceleration.y = maxVelocity.y * 6;
				
			if (FlxG.keys.D)
				acceleration.x = maxVelocity.x * 6;
			
			//keep object inside the screen
			if (x > FlxG.width - width - 16) //FlxG.width: screen, width: object, 16: just a padding
			{
				x = FlxG.width - width - 16;
			}
			else if(x < 16)
				x = 16;

			if(y > FlxG.height-height-16)
				y = FlxG.height-height-16;
			else if(y < 16)
				y = 16;
		}
	}

}