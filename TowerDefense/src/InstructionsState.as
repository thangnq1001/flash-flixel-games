package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	
	public class InstructionsState extends FlxState
	{
		public function InstructionsState() 
		{
			
		}
		
		override public function create():void
		{
			MenuState.replayMusicAllowed = false;
			
			var title:FlxText = new FlxText(0, 50, 640, "TUTORIAL");
			title.setFormat("Gabriola", 55, 0xFFFF0000, "center");
			add(title);
			
			var summonIcon:FlxSprite = new FlxSprite(155, 220, PlayState.spawnBtImg);
			add(summonIcon);
			
			var instructionsText:FlxText = new FlxText(100, 150, 440);
			instructionsText.text = "Our ancient towers are under attack by a powerful tank army. You, the commander, must hold your defense lines at all cost.\n";
			instructionsText.text += "Click\tto summon a tank\nRemember to call Air support, 141 force and upgrade your tanks.";
			instructionsText.setFormat("Arial", 20, 0xFFFFFFFF, "left");
			add(instructionsText);
			
			var backBt:FlxButton = new FlxButton(640 / 2 - 190 / 2, 340, "Back", function back():void {
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