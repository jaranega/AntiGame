package com.antigame.states
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import org.osflash.signals.Signal;
	
	import starling.text.TextField;
	
	public class LoadingState extends StarlingState
	{
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		private var box2D:Box2D;
		
		public function LoadingState(level:MovieClip = null)
		{
			super();
			
			lvlEnded = new Signal();
			restartLevel = new Signal();
		}
		
		override public function initialize():void{
			super.initialize();
			
			this.touchable=true;
			box2D = new Box2D("box2D");
			add(box2D);

			var text:TextField=new TextField( stage.stageWidth, stage.stageHeight, 
												"LOADING...","Verdana",60,0x000000,true);
			text.autoScale=true;
			
			var textSprite:CitrusSprite = new CitrusSprite("fons", {view:text, width:stage.stageWidth, height:stage.stageHeight});
			add(textSprite);
			
			setTimeout(onClicked,2000);
		}
		
		private function onClicked(event:MouseEvent = null):void
		{
			lvlEnded.dispatch();
		}
	}
}