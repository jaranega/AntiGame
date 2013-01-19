package
{
	import com.antigame.levels.ALevel;
	import com.antigame.levels.Level1;
	import com.antigame.levels.Level2;
	import com.antigame.states.GameState;
	
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	
	import starling.core.Starling;
	
	[SWF(width="1280",height="705",frameRate="60",BackgroundColor="0xAA22CC")]
	public class AntiGame extends StarlingCitrusEngine
	{
		private var gameState:GameState;
		private var levelMC:MovieClip; 
		
		public function AntiGame()
		{
			super();
			Starling.handleLostContext = true;
			setUpStarling(true,1,null);
			
			gameState=new GameState();
			state = gameState;
			sound.addSound("music","../assets/sounds/break.mp3");
			
		}
	}
}

