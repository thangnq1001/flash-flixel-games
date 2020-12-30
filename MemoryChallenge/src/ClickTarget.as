package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	
	public class ClickTarget extends FlxSprite
	{
		private var timer:FlxTimer;
		private var timer2:FlxTimer;
		private var switcher:Boolean = true;
		
		public static var clickAllowed:Boolean = false;
		[Embed(source = "data/hitClick.mp3")]
		private var hitClickMp3:Class;
		
		public function ClickTarget(x:Number, y:Number, size:Number) 
		{
			super(x, y);
			makeGraphic(size, size, 0xFFFFFF80);
			
			//fade effect
			timer2 = new FlxTimer();
			timer2.start(0.05, 40, function fadeTarget():void {
				alpha -= 0.025;
			});
			
			//click allowed after 2s
			timer = new FlxTimer();
			timer.start(2, 1, function delay():void {
				clickAllowed = true;
				FlxG.mouse.show();
			});
		}
		
		override public function update():void
		{
			
			if (clickAllowed && FlxG.mouse.justPressed())
			{
				if (FlxG.mouse.x >= x && FlxG.mouse.x <= x + width && FlxG.mouse.y >= y && FlxG.mouse.y <= y + height)
				{
					PlayState.targetLeft--;
					PlayState.targetLeftText.text = "Target left: " + PlayState.targetLeft.toString();
					kill();
					FlxG.play(hitClickMp3);
					
				}
			}
			
			
			if (PlayState.checkGameOver)
			{
				alpha = 0.2;
			}
			
			if (PlayState.checkHint == true && switcher == true)
			{
				
				FlxG.mouse.hide();
				switcher = false;
				alpha = 1;
				var timer:FlxTimer = new FlxTimer();
				timer.start(0.01, 10, function fn():void {
					alpha -= 0.1;
				});
				
			}
			
			super.update();
		}
	}

}