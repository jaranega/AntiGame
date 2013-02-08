package com.antigame.characters
{

	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.platformer.box2d.Enemy;
	
	import com.antigame.resources.ResourceLoader;
	import com.antigame.utils.GraphicUtils;
	
	import flash.utils.setInterval;
	
	import starling.textures.TextureAtlas;
	
	public class RiotPolice extends Enemy
	{
		[Embed(source="/assets/imgs/police.xml", mimeType="application/octet-stream")]
		private var _policeXML:Class;
		
		public function RiotPolice(name:String, params:Object=null)
		{
			super(name, params);
			setInterval(doJump,1000)
			
			var policeXML:XML = XML(new _policeXML());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(ResourceLoader.getInstance().assetManager.getTexture("police"), policeXML);
			
			this.group = 3;
			this.speed = 5;
			
			GraphicUtils.resizeBox2DObject(this, sTextureAtlas, 0.3);
			
		}
		
		private function doJump():void
		{
			this._body.ApplyImpulse(new b2Vec2(0,-100),new b2Vec2(100,-90));
		}
		
		protected override function endHurtState():void{
			_hurt = false;
			kill = false;
		}
	}
}