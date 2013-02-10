package
{

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	
	import com.antigame.controller.MenuNavigationManager;
	import com.antigame.levels.BarcelonaLevel1;
	import com.antigame.levels.BarcelonaLevel2;
	import com.antigame.levels.BarcelonaLevelGameState;
	import com.antigame.resources.ResourceLoader;
	import com.antigame.states.menu.BaseMenu;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(width="1280",height="800",frameRate="60", backgroundColor="0x0")]
	public class AntiGame extends StarlingCitrusEngine
	{
		private var navigationManager:MenuNavigationManager;
		
		public function AntiGame()
		{
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			Starling.handleLostContext = true;
			setUpStarling(true,1,null);
			this.starling.showStatsAt("left","top",3);
			this.starling.addEventListener(Event.CONTEXT3D_CREATE, setupLevelsAndLoadAssets);
			this.starling.stage.addEventListener(Event.RESIZE,onResize);
			
			
			this.navigationManager = new MenuNavigationManager();
			this.navigationManager.gotoMenu(BaseMenu.SPLASH_SCREEN);
			
			
		}
		
		private function setupLevelsAndLoadAssets():void{
			setupLevelManager();
			loadAssets();
		}
		
		private function setupLevelManager():void
		{
			levelManager = new LevelManager(BarcelonaLevelGameState); 
			levelManager.applicationDomain = ApplicationDomain.currentDomain;
			levelManager.onLevelChanged.add(this.navigationManager.onLevelChanged);
			levelManager.levels = [ [BarcelonaLevel1, "assets/levels/barcelonaLevel1.swf"], 
				[BarcelonaLevel2, "assets/levels/barcelonaLevel2.swf"] ];	
		}
		
		private function loadAssets():void{
			var resourceLoader:ResourceLoader = ResourceLoader.getInstance();
			resourceLoader.loadResources();
			resourceLoader._loadSuccess.addOnce(onResourcesLoaded);
		}
		
		private function onResourcesLoaded():void{
			if((this.state as BaseMenu).menuID == BaseMenu.SPLASH_SCREEN){
				//wait for the splash to go out
			}else{
				this.navigationManager.gotoMenu(BaseMenu.MAIN_MENU);
			}
		}
		
		
		
		private function onResize(event:Event, size:Point):void
		{
			trace("Point: " + size.x, ' - ',  size.y);
			trace("Before Resize: " + this.starling.viewPort.size.x, ' - ',  this.starling.viewPort.size.y);
			this.starling.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, this.starling.stage.stageWidth, this.starling.stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.SHOW_ALL);
			trace("After Resize: " + this.starling.viewPort.size.x, ' - ',  this.starling.viewPort.size.y);
			trace("StageStarling: " +  this.starling.stage.stageWidth, ' - ',   this.starling.stage.stageHeight);
		}
		
	}
}

