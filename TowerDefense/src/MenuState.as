package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*;

	
	public class MenuState extends FlxState
	{
		[Embed(source="data/ARIAL.TTF", fontName = "Arial", embedAsCFF = "false", mimeType = "application/x-font")]
		private var fontClass:Class;
		
		[Embed(source="data/GABRIOLA.TTF", fontName = "Gabriola", embedAsCFF = "false", mimeType = "application/x-font")]
		private var fontClass2:Class;
		
		[Embed(source = "data/button_2.jpg")]
		public static var imgButton:Class;
		
		[Embed(source = "data/menu.mp3")]
		private var backgroundMp3:Class;
		
		public static var replayMusicAllowed:Boolean = true;
		
		
		public function MenuState() 
		{
			
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
			
			if(replayMusicAllowed)
				FlxG.playMusic(backgroundMp3);
			
			var title:FlxText = new FlxText(0, 50, 640, "DEFENSE OF THE TOWERS");
			title.setFormat("Gabriola", 55, 0xFFFF0000, "center");
			add(title);
			
			var playBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 170, "Play", function play():void {
					FlxG.fade(0xff000000, 0.5, function fn():void {
						FlxG.switchState(new PlayState);
					});
				});
			playBt.loadGraphic(imgButton, false, false, 190, 50);
			playBt.label.setFormat("Gabriola", 30, 0xFFFF0000, "center");
			playBt.labelOffset.y = -5;
			add(playBt);
			
			var instructionsBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 245, "Tutorial", function instructions():void {
					FlxG.switchState(new InstructionsState);
				});
			instructionsBt.loadGraphic(imgButton, false, false, 190, 50);
			instructionsBt.label.setFormat("Gabriola", 30, 0xFFFF0000, "center");
			instructionsBt.labelOffset.y = -5;
			add(instructionsBt);
			
			var aboutBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 320, "About", function about():void {
					FlxG.switchState(new AboutState);
				});
			aboutBt.loadGraphic(imgButton, false, false, 190, 50);
			aboutBt.label.setFormat("Gabriola", 30, 0xFFFF0000, "center");
			aboutBt.labelOffset.y = -5;
			add(aboutBt);
			
			super.create();
		}
		
	}

}