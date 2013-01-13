package
{
	import com.antigame.states.GameState;
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	[SWF(width="1200",height="680",frameRate="60",BackgroundColor="0xAA22CC")]
	public class AntiGame extends StarlingCitrusEngine
	{
		public var gameState:GameState;
		
		public function AntiGame()
		{
			super();
			setUpStarling(true,1,null);
			
			gameState=new GameState();
			state = gameState;
			
			sound.addSound("music","../assets/sounds/break.mp3");
		}
	}
}

