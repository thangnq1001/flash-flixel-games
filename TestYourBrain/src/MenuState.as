package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	
	public class MenuState extends FlxState
	{
		[Embed(source = "data/button.jpg")]
		private var imgButton:Class;
		
		public function MenuState() 
		{
			FlxG.mouse.show();
			FlxG.mute = true;
			
			var title:FlxText = new FlxText(0, 100, FlxG.width, "TYPING MASTER");
			title.setFormat("Arial", 40, 0xFFFFFFFF, "center");
			add(title);
			

			var easyButton:FlxButton = new FlxButton(150, 200, "Easy", function setEasy():void {
					PlayState.minInterval = 0.4;
					PlayState.intervalReduceAmount = 0.05;
					startPlay();
				});
			easyButton.loadGraphic(imgButton, false, false, 100, 40);
			easyButton.label.setFormat("Arial", 21, 0xffffffff, "center");
			add(easyButton);
				
			var mediumButton:FlxButton = new FlxButton(270, 200, "Medium", function setMedium():void {
					PlayState.minInterval = 0.34;
					PlayState.intervalReduceAmount = 0.055;
					startPlay();
				});
			mediumButton.loadGraphic(imgButton, false, false, 100, 40);
			mediumButton.label.setFormat("Arial", 21, 0xffffffff, "center");
			add(mediumButton);
			
			var hardButton:FlxButton = new FlxButton(390, 200, "Hard", function setHard():void {
					PlayState.minInterval = 0.28;
					PlayState.intervalReduceAmount = 0.06;
					startPlay();
				});
			hardButton.loadGraphic(imgButton, false, false, 100, 40);
			hardButton.label.setFormat("Arial", 21, 0xffffffff, "center");
			add(hardButton);
			
			
			var introText:FlxText = new FlxText(10, 280, FlxG.width - 10, "Type all the keys moving on the screen to prevent them from reaching the right border");
			introText.setFormat("Arial", 20, 0xffffffff, "center");
			add(introText);
			
			var tutText:FlxText = new FlxText(220, 350, 300, "\nPress Esc to Pause\nPress +/- to +/- volume");
			tutText.setFormat("Arial", 20, 0xffffffff, "left");
			add(tutText);
			
			var authorText:FlxText = new FlxText(5, 448, FlxG.width, "Author: NONONO\nthangnq1001@gmail.com");
			authorText.setFormat("Arial", 12, 0xffffffff, "left");
			add(authorText);
		}
		
		public function startPlay():void
		{
			FlxG.fade(0xff000000, 0.5, function play():void {
					FlxG.switchState(new PlayState);
				});
			FlxG.mouse.hide();
		}
	}

}