package com.antigame.states
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import com.antigame.utils.MenuFactory;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class MainMenu extends StarlingState
	{
		
		public var _gotoLevelSelection:Signal = new Signal();
		public var _gotoSettingsMenu:Signal = new Signal();
		
		
		public function MainMenu()
		{
			super();
			
		}
		
		override public function initialize():void{
			super.initialize();
			
			var background:CitrusSprite = new CitrusSprite("back", {view:new Quad(stage.stageWidth, stage.stageHeight, 0xFFFFFF), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this,"titleLabel","MAIN MENU", 0.2, 60, true));		
			
		}
		
		
	}
}