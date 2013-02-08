package com.antigame.levels
{

	import com.antigame.characters.AntiHero;
	import com.antigame.characters.RiotPolice;
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.starling.VirtualJoystick;
	import citrus.math.MathVector;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.starlingview.StarlingCamera;
	import citrus.view.starlingview.StarlingTileSystem;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.extensions.particles.PDParticleSystem;
	import starling.extensions.particles.ParticleSystem;
	import starling.textures.Texture;

	
	public class BarcelonaLevelGameState extends StarlingState 
	{
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		
		protected var _hero:Hero;
		protected var _endLevel:Sensor;
		protected var _enemies:Vector.<CitrusObject>;
		protected var _ce:CitrusEngine;
		protected var _level:MovieClip;
		
		protected var mando:VirtualJoystick;
		protected var shotButton:Button;
		protected var box2d:Box2D;
		
		private var psconfig:XML;
		private var psTexture:Texture;
		
		[Embed(source="/assets/imgs/particula.pex", mimeType="application/octet-stream")]
		private var _particleConfig:Class;
		
		public function BarcelonaLevelGameState(level:MovieClip = null) 
		{
			super();
			
			_ce = CitrusEngine.getInstance();
			_level = level;
			
			lvlEnded = new Signal();
			restartLevel = new Signal();
			
			var objectsUsed:Array = [AntiHero, RiotPolice, Platform, Sensor, CitrusSprite];
		}
 
		override public function initialize():void 
		{
			super.initialize();
			
			box2d = new Box2D("box2d");
			add(box2d);
			
			ObjectMaker2D.FromMovieClip(_level);
			
			_hero = AntiHero(this.getFirstObjectByType(AntiHero));
			_enemies = getObjectsByName("police");
			_endLevel = Sensor(getObjectByName("restartLevel"));
			_endLevel.onBeginContact.add(levelEnded);
			
			view.setupCamera(_hero, new MathVector(200*Starling.contentScaleFactor, 300*Starling.contentScaleFactor), new Rectangle(0, 0, _level.width*Starling.contentScaleFactor , 800*Starling.contentScaleFactor), new MathVector(0.25, 0.15));
			(view.camera as StarlingCamera).zoom(0.75);
			
			AntiGame.assetManager.playSound("breakSong",1,0);
			
			//addFire();
			addControls();
			addBackground();
			//addPhysicsObject();
		}	
		
		private function levelEnded(e:b2PolygonContact):void
		{
			lvlEnded.dispatch();
		}
		
		private function addControls():void
		{
			//Mando
			mando = new VirtualJoystick("mando");
			mando.graphic.width = 100;
			mando.graphic.height = 100;
			mando.graphic.x = 80;
			mando.graphic.y = stage.stageHeight - mando.graphic.width/2 - 80;
			mando.addAxisAction("Y","duck",-1,-.9);
			
			//Shot Button
			shotButton = new Button(AntiGame.assetManager.getTexture("molotov"),"Shot!");
			shotButton.addEventListener(Event.TRIGGERED, shot);
			addChild(shotButton);
			
			shotButton.x = stage.stageWidth - shotButton.width - 80;
			shotButton.y = stage.stageHeight - shotButton.width - 80;
		}
		
		private function shot(e:Event):void
		{	
			trace("Shot!");
		}
		
		private function addBackground():void
		{
			var tileSprite:CitrusSprite = new CitrusSprite("tile_bg_sprite_0", { x:0, y:0, parallax:1} );
			var tileSystem:StarlingTileSystem = new StarlingTileSystem(MovieClip(_level.getChildByName("fonsCiti")));
			
			tileSystem.parallax = 1;
			tileSystem.name = "tile_bg_tiles_0";
			tileSystem.tileWidth = 2048; tileSystem.tileHeight = 1024;
			tileSystem.blendMode = BlendMode.NONE;
			tileSystem.touchable = false;
			tileSystem.init();
			
			tileSprite.view = tileSystem;
			tileSprite.group = 0;
			add(tileSprite);
			
			if (Starling.current.context.driverInfo.toLowerCase().search("software") < 0) 
			{
				tileSprite = new CitrusSprite("tile_bg_sprite_1", { x:0, y:0, parallax:1} );
				tileSystem = new StarlingTileSystem(MovieClip(_level.getChildByName("busstops")));
				
				tileSystem.parallax = 1;
				tileSystem.name = "tile_bg_tiles_1";
				tileSystem.tileWidth = 2048; tileSystem.tileHeight = 1024;
				tileSystem.touchable = false;
				tileSystem.init();
				
				tileSprite.view = tileSystem;
				tileSprite.group = 1;
				add(tileSprite);
			}
		}
		
		private function addPhysicsObject():void
		{
			for (var i:int = 0; i < 3; i++) 
			{	
				var texture:Texture = AntiGame.assetManager.getTexture("blueContainer");
				var image:Image;
				var physicObject:Box2DPhysicsObject;
				image = new Image(texture);
				image.scaleX=image.scaleY=.6;
				var cont:Crate=new Crate("container",{width:160,height:120,view:image,offsetY:300}); 
				cont.group=3;
				add(cont);
				cont.x=stage.stageWidth*Math.random();
			}	
		}
		
		private function addFire():ParticleSystem
		{
			psconfig = new XML(new _particleConfig())
			psTexture = AntiGame.assetManager.getTexture("textura");
			
			var ps:PDParticleSystem = new PDParticleSystem(psconfig, psTexture);
			ps.start(); Starling.juggler.add(ps);
			
			return ps;
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
 
}