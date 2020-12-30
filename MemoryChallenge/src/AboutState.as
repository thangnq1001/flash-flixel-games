package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	
	public class AboutState extends FlxState
	{
		private var starfield:StarfieldFX;
		
		public function AboutState() 
		{
			
		}
		
		override public function create():void
		{
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0.2, 0.1);
			add(starfield.create(0, 0, 640, 480));
			
			MenuState.replayMusicAllowed = false;
			
			var title:FlxText = new FlxText(0, 50, 640, "ABOUT");
			title.setFormat("Gabriola", 55, 0xFFFF0000, "center");
			add(title);
			
			var aboutText:FlxText = new FlxText(80, 180, 460);
			aboutText.text = "Author:\t\tNONONO - A Noob Game Maker :D\n";
			aboutText.text += "Email:\t\tthangnq1001@gmail.com\n";
			aboutText.text += "Tools used:\tFlashDevelop + Flixel";
			aboutText.setFormat("Arial", 20, 0xFFFFFFFF, "left");
			add(aboutText);
			
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