package com.antigame.states
{
	
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.math.MathUtils;
	import citrus.math.MathVector;
	
	
	/**
	 * @author Aymeric
	 */
	public class CameraMovement extends State {
		
		public function CameraMovement() {
			super();
		}
		
		override public function initialize():void {
			super.initialize();
		}
		
		override public function destroy():void {
			super.destroy();
		}
		
		override public function update(timeDelta:Number):void {
			
			super.update(timeDelta);
			
			if (CitrusEngine.getInstance().input.isDown(Keyboard.R)) {
				
				// if you use Starling, just move the pivot point!
				
				MathUtils.RotateAroundInternalPoint(this, new Point(stage.stageWidth / 2, stage.stageHeight / 2), 1);
				
				view.cameraOffset = new MathVector(stage.stageWidth / 2, stage.stageHeight / 2);
				view.cameraBounds = new Rectangle(0, 0, 1550, 450);
			}
		}
		
		private function _mouseWheel(mEvt:MouseEvent):void {
			
			scaleX = mEvt.delta > 0 ? scaleX + 0.03 : scaleX - 0.03;
			scaleY = scaleX;
			
			view.cameraOffset = new MathVector(stage.stageWidth / 2 / scaleX, stage.stageHeight / 2 / scaleY);
			view.cameraBounds = new Rectangle(0, 0, 1550 * scaleX, 450 * scaleY);
		}
	}
}