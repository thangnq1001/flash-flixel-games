package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	import org.flixel.plugin.photonstorm.FX.StarfieldFX
	import org.flixel.plugin.photonstorm.FlxSpecialFX
	
	public class PlayState extends FlxState
	{
		[Embed(source = "data/Bullet.MP3")]
		private var bulletSound:Class;
		
		[Embed(source = "data/Explosion.MP3")]
		private var explosionSound:Class;
		
		[Embed(source = "data/GameOver.mp3")]
		private var gameOverSound:Class;
		
		private var _ship: Ship;		//ship object
		private var _aliens: FlxGroup;	//group of aliens
		private var _spawnTimer: Number;	//used in spawnAlien()
		private var _spawnInterval: Number = 2.5;	//_spawnTimer's value
		private var _bullets: FlxGroup;	//group of bullets
		private var _scoreText: FlxText;	
		private var _gameOverText: FlxText;
		private var paused:Boolean;			//check if P is pressed
		private var pauseGroup:FlxGroup;	//to pause
		private var pauseMsg:FlxText;
		private var healthText: FlxText;
		private var alienHPText: FlxText;
		private var upgradeText: FlxText;
		private var alienHP: int = 1;				
		private var alienSpeedIncrease: int = 0;	//amount of speed increase per level
		private var changeAllowed:Boolean = true; 	//check if difficult level is allowed to change
		public static var alienHPMax:int;			//also the max difficult level
		
		private var starfield:StarfieldFX;
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void
		{
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0.2, 0.1);
			add(starfield.create(0, 0, 640, 480));
			
			_ship = new Ship();
			_ship.maxVelocity.x = _ship.maxVelocity.y = 200;
			add(_ship);
			
			_aliens = new FlxGroup();
			add(_aliens);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			resetSpawnTimer();
			
			FlxG.score = 0;
			_scoreText = new FlxText(10, 8, 200, "Score: 0");
			_scoreText.setFormat(null, 20, 0xFF597137, "left");
			add(_scoreText);
			
			healthText = new FlxText(520, 8, 100, "HP: 3");
			healthText.setFormat(null, 20, 0xFF597137, "right");
			add(healthText);
			
			alienHPText = new FlxText(200, 8, 260, "Alien's HP: 1");
			alienHPText.setFormat(null, 20, 0xFF597137, "center");
			add(alienHPText);
			
			upgradeText = new FlxText(10, 420, 300, "Lv 1\nGet 70 to Lv2");
			upgradeText.setFormat(null, 20, 0xFF597137, "left");
			add(upgradeText);
			
			paused = false;
			pauseGroup = new FlxGroup();
			
			super.create();
		}
		
		override public function update():void
		{
			//pause game
			if (FlxG.keys.justPressed("P"))
			{
				paused = !paused;
				
				if (paused == true)
				{
					pauseMsg = new FlxText(0, FlxG.height/2 - 50, FlxG.width, "Pausing...\nPress P to continue\n");
					pauseMsg.setFormat(null, 20, 0xFF597137, "center");
					add(pauseMsg);
				}
				
				if (paused == false)
					remove(pauseMsg);
			}
			if (paused)
				return pauseGroup.update();
			
			//collision; Can use FlxG.overlap(_aliens, _bullets, overlapAlienBullet)
			FlxG.overlap(_aliens, _bullets, overlapAlienBullet); 
			FlxG.collide(_aliens, _ship, overlapAlienShip);
			
			//shoot
			if (FlxG.keys.justPressed("SPACE") && !_ship.dead)
				spawnBullet(_ship.x + 36, _ship.y + 12);
				
			_spawnTimer -= FlxG.elapsed; //reduce spawning interval
			
			if (_spawnTimer < 0)
			{
				spawnAlien();
				resetSpawnTimer();
			}
			
			if (FlxG.keys.ENTER && _ship.dead)
			{
				starfield.destroy();
				FlxG.switchState(new MenuState);
			}
			
			//increase difficult level
			if (FlxG.score > 0 && FlxG.score % 50 == 0 && changeAllowed)
			{
				changeAllowed = false;
				if (alienHP < alienHPMax)
				{
					alienHP++;
					alienHPText.text = "Alien's HP: " + alienHP.toString();
				}
				alienSpeedIncrease += 20;
			}
			
			if (FlxG.score % 50 != 0)
				changeAllowed = true;
			
			if (FlxG.score == 70)
				upgradeText.text = "Level 2\nGet 250 to Lv3";
			
			if (FlxG.score == 250)
			{
				upgradeText.y = 450;
				upgradeText.text = "Level 3";
			}
				
			super.update();
		}
		
		
		private function spawnAlien():void
		{
			var x: Number = FlxG.width;
			var y: Number = Math.random() * (FlxG.height - 100) + 50;
			var alien_temp:Alien = new Alien(x, y);
			
			alien_temp.hp = alienHP;
			alien_temp.velocity.x -= alienSpeedIncrease;
			
			_aliens.add(alien_temp);
		}
		
		//reset timer for a new alien
		private function resetSpawnTimer():void
		{
			_spawnTimer = _spawnInterval;
			_spawnInterval *= 0.95;
			
			//0.3 is max interval
			if (_spawnInterval < 0.3)
				_spawnInterval = 0.3;
		}
		
		private function spawnBullet(x: Number, y: Number):void 
		{
			var bullet: Bullet = new Bullet(x, y, 1000, 0);
			_bullets.add(bullet);
			
			//if score >= 70, add 2 more bullets
			if (FlxG.score >= 70)
			{
				var bulletTop1: Bullet = new Bullet(x, y, 1000, -150);
				var bulletBottom1:Bullet = new Bullet(x, y, 1000, 150);
				_bullets.add(bulletTop1);
				_bullets.add(bulletBottom1);
			}
			if (FlxG.score >= 250)
			{
				var bulletTop2: Bullet = new Bullet(x, y, 1000, -250);
				var bulletBottom2: Bullet = new Bullet(x, y, 1000, 250);
				_bullets.add(bulletTop2);
				_bullets.add(bulletBottom2);
			}
			
			FlxG.play(bulletSound);
		}
		
		private function overlapAlienBullet(alien: Alien, bullet: Bullet):void
		{
			if (alien.hp == 1)
			{
				alien.kill();
				bullet.kill();
				FlxG.score += 1;
				_scoreText.text = "Score: " + FlxG.score.toString();
				
				if (FlxG.score > 0 && FlxG.score % 50 == 0)
					_ship.hp++;
				healthText.text = "HP: " + _ship.hp.toString();
					
				FlxG.play(explosionSound);
				
				var emitter:FlxEmitter = createEmitter();
				emitter.at(alien);
			}
			else
			{
				bullet.kill();
				alien.hp--;
			}
		}
		
		private function overlapAlienShip(alien: Alien, ship: Ship):void 
		{
			if (ship.hp == 1)
			{
				healthText.text = "0";
				ship.kill();
				alien.kill();
				ship.dead = true;
				_gameOverText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "GAME OVER\nPRESS ENTER TO PLAY AGAIN");
				_gameOverText.setFormat(null, 16, 0xFF597137, "center");
				add(_gameOverText);
				FlxG.play(explosionSound);
				FlxG.play(gameOverSound);
			}
			else
			{
				alien.kill();
				ship.hp--;
				healthText.text = "HP: " + ship.hp.toString();
				FlxG.play(explosionSound);
			}
			var emitter:FlxEmitter = createEmitter();
			emitter.at(ship);
			emitter.at(alien);
		}
		
		private function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.gravity = 0;
			emitter.maxRotation = 1000;
			emitter.setXSpeed(-400, 400);
			emitter.setYSpeed(-400, 400);
			var n:int = 10;
			for (var i:int = 0; i < n; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(3, 5, 0xFF597137);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
	}

}