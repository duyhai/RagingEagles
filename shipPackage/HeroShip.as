package shipPackage{
	
	import menuPackage.*;
	import effectPackage.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	import flash.system.System;
	
	public class HeroShip extends Ship{
		
		protected var firerate:Number;
		public var fireCount:Number;
		public var isMouseDown:Boolean;
		
		public function HeroShip(firerate:Number = 10, health:Number = 0, pos:Vector2D = null){
			super(health, pos);
			this.firerate = firerate;
			fireCount = firerate; //-Talent
			isMouseDown=false;
			//stage.addEventListener("mouseDown", checkFire);
			//addEventListener("enterFrame",enterFrame);
		}
		
		override protected function enterFrame(e:Event){
			//trace(new Number(System.totalMemory/1024).toFixed(2));
			pcounter--;
			if (pcounter<=0) 
			{
				paralyzed=false;
				pcounter=60;
			}
			if (paralyzed) return;
			
			destination.x=stage.mouseX;
			destination.y=stage.mouseY;
			
			this.x=(this.x*0.6+destination.x*0.4);
			this.y=(this.y*0.6+destination.y*0.4);
			
			if(fireCount > 0) fireCount--;
			if (isMouseDown) checkFire();
		} //Ide majd kell egy if(fireCount > 0) fireCount--;
		
		override public function kill(){
			switch(Math.floor(Math.random()*3))
			{
				case 0:
				{
					stage.addChild(new Explosion(0, new Vector2D(this.x, this.y)));
					break;
				}
				case 1:
				{
					stage.addChild(new Explosion2(0, new Vector2D(this.x, this.y)));
					break;
				}
				case 2:
				{
					stage.addChild(new Explosion3(0, new Vector2D(this.x, this.y)));
					break;
				}
			}
			super.kill();
		}
		
		public function MouseDown(e:MouseEvent){
			isMouseDown = true;
		}
		
		public function MouseUp(e:MouseEvent){
			isMouseDown = false;
		}
		
		//Ezt shootorialban nem sikerült működésre bírni, úgyhogy gondolom nem működik így...
		public function checkFire(){	//ez event-öt a stage-hez regeljük be akkor ez public kell hogy legyen
			
				if(fireCount <= 0){
					this.shoot();
					fireCount = firerate; // -Talent.még meglátjuk
					
				}
			
		}
		
		override protected function shoot(){
		}
		
		override public function takeDamage(d:Number, s:String=null){
			health-=d;
			GameClass.HPBar.setHP(health/maxhealth);
			//if (health>=0) trace(health);
			//if (health<=0 && health>-d) trace("Game Over");
		} //Ezt még azért nem írtam meg, mert egyes hajóknál még lehet majd ugye pajzs meg ilyenek pl a fúrósnál
		
	}
	
}