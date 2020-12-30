package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	
	public class InstructionsState extends FlxState
	{
		private var starfield:StarfieldFX;
		
		public function InstructionsState() 
		{
			
		}
		
		override public function create():void
		{
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0.2, 0.1);
			add(starfield.create(0, 0, 640, 480));
			
			MenuState.replayMusicAllowed = false;
			
			var title:FlxText = new FlxText(0, 50, 640, "TUTORIAL");
			title.setFormat("Gabriola", 55, 0xFFFF0000, "center");
			add(title);
			
			var instructionsText:FlxText = new FlxText(100, 150, 440);
			instructionsText.text = "5 squares will appear and be visible for only 2 seconds. After that, you must find their positions and click on them to clear the level.\n";
			instructionsText.text += "There are only 10 (easy), 9 (medium) or 8 (hard) chances to click.\nThe size of the squares will decrease per level.\nRemember to get a hint when u need.\nGood luck!";
			instructionsText.setFormat("Arial", 20, 0xFFFFFFFF, "left");
			add(instructionsText);
			
			var backBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 340, "Back", function back():void {
				starfield.destroy();
				FlxG.switchState(new MenuState);
			});
			backBt.loadGraphic(MenuState.imgButton, false, false, 190, 50);
			backBt.label.setFormat("Gabriola", 30, 0xFFFF0000, "center");
			backBt.labelOffset.y = -5;
			add(backBt);
			
			super.create();
		}
		
	}

}