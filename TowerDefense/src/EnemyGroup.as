package 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author thangnq
	 */
	public class EnemyGroup extends FlxGroup
	{
		private var interval:Number;	//interval of 2 enemies
		private var lane:uint;
		private var upgradeIntervalTimer:Number;
		private var upgradeinterval:Number = 120;
		
		public function EnemyGroup() 
		{
			upgradeIntervalTimer = upgradeinterval;
			interval = 6;
		}
		
		override public function update():void
		{
			interval -= FlxG.elapsed;
			upgradeIntervalTimer -= FlxG.elapsed;
			
		//spawn Enemies
			if (interval < 0)
			{
				lane = Math.random() * 100 % 3 + 1;
				var enemy:Enemy = new Enemy(lane);
				enemy.health = Enemy.healthMax;
				add(enemy);
				add(enemy.healthBar);
				if (lane == 1)
				{
					Registry.numOfEnemyLane1++;
					PlayState.numOfEnemyLane1Text.text = Registry.numOfEnemyLane1.toString();
				}
				else if (lane == 2)
				{
					Registry.numOfEnemyLane2++;
					PlayState.numOfEnemyLane2Text.text = Registry.numOfEnemyLane2.toString();
				}
				else if (lane == 3)
				{
					Registry.numOfEnemyLane3++;
					PlayState.numOfEnemyLane3Text.text = Registry.numOfEnemyLane3.toString();
				}
				interval = 3;
			}
			 
		//-------------------------------------------------------
		
				
		//enemies grow stronger over time
			if (upgradeIntervalTimer < 0 && Registry.enemyLevel < 5)
			{
				upgradeIntervalTimer = upgradeinterval + 60;
				interval *= 0.96;
				Registry.enemyLevel += 1;
				Enemy.healthMax += 5;
				PlayState.enemyLevelText.text = "Enemy: Level " + Registry.enemyLevel.toString();
			}
		//--------------------------------------------------------
		
			super.update();
		}
	}

}