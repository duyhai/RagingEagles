package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	
	public class Ship extends MovieClip{
		
		protected var maxhealth:Number;
		protected var health:Number;
		protected var velocity:Vector2D;
		protected var speed:Number;
		protected var destination:Vector2D;
		protected var paralyzed:Boolean=false;
		protected var pcounter:Number=60;	//ennyi időre bénítja le az overlord
		var killed:Boolean=false;	//hogy egy körben csak egyszer lehessen meghalni
		
		public function Ship(health:Number = 0, pos:Vector2D = null, velocity:Vector2D = null){
			if (velocity == null) velocity = new Vector2D();
			if (pos == null) pos=new Vector2D();
			this.maxhealth = this.health = health;
			x = pos.x;
			y = pos.y;
			this.velocity = velocity;
			destination = pos;
			
			this.speed=speed;
			
			addEventListener("enterFrame", enterFrame, false, 0, true);
			
		}
		
		protected function enterFrame(e:Event){
			pcounter--;
			if (pcounter<=0) 
			{
				paralyzed=false;
				pcounter=60;
			}
			if (paralyzed) return;
			var direction_vector:Vector2D = new Vector2D(destination.x - this.x, destination.y - this.y);
			velocity = direction_vector.normalized();
			velocity.scaleBy(speed);
		}	
		
		public function kill()
		{
			removeEventListener("enterFrame", enterFrame);
			stage.removeChild(this);	//ha stage.removeChild(this)-t írok, a futás nem áll le, de az outputon hibaüzenet jelenik meg
			killed=true;
		}
		
		protected function shoot(){}
		
		public function takeDamage(d:Number, s:String=null){}
		
		public function setDestination(v:Vector2D)
		{
			destination=v;
		}
		
		public function getVelocity():Vector2D
		{
			return velocity;
		}
		
		public function paralyze()
		{
			paralyzed=true;
		}
		
		public function grayscale(){
			var b:Number = 1 / 3;
			var c:Number = 1 - (b * 2);
			var mtx:Array = [c, b, b, 0, 0,
							b, c, b, 0, 0,
							b, b, c, 0, 0,
							0, 0, 0, 1, 0];
			var mtxFilter:ColorMatrixFilter = new ColorMatrixFilter(mtx);
			this.filters = [mtxFilter];
		}
		
		public function unGrayscale(){
			this.filters = [];
		}
		
		public function bringToFront()
		{
			if (stage) stage.setChildIndex(this, stage.numChildren-1);
		}
		
	}
	
}