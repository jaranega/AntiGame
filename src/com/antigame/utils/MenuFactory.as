package com.antigame.utils
{
	import citrus.core.CitrusObject;
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	
	import starling.display.Button;
	import starling.display.Stage;
	import starling.text.TextField;

	public class MenuFactory
	{
		
		public static function createCenteredLabel(stage:Stage, labelId:String, text:String, fontSize:Number=60, bold:Boolean=false, y:Number = -1):CitrusSprite{
			var center:Number = stage.stage.stageWidth/2;
			
			return createLabel(labelId, text, fontSize, bold, center, y>-1 ? y : stage.stage.stageHeight/2)
		}
		
		public static function createLabel(labelId:String, text:String, fontSize:Number=60, bold:Boolean=false, x:Number = -1, y:Number = -1):CitrusSprite{
			var textField:TextField=new TextField(600, 100, text,"Verdana",fontSize, 0x0, bold);
			textField.autoScale=true;
			
			var label:CitrusSprite=new CitrusSprite(labelId, {view:textField, 
				x:x - textField.width/2, 
				y:y - textField.height/2,
				width:0, 
				height:0
			});
			
			return label;
		}
		
	
		
		public static function createCenteredButton(stage:Stage, buttonId:String, text:String, y:Number = -1):CitrusSprite{
			var center:Number = stage.stage.stageWidth/2;
			
			return createButton(buttonId, text, center, y>-1 ? y : stage.stage.stageHeight/2)
		}
		
		public static function createButton(buttonId:String, text:String, x:Number = -1, y:Number = -1):CitrusSprite{
			//creates a label button
			var textField:TextField=new TextField(300, 100, text,"Verdana",40, 0x0, true);
			textField.autoScale=true;
			
			var button:CitrusSprite=new CitrusSprite(buttonId, {view:textField, 
				x:x - textField.width/2, 
				y:y - textField.height/2,
				width:0, 
				height:0
			});
			
			return button;
			
			//creates a Starling button (faltan las texturas)
			/*
			var button:Button = new Button(null, text, null);
			
			var sprite:CitrusSprite=new CitrusSprite(buttonId,{view:button, 
				x:x - button.width/2, 
				y:y - button.height/2,
				width:0, 
				height:0
			});
			
			return sprite;
			*/
		}
		
		
		
	}
}