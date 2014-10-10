package shipPackage.bulletPackage {
	
	import effectPackage.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class X9DrillProjectile extends Bullet {
		
		var speed:Number;
		var turning:Number=5;	//fordulékonyság
		var behaviour:Number=0;	//0=standby, 1=seek, 2=DRILL!
		var shipPos:MovieClip;	//tulajdonos hajóra referncia (csak mint MovieClip)
		var offset:Vector2D;	//hajóhoz viszonyított elhelyezkedés
		var counter:Number=0;	
		
		public function X9DrillProjectile(shipPos:MovieClip, ishero:Boolean = false, dmg:Number = 10, ofs:Vector2D = null, speed:Number=5) {
			super(ishero, dmg, new Vector2D(shipPos.x+ofs.x, shipPos.y+ofs.y), null);
			this.speed = speed;
			this.shipPos=shipPos;
			offset=ofs;
		}
		
		override protected function enterFrame(e:Event)
		{
			super.enterFrame(e);
			switch(behaviour)
			{
				case 0:
				{
					x=shipPos.x+offset.x;
					y=shipPos.y+offset.y;
					break;
				}
				case 1:
				{
					var angle:Number = Math.atan2(GameClass.heroShip.y-this.y,GameClass.heroShip.x-this.x)/Math.PI*180;	//<<DUMMYVERSION
					if (Math.abs(rotationZ-angle)%360<=turning) rotationZ=angle;
					else
					{
						if (angle>rotationZ)
						{
							if (angle-rotationZ<180) rotationZ+=turning;
							else rotationZ-=turning;
						}
						else
						{
							if (rotationZ-angle<180) rotationZ-=turning;
							else rotationZ+=turning;
						}
					}
					velocity.x=speed*Math.cos(rotationZ*Math.PI/180);
					velocity.y=speed*Math.sin(rotationZ*Math.PI/180);
					counter--;
					if (counter<=0) behaviour=2;
					break;
				}
				case 2:
				{
					//semmi extra, ezt az esetet a super.enterFrame(e) kezeli
					break;
				}
			}
		}
		
		override public function giveDamage(target:MovieClip):Number
		{
			//if(velocity.x > 0)
				//target.addChild(new LaserMark(x+width*Math.cos(rotationZ*Math.PI/180)-target.x, y-target.y));
			//else
			if(target)	target.addChild(new LaserMark(x+width*Math.sin(rotationZ*Math.PI/180)-target.x, y-target.y));
		
			this.kill();
			return damage;
		}
		
		public function fire()
		{
			if (behaviour==0) behaviour=1;
			counter=30;
		}
		
		public function getState():Number{
			return behaviour;
		}
	}
	
}
