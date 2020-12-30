package 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author thangnq
	 */
	public class Plane extends FlxSprite
	{
		[Embed(source = "data/plane.png")]
		private var planeImg:Class;
		
		[Embed(source = "data/bomb.png")]
		private var bombImg:Class;
		
		[Embed(source = "data/flyingplane.mp3")]
		private var flyingPlaneMp3:Class;
		
		private var switcher:Boolean = true;
		
		public function Plane() 
		{
			super(-100, 45, planeImg);
			velocity.x = 80;
			angle = 17;
			FlxG.play(flyingPlaneMp3, 1);
		}
		
		override public function update():void
		{
			if (x > 205 && switcher == true)
			{
				switcher = false;
				
				var timer:FlxTimer = new FlxTimer();
				timer.start(0.4, 15, function fn():void {
					var bomb:FlxSprite = new FlxSprite(x + 20, y + 15, bombImg);
					bomb.velocity.y = 50;
					bomb.angle = 45;
					PlayState.bombGroup.add(bomb);
				});
			}
			
			if (x > 640)
			{
				kill();
				PlayState.bombGroup.clear();
			}
			
			super.update();
		}
	}

}