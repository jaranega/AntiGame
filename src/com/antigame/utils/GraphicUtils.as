package com.antigame.utils
{
	import citrus.objects.Box2DPhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
	
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;

	public class GraphicUtils
	{
		public static function resizeBox2DObject(object:Box2DPhysicsObject, texture:TextureAtlas, factor:Number):void
		{
			object.view = new AnimationSequence(texture, ["walk","duck","idle","jump","hurt","die"], "idle",10,true);
			
			(object.view.mcSequences["walk"] as starling.display.MovieClip).scaleY = factor;
			(object.view.mcSequences["walk"] as starling.display.MovieClip).scaleX = factor;
			(object.view.mcSequences["jump"] as starling.display.MovieClip).scaleX = factor;
			(object.view.mcSequences["jump"] as starling.display.MovieClip).scaleY = factor;
			(object.view.mcSequences["duck"] as starling.display.MovieClip).scaleX = factor;
			(object.view.mcSequences["duck"] as starling.display.MovieClip).scaleY = factor;
			(object.view.mcSequences["idle"] as starling.display.MovieClip).scaleX = factor;
			(object.view.mcSequences["idle"] as starling.display.MovieClip).scaleY = factor;
			(object.view.mcSequences["hurt"] as starling.display.MovieClip).scaleX = factor;
			(object.view.mcSequences["hurt"] as starling.display.MovieClip).scaleY = factor;
			(object.view.mcSequences["die"] as starling.display.MovieClip).scaleX = factor;
			(object.view.mcSequences["die"] as starling.display.MovieClip).scaleY = factor;
		}
	}
}