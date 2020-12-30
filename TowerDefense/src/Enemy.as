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
	public class Enemy extends FlxSprite
	{
		[Embed(source = "data/enemy1.png")]
		private var enemy1Img:Class;
		
		[Embed(source = "data/enemy2.png")]
		private var enemy2Img:Class;
		
		[Embed(source = "data/enemy3.png")]
		private var enemy3Img:Class;
		
		[Embed(source = "data/enemy4.png")]
		private var enemy4Img:Class;
		
		[Embed(source = "data/enemy5.png")]
		private var enemy5Img:Class;
		
		private var _lane:uint;
		public var healthBar:FlxBar;
		private var interval:Number;	//interval of 2 bullets
		public static var healthMax:uint = 5;
		public var damage:uint;
		
		public function Enemy(lane:uint)
		{	
			damage = 1 + (Registry.enemyLevel - 1) / 2;
			interval = 2;
			healthBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 60, 5, this, "health", 0, healthMax, true);
			healthBar.createFilledBar(0xFFFF9191, 0xFFFF0000);
			healthBar.trackParent(0, -12);
			_lane = lane;
			
			var _y:int;
			
			if (lane == 1)
				_y = 110;
			else if (lane == 2)
				_y = 110 + 135;
			else if (lane == 3)
				_y = 110 + 270;
				
			var imgClass:Class;
			if (Registry.enemyLevel == 1)
				imgClass = enemy1Img;
			else if (Registry.enemyLevel == 2)
				imgClass = enemy2Img;
			else if (Registry.enemyLevel == 3)
				imgClass = enemy3Img;
			else if (Registry.enemyLevel == 4)
				imgClass = enemy4Img;
			else if (Registry.enemyLevel == 5)
				imgClass = enemy5Img;
				
			super(640 - 43, _y, imgClass);
			
			var bullet:Bullet = new Bullet(x, y, "left", damage);
			PlayState.enemyBulletGroup.add(bullet);
		}
		
		override public function update():void
		{
			if (x <= 250 )
			{
				velocity.x = 0;
			}
			else if(x > 250)
				velocity.x = -50;
			
			interval -= FlxG.elapsed;
			
			if (interval < 0)
			{
				interval = 2;
				var bullet:Bullet = new Bullet(x, y, "left", damage);
				PlayState.enemyBulletGroup.add(bullet);
			}
			
			if (health <= 0)
			{
				Registry.gold += 10;
				PlayState.goldText.text = "Gold: " + Registry.gold.toString();
				if (_lane == 1)
				{
					Registry.numOfEnemyLane1--;
					PlayState.numOfEnemyLane1Text.text = Registry.numOfEnemyLane1.toString();
				}
				else if (_lane == 2)
				{
					Registry.numOfEnemyLane2--;
					PlayState.numOfEnemyLane2Text.text = Registry.numOfEnemyLane2.toString();
				}
				else if (_lane == 3)
				{
					Registry.numOfEnemyLane3--;
					PlayState.numOfEnemyLane3Text.text = Registry.numOfEnemyLane3.toString();
				}
					
				healthBar.kill();
				kill();
			}
			
			if (PlayState.plane != null && PlayState.plane.alive && PlayState.plane.x > 640)
			{
				health = 1;
			}
			
			super.update();
		}
	}

}