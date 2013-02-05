package com.antigame.states
{
	import flash.media.SoundChannel;
	
	import citrus.core.starling.StarlingState;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class MenuState extends StarlingState
	{
		
		public var lvlEnded:Signal;
		public var soundChannel:SoundChannel;
		
		public function MenuState()
		{
			super();
			
			lvlEnded = new Signal();
			
			soundChannel = AntiGame.assetManager.playSound("breakTheLawBass",1,10000);
			addEventListener(Event.ADDED_TO_STAGE,added);
			
		}
		
		private function added():void
		{
			var fondo:Image=new Image(AntiGame.assetManager.getTexture("splashScreen"));
			addChild(fondo);
			
			var b:Button=new Button(AntiGame.assetManager.getTexture("playLogo"));
			b.addEventListener(Event.TRIGGERED,go);
			addChild(b);
			b.x=stage.stageWidth/2-b.width/2;
			b.y=stage.stageHeight/2-b.height/2;
		}
		
		private function go(e:Event):void
		{
			soundChannel.stop();
			soundChannel = AntiGame.assetManager.playSound("ueagh",1,0);
			lvlEnded.dispatch();
		}
		
	}
}