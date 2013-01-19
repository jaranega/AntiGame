package
{
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	
	import com.antigame.states.GameState;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
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
			
			this.starling.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(event:Event, size:Point):void
		{
			Starling.current.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.NO_BORDER);
		}
		
	}
}

