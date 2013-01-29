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
			
			
			trace ("vp1: "+Starling.current.viewPort);
			trace ("sf1: "+Starling.current.contentScaleFactor);
			gameState=new GameState();
			state = gameState;
			
			trace ("vp2: "+Starling.current.viewPort);
			trace ("sf2: "+Starling.current.contentScaleFactor);
			sound.addSound("music","../assets/sounds/break.mp3");
			
			this.starling.addEventListener(Event.CONTEXT3D_CREATE, context3DCreated);
			this.starling.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function context3DCreated(event:Event):void{
			trace(event.type);
		}
		
		
		private function onResize(event:Event, size:Point):void
		{
			trace ("vp3: "+Starling.current.viewPort);
			trace ("sf3: "+Starling.current.contentScaleFactor);
			
			//WARN: If you want to use ScaleMode.NO_BORDER, then you have to manually fix the vertical offset!
			this.starling.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, this.starling.stage.stageWidth, this.starling.stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.SHOW_ALL);
			
			trace ("vp4: "+Starling.current.viewPort);
			trace ("sf4: "+Starling.current.contentScaleFactor);
		}
		
	}
}

