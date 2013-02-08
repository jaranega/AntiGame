package com.antigame.states.menu
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import com.antigame.resources.AssetFactory;
	import com.antigame.resources.ResourceLoader;
	import com.antigame.utils.MenuFactory;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	
	public class MainMenu extends BaseMenu
	{
		
		protected var playButton:CitrusSprite;
		protected var settingsButton:CitrusSprite;
		
		protected var assetFactory:AssetFactory;
		
		public function MainMenu()
		{
			super(MAIN_MENU);
			
			this.assetFactory = AssetFactory.getInstance();
		}
		
		override public function initialize():void{
			super.initialize();
			
			var background:CitrusSprite = new CitrusSprite("back", {view: assetFactory.newImage("menuBackground"), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"titleLabel","MAIN MENU", 60, true, 200));		
			
			playButton = MenuFactory.createCenteredButton(this.stage, "playButton", "PLAY", 400);
			settingsButton = MenuFactory.createCenteredButton(this.stage, "settingsButton", "SETTINGS", 500);
			
			add(playButton);
			add(settingsButton);
			
		}
		
		override protected function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED)
			
			if(touch){
				if(touch.isTouching(playButton.view)){
					_showMenu.dispatch(BaseMenu.LEVEL_SELECTION_MENU);
				}
				if(touch.isTouching(settingsButton.view)){
					_showMenu.dispatch(BaseMenu.SETTINGS_MENU);
				}
			}
			
			/*switch(buttonName){
				case "playButton":
					_showMenu.dispatch(BaseMenu.LEVEL_SELECTION_MENU);
					break;
				case "settingsButton":
					_showMenu.dispatch(BaseMenu.SETTINGS_MENU);
					break; 
			}*/
		}
		
		
	}
}