package 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author thangnq
	 */
	public class TowerGroup extends FlxGroup
	{
		[Embed(source = "data/tower.png")]
		private var towerImg:Class;
		
		public function TowerGroup() 
		{
			var tower1:FlxSprite = new FlxSprite(2, 68 - 10, towerImg);
			add(tower1);
			
			var tower2:FlxSprite = new FlxSprite(2, 203 - 10, towerImg);
			add(tower2);
			
			var tower3:FlxSprite = new FlxSprite(2, 338 - 10, towerImg);
			add(tower3);
			
			//health bar (tower)
			tower1.health = 30;
			var towerHealthBar1:FlxBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 30, 5, tower1, "health", 0, 30, true);
			towerHealthBar1.trackParent(0, -3);
			add(towerHealthBar1);
			
			tower2.health = 30;
			var towerHealthBar2:FlxBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 30, 5, tower2, "health", 0, 30, true);
			towerHealthBar2.trackParent(0, -3);
			add(towerHealthBar2);
			
			tower3.health = 30;
			var towerHealthBar3:FlxBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 30, 5, tower3, "health", 0, 30, true);
			towerHealthBar3.trackParent(0, -3);
			add(towerHealthBar3);
		}
		
	}

}