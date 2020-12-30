package 
{
	/**
	 * ...
	 * @author thangnq
	 */
	import org.flixel.*
	
	public class Letter extends FlxText
	{
		public var keyCode:int;
		
		[Embed(source = "data/ARIAL.TTF", fontName = "Arial", embedAsCFF = "false", mimeType = "application/x-font")]
		private var fontClass:Class;
		
		public function Letter(x:Number, y:Number) 	//A -Z: 65 - 90
		{
			super(x, y, 40);
			setFormat("Arial", 40, 0xFFFFFFFF, "center");
			velocity.x = 80;
			
			keyCode = Math.floor((Math.random() * 1000)) % 26 + 65;
			
			switch(keyCode)
			{
				case 65:
					text = "A"; break;
				case 66:
					text = "B"; break;
				case 67:
					text = "C"; break;
				case 68:
					text = "D"; break;
				case 69:
					text = "E"; break;
				case 70:
					text = "F"; break;
				case 71:
					text = "G"; break;
				case 72:
					text = "H"; break;
				case 73:
					text = "I"; break;
				case 74:
					text = "J"; break;
				case 75:
					text = "K"; break;
				case 76:
					text = "L"; break;
				case 77:
					text = "M"; break;
				case 78:
					text = "N"; break;
				case 79:
					text = "O"; break;
				case 80:
					text = "P"; break;
				case 81:
					text = "Q"; break;
				case 82:
					text = "R"; break;
				case 83:
					text = "S"; break;
				case 84:
					text = "T"; break;
				case 85:
					text = "U"; break;
				case 86:
					text = "V"; break;
				case 87:
					text = "W"; break;
				case 88:
					text = "X"; break;
				case 89:
					text = "Y"; break;
				case 90:
					text = "Z"; break;
				default:
					break;
			}
		}
		
		override public function update():void
		{
			if (x > FlxG.width)
			{
				kill();
				PlayState.HP--;
				PlayState.HPText.text = "HP: " + PlayState.HP.toString();
				
				FlxG.shake(0.002, 0.2);
			}
			super.update();
		}
		
	}

}