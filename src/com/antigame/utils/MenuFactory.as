package com.antigame.utils
{
	import citrus.core.CitrusObject;
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	
	import starling.text.TextField;

	public class MenuFactory
	{
		public function MenuFactory()
		{
		}
		
		public static function createCenteredLabel(state:StarlingState, labelId:String, text:String, heightFactor:Number, fontSize:Number=60, bold:Boolean=false):CitrusSprite{
			var textField:TextField=new TextField(600, 100, text,"Verdana",fontSize, 0x0, bold);
			textField.autoScale=true;
			
			var label:CitrusSprite=new CitrusSprite("label",{view:textField, 
																x:(state.stage.stageWidth>>1)-(textField.width>>1), 
																y:state.stage.stageHeight*heightFactor-(textField.height>>1),
																width:0, 
																height:0
															});
			
			return label;
		}
		
	}
}