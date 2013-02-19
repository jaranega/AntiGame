package com.antigame.states.menu
{
	import citrus.objects.CitrusSprite;
	
	import com.antigame.resources.AssetFactory;
	import com.antigame.utils.MenuFactory;
	
	import starling.display.Button;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class LevelSelectionMenu extends BaseMenu
	{
		
		protected var mainMenuButton:CitrusSprite;
		
		protected var level1Button:CitrusSprite;
		protected var level2Button:CitrusSprite;
		
		
		protected var assetFactory:AssetFactory;
		
		public function LevelSelectionMenu()
		{
			super(LEVEL_SELECTION_MENU);
			
			this.assetFactory = AssetFactory.getInstance();
		}
		
		override public function initialize():void{
			super.initialize();
			
			assetFactory.playBackgroundMusic("breakBass");
			//assetFactory.playBackgroundMusic("breakSong");
			
			var background:CitrusSprite = new CitrusSprite("back", {view: assetFactory.newImage("menuBackground"), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"titleLabel","LEVEL SELECTION", 60, 0xFFFFFF, true, 200));	
			
			level1Button = MenuFactory.createButton("lvl1", "Level 1", 0xFFFFFF, 200, 350);
			level2Button = MenuFactory.createButton("lvl2", "Level 2", 0xFFFFFF, 400, 350);
			
			var b:Button= assetFactory.newButton("playLogo");
	

		
			mainMenuButton = MenuFactory.createButton("mainMenuBtn", "MAIN MENU", 0xFFFFFF, 200, 700);
			
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
					assetFactory.playSoundOnce("ueagh");
					_startLevel.dispatch(level1Button.name);
				}
				
				if(touch.isTouching(level2Button.view)){
					assetFactory.playSoundOnce("ueagh");
					_startLevel.dispatch(level2Button.name);
				}
			}
			
		}
		
		
	}
}