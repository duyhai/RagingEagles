package menuPackage
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class BaseMenu extends MovieClip
	{
 
		public var stageRef:Stage; //the stage
		public var loadNext:BaseMenu = null; //instance of next Menu to load
		protected var menuName:String;  //Name of menu. Plays role in selfdisposal eventhandling.
 
 		//Tween
		protected var tweenLoad:Boolean = false;
		protected var tweenUnLoad:Boolean = false;
 
		public function BaseMenu(stageRef:Stage = null, menuName:String = "Menu")
		{
			this.stageRef = stageRef;
			this.menuName = menuName;
			alpha = 0;	//Start from outside of screen
		}
 
 		private function onEnterFrame(e:Event):void
		{
			//If a tween is active, perform it
			if(tweenLoad)
				tweeningLoad();
			if(tweenUnLoad)
				tweeningUnLoad();
			
		}
		
		protected function buttonsActivate(): void
		{
			
		}
 
		//Unloads itself while loading another menu. Also activates unloadinf tween
		public function unload(loadMe:BaseMenu = null) : void
		{
			if (loadMe != null)
				loadNext = loadMe;
 			tweenUnLoad = true;
			if (loadNext != null)
				loadNext.load();
		}
 
		//Dispatches selfdispose event
		public function remove() : void
		{
			dispatchEvent(new Event(menuName+"Removed"));
		}
 
		//Loading. Load tween activate
		public function load() : void
		{			
			addEventListener(menuName+"Removed", dispose);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stageRef.addChild(this);
			tweenLoad = true;
		}
 
		//Loading tween in action
 		private function tweeningLoad(): void
		{
			if(alpha >= 1)
			{
				tweenLoad = false;
				buttonsActivate();
			}
			else
			{
				alpha += 0.1;			
			}
		}
		
		//Unloading tween in action
		private function tweeningUnLoad(): void
		{
			if(alpha <= 0)
			{
				tweenUnLoad = false;
				remove();
			}
			else
			{
				alpha -= 0.1;			
			}			
		}
		
		//Dispose function
		protected function dispose(e:Event):void
		{
			if (stageRef.contains(this))
				stageRef.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(menuName+"Removed", dispose);
		}
 
	}
	
}
