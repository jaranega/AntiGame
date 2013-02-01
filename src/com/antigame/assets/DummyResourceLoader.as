package com.antigame.assets
{
	
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.math.MathUtils;
	import citrus.math.MathVector;
	
	import com.antigame.utils.Math2;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	
	/**
	 * @author Aymeric
	 */
	public class DummyResourceLoader {
	
		public var _loadSuccess:Signal = new Signal();
		public var loadingEnded:Boolean = false;
	
		
		private static var instance:DummyResourceLoader;
		
		public function DummyResourceLoader(e:Enforcer){
			
		}
		
		public static function getInstance():DummyResourceLoader{
			if(!instance){
				instance = new DummyResourceLoader(new Enforcer());
			}
			
			return instance;
		}
		
		public function loadResources():void{
			
			//images
			
			//sounds
			CitrusEngine.getInstance().sound.addSound("music","../assets/sounds/break.mp3");
			
			//simulate 1 to 4 seconds of resource loading, and lauch Signal
			var downTimer:Timer = new Timer(Math2.random(2,5)*1000, 1);     
			downTimer.addEventListener(TimerEvent.TIMER_COMPLETE, loadResourcessHandler);
			downTimer.start()
		}
		
		private function loadResourcessHandler(event:TimerEvent):void{
			this.loadingEnded = true;
			this._loadSuccess.dispatch();
		}
		
	
	}
	
	
	
}

class Enforcer{
	
}