package com.antigame.resources
{
	import citrus.core.SoundManager;
	import citrus.view.starlingview.StarlingTile;
	
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class AssetFactory {
		
		public var assetManager:AssetManager;
		
		
		private static var instance:AssetFactory;
		
		private var backgroundMusic:Object;
		
		public function AssetFactory(e:Enforcer){
			assetManager = ResourceLoader.getInstance().assetManager;
		}
		
		public static function getInstance():AssetFactory{
			if(!instance){
				instance = new AssetFactory(new Enforcer());
			}
			
			return instance;
		}
		
		
		//images and buttons
		public function getTexture(name:String):Texture{
			return assetManager.getTexture(name);
		}
		
		public function getTextureAtlas(name:String):TextureAtlas{
			return assetManager.getTextureAtlas(name);
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
		
		
		//sounds
		//TODO: Improve with the use of citrus SoundManager. It can give us some extra functionality to mute sounds, or change volumes individually.
		public function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel{
			return assetManager.playSound(name, startTime, loops, transform);
		}
		
		
		public function playSoundOnce(name:String, startTime:Number=0):SoundChannel{
			return playSound(name, startTime, 0, null);
		}
		
		public function playBackgroundMusic(name:String, startTime:Number=0):SoundChannel{
			if(backgroundMusic && backgroundMusic.name == name){
				//requested music is already playing, do nothing
				return backgroundMusic.channel;
			}else{
				stopBackgroundMusic();
			}
			
			var channel:SoundChannel = playSound(name, startTime, 999999, null);
			
			backgroundMusic = {name:name ,channel:channel};
			
			return channel;
		}
		
		public function stopBackgroundMusic():void{
			if(this.backgroundMusic){
				this.backgroundMusic.channel.stop();
				this.backgroundMusic = null;
			}
		}
		
	}
	
	
	
}

class Enforcer{
	
}