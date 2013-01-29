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
	
	[SWF(width="1024",height="768",frameRate="60",BackgroundColor="0xAA22CC")]
	public class AntiGame extends StarlingCitrusEngine
	{
		private var gameState:GameState;
		private var levelMC:MovieClip; 
		
		public function AntiGame()
		{
			super();
			Starling.handleLostContext = true;
			setUpStarling(true,1,null);
			this.starling.showStatsAt("left","top",4);
			
			
			gameState=new GameState();
			state = gameState;
			
			sound.addSound("music","../assets/sounds/break.mp3");
			
			this.starling.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		
		private function onResize(event:Event, size:Point):void
		{
			
			//WARN: If you want to use ScaleMode.NO_BORDER, then you have to manually fix the vertical offset!
			this.starling.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, this.starling.stage.stageWidth, this.starling.stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.SHOW_ALL);
			
		}
		
	}
}

