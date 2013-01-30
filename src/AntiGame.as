package
{
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	
	import com.antigame.states.GameState;
	import com.antigame.states.MainLoadingState;
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	//1024x768 es la resolución de un iPad
	[SWF(width="1024",height="768",frameRate="60", backgroundColor="0x000000")]
	public class AntiGame extends StarlingCitrusEngine
	{
		private var gameState:GameState;
		private var loadingState:MainLoadingState;
		
		private var loadResourcesSuccessSignal:Signal = new Signal();
		
		public function AntiGame()
		{
			super();
			Starling.handleLostContext = true;
			setUpStarling(true,1,null);
			this.starling.showStatsAt("left","top",4);
			
			loadingState = new MainLoadingState();
			
			state = loadingState;
			
			
			loadResources();
			loadResourcesSuccessSignal.add(onResourcesLoadedHandler);
			
			
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
		
		private function loadResources():void{
			gameState=new GameState();
			gameState.loadResources();
		
			var downTimer:Timer = new Timer(2000, 1); // every second ten times and then complete         
			downTimer.addEventListener(TimerEvent.TIMER_COMPLETE, loadResourcessHandler);
			downTimer.start()
		}
		
		private function loadResourcessHandler(event:TimerEvent):void{
			this.loadResourcesSuccessSignal.dispatch();
		}
		
		private function onResourcesLoadedHandler():void{
			this.loadResourcesSuccessSignal.remove(onResourcesLoadedHandler);
			this.state = this.gameState;
		}
		
	}
}

