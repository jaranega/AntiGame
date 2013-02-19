package com.antigame.characters
{

	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.view.starlingview.AnimationSequence;
	
	import com.antigame.resources.AssetFactory;
	import com.antigame.resources.ResourceLoader;
	import com.antigame.utils.GraphicUtils;
	
	import flash.utils.setInterval;
	
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	public class RiotPolice extends Enemy
	{
		
		public function RiotPolice(name:String, params:Object=null)
		{
			super(name, params);
			setInterval(doJump,1000)
			
			this.view = new AnimationSequence(AssetFactory.getInstance().getTextureAtlas("police"), ["walk","duck","idle","jump","hurt","die"], "idle",10,true);
			(this.view as Sprite).scaleX = 0.3;
			(this.view as Sprite).scaleY = 0.3;
			
			this.group = 3;
			this.speed = 5;
			
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