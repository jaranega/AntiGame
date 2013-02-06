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
	
	public class LevelSelectionMenu extends BaseMenu
	{
		
		protected var mainMenuButton:CitrusSprite;
		
		protected var level1Button:CitrusSprite;
		protected var level2Button:CitrusSprite;
		
		public function LevelSelectionMenu()
		{
			super(LEVEL_SELECTION_MENU);
			
		}
		
		override public function initialize():void{
			super.initialize();
			
			var background:CitrusSprite = new CitrusSprite("back", {view:new Quad(stage.stageWidth, stage.stageHeight, 0xFFFFFF), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"titleLabel","LEVEL SELECTION", 60, true, 200));	
			
			level1Button = MenuFactory.createButton("lvl1", "Level 1", 200, 350);
			level2Button = MenuFactory.createButton("lvl2", "Level 2", 400, 350);
		
			mainMenuButton = MenuFactory.createButton("mainMenuBtn", "MAIN MENU", 200, 700);
			
			add(level1Button);
			add(level2Button);
			add(mainMenuButton);
		}
		
		override protected function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED)
			
			if(touch){
				if(touch.isTouching(mainMenuButton.view)){
					_showMenu.dispatch(BaseMenu.MAIN_MENU);
				}
				
				if(touch.isTouching(level1Button.view)){
					_startLevel.dispatch(level1Button.name);
				}
				
				if(touch.isTouching(level2Button.view)){
					_startLevel.dispatch(level2Button.name);
				}
			}
			
		}
	}
}