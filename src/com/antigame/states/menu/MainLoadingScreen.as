package com.antigame.states.menu
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import com.antigame.utils.MenuFactory;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class MainLoadingScreen extends BaseMenu
	{
		
	
		
		public function MainLoadingScreen()
		{
			super(LOADING_SCREEN);
			
		}
		
		override public function initialize():void{
			super.initialize();
			
			
			var background:CitrusSprite = new CitrusSprite("back", {view:new Quad(stage.stageWidth, stage.stageHeight, 0xFFFFFF), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"loadingLabel","LOADING...", 60, 0x0, true));		
		}
		
		
	}
}