package preloaderPackage
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
 
	public class PrerollSponsors extends Sprite
	{
 
		private var stageRef:Stage;		//Stage reference
		private var prerollList:Array; //keeps up with our Movieclip prerolls
		private var currentPreroll:int = 0; //the current preroll we are on
		private var prerollLinks:Array;	//Assigns links to preroll clips
 
		public function PrerollSponsors(stageRef:Stage):void
		{
			this.stageRef = stageRef;
			//Fill preroll array
			prerollList = [new PrerollMathDebaters(), new PrerollKongregate()];
			prerollLinks = ["https://www.facebook.com/MathDebaters", "http://www.kongregate.com/?referrer=TiElite"]
			stageRef.addEventListener(MouseEvent.CLICK, openLink);
		}
 
		//Start prerolls
		public function preroll() : void
		{
			//If all prerolls played, finish prerolling
			if (currentPreroll == prerollList.length)
			{
				stageRef.removeEventListener(MouseEvent.CLICK, openLink);
				return prerollComplete();
			}
 
			//Position current clip to center and play it.
			var clip:MovieClip = prerollList[currentPreroll];
			clip.x = (stageRef.stageWidth - clip.width) / 2;
			clip.y = (stageRef.stageHeight - clip.height) / 2;
			clip.gotoAndPlay(1);
			//Every preroll should have its last frame added a code: stop(); dispatchEvent(new Event("finished"))
			//We listen to these events
			clip.addEventListener("finished", nextPreroll);
			stageRef.addChild(clip);
		}
 
		//Cleaning up previous prerolls and getting ready for next
		private function nextPreroll(e:Event) : void
		{
			e.currentTarget.removeEventListener("finished", nextPreroll);
			stageRef.removeChild(e.currentTarget as MovieClip);
			currentPreroll++;
			preroll();
		}
 
		//Signalling for the end of prerolls
		private function prerollComplete() : void
		{
			dispatchEvent(new Event("prerollComplete"));
		}
		
		//Open link on click
		private function openLink(e:Event): void
		{
			if(prerollLinks[currentPreroll] != null)
			{
				var request:URLRequest = new URLRequest(prerollLinks[currentPreroll]);
				navigateToURL(request, "_blank");			
			}
			
		}
 
	}
	
}
