package 
{

	import preloaderPackage.*;
	import menuPackage.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;

	public class Engine extends MovieClip
	{

		private var preloader:Preloader;
		public static var so:SharedObject = SharedObject.getLocal("saveddata043");

		public function Engine()
		{
			preloader = new Preloader(stage, 800, this.loaderInfo);
			preloader.addEventListener("loadComplete", loadAssets);
			preloader.addEventListener("preloaderFinished", showSponsors);
			
		}

		private function loadAssets(e:Event):void
		{
			this.play();
		}

		private function showSponsors(e:Event):void
		{			
			var ps:PrerollSponsors = new PrerollSponsors(stage);
			ps.addEventListener("prerollComplete", showMenu);
			ps.preroll();
		}
 
		private function showMenu(e:Event) : void
		{
			var mm:MainMenu = new MainMenu(stage);
			mm.load();
		}

	}

}