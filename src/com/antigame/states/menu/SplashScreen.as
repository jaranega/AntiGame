package com.antigame.states.menu
{
	import citrus.objects.CitrusSprite;
	import com.antigame.utils.MenuFactory;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;
	import starling.display.Quad;
	
	public class SplashScreen extends BaseMenu
	{
		
		public var _splashScreenTimeout:Signal = new Signal();
		public var timedOut:Boolean = false;
		
		[Embed(source="/assets/imgs/splashScreen.png")]
		private var _splashScreen:Class;
		
		public function SplashScreen()
		{
			super(SPLASH_SCREEN);
		}
		
		override public function initialize():void{
			super.initialize();
			
			
			var background:CitrusSprite = new CitrusSprite("background", {view:new _splashScreen(), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			//add(MenuFactory.createCenteredLabel(this.stage,"label","¡¡SPLASH!!", 60, true));	
			
			//waitSomeSecondsAndShowLoadingScreen(1000);
		}
		
		private function waitSomeSecondsAndShowLoadingScreen(seconds:int):void{
			var downTimer:Timer = new Timer(seconds*1000, 1); // every second ten times and then complete         
			downTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			downTimer.start()
		}
		
		private function onTimerComplete(event:TimerEvent):void{
			this.timedOut = true;
			this._splashScreenTimeout.dispatch();
			
			/*if(DummyResourceLoader.getInstance().loadingEnded){
				_showMenu.dispatch(MAIN_MENU);
			}else{
				_showMenu.dispatch(LOADING_SCREEN);
			}*/
		}
		
		
	}
}