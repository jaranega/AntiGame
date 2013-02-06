package com.antigame.states.menu
{
	import citrus.core.starling.StarlingState;
	
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import starling.events.TouchEvent;
	
	/* inspired on "Game Structure" blog post http://pzuh.blogspot.com.es/2012/10/citrus-engine-game-structure.html */
	public class BaseMenu extends StarlingState
	{
		public static const SPLASH_SCREEN:String = "SPLASH_SCREEN";
		public static const LOADING_SCREEN:String = "LOAD_GAME";
		public static const MAIN_MENU:String = "MAIN_MENU";
		public static const SETTINGS_MENU:String = "SETTINGS_MENU";
		public static const LEVEL_SELECTION_MENU:String = "LEVEL_SELECTION_MENU";
		public static const LEVEL_SUCCESS_SCREEN:String = "LEVEL_SUCCESS_SCREEN";
		public static const LEVEL_FAILURE_SCREEN:String = "LEVEL_FAILURE_SCREEN";
		
		public var menuID:String;
		
		public var _showMenu:Signal = new Signal(String); //String here is "menu_id"
		public var _startLevel:Signal= new Signal(String); //String here is "level_id"
		
		protected var flashMenu:MovieClip;      
		
		public function BaseMenu(menuID:String)
		{
			super();
			this.menuID = menuID;
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			if(flashMenu){
				this.flashMenu.addEventListener(MouseEvent.CLICK, onMouseClick);
			}
		}
		
		override public function initialize():void{
			super.initialize();
		}
		
		override public function destroy():void{
			
			_showMenu.removeAll();
			_startLevel.removeAll();
			
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
			
			if(flashMenu){
				this.flashMenu.removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			super.destroy();
		}
		
		protected function onTouch(event:TouchEvent):void
		{
			//a concrete implementation of this method  need to be defined in child classes
		}
		
		protected function onMouseClick(event:TouchEvent):void
		{
			//a concrete implementation of this method  need to be defined in child classes
		}  
		
	}
}