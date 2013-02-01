package com.antigame.controller
{
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	
	import com.antigame.assets.DummyResourceLoader;
	import com.antigame.states.GameState;
	import com.antigame.states.menu.BaseMenu;
	import com.antigame.states.menu.LevelFailureScreen;
	import com.antigame.states.menu.LevelSelectionMenu;
	import com.antigame.states.menu.LevelSuccessScreen;
	import com.antigame.states.menu.MainLoadingScreen;
	import com.antigame.states.menu.MainMenu;
	import com.antigame.states.menu.SettingsMenu;
	import com.antigame.states.menu.SplashScreen;

	public class MenuNavigationManager
	{
		private var engine:CitrusEngine;
		
	
		
		private var resourceLoader:DummyResourceLoader;
		
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
		
		
		public function gotoLevel(levelID:String):void{
			
			var gameLevel:IState; 
			switch(levelID){
				case "lvl1":
					gameLevel = new GameState();
					break;
				case "lvl2":
					//no level;
					break;
					
			}
			
			loadLevel(gameLevel)
		}

		public function loadLevel(state:IState):void{
			if(!state)
				return;
			
			//setup game level
			
			//add game level
			this.engine.state = state;
		}
	
		
		
		
	}
}