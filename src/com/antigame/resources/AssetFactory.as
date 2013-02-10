package com.antigame.resources
{
	import citrus.view.starlingview.StarlingTile;
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class AssetFactory {
		
		public var assetManager:AssetManager;
		
		
		private static var instance:AssetFactory;
		
		public function AssetFactory(e:Enforcer){
			assetManager = ResourceLoader.getInstance().assetManager;
		}
		
		public static function getInstance():AssetFactory{
			if(!instance){
				instance = new AssetFactory(new Enforcer());
			}
			
			return instance;
		}
		
		public function newImage(textureName:String):Image{
			return new Image(assetManager.getTexture(textureName));
		}
		
		public function newButton(upTextureName:String, text:String = "", downTextureName:String = null):Button{
			var upTexture:Texture = assetManager.getTexture(upTextureName);
			var downTexture:Texture;
			
			if(downTextureName){
				downTexture = assetManager.getTexture(downTextureName);
			}else{
				downTexture = null;
			}
			
			return new Button(upTexture, text, downTexture);	
		}
		
		public function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel{
			return assetManager.playSound(name, startTime, loops, transform);
		}
	}
	
	
	
}

class Enforcer{
	
}