package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import flash.events.KeyboardEvent;
	import org.flixel.*
	
	public class PlayState extends FlxState 
	{
		private var letterGroup:FlxGroup;
		
		private var paused:Boolean;
		private var pauseGroup:FlxGroup;
		private var pauseMsg:FlxText;		//pause message
		
		private var spawnInterval:Number = 1;
		private var spawnTimer:Number;
		public static var minInterval:Number;
		public static var intervalReduceAmount:Number;
		private var changeAllowed:Boolean = true;
		private var bonusAllowed:Boolean = true;
		
		private var keyPressed:int;		//keycode of key just pressed
		private var scoreText:FlxText;
		private var intervalText:FlxText;
		
		private var checkGameOver:Boolean = false;
		
		public static var HP:int;
		public static var HPText:FlxText;
		
		[Embed(source = "data/background.mp3")]
		private var backgroundMp3:Class;
		
		[Embed(source = "data/gameOver.mp3")]
		private var gameOverMp3:Class;
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void
		{
			HP = 5;
			
			FlxG.score = 0;
			
			letterGroup = new FlxGroup();
			add(letterGroup);
			
			paused = false;
			pauseGroup = new FlxGroup();
			
			spawnTimer = spawnInterval;
			
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			scoreText = new FlxText(5, 5, 220, "Score: " + FlxG.score.toString());
			scoreText.setFormat("Arial", 20, 0xFFFFFFFF, "left");
			add(scoreText);
			
			intervalText = new FlxText(280, 5, 160, "Rate: " + spawnTimer.toString() + "s");
			intervalText.setFormat("Arial", 20, 0xFFFFFFFF, "left");
			add(intervalText);
			
			HPText = new FlxText(640 - 8 - 140, 5, 140, "HP: " + HP.toString());
			HPText.setFormat("Arial", 20, 0xFFFFFFFF, "right");
			add(HPText);
			
			FlxG.playMusic(backgroundMp3, 1.0);
			
			super.create();
		}
		
		override public function update():void
		{
			if (checkGameOver == false) //when game is not over yet
			{
				FlxG.mute = false;
				
				//pause game
				if (FlxG.keys.justPressed("ESCAPE"))
				{
					paused = !paused;
					
					if (paused)
					{
						pauseMsg = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Pausing...\nPress Esc to resume");
						pauseMsg.setFormat("Arial", 20, 0xFFFFFFFF, "center");
						add(pauseMsg);
					}
					else
						remove(pauseMsg);
				}
				
				if (paused)
					return pauseGroup.update();
					
				//--------------------------------------------------------------
				
				
				
				spawnTimer -= FlxG.elapsed;		//countdown the timmer
				
				
				//create letters
				if (spawnTimer < 0)
				{
					var x:Number = 0;
					var y:Number = Math.random() * (FlxG.height - 100) + 50;
					var letter:Letter = new Letter(x, y);
					letterGroup.add(letter);
					
					spawnTimer = spawnInterval;		//reset timer
				}
				//--------------------------------------------------------------
				
				
				//reduce interval to  increase difficult level
				if (FlxG.score != 0 && FlxG.score % 10 == 0 && changeAllowed && spawnInterval - 0.0001 > minInterval) //idk why spawnInterval is kind of = 0.70000001
				{																									//so if spawnInterval = 0.4, it actually = 0.400001 
					changeAllowed = false;																			//so need to -0.01 to make spawnInterval < minInterval at 0.4 level
					spawnInterval -= intervalReduceAmount;
					intervalText.text = "Rate: " + spawnInterval.toFixed(3) + "s";
				}
				
				if (FlxG.score % 10 != 0)
					changeAllowed = true;
				//--------------------------------------------------------------
				
				
				//keyboard event
				for (var i:int = 0; i < letterGroup.length; i++)		
					if (letterGroup.members[i].keyCode == keyPressed && letterGroup.members[i].alive)
					{
						FlxG.score++;									
						letterGroup.members[i].kill();
						scoreText.text = "Score: " + FlxG.score.toString();
						break;	//can only kill 1 letter (the oldest letter)
					}
					
				keyPressed = -1;	//reset keyPressed
				//---------------------------------------------------------------
				
				
				//bonus HP
				if (FlxG.score > 0 && FlxG.score % 50 == 0 && bonusAllowed == true)
				{
					bonusAllowed = false;
					HP++;
					HPText.text = "HP: " + HP.toString();
				}
					
				if (FlxG.score % 50 != 0)
					bonusAllowed = true;
				//----------------------------------------------------------------
				
				
				//game over event
				if (HP == 0)
				{
					checkGameOver = true;
					HP--;
					var gameOverText:FlxText = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Game over!\nPress ENTER to play again.");
					gameOverText.setFormat("Arial", 20, 0xffffffff, "center");
					add(gameOverText);
					letterGroup.kill();

					FlxG.music.stop();
					FlxG.play(gameOverMp3, 1.0);
				}
				//----------------------------------------------------------------
				
				super.update();
			}
			//end if(game is not over yet)-----------------------------------------
			
			
			//after game over
			if (FlxG.keys.justPressed("ENTER") && HP == -1 && checkGameOver)
				FlxG.switchState(new MenuState);
			//------------------------------------------------------------------
		}
		
		private function keyDownHandler(event:KeyboardEvent):void 
		{
			keyPressed = event.keyCode;
		}
		
	}

}