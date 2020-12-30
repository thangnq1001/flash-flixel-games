package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	
	public class Level extends FlxGroup
	{
		private var switcher:Boolean = true;
		
		public function Level(level:int) 	
		{
			var oldPoint:Array = new Array();	//array of added targets
			var space:Number = 50; //minimum space between 2 squares
			var size:Number;
			if(level <= 10)
				size = 90 - 2 * level;	//size reduces per level
			else if (level <= 20)
				size = 90 - 2 * 10 - 1.5 * (level - 10);
			else if(level <= 30)
				size = 90 - 2 * 10 - 1.5 * 10 - (level - 20);
			else
				size = 90 - 2 * 10 - 1.5 * 10 - 10 - 0.5 * (level - 30);
				
			//add 5 targets
			for (var i:int = 0; i < 5; i++)
			{	
				
				var check:Boolean = true;
				var targetX:Number = Math.random() * (640 - 1.2 * size) + 0.1 * size;
				var targetY:Number = Math.random() * (480 - 60 - size) + 55;
				
				
				if (i > 0) //i = 0 no old point
					for (var j:int = 0; j < oldPoint.length; j++)
						if (Math.abs(targetX - oldPoint[j].x) <= size + space && Math.abs(targetY - oldPoint[j].y) <= size + space) //check collision
						{
							check = false;
							i--; //re-create this i target
							break;
						}

				
				if (check == true)
				{
					var target:ClickTarget = new ClickTarget(targetX, targetY, size);
					add(target);
					
					oldPoint.push(new FlxPoint(targetX, targetY));
				}
				else
					continue;
			}
		}
		
		override public function update():void
		{
			if (PlayState.checkHint == true && switcher == true)
			{
				switcher = false;
				var timer2:FlxTimer = new FlxTimer();
				timer2.start(1, 1, function fn():void {
					FlxG.mouse.show();
					ClickTarget.clickAllowed = true;
				});
			}
			
			
			if (ClickTarget.clickAllowed && FlxG.mouse.justPressed() && FlxG.mouse.y > 54)
			{
				PlayState.clickLimit--;
				PlayState.clickLimitText.text = "Click limit: " + PlayState.clickLimit.toString();
			}
			
			
			super.update();
		}
		
	}

}