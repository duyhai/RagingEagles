package background {
	
	import flash.display.MovieClip;
	import flash.events.Event;	
	
	public class Background01_01 extends MovieClip {
		
		var v:Number;	//scrolling speed
		var w:Number;	//width
		
		public function Background01_01(w:Number=1600, v:Number=0) {
			this.v=v;
			this.w=w;
			this.addEventListener("enterFrame", enterFrame);
		}
		
		public function enterFrame(e:Event)
		{
			x-=v;
			if (x<-w) x=0;
		}
		
		public function setSpeed(v:Number=0)	//egyelőre nem írtam bele hogy az avatar mozgása
		{		//befolyásolja a háttérét
			this.v=v;
		}
		
		public function getSpeed():Number	//de ezzel a két függvénnyel meg lehet csinálni
		{
			return this.v;
		}
		
		public function kill()
		{
			stage.removeChild(this);
		}
	}
	
}
