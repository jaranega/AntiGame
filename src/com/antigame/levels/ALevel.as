package com.antigame.levels
{
	import flash.display.MovieClip;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Cannon;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	import org.osflash.signals.Signal;
	
	public class ALevel extends StarlingState
	{
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		protected var _level:MovieClip;
		
		public function ALevel(level:MovieClip = null) {
			super();
			_level = level;		
			lvlEnded = new Signal();
			restartLevel = new Signal();
			
			// Useful for not forgetting to import object from the Level Editor
			var objectsUsed:Array = [Hero, Platform, Cannon, Coin];
		}
		
		override public function initialize():void {
			super.initialize();

			var box2d:Box2D = new Box2D("Box2D");
			box2d.visible = true;
			add(box2d);
			ObjectMaker2D.FromMovieClip(_level);
		}
	}
}