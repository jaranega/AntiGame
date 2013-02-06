package com.antigame.characters
{
	import com.antigame.utils.GraphicUtils;
	
	import citrus.objects.platformer.box2d.Hero;
	import starling.textures.TextureAtlas;
	
	public class AntiHero extends Hero
	{
		[Embed(source="/assets/imgs/antiHero.xml", mimeType="application/octet-stream")]
		private var _heroXML:Class;
		
		public function AntiHero(name:String, params:Object=null)
		{
			super(name, params);
			
			var heroXml:XML = XML(new _heroXML());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(AntiGame.assetManager.getTexture("antiHero"), heroXml);
			
			GraphicUtils.resizeBox2DObject(this, sTextureAtlas, 0.4);
			this.hurtDuration=200;
		}
	}
}