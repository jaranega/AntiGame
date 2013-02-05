package
{
	import com.antigame.levels.BarcelonaLevel1;
	import com.antigame.levels.BarcelonaLevel2;
	import com.antigame.levels.BarcelonaLevelGameState;
	import com.antigame.resources.EmbeddedAssets;
	import com.antigame.resources.EmbeddedSounds;
	import com.antigame.states.MenuState;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(width="1280",height="800",frameRate="60",BackgroundColor="0xAA22CC")]
	public class AntiGame extends StarlingCitrusEngine
	{
		private var levelMC:MovieClip; 
		private var menuState:MenuState;
		
		public static var assetManager:AssetManager;
		
		public function AntiGame()
		{
			super();
			
			initialize();
			loadLevelManager();
		}
		
		private function initialize():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Starling.handleLostContext = true;
			setUpStarling(true,1,null);
			this.starling.addEventListener(Event.CONTEXT3D_CREATE, loadAssets);
			
			this.starling.stage.addEventListener(Event.RESIZE,onResize);
		}
		
		private function loadLevelManager():void
		{
			levelManager = new LevelManager(BarcelonaLevelGameState);
			levelManager.applicationDomain = ApplicationDomain.currentDomain;
			levelManager.onLevelChanged.add(onLevelChanged);
			levelManager.levels = [ [BarcelonaLevel1, "assets/levels/barcelonaLevel1.swf"], 
									[BarcelonaLevel2, "assets/levels/barcelonaLevel2.swf"] ];	
		}
		
		private function loadAssets(event:Event = null):void
		{
			assetManager = new AssetManager(1.0, true);
			assetManager.verbose = true;
			assetManager.enqueue(EmbeddedAssets);
			assetManager.enqueue(EmbeddedSounds);
			assetManager.loadQueue(loadAssetsProgress);
		}
		
		private function loadAssetsProgress(ratio:Number):void
		{
			trace("Loading assets, progress:", ratio);
			if (ratio == 1.0)
				startGame();
		}
		
		private function startGame():void
		{
			menuState=new MenuState();
			state = menuState;
			menuState.lvlEnded.add(gotoGame);	
		}
		
		private function gotoGame():void
		{
			levelManager.gotoLevel(0);
		}		
		
		
		private function onResize(event:Event, size:Point):void
		{
			trace("Point: " + size.x, ' - ',  size.y);
			trace("Before Resize: " + this.starling.viewPort.size.x, ' - ',  this.starling.viewPort.size.y);
			this.starling.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, this.starling.stage.stageWidth, this.starling.stage.stageHeight),
				new Rectangle(0, 0, size.x, size.y),
				ScaleMode.NO_BORDER);
			trace("After Resize: " + this.starling.viewPort.size.x, ' - ',  this.starling.viewPort.size.y);
			trace("StageStarling: " +  this.starling.stage.stageWidth, ' - ',   this.starling.stage.stageHeight);
		}

		
		
		private function onLevelChanged(level:BarcelonaLevelGameState):void 
		{
			state = level;
			level.lvlEnded.add(_nextLevel);
			level.restartLevel.add(_restartLevel);
		}
		
		private function _nextLevel():void
		{
			levelManager.nextLevel();
		}
		
		private function _restartLevel():void 
		{
			state = levelManager.currentLevel as IState;
		}
		
		public function changeLvl():void 
		{
			state = new BarcelonaLevelGameState(levelMC);
		}
	}
}

