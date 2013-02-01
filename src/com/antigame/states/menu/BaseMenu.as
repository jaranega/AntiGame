package com.antigame.states.menu
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import com.antigame.utils.MenuFactory;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
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
		
		public function BaseMenu(menuID:String)
		{
			super();
			
			this.menuID = menuID;
			
		}
		
		override public function initialize():void{
			super.initialize();
		}
		
		override public function destroy():void{
			
			_showMenu.removeAll();
			_startLevel.removeAll();
			
			super.destroy();
		}
		
	}
}