package com.antigame.resources
{
	public class EmbeddedAssets
	{
		//SpriteSheets
		[Embed(source="/assets/imgs/antiHero.png")]
		public static var antiHero:Class;
		[Embed(source="/assets/imgs/antiHero.xml", mimeType="application/octet-stream")]
		public static var heroXML:Class; //el nombre no importa
		
		[Embed(source="/assets/imgs/police.png")]
		public static var police:Class;
		[Embed(source="/assets/imgs/police.xml", mimeType="application/octet-stream")]
		public static var policeXML:Class;
		
		//Images Levels
		[Embed(source="/assets/imgs/blueContainer.png")]
		public static var blueContainer:Class;
		
		[Embed(source="/assets/imgs/molotov.png")]
		public static var molotov:Class;
		
		//SplashScreen
		[Embed(source="/assets/imgs/playLogo.png")]
		public static var playLogo:Class;
		
		[Embed(source="/assets/imgs/splashScreen.png")]
		public static var splashScreen:Class;

		[Embed(source="/assets/imgs/splashScreen.png")]
		public static var menuBackground:Class;
		
		[Embed(source="/assets/imgs/textura.png")]
		public static var textura:Class;
		
		
	}
}