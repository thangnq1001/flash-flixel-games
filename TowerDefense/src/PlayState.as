package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.FlxGroup;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxButton;
	
	public class PlayState extends FlxState
	{
		private var switcher:Boolean = true;
		private var switcher2:Boolean = true;
		
		public static var goldText:FlxText;
		private var goldOverTime:Number = 1;
		
		
		[Embed(source = "data/background.jpg")]
		private var bgImg:Class;
		
		[Embed(source = "data/fench.png")]
		private var fenchImg:Class;
		
		[Embed(source = "data/barricade.png")]
		private var barricadeImg:Class;
		
		[Embed(source = "data/spawn.png")]
		public static var spawnBtImg:Class;
		
		[Embed(source = "data/ingame.mp3")]
		private var ingameMp3:Class;
		
		[Embed(source = "data/gameOver1.mp3")]
		private var gameOverMp3:Class;
		
		[Embed(source = "data/plane.png")]
		private var planeImg:Class;
		
		[Embed(source = "data/reserveforce.png")]
		private var reserveForceImg:Class;
		
		[Embed(source = "data/upgrade.png")]
		private var upgradeImg:Class;
		
		public static var enemyGroup:EnemyGroup;
		public static var towerGroup:TowerGroup;
		public static var enemyBulletGroup:FlxGroup;
		public static var allyGroup:AllyGroup;
		public static var allyBulletGroup:FlxGroup;
		public static var bombGroup:FlxGroup;
		
		private var checkGameOver:Boolean = false;
		
		public static var summon1Bt:FlxButton;
		public static var summon2Bt:FlxButton;
		public static var summon3Bt:FlxButton;
		
		private var cooldownLane1:Boolean = true;
		private var cooldownLane2:Boolean = true;
		private var cooldownLane3:Boolean = true;
		
		private var upgradeBt:FlxButton;
		public static var allyLevelText:FlxText;
		public static var enemyLevelText:FlxText;
		
		private var paused:Boolean;
		private var pauseGroup:FlxGroup;
		private var pauseText:FlxText;
		
		public static var numOfEnemyLane1Text:FlxText;
		public static var numOfEnemyLane2Text:FlxText;
		public static var numOfEnemyLane3Text:FlxText;
		
		public static var numOfAllyLane1Text:FlxText;
		public static var numOfAllyLane2Text:FlxText;
		public static var numOfAllyLane3Text:FlxText;
		
		private var instruction:FlxText;
		
		private var reserveForceBt:FlxButton;
		private var reserveForceCd:Boolean = true;
		
		private var airSupportBt:FlxButton;
		private var airSupportCd:Boolean = true;
		public static var plane:Plane;
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void
		{
		//	if (FlxG.getPlugin(...) == null)
		//		FlxG.addPlugin(...);
		
		//pause
			paused = false;
			pauseGroup = new FlxGroup();
		//-------------------------------------------------
		
		FlxG.playMusic(ingameMp3, 0.7);
		
		//environment
			var bg:FlxSprite = new FlxSprite(0, 0, bgImg);
			add(bg);
			
			var fench1:FlxSprite = new FlxSprite(2, 40, fenchImg);
			add(fench1);
			
			var fench2:FlxSprite = new FlxSprite(2, 175, fenchImg);
			add(fench2);
			
			var fench3:FlxSprite = new FlxSprite(2, 310, fenchImg);
			add(fench3);
			
			var fench4:FlxSprite = new FlxSprite(2, 445, fenchImg);
			add(fench4);
			
			var bgScoreBoard:FlxSprite = new FlxSprite(0, 0);
			bgScoreBoard.makeGraphic(640, 40, 0xFF808080);
			add(bgScoreBoard);
			
			add(new FlxSprite(220, 73, barricadeImg));
			add(new FlxSprite(220, 98, barricadeImg));
			add(new FlxSprite(220, 123, barricadeImg));
			add(new FlxSprite(220, 148, barricadeImg));
			
			add(new FlxSprite(220, 73 + 135, barricadeImg));
			add(new FlxSprite(220, 98 + 135, barricadeImg));
			add(new FlxSprite(220, 123 + 135, barricadeImg));
			add(new FlxSprite(220, 148 + 135, barricadeImg));

			add(new FlxSprite(220, 73 + 135 + 135, barricadeImg));
			add(new FlxSprite(220, 98 + 135 + 135, barricadeImg));
			add(new FlxSprite(220, 123 + 135 + 135, barricadeImg));
			add(new FlxSprite(220, 148 + 135 + 135, barricadeImg));
			
			goldText = new FlxText(5, 10, 200, "Gold: " + Registry.gold.toString());
			goldText.setFormat("Arial", 15, 0xffffffff, "left");
			add(goldText);
			
			instruction = new FlxText(0, 200, 640, "The enemies\nare reaching!\nDeploy your\nforce now!");
			instruction.setFormat("Arial", 20, 0xFFFF0000, "center");
			add(instruction);
			var timer:FlxTimer = new FlxTimer();
			timer.start(6, 1, function fn():void {
				remove(instruction);
			});
		//------------------------------------------------------------------------------	
		
		
		//towers
			towerGroup = new TowerGroup();
			add(towerGroup);
		//------------------------------------	
		
		
		//enemy bullets
			enemyBulletGroup = new FlxGroup();
			add(enemyBulletGroup);
		//------------------------------------
		
		
		//ally bullets
			allyBulletGroup = new FlxGroup();
			add(allyBulletGroup);
		//------------------------------------
		
		
		//enemies
			enemyGroup = new EnemyGroup();
			add(enemyGroup);
			
		//------------------------------------
		
		
		//allies
			allyGroup = new AllyGroup();
			add(allyGroup);
		//------------------------------------
		
		
		//summon ally buttons
			summon1Bt = new FlxButton(2, 155, null, function fn():void {
				if (Registry.gold >= Registry.allyCost && cooldownLane1 == true)
				{
					var ally1:Ally = new Ally(1);
					ally1.health = Ally.healthMax;
					allyGroup.add(ally1);
					allyGroup.add(ally1.healthBar);
					Registry.gold -= Registry.allyCost;
					goldText.text = "Gold: " + Registry.gold.toString();
					Registry.numOfAllyLane1++;
					numOfAllyLane1Text.text = Registry.numOfAllyLane1.toString();
					
					cooldownLane1 = false;
					
					//after 4s, set var = true to allow summoning
					var timer:FlxTimer = new FlxTimer();
					timer.start(Registry.summonCooldown, 1, function fn():void {
						cooldownLane1 = true;
						summon1Bt.alpha = 1;
					});
				}
			});
			summon1Bt.loadGraphic(spawnBtImg);
			add(summon1Bt);
			
			summon2Bt = new FlxButton(2, 290, null, function fn():void {
				if (Registry.gold >= Registry.allyCost && cooldownLane2 == true)
				{
					var ally2:Ally = new Ally(2);
					ally2.health = Ally.healthMax;
					allyGroup.add(ally2);
					allyGroup.add(ally2.healthBar);
					Registry.gold -= Registry.allyCost;
					goldText.text = "Gold: " + Registry.gold.toString();
					Registry.numOfAllyLane2++;
					numOfAllyLane2Text.text = Registry.numOfAllyLane2.toString();
					
					cooldownLane2 = false;
					
					var timer:FlxTimer = new FlxTimer();
					timer.start(Registry.summonCooldown, 1, function fn():void {
						cooldownLane2 = true;
					});
				}
			});
			summon2Bt.loadGraphic(spawnBtImg);
			add(summon2Bt);
			
			summon3Bt = new FlxButton(2, 425, null, function fn():void {
				if (Registry.gold >= Registry.allyCost && cooldownLane3 == true)
				{
					var ally3:Ally = new Ally(3);
					ally3.health = Ally.healthMax;
					allyGroup.add(ally3);
					allyGroup.add(ally3.healthBar);
					Registry.gold -= Registry.allyCost;
					goldText.text = "Gold: " + Registry.gold.toString();
					Registry.numOfAllyLane3++;
					numOfAllyLane3Text.text = Registry.numOfAllyLane3.toString();
					
					cooldownLane3 = false;
					
					var timer:FlxTimer = new FlxTimer();
					timer.start(Registry.summonCooldown, 1, function fn():void {
						cooldownLane3 = true;
					});
				}
			});
			summon3Bt.loadGraphic(spawnBtImg);
			add(summon3Bt);
			
		//------------------------------------
		
		
		//upgrade allies
			allyLevelText = new FlxText(280, 10, 90, "Level: " + Registry.allyLevel.toString());
			allyLevelText.setFormat("Arial", 16, 0xffffffff, "center");
			add(allyLevelText);
			
			upgradeBt = new FlxButton(270 - 20, 0, "Upgrade", function fn():void {
				if (Registry.gold >= Registry.upgradeGoldRequire && Registry.allyLevel < 5 && checkGameOver == false)
				{
					//increase strength
					Ally.healthMax += 4;
					Registry.allyLevel += 1;
					//increase cost
					Registry.allyCost += 5;
					
					allyLevelText.text = "Level: " + Registry.allyLevel.toString();
					Registry.gold -= Registry.upgradeGoldRequire;
					goldText.text = "Gold: " + Registry.gold.toString();
					
					remove(upgradeBt);
				}
			});
			upgradeBt.label.setFormat("Arial", 12, 0xffffffff, "left");
			upgradeBt.loadGraphic(upgradeImg);
			upgradeBt.labelOffset.x = -10;
			upgradeBt.labelOffset.y = 25;
		//	upgradeBt.makeGraphic(75, 40, 0xff0080FF);
		//	add(upgradeBt);
			
			
		//-------------------------------------
		
		//enemyLevelText
			enemyLevelText = new FlxText(500, 10, 140, "Enemy: Level " + Registry.enemyLevel.toString());
			enemyLevelText.setFormat("Arial", 16, 0xffffffff, "center");
			add(enemyLevelText);
		//-------------------------------------------
		
		
		//display number of tanks
			numOfEnemyLane1Text = new FlxText(250, 68, 50, Registry.numOfEnemyLane1.toString());
			numOfEnemyLane1Text.setFormat("Arial", 16, 0xFFFF0000);
			add(numOfEnemyLane1Text);
			numOfEnemyLane2Text = new FlxText(250, 203, 50, Registry.numOfEnemyLane2.toString());
			numOfEnemyLane2Text.setFormat("Arial", 16, 0xFFFF0000);
			add(numOfEnemyLane2Text);
			numOfEnemyLane3Text = new FlxText(250, 338, 50, Registry.numOfEnemyLane3.toString());
			numOfEnemyLane3Text.setFormat("Arial", 16, 0xFFFF0000);
			add(numOfEnemyLane3Text);
			
			numOfAllyLane1Text = new FlxText(190, 68, 50, Registry.numOfAllyLane1.toString());
			numOfAllyLane1Text.setFormat("Arial", 16, 0xFF008000);
			add(numOfAllyLane1Text);
			numOfAllyLane2Text = new FlxText(190, 203, 50, Registry.numOfAllyLane2.toString());
			numOfAllyLane2Text.setFormat("Arial", 16, 0xFF008000);
			add(numOfAllyLane2Text);
			numOfAllyLane3Text = new FlxText(190, 338, 50, Registry.numOfAllyLane3.toString());
			numOfAllyLane3Text.setFormat("Arial", 16, 0xFF008000);
			add(numOfAllyLane3Text);
		//---------------------------------------------
		
		
		//summon reserve force
			reserveForceBt = new FlxButton(200 - 20, 0, "141 Force", function fn():void {
				if (reserveForceCd == true && checkGameOver == false)
				{
					reserveForceCd = false;
					
					var ally1:Ally = new Ally(1);
					ally1.health = Ally.healthMax;
					allyGroup.add(ally1);
					allyGroup.add(ally1.healthBar);
					Registry.numOfAllyLane1++;
					numOfAllyLane1Text.text = Registry.numOfAllyLane1.toString();
					
					var ally2:Ally = new Ally(2);
					ally2.health = Ally.healthMax;
					allyGroup.add(ally2);
					allyGroup.add(ally2.healthBar);
					Registry.numOfAllyLane2++;
					numOfAllyLane2Text.text = Registry.numOfAllyLane2.toString();
					
					var ally3:Ally = new Ally(3);
					ally3.health = Ally.healthMax;
					allyGroup.add(ally3);
					allyGroup.add(ally3.healthBar);
					Registry.numOfAllyLane3++;
					numOfAllyLane3Text.text = Registry.numOfAllyLane3.toString();
					
					remove(reserveForceBt);
					var timer:FlxTimer = new FlxTimer();
					timer.start(Registry.reserveForceCooldown, 1, function fn():void {
						reserveForceCd = true;
						add(reserveForceBt);
					});
				}
			});
			reserveForceBt.label.setFormat("Arial", 12, 0xffffffff, "left");
			reserveForceBt.labelOffset.y = 25;
			reserveForceBt.labelOffset.x = -15;
			reserveForceBt.loadGraphic(reserveForceImg);
			add(reserveForceBt);
		//---------------------------------------------
		
		//bomb group
			bombGroup = new FlxGroup();
			add(bombGroup);
			
		//---------------------------------------------
		
		//summon air support
			airSupportBt = new FlxButton(100 - 20, 0, "Air Support", function fn():void {
				if (airSupportCd == true && checkGameOver == false)
				{
					airSupportCd = false;
					remove(airSupportBt);
					
					plane = new Plane();
					add(plane);
					
					var timer:FlxTimer = new FlxTimer();
					timer.start(Registry.airSupportCooldown, 1, function fn():void {
						airSupportCd = true;
						add(airSupportBt);
					});
				}
			});
			airSupportBt.loadGraphic(planeImg, false, false);
			airSupportBt.label.setFormat("Arial", 12, 0xffffffff, "center");
			airSupportBt.labelOffset.y = 25;
			add(airSupportBt);
		//------------------------------------------------
		
			super.create();
		}
		
		override public function update():void
		{
		//pause
			if (FlxG.keys.justPressed("P"))
			{
				paused = !paused;
					
				if (paused == true)
				{
					pauseText = new FlxText(0, 230, 640, "Pausing...\nPress P to resume");
					pauseText.setFormat("Arial", 20, 0xFFFF0000, "center");
					add(pauseText);
				}
				else
					remove(pauseText);
			}
			
			if (paused == true)
				return pauseGroup.update();
		//---------------------------------------------------
			
		//gold grows over time
			if(checkGameOver == false)
			{	goldOverTime -= FlxG.elapsed;
				
				if (goldOverTime < 0)
				{
					Registry.gold++;
					goldText.text = "Gold: " + Registry.gold.toString();
					goldOverTime = 1;
				}
			}
		//-------------------------------------------------
		
		
		//if towers get hit by enemies
			FlxG.overlap(enemyBulletGroup, towerGroup, function fn(bullet:Bullet, tower:FlxSprite):void {
				bullet.kill();
				tower.health -= bullet.damage;
				
				if (tower.health <= 0 && switcher == true)
				{
					checkGameOver = true;
					switcher = false;
					var gameOverText:FlxText = new FlxText(0, 210, 640, "Game Over!\nPress ENTER to return to menu");
					gameOverText.setFormat("Arial", 30, 0xFFFF0000, "center");
					add(gameOverText);
					killThings();
					FlxG.music.stop();
					FlxG.play(gameOverMp3);
				}
			});
		//------------------------------------------------------
		
		
		//game over event
			if (checkGameOver == true && FlxG.keys.justPressed("ENTER"))
			{
				FlxG.fade(0xff000000, 0.5, function fn():void {
					resetThings();
					MenuState.replayMusicAllowed = true;
					FlxG.switchState(new MenuState);
				});
			}
		//-------------------------------------------------------
		
		
		//if allies get hit by enemies
			FlxG.overlap(enemyBulletGroup, allyGroup, function fn(bullet:Bullet, ally:Ally):void {
				bullet.kill();
				ally.health -= bullet.damage;
			});
		//-------------------------------------------------------
		
		
		//if enemies get hit by allies
			FlxG.overlap(allyBulletGroup, enemyGroup, function fn(bullet:Bullet, enemy:Enemy):void {
				bullet.kill();
				enemy.health -= bullet.damage;
			});
		//-------------------------------------------------------
		
		//effect for cooldown
			if (cooldownLane1 == false)
				remove(summon1Bt);
			else
				add(summon1Bt);
			
			if (cooldownLane2 == false)
				remove(summon2Bt);
			else
				add(summon2Bt);
				
			if (cooldownLane3 == false)
				remove(summon3Bt);
			else
				add(summon3Bt);
		//-------------------------------------------------------
		
		//effect for upgrade button
			if (Registry.gold >= Registry.upgradeGoldRequire && Registry.allyLevel < 5)
				add(upgradeBt);
			else
				remove(upgradeBt);
			
			
		//-------------------------------------------------------
		
			super.update();
		}
		
		
		private function killThings():void
		{
			enemyBulletGroup.kill();
			allyBulletGroup.kill();
			enemyGroup.kill();
			allyGroup.kill();
			
		}
		
		private function resetThings():void
		{
			Registry.gold = 100;
			Registry.allyLevel = 1;
			Registry.enemyLevel = 1;
			
			Registry.allyCost = 15;
			Ally.healthMax = 5;
			Enemy.healthMax = 5;
			
			Registry.numOfAllyLane1 = 0;
			Registry.numOfAllyLane2 = 0;
			Registry.numOfAllyLane3 = 0;
			
			Registry.numOfEnemyLane1 = 0;
			Registry.numOfEnemyLane2 = 0;
			Registry.numOfEnemyLane3 = 0;
		}
	}

}