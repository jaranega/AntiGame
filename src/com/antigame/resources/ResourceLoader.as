package com.antigame.resources
{
	
	
	import org.osflash.signals.Signal;
	
	import starling.utils.AssetManager;
	
	
	/**
	 * @author Aymeric
	 */
	public class ResourceLoader {
	
		public var _loadSuccess:Signal = new Signal();
		public var loadingEnded:Boolean = false;
	
		public var assetManager:AssetManager;

		
		private static var instance:ResourceLoader;
		
		public function ResourceLoader(e:Enforcer){
			assetManager = new AssetManager(1.0, true);
			assetManager.verbose = true;
		}
		
		public static function getInstance():ResourceLoader{
			if(!instance){
				instance = new ResourceLoader(new Enforcer());
			}
			
			return instance;
		}
		
		public function loadResources():void{
			
			//sounds
			loadSounds();

			//images
			loadImages();
			
			//embedded
			loadEmbededAssets();
			
			
			//load ALL
			assetManager.loadQueue(loadAssetsProgress);
		}
		
		private function loadSounds():void{
			//CitrusEngine.getInstance().sound.addSound("music","../assets/sounds/break.mp3");
		}
		
		private function loadImages():void{

		}
		
		private function loadEmbededAssets():void
		{
			assetManager.enqueue(EmbeddedAssets);
			assetManager.enqueue(EmbeddedSounds);
		}
		
		
		
		
		private function loadAssetsProgress(ratio:Number):void
		{
			if (ratio == 1.0) {
				notifyLoadingEnded()
			}
		}
		
		private function notifyLoadingEnded():void{
			this.loadingEnded = true;
			this._loadSuccess.dispatch();
		}
		
	
	}
	
	
	
}

class Enforcer{
	
}