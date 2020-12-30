package 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author thangnq
	 */
	public class Ally extends FlxSprite
	{
		[Embed(source = "data/ally1.png")]
		private var ally1Img:Class;
		
		[Embed(source = "data/ally2.png")]
		private var ally2Img:Class;
		
		[Embed(source = "data/ally3.png")]
		private var ally3Img:Class;
		
		[Embed(source = "data/ally4.png")]
		private var ally4Img:Class;
		
		[Embed(source = "data/ally5.png")]
		private var ally5Img:Class;
		
		private var _lane:uint;
		public var healthBar:FlxBar;
		private var interval:Number;
		
		public static var healthMax:uint = 5;
		public var damage:uint;
		
		public function Ally(lane:uint)
		{	
			damage = 1 + (Registry.allyLevel - 1) / 2;
			interval = 2;
			healthBar = new FlxBar(0 , 0, FlxBar.FILL_LEFT_TO_RIGHT, 60, 5, this, "health", 0, healthMax);
			healthBar.trackParent(0, -12);
			
			var _y:int;
			_lane = lane;
			
			if (lane == 1)
				_y = 115;
			else if (lane == 2)
				_y = 115 + 135;
			else if (lane == 3)
				_y = 115 + 270;
			
			var imgClass:Class;
			if (Registry.allyLevel == 1)
				imgClass = ally1Img;
			else if (Registry.allyLevel == 2)
				imgClass = ally2Img;
			else if (Registry.allyLevel == 3)
				imgClass = ally3Img;
			else if (Registry.allyLevel == 4)
				imgClass = ally4Img;
			else if (Registry.allyLevel == 5)
				imgClass = ally5Img;
			
			super(30, _y, imgClass);
			
			var bullet:Bullet = new Bullet(x + 60, y, "right", damage);
			PlayState.allyBulletGroup.add(bullet);
		}
		
		override public function update():void
		{
			if (x >= 150 )
			{
				velocity.x = 0;
			}
			else if(x < 250)
				velocity.x = 50;
			
			interval -= FlxG.elapsed;
			
			if (interval < 0)
			{
				interval = 2;
				var bullet:Bullet = new Bullet(x, y, "right", damage);
				PlayState.allyBulletGroup.add(bullet);
			}
			
			if (health <= 0)
			{
				if (_lane == 1)
				{
					Registry.numOfAllyLane1--;
					PlayState.numOfAllyLane1Text.text = Registry.numOfAllyLane1.toString();
				}
				else if (_lane == 2)
				{
					Registry.numOfAllyLane2--;
					PlayState.numOfAllyLane2Text.text = Registry.numOfAllyLane2.toString();
				}
				else if (_lane == 3)
				{
					Registry.numOfAllyLane3--;
					PlayState.numOfAllyLane3Text.text = Registry.numOfAllyLane3.toString();
				}
				healthBar.kill();
				kill();
			}
			
			super.update();
		}
	}

}