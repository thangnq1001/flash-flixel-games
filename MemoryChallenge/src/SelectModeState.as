package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	
	public class SelectModeState extends FlxState
	{
		public static var limit:int;
		private var starfield:StarfieldFX;
		
		public function SelectModeState() 
		{
			
		}
		
		override public function create():void
		{
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0.2, 0.1);
			add(starfield.create(0, 0, 640, 480));
			
			MenuState.replayMusicAllowed = false;
			
			var title:FlxText = new FlxText(0, 50, 640, "SELECT DIFFICULT LEVEL");
			title.setFormat("Gabriola", 55, 0xFFFF0000, "center");
			add(title);
			
			var easyBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 170, "Easy", function easy():void {
				limit = 10;
				FlxG.fade(0xff000000, 0.5, function play():void {
					starfield.destroy();
					FlxG.switchState(new PlayState);
				});
			});
			easyBt.loadGraphic(MenuState.imgButton, false, false, 190, 50);
			easyBt.label.setFormat("Gabriola", 29.4, 0xFFFF0000, "center");
			easyBt.labelOffset.y = -5;
			add(easyBt);
			
			var mediumBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 245, "Medium", function medium():void {
				limit = 9;
				FlxG.fade(0xff000000, 0.5, function play():void {
					starfield.destroy();	
					FlxG.switchState(new PlayState);
				});
			});
			mediumBt.loadGraphic(MenuState.imgButton, false, false, 190, 50);
			mediumBt.label.setFormat("Gabriola", 29.4, 0xFFFF0000, "center");
			mediumBt.labelOffset.y = -5;
			add(mediumBt);
			
			var hardBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 320, "Hard", function hard():void {
				limit = 8;
				FlxG.fade(0xff000000, 0.5, function play():void {
					starfield.destroy();
					FlxG.switchState(new PlayState);
				});
			});
			hardBt.loadGraphic(MenuState.imgButton, false, false, 190, 50);
			hardBt.label.setFormat("Gabriola", 29.4, 0xFFFF0000, "center");
			hardBt.labelOffset.y = -5;
			add(hardBt);
			
			var backBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 400, "Back", function back():void {
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