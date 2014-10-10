package preloaderPackage
{
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Stage;	
	
	public class Preloader extends MovieClip
	{
		
		private var stageRef:Stage;	//Stage reference
		private var fullWidth:Number; //the width of our mcPreloaderBar at 100%
		public var ldrInfo:LoaderInfo;	//Holds information about loading the swf
		
		//Tween
		private var tweenFade:Boolean = false;
		
		public function Preloader(stageRef:Stage = null, fullWidth:Number = 0, ldrInfo:LoaderInfo = null) 
		{
			this.stageRef = stageRef;
			this.fullWidth = fullWidth;
			this.ldrInfo = ldrInfo;
			
			stageRef.addChild(this);
			addEventListener(Event.ENTER_FRAME, checkLoad);
		}
		
		//Every frame, it checks how much of the swf is loaded
		private function checkLoad (e:Event) : void
		{
			//If fully loaded, begin phase out, asset loading is in progress
			if (!tweenFade && ldrInfo.bytesLoaded == ldrInfo.bytesTotal && ldrInfo.bytesTotal != 0)
			{
				//loading complete
				dispatchEvent(new Event("loadComplete"));
				phaseOut();
			}
			
			//Update preload bar
			updateLoader(ldrInfo.bytesLoaded / ldrInfo.bytesTotal);
			
			//Tweens
			if(tweenFade)
				tweeningFade();
			
		}
		
		//Dispose function
		private function dispose():void
		{
			phaseComplete();
			tweenFade = false;
			stage.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, checkLoad);
		}
		
		//Loader update
		private function updateLoader(num:Number) : void
		{
			//num is a number between 0 and 1
			mcPreloaderBar.width = num * fullWidth;
		}
		
		//Activate tween
		private function phaseOut() : void
		{	
			tweenFade = true;
		}
		
		//Tween should be finished, 3rd frame should be reached by now ---> ready, new movieclips can be displayed
		private function phaseComplete() : void
		{	
			//go on to the next phase
			dispatchEvent(new Event("preloaderFinished"));	
		}
		
		//Tweening in action
		private function tweeningFade():void
		{			
			if(this.alpha <= 0)
				dispose();
			else
				this.alpha -=0.05;
		}

	}
	
}