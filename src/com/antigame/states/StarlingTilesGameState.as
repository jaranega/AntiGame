package com.antigame.states
{

	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.starling.VirtualJoystick;
	import citrus.math.MathVector;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingTileSystem;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * @author Nick Pinkham
	 */
	public class StarlingTilesGameState extends StarlingState 
	{
		[Embed(source="/assets/imgs/CONT_04.png")]
		private var _cratePng:Class;
		
		[Embed(source="/assets/imgs/corriendo.xml", mimeType="application/octet-stream")]
		private var _heroConfig:Class;
		
		[Embed(source="/assets/imgs/corriendo.png")]
		public var _heroPng:Class;
		
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		
		protected var _ce:CitrusEngine;
		protected var _level:MovieClip;
		
		private var _hero:Hero;
		private var mando:VirtualJoystick;
		
		public function StarlingTilesGameState(level:MovieClip = null) 
		{
			super();
			
			_ce = CitrusEngine.getInstance();
			
			_level = level;
			
			lvlEnded = new Signal();
			restartLevel = new Signal();
			
			// Useful for not forgetting to import object from the Level Editor
			var objectsUsed:Array = [Hero, Platform, Sensor, CitrusSprite];
		}
 
		override public function initialize():void {
 
			super.initialize();
			
			var box2d:Box2D = new Box2D("box2d");
			box2d.visible = false;
			add(box2d);
			
			// create objects from our level made with Flash Pro
			ObjectMaker2D.FromMovieClip(_level);
			
			// the hero view from sprite sheet
			var heroBitmap:Bitmap = new _heroPng();
			var textureHero:Texture = Texture.fromBitmap(heroBitmap);
			var heroXml:XML = XML(new _heroConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(textureHero, heroXml);
			
			mando = new VirtualJoystick("mando");
			mando.graphic.width = 100;
			mando.graphic.height = 100;
			
			
			// get hero from movieclip
			_hero = Hero(getFirstObjectByType(Hero));
			_hero.view = new AnimationSequence(sTextureAtlas, ["walk","duck","idle","jump","hurt","die"], "idle",10,true);
			(_hero.view.mcSequences["walk"] as starling.display.MovieClip).scaleY = .2;
			(_hero.view.mcSequences["walk"] as starling.display.MovieClip).scaleX = .2;
			(_hero.view.mcSequences["jump"] as starling.display.MovieClip).scaleX = .2;
			(_hero.view.mcSequences["jump"] as starling.display.MovieClip).scaleY = .2;
			(_hero.view.mcSequences["duck"] as starling.display.MovieClip).scaleX = .2;
			(_hero.view.mcSequences["duck"] as starling.display.MovieClip).scaleY = .2;
			(_hero.view.mcSequences["idle"] as starling.display.MovieClip).scaleX = .2;
			(_hero.view.mcSequences["idle"] as starling.display.MovieClip).scaleY = .2;
			(_hero.view.mcSequences["hurt"] as starling.display.MovieClip).scaleX = .2;
			(_hero.view.mcSequences["hurt"] as starling.display.MovieClip).scaleY = .2;
			(_hero.view.mcSequences["die"] as starling.display.MovieClip).scaleX = .2;
			(_hero.view.mcSequences["die"] as starling.display.MovieClip).scaleY = .2;
			_hero.hurtDuration=1;
			
			// setup camera to follow hero
			view.setupCamera(_hero, new MathVector(400, 300), new Rectangle(0, 0, 4096, 1024), new MathVector(0.25, 0.15));
			
			
			// movieclip on stage converted to tiles
			addBackground();
			
			
			//addPhysicsObject();
		}	
		
		private function addPhysicsObject():void
		{
			// if software mode, only drops 1 box. if full gpu drops 10 boxes.
			if (Starling.current.context.driverInfo.toLowerCase().search("software") < 0) {
				var texture:Texture = Texture.fromBitmap(new  _cratePng());
				var image:Image;
				var physicObject:Box2DPhysicsObject;
				for (var i:uint = 0; i < 10; i++ ) {
					image = new Image(texture);
					physicObject = new Box2DPhysicsObject(("physicobject" + i), { x:Math.random() * stage.stageWidth, y:Math.random() * 300, width:60, height:60, view:image } );
					physicObject.group = 3;
					add(physicObject);
				}
				
			} else {
				var texture1:Texture = Texture.fromBitmap(new _cratePng());
				var image1:Image = new Image(texture1);
				var physicObject1:Box2DPhysicsObject = new Box2DPhysicsObject("physicobject", { x:Math.random() * stage.stageWidth, y:0, width:60, height:60, view:image1 } );
				physicObject1.group = 3;
				add(physicObject1);
			}
		}
		
		private function addBackground():void
		{
			var tileSprite:CitrusSprite = new CitrusSprite("tile_bg_sprite_0", { x:0, y:0, parallax:0.6 } );
			var tileSystem:StarlingTileSystem = new StarlingTileSystem(MovieClip(_level.getChildByName("tile_background_0")));
			
			tileSystem.parallax = 0.6;
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
				// add upper background
				tileSprite = new CitrusSprite("tile_bg_sprite_1", { x:0, y:0, parallax:0.8 } );
				tileSystem = new StarlingTileSystem(MovieClip(_level.getChildByName("tile_background_1")));
				
				tileSystem.parallax = 0.8;
				tileSystem.name = "tile_bg_tiles_1";
				tileSystem.tileWidth = 2048; tileSystem.tileHeight = 1024;
				tileSystem.touchable = false;
				tileSystem.init();
				
				tileSprite.view = tileSystem;
				tileSprite.group = 1;
				add(tileSprite);
			}
			
			// add top plane tiles via flash stage
			tileSprite = new CitrusSprite("tile_bg_sprite_2", { x:0, y:0 } );
			tileSystem = new StarlingTileSystem(MovieClip(_level.getChildByName("tile_background_2")));
			
			tileSystem.name = "tile_bg_tiles_2";;
			tileSystem.tileWidth = 2048; tileSystem.tileHeight = 1024;
			tileSystem.touchable = false;
			tileSystem.init();
			
			tileSprite.view = tileSystem;
			tileSprite.group = 2;
			add(tileSprite);
		}
		
		override public function destroy():void {
			super.destroy();
		}
 
	}
 
}