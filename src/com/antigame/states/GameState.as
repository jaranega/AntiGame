package com.antigame.states
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.view.starlingview.AnimationSequence;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GameState extends StarlingState
	{
		public var hero:Hero;
		public var floor:Platform;
		private var _citrusEngine:CitrusEngine;
		private var box2D:Box2D = new Box2D("box2D");
		
		
		[Embed(source="/assets/imgs/corriendo.xml", mimeType="application/octet-stream")]
		private var _heroConfig:Class;
		
		[Embed(source="/assets/imgs/corriendo.png")]
		public var _heroPng:Class;
		
		[Embed(source="/assets/imgs/fondo.png")]
		public var backImage:Class;
		 
		public var bitmap:Bitmap;
		public var texture:Texture;
		public var heroXml:XML;
		public var sTextureAtlas:TextureAtlas;
		private var background:CitrusSprite;
		
		public function GameState()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			_citrusEngine = CitrusEngine.getInstance();
			box2D.visible=false;
			add(box2D);
			
			addBackground();
			addHero(); 
			
			floor = new Platform("floor",{x:stage.stageWidth,y:stage.stageHeight,width:stage.stageWidth*4,height:60});
			add(floor);

			//view.setupCamera(hero, new MathVector(320, 320), new Rectangle(0, 0, 5000, 5000), new MathVector(.35, .15));
			view.setupCamera(hero, new MathVector(stage.stageWidth /2, stage.stageHeight / 2), new Rectangle(0, 0, int.MAX_VALUE, 100), new MathVector(.25, .05));		
		
			_citrusEngine.sound.playSound("music", 1, 0);
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		public function addHero():void{
			
			bitmap = new _heroPng();
			texture= Texture.fromBitmap(bitmap);
			heroXml = XML(new _heroConfig());
			sTextureAtlas = new TextureAtlas(texture, heroXml);
			
			hero=new Hero("hero",{width:100,height:140}); hero.x=hero.y=100;	
			
			hero.view = new AnimationSequence(sTextureAtlas, ["walk","duck","idle","jump","hurt"], "idle",10,true);
			(hero.view.mcSequences["walk"] as starling.display.MovieClip).scaleY = .4;
			(hero.view.mcSequences["walk"] as starling.display.MovieClip).scaleX = .4;
			(hero.view.mcSequences["jump"] as starling.display.MovieClip).scaleX = .4;
			(hero.view.mcSequences["jump"] as starling.display.MovieClip).scaleY = .4;
			(hero.view.mcSequences["duck"] as starling.display.MovieClip).scaleX = .4;
			(hero.view.mcSequences["duck"] as starling.display.MovieClip).scaleY = .4;
			(hero.view.mcSequences["idle"] as starling.display.MovieClip).scaleX = .4;
			(hero.view.mcSequences["idle"] as starling.display.MovieClip).scaleY = .4;
			(hero.view.mcSequences["hurt"] as starling.display.MovieClip).scaleX = .4;
			(hero.view.mcSequences["hurt"] as starling.display.MovieClip).scaleY = .4;
			hero.hurtDuration=1;
			add(hero);
		}
		
		private function addBackground():void
		{
			background = new CitrusSprite("background",{width:stage.stageWidth,height:stage.stageHeight});
			background.view=new backImage();
			add(background);
		}
		
	}
}