package com.antigame.states.menu
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import com.antigame.utils.MenuFactory;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class LevelFailureScreen extends BaseMenu
	{
		public function LevelFailureScreen()
		{
			super(LEVEL_FAILURE_SCREEN);
			
		}
		
		override public function initialize():void{
			super.initialize();
			
			var background:CitrusSprite = new CitrusSprite("back", {view:new Quad(stage.stageWidth, stage.stageHeight, 0xFFFFFF), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"titleLabel","LEVEL FAILED", 60, 0xFFFFFF, true, 150));		
		}
	}
}