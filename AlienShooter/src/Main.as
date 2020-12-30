package
{
	import org.flixel.*
	[Frame(factoryClass = "Preloader")]
	/**
	 * ...
	 * @author thangnq
	 */
	public class Main extends FlxGame 
	{
		
		public function Main() 
		{
			super(640, 480, MenuState, 1, 120, 60);
		}
		
	}
	
}