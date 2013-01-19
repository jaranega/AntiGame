package
{
	import com.antigame.levels.ALevel;
	import com.antigame.levels.Level1;
	import com.antigame.levels.Level2;
	import com.antigame.states.GameState;
	
	import flash.display.MovieClip;
	import flash.events.Event;
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
			
			levelManager = new LevelManager(ALevel);
			levelManager.applicationDomain = ApplicationDomain.currentDomain; // to be able to load your SWF level on iOS
			levelManager.onLevelChanged.add(onLevelChanged);
			levelManager.levels = [[Level1, "assets/levels/nivel1.swf"],[Level2, "assets/levels/nivel1.swf"]];
			levelManager.gotoLevel();
			
			/*gameState=new GameState();
			state = gameState;
			sound.addSound("music","../assets/sounds/break.mp3");*/
		}
		
		private function onLevelChanged(level:ALevel):void 
		{
			state = level;
			level.lvlEnded.add(_nextLevel);
			level.restartLevel.add(_restartLevel);
		}
		
		private function _nextLevel():void
		{
			levelManager.nextLevel();
		}
		
		private function _restartLevel():void 
		{
			state = levelManager.currentLevel as IState;
		}
		
		public function changeLvl():void 
		{
			state = new ALevel(levelMC);
		}
		
		private function onResize(event:Event):void
		{
			/*Starling.current.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.SHOW_ALL);*/
		}
	}
}

