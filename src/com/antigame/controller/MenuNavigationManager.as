package com.antigame.controller
{
	import com.antigame.levels.BarcelonaLevelGameState;
	import com.antigame.states.menu.BaseMenu;
	import com.antigame.states.menu.LevelFailureScreen;
	import com.antigame.states.menu.LevelSelectionMenu;
	import com.antigame.states.menu.LevelSuccessScreen;
	import com.antigame.states.menu.MainLoadingScreen;
	import com.antigame.states.menu.MainMenu;
	import com.antigame.states.menu.SettingsMenu;
	import com.antigame.states.menu.SplashScreen;
	
	import citrus.core.CitrusEngine;
	import citrus.core.IState;

	public class MenuNavigationManager
	{
		private var engine:CitrusEngine;
		
		public function MenuNavigationManager()
		{
			this.engine = CitrusEngine.getInstance();
		}
		
		public function gotoMenu(menuID:String):void{
			switch(menuID)
			{
				case BaseMenu.SPLASH_SCREEN:
					showMenu(new SplashScreen());
					break;
				
				case BaseMenu.LOADING_SCREEN:
					showMenu(new MainLoadingScreen());
					break;
				
				case BaseMenu.MAIN_MENU:
					showMenu(new MainMenu());
					break;
				
				case BaseMenu.SETTINGS_MENU:
					showMenu(new SettingsMenu());
					break;
				
				case BaseMenu.LEVEL_SELECTION_MENU:
					showMenu(new LevelSelectionMenu());
					break;
				
				case BaseMenu.LEVEL_SUCCESS_SCREEN:
					showMenu(new LevelSuccessScreen());
					break;
				
				case BaseMenu.LEVEL_FAILURE_SCREEN:
					showMenu(new LevelFailureScreen());
					
					break;
					
				default:
					break;
			}
		}
		
		private function showMenu(menu:BaseMenu):void{
						
			engine.state = menu;
			
			menu._showMenu.add(gotoMenu);
			menu._startLevel.add(gotoLevel);
		}
		
		public function startGame():void
		{
			
		}
		
		public function gotoLevel(levelID:String):void{
			
			var gameLevel:IState; 
			
			switch(levelID){
				case "lvl1":
					//gameLevel = new GameState();
					engine.levelManager.gotoLevel(0);
					break;
				case "lvl2":
					//no level;
					engine.levelManager.gotoLevel(1);
					break;
					
			}
			//loadLevel(gameLevel);
		}

		
		public function onLevelChanged(level:BarcelonaLevelGameState):void 
		{
			this.engine.state = level;
			level.lvlEnded.add(_nextLevel);
			level.restartLevel.add(_restartLevel);
		}
		
		private function _nextLevel():void
		{
			this.engine.levelManager.nextLevel();
		}
		
		private function _restartLevel():void 
		{
			this.engine.state = this.engine.levelManager.currentLevel as IState;
		}
		
	}
}