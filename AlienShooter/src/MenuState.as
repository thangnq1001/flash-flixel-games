package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	import org.flixel.plugin.photonstorm.FX.StarfieldFX
	import org.flixel.plugin.photonstorm.FlxSpecialFX
	
	public class MenuState extends FlxState 
	{
		
		[Embed(source = "data/button.jpg")]
		private var imgButton:Class;
		
		private var starfield:StarfieldFX;
		
		public function MenuState() 
		{
			FlxG.mouse.show();
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
				FlxG.addPlugin(new FlxSpecialFX);

			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0.2, 0.1);
			add(starfield.create(0, 0, 640, 480));
			
			var title:FlxText = new FlxText(0, 100, 640, "Alien Shooter");
			title.setFormat(null, 50, 0xFFFF0000, "center");
			add(title);
			
			var pressEnter:FlxText = new FlxText(0, 180, 640, "Press ENTER to play");
			pressEnter.setFormat(null, 20, 0xffffffff, "center");
			add(pressEnter);
			
			var tutorial:FlxText = new FlxText(220, 330, 200, "Move:\tWASD\nFire:\tSpace\nPause:\tP");
			tutorial.setFormat(null, 20, 0xffffffff);
			add(tutorial);
			
			//add buttons
			var easyBt:FlxButton = new FlxButton(150, 250, "Easy", function setEasy():void {
					PlayState.alienHPMax = 2;
					startPlay();
				});
			easyBt.loadGraphic(imgButton, false, false, 100, 40);
			easyBt.label.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(easyBt);
			
			var mediumBt:FlxButton = new FlxButton(270, 250, "Medium", function setMedium():void {
					PlayState.alienHPMax = 3;
					startPlay();
				});
			mediumBt.loadGraphic(imgButton, false, false, 100, 40);
			mediumBt.label.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(mediumBt);
			
			var hardBt:FlxButton = new FlxButton(390, 250, "Hard", function setHard():void {
					PlayState.alienHPMax = 4;
					startPlay();
				});
			hardBt.loadGraphic(imgButton, false, false, 100, 40);
			hardBt.label.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(hardBt);
		}
		
		private function startPlay():void
		{
			//0.5s fade time before play
			FlxG.fade(0xff000000, 0.5, function startPlay():void {
					starfield.destroy();
					FlxG.switchState(new PlayState);
				});
			FlxG.mouse.hide();
		}
	}

}