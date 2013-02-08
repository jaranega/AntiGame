package com.antigame.states.menu
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import com.antigame.utils.MenuFactory;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class SettingsMenu extends BaseMenu
	{
		protected var mainMenuButton:CitrusSprite;
		
		public function SettingsMenu()
		{
			super(SETTINGS_MENU);
			
		}
		
		override public function initialize():void{
			super.initialize();
			
			var background:CitrusSprite = new CitrusSprite("back", {view:new Quad(stage.stageWidth, stage.stageHeight, 0xFFFFFF), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"titleLabel","SETTINGS MENU", 60, 0xFFFFFF, true, 200));	
			
			mainMenuButton = MenuFactory.createButton("mainMenuBtn", "MAIN MENU", 0xFFFFFF, 200, 700);
			
			add(mainMenuButton);
		}
		
		override protected function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED)
			
			if(touch){
				if(touch.isTouching(mainMenuButton.view)){
					_showMenu.dispatch(BaseMenu.MAIN_MENU);
				}
			}
			
		}
	}
}