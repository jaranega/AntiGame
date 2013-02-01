package com.antigame.states
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.starling.VirtualJoystick;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	
	import dragonBones.animation.Animation;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
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
		
		[Embed(source="/assets/imgs/mamporreros.xml", mimeType="application/octet-stream")]
		private var _policeConfig:Class;
		
		[Embed(source="/assets/imgs/corriendo.png")]
		public var _heroPng:Class;
		
		[Embed(source="/assets/imgs/mamporreros.png")]
		public var _policePng:Class;
		
		[Embed(source="/assets/imgs/antiBackground.jpg")]
		public var backImage:Class;
		
		[Embed(source="/assets/imgs/CONT_04.png")]
		public var container:Class;
		 
		public var bitmap:Bitmap;
		public var texture:Texture;
		public var heroXml:XML;
		public var sTextureAtlas:TextureAtlas;
		private var background:CitrusSprite;
		private var mando:VirtualJoystick;
		
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
			addEnemies();
			
			floor = new Platform("floor",{x:stage.stageWidth,y:stage.stageHeight,width:stage.stageWidth*10,height:60});
			add(floor);

			//view.setupCamera(hero, new MathVector(320, 320), new Rectangle(0, 0, 5000, 5000), new MathVector(.35, .15));
			view.setupCamera(hero, new MathVector(stage.stageWidth /2, stage.stageHeight / 2), new Rectangle(0, 0, int.MAX_VALUE, 100), new MathVector(.25, .05));		
		
			//mando = new VirtualJoystick("mando");
			
			_citrusEngine.sound.playSound("music", 1, 0);
			
			var policeTimer:Timer=new Timer(4000,5);
			policeTimer.start()
			policeTimer.addEventListener(TimerEvent.TIMER, addEnemies);
			
			addContainer();
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		public function addContainer():void
		{
			var containerBitmap:Bitmap = new container();
			var crate:Crate = new Crate("container",{view:containerBitmap,width:280,height:180,x:1000});
			add(crate);
		}
		
		public function addHero():void
		{
			bitmap = new _heroPng();
			texture= Texture.fromBitmap(bitmap);
			heroXml = XML(new _heroConfig());
			sTextureAtlas = new TextureAtlas(texture, heroXml);
			
			hero=new Hero("hero",{width:100,height:140}); 
			hero.x=hero.y=100;	
			hero.jumpHeight = 12;
			
			hero.view = new AnimationSequence(sTextureAtlas, ["walk","duck","idle","jump","hurt","die"], "idle",10,true);
			(hero.view as Sprite).scaleX = .4;
			(hero.view as Sprite).scaleY = .4;
			hero.hurtDuration=1;
			
			add(hero);
		}
		
		public function addEnemies(event:TimerEvent = null):void
		{
			
			for (var i:int = 0; i < 2; i++) 
			{
				var policeBitmap:Bitmap = new _policePng();
				var policeTexture:Texture = Texture.fromBitmap(policeBitmap);
				var policeXML:XML = XML(new _policeConfig());
				var policeTextureAtlas:TextureAtlas = new TextureAtlas(policeTexture, policeXML);
				
				var police:Enemy = new Enemy("enemy",{width:100,height:140,y:300}); 
				police.x=500+Math.random()*1000;
				
				police.view = new AnimationSequence(policeTextureAtlas, ["walk","duck","idle","jump","hurt","die"], "idle",10,true);
				(police.view as Sprite).scaleX = .4;
				(police.view as Sprite).scaleY = .4;
				police.hurtDuration=1;
				
				add(police);
			}
			
		}
		
		private function addBackground():void
		{
			background = new CitrusSprite("background",{width:stage.stageWidth,height:stage.stageHeight});
			background.view=new backImage();
			add(background);
			
			(view.getArt(background) as StarlingArt).content.scaleX = 3.2;
			(view.getArt(background) as StarlingArt).content.scaleY = 3.2;
		}
		
	}
}