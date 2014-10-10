package shipPackage{
	
	import menuPackage.*;
	import enumPackage.*;
	import effectPackage.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class EnemyShip extends Ship{
		
		protected var firerate:Number;
		public var fireCount:Number;
		protected var maxspeedx:Number=100;	//azért jó ez a magas kezdőérték mert így ha nem adjuk meg külön,
		protected var maxspeedy:Number=100;	//akkor nem zavar bele a játékba (a 0 pl. kifejezetten rossz kezdőérték volna)
		public var bulletdamage:Number = 10;
		public var damagebonus:Number = 0;
		static public var list:Array = new Array();
		static public var numOfShips:Number=0;
		public var bonusSender:EnemyShipX22Commander = null;
		var killedbylaser=false;
		
		public function EnemyShip(firerate:Number = 0, health:Number = 1, pos:Vector2D=null, velocity:Vector2D = null){
			super(health, pos, velocity);
			this.firerate = firerate;
			fireCount = firerate;
			numOfShips++;
			list.push(this);
			//addEventListener("enterFrame", enterFrame);
			
		}
		
		override protected function enterFrame(e:Event){
			pcounter--;
			if (pcounter<=0) 
			{
				paralyzed=false;
				pcounter=60;
			}
			if (paralyzed) return;
			if (Math.abs(velocity.x)>Math.abs(maxspeedx)) velocity.x=maxspeedx*Vector2D.sgn(velocity.x);
			if (Math.abs(velocity.y)>Math.abs(maxspeedy)) velocity.y=maxspeedx*Vector2D.sgn(velocity.y);
			x+=velocity.x;
			y+=velocity.y;
			if (x<-100 || health<0) kill();
			if (hitTestObject(GameClass.heroShip))
			{
				GameClass.heroShip.takeDamage(collide());
			}
			if(fireCount > 0) fireCount--;
		}
		
		override public function kill(){
			if (killed) return;
			//itt majd hozzáadunk egy robbanást
			if (x>=-100 && x<=950 && y>=-100 && y<=550)
			{
				switch(Math.floor(Math.random()*3))
				{
					case 0:
					{
						if (!killedbylaser) stage.addChild(new Explosion(0, new Vector2D(this.x, this.y)));
						else stage.addChild(new LaserExplosion(0, new Vector2D(this.x, this.y)));
						break;
					}
					case 1:
					{
						if (!killedbylaser) stage.addChild(new Explosion2(0, new Vector2D(this.x, this.y)));
						else stage.addChild(new LaserExplosion2(0, new Vector2D(this.x, this.y)));
						break;
					}
					case 2:
					{
						if (!killedbylaser) stage.addChild(new Explosion3(0, new Vector2D(this.x, this.y)));
						else stage.addChild(new LaserExplosion3(0, new Vector2D(this.x, this.y)));
						break;
					}
				}
			}
			if (killedbylaser)
			{
				var maxrange:Number=100;
				for each (var ESh:EnemyShip in EnemyShip.list)
				if(ESh!=this){
					var distance:Number = new Vector2D(ESh.x-this.x, ESh.y-this.y).length();
					var coeff:Number = 1/((100+distance)/100*(100+distance)/100);	//négyzetes csökkenés
					if (distance<=maxrange)
						ESh.takeDamage(maxhealth*(1+0.15*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(2))*coeff);
				}
			}
			super.kill();	//törli az enterFrame eseménykezelőt, és eltávolítja a stage-ről az objektumot
			numOfShips--;
			for(var i in list){
				if(list[i] == this){
					delete list[i];
				}
			}
		}
		
		protected function checkFire(){
			
				if(fireCount <= 0){
					this.shoot();
					fireCount = firerate;
					
				}
			
		}
		
		override protected function shoot(){}
		
		override public function takeDamage(d:Number, s:String=null){
			health-=d;
			if (s=="PlasmaBlast")	//ezt a részt még nem teszteltem
			{
				if (health<=0) killedbylaser=true;
			}
		}
		
		public function setBonus(b:Number, s:EnemyShipX22Commander)
		{
			if (Math.min(bulletdamage*(b*0.05),bulletdamage)>damagebonus || b==0)
			{
				damagebonus=bulletdamage*(b*0.05);
				bonusSender=s;
			}
		}
		
		public function collide():Number
		{
			if (!killed) kill();
			return health/10;
		}
		
		public static function killThemAll()
		{
			for each(var ESh:EnemyShip in list)	//erre valamit ki kell találni mert egyszerűen nem működik
			{
				ESh.kill();
			}
		}
		
	}
	
}