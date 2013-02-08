package com.antigame.states.menu
{
	import citrus.objects.CitrusSprite;
	
	import com.antigame.resources.ResourceLoader;
	import com.antigame.utils.MenuFactory;
	
	import flash.media.SoundChannel;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class LevelSelectionMenu extends BaseMenu
	{
		
		protected var mainMenuButton:CitrusSprite;
		
		protected var level1Button:CitrusSprite;
		protected var level2Button:CitrusSprite;
		
		[Embed(source="/assets/imgs/splashScreen.png")]
		private var _splashScreen:Class;
		
		public var soundChannel:SoundChannel;
		
		protected var assetManager:AssetManager;
		
		public function LevelSelectionMenu()
		{
			super(LEVEL_SELECTION_MENU);
			
			this.assetManager = ResourceLoader.getInstance().assetManager;
		}
		
		override public function initialize():void{
			super.initialize();
			
			soundChannel = ResourceLoader.getInstance().assetManager.playSound("breakBass",1,10000);
			
			var background:CitrusSprite = new CitrusSprite("back", {view: new _splashScreen(), width:stage.stageWidth, height:stage.stageHeight});
			add(background);
			
			add(MenuFactory.createCenteredLabel(this.stage,"titleLabel","LEVEL SELECTION", 60, true, 200));	
			
			level1Button = MenuFactory.createButton("lvl1", "Level 1", 200, 350);
			level2Button = MenuFactory.createButton("lvl2", "Level 2", 400, 350);
			
			var b:Button=new Button(assetManager.getTexture("playLogo"));
			b.addEventListener(Event.TRIGGERED,go);
			addChild(b);
			b.x=stage.stageWidth/2-b.width/2;
			b.y=stage.stageHeight/2-b.height/2;
		
			mainMenuButton = MenuFactory.createButton("mainMenuBtn", "MAIN MENU", 200, 700);
			
			add(level1Button);
			add(level2Button);
			add(mainMenuButton);
		}
		
		override protected function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED)
			
				
			if(touch){
				soundChannel.stop();
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
		
		private function go(e:Event):void
		{
			soundChannel.stop();
			soundChannel = assetManager.playSound("ueagh",1,0);
			_startLevel.dispatch(level1Button.name);
		}
	}
}