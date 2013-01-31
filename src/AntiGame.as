package
{
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	
	import com.antigame.controller.MenuNavigationManager;
	import com.antigame.states.GameState;
	import com.antigame.states.MainLoadingScreen;
	
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
		private var navigationManager:MenuNavigationManager;
		
		
		public function AntiGame()
		{
			super();
			Starling.handleLostContext = true;
			setUpStarling(true,1,null);
			this.starling.showStatsAt("left","top",4);
			this.starling.stage.addEventListener(Event.RESIZE, onResize);
			
			
			this.navigationManager = new MenuNavigationManager();
			this.navigationManager.showSplashAndLoadGame();
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

