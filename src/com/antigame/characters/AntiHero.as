package com.antigame.characters
{
	import citrus.objects.platformer.box2d.Hero;
	import citrus.view.starlingview.AnimationSequence;
	
	import com.antigame.resources.AssetFactory;
	import com.antigame.resources.ResourceLoader;
	import com.antigame.utils.GraphicUtils;
	
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	public class AntiHero extends Hero
	{
		
		public function AntiHero(name:String, params:Object=null)
		{
			super(name, params);
			
			this.view = new AnimationSequence(AssetFactory.getInstance().getTextureAtlas("antiHero"), ["walk","duck","idle","jump","hurt","die"], "idle",10,true);
			(this.view as Sprite).scaleX = 0.4;
			(this.view as Sprite).scaleY = 0.4;
			
			this.hurtDuration=200;
		}
	}
}