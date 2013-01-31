package com.antigame.controller
{
	import citrus.core.CitrusEngine;
	
	import com.antigame.assets.DummyResourceLoader;
	import com.antigame.states.GameState;
	import com.antigame.states.LevelFailureScreen;
	import com.antigame.states.LevelLoadingScreen;
	import com.antigame.states.LevelSelectionMenu;
	import com.antigame.states.LevelSuccessScreen;
	import com.antigame.states.MainLoadingScreen;
	import com.antigame.states.MainMenu;
	import com.antigame.states.SettingsMenu;
	import com.antigame.states.SplashScreen;

	public class MenuNavigationManager
	{
		private var engine:CitrusEngine;
		
		
		
		private var splashScreen:SplashScreen;
		private var loadingScreen:MainLoadingScreen;
		private var mainMenu:MainMenu;
		private var levelSelectionMenu:LevelSelectionMenu;
		private var levelLoadingScreen:LevelLoadingScreen;
		private var game:GameState;
		private var levelSuccessScreen:LevelSuccessScreen;
		private var levelFailureScreen:LevelFailureScreen;
		private var settingsMenu:SettingsMenu;
		
		private var resourceLoader:DummyResourceLoader;
		
		public function MenuNavigationManager()
		{
			this.engine = CitrusEngine.getInstance();
		}
		
		public function showSplashAndLoadGame():void{
			if(!this.splashScreen){
				this.splashScreen = new SplashScreen();
			}

			//setup events from splashScreen
			this.splashScreen._splashScreenTimeout.addOnce(function():void{
				if(resourceLoader.loadingEnded){
					showMainMenu();
				}else{
					showLoadingScreen();
				}
			});
			engine.state = this.splashScreen;
			
			
			this.resourceLoader = DummyResourceLoader.getInstance();
			this.resourceLoader.loadResources();
			this.resourceLoader._loadSuccess.addOnce(function():void{
				showMainMenu();
			});
				
		}
		
		public function showLoadingScreen():void{
			if(!this.loadingScreen)
				this.loadingScreen = new MainLoadingScreen();
			
			engine.state = this.loadingScreen;
			
			//no events to handle
		}
		
		public function showMainMenu():void{
			if(!this.splashScreen.timedOut){
				//wait till the splash screen disapears
				return;
			}
			
			if(!this.resourceLoader.loadingEnded){
				//wait till the resources are loaded
				return;
			}
			
			
			if(!this.mainMenu) 
				this.mainMenu = new MainMenu();
			
			engine.state = this.mainMenu;
			
			
			//setup events from mainMenu
			this.mainMenu._gotoLevelSelection.add(function():void{
				showLevelSelection();
			});
			
			this.mainMenu._gotoSettingsMenu.add(function():void{
				showSettingsMenu();
			});
		}
		
		public function showLevelSelection():void{
			if(!this.levelSelectionMenu) 
				this.levelSelectionMenu = new LevelSelectionMenu();
			
			engine.state = this.levelSelectionMenu;
		}
		
		public function showSettingsMenu():void{
			if(!this.settingsMenu) this.settingsMenu = new SettingsMenu();
			
			engine.state = this.settingsMenu;
		}
	
		public function loadLevel():void{
			if(!this.levelLoadingScreen) 
				this.levelLoadingScreen = new LevelLoadingScreen();
			
			engine.state = this.levelLoadingScreen;
		}
	
		private function showGame():void{
			if(!this.game) 
				this.game = new GameState();
			
			engine.state = this.game;
		}
		
		
	}
}