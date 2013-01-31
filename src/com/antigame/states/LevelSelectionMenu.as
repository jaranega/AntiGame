package com.antigame.states
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class LevelSelectionMenu extends StarlingState
	{
		public function LevelSelectionMenu()
		{
			super();
			
		}
		
		override public function initialize():void{
			super.initialize();
			
			var ancho:Number = stage.stageWidth;
			var alto:Number = stage.stageHeight;
			
			var loadingText:TextField=new TextField(ancho, alto,"LEVEL_SELECTION","Verdana",60,0x000000,true);
			loadingText.autoScale=true;
			
			var background:CitrusSprite = new CitrusSprite("back", {view:new Quad(ancho, alto, 0xFFFFFF),width:ancho,height:alto});
			
			var loadingLabel:CitrusSprite=new CitrusSprite("label",{view:loadingText, x:stage.stageWidth>>1, y:stage.stageHeight*0.2 ,width:ancho, height:alto});
			
			add(background);
			add(loadingLabel);
		}
	}
}