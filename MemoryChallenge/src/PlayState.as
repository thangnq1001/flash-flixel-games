package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.RainbowLineFX;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	
	public class PlayState extends FlxState 
	{
		[Embed(source = "data/gameOver.mp3")]
		private var gameOverMp3:Class;
		
		[Embed(source = "data/completed.mp3")]
		private var completedMp3:Class;
		
		public static var targetLeftText:FlxText;
		public static var targetLeft:int;
	
		public static var clickLimit:int;
		public static var clickLimitText:FlxText;
		private var levelText:FlxText;
		
		public static var checkGameOver:Boolean;
		private var checkCompleted:Boolean = false;
		
		private var switcher:Boolean = false;	//something is allowed to run once only (use if and change value of switcher)
		private var switcher2:Boolean = false;
		
		private var newGameAllowed:Boolean = false; //to set a delay time (1s) before switching to a new game
		
		private var levelGroup:Level;
		
		private var starfield:StarfieldFX;
		
		private var rainbow:RainbowLineFX;
		private var rainbow2:RainbowLineFX;
		public static var checkHint:Boolean;
		private var hintText:FlxText;
		
		public function PlayState() 
		{

		}
		
		override public function create():void
		{
			checkGameOver = false;
			
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0.2, 0.1);
			add(starfield.create(0, 0, 640, 480));
			
			checkHint = false;
			
			clickLimit = SelectModeState.limit;
			targetLeft = 5;
			
			FlxG.mouse.hide();
			FlxG.music.play();
		
			levelGroup = new Level(Registry.level);
			add(levelGroup);
			
			targetLeftText = new FlxText(5, -10, 300, "Target Left: " + targetLeft.toString());
			targetLeftText.setFormat("Gabriola", 25, 0xffffffff, "left");
			add(targetLeftText);
			
			levelText = new FlxText(5, -10, 630, "Level: " + Registry.level.toString());
			levelText.setFormat("Gabriola", 25, 0xffffffff, "center");
			add(levelText);
			
			clickLimitText = new FlxText(5, -10, 630, "Click Limit: " + clickLimit.toString());
			clickLimitText.setFormat("Gabriola", 25, 0xffffffff, "right");
			add(clickLimitText);
			var timer:FlxTimer = new FlxTimer();
			timer.start(2, 1, function fn():void {
				hintText = new FlxText(0, 15, 640, "Click here to get a hint");
				hintText.setFormat("Gabriola", 25, 0xffffffff, "center");
				add(hintText);
				rainbow = FlxSpecialFX.rainbowLine();
				add(rainbow.create(0, 28, 640, 2, null, 360, 2, 1, 0, 0xff000000));
				
				rainbow2 = FlxSpecialFX.rainbowLine();
				add(rainbow2.create(0, 53, 640, 2, null, 360, 2, 1, 0, 0xff000000));
				rainbow2.setDirection(1);
			});
			
			
			
			
			super.create();
		}
		
		override public function update():void		
		{
			if (!checkCompleted && !checkGameOver)
			{
				if (targetLeft > clickLimit && !switcher)	//game over
				{
					checkGameOver = true;
					ClickTarget.clickAllowed = false;
					switcher = true;
					
					var timer:FlxTimer = new FlxTimer();
					timer.start(1.5, 1, function temp():void {
						newGameAllowed = true;
						var gameOverText:FlxText = new FlxText(0, 170, 640, "Game Over\nClick to play again\nPress Esc to return to main menu");
						gameOverText.setFormat("Gabriola", 30, 0xffffffff, "center");
						add(gameOverText);
					});
					
					
					FlxG.music.stop();
					FlxG.play(gameOverMp3);
					
				}
				
				
				if (targetLeft == 0 && clickLimit >= targetLeft && !switcher)	//level completed
				{
					checkCompleted = true;
					ClickTarget.clickAllowed = false;
					switcher = true;
					
					var timer2:FlxTimer = new FlxTimer();
					timer2.start(1, 1, function temp2():void {
						newGameAllowed = true;
						var completedText:FlxText = new FlxText(0, 170, 640, "Level Completed!\nClick to go to next level\nPress Esc to return to main menu");
						completedText.setFormat("Gabriola", 30, 0xffffffff, "center");
						add(completedText);
					});
					
					
					FlxG.play(completedMp3);
				}
			}
			
			
			if (checkGameOver && FlxG.mouse.justPressed() && newGameAllowed)	//click to replay
			{
				Registry.level = 1;
				FlxG.fade(0xff000000, 0.5, function switchState():void {
					starfield.destroy();
					rainbow.destroy();
					rainbow2.destroy();
					FlxG.switchState(new PlayState);
				});
				
			}
			
			if ((checkGameOver || checkCompleted) && FlxG.keys.justPressed("ESCAPE") && newGameAllowed)	//Esc to return to menu
			{
				Registry.level = 1;
				MenuState.replayMusicAllowed = true;
				FlxG.fade(0xff000000, 0.5, function switchState():void {
					starfield.destroy();
					rainbow.destroy();
					rainbow2.destroy();
					FlxG.switchState(new MenuState);
				});
			}
			
			if (checkCompleted && FlxG.mouse.justPressed() && newGameAllowed)	//click to go to next level
			{
				Registry.level++;
				FlxG.fade(0xff000000, 0.5, function switchState():void {
					starfield.destroy();
					rainbow.destroy();
					rainbow2.destroy();
					FlxG.switchState(new PlayState);
				});
			}
			
			if (checkHint == false && FlxG.mouse.justPressed() && FlxG.mouse.y <= 53 && FlxG.mouse.y >= 28 && ClickTarget.clickAllowed)
			{
				ClickTarget.clickAllowed = false;
				remove(hintText);
				rainbow.destroy();
				rainbow2.destroy();
				checkHint = true;
			}
			
			super.update();
		}
		
	}

}