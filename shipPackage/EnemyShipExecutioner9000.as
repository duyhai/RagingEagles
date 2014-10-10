package shipPackage {
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EnemyShipExecutioner9000 extends EnemyShip {	//még meg kell oldani hogy hogy kapjon ez bónuszt az X22Commander-től
		
		var d0:X9DrillProjectile=null;
		var d1:X9DrillProjectile=null;
		var d2:X9DrillProjectile=null;
		var reload:Boolean=true;
		var turning:Number=5;
		var rot:Number=0;
		
		public function EnemyShipExecutioner9000(firerate:Number = 0, health:Number = EnumHealth.LEVEL_FOUR, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_THREE;
			maxspeedx=EnumSpeed.LEVEL_FOUR;
			maxspeedy=EnumSpeed.LEVEL_FOUR;
			speed = new Vector2D(maxspeedx, maxspeedy).length()/5;	//
		}
		
		override protected function enterFrame(e:Event)
		{
			if (reload && stage)
			{
				d0 = new X9DrillProjectile(this, false, bulletdamage+damagebonus, new Vector2D(-11,-20), 5);
				d0.rotationZ=270;
				stage.addChild(d0);
				d1 = new X9DrillProjectile(this, false, bulletdamage+damagebonus, new Vector2D(-29,-12), 5);
				d1.rotationZ=225;
				stage.addChild(d1);
				d2 = new X9DrillProjectile(this, false, bulletdamage+damagebonus, new Vector2D(-37,7), 5);
				d2.rotationZ=180;
				stage.addChild(d2);
				reload=false;
			}
			
			var angle:Number = Math.atan2(GameClass.heroShip.y-this.y,GameClass.heroShip.x-this.x)/Math.PI*180;
			if (Math.abs(rot-angle)%360<=turning) rot=angle;
			else
			{
				if (angle>rot)
				{
					if (angle-rot<180) rot+=turning;
					else rot-=turning;
				}
				else
				{
					if (rot-angle<180) rot-=turning;
					else rot+=turning;
				}
			}
			velocity.x=speed*Math.cos(rot*Math.PI/180);
			velocity.y=speed*Math.sin(rot*Math.PI/180);
			
			
			//x+=velocity.x;
			//y+=velocity.y;
			
			/*
			var v:Vector2D = new Vector2D(GameClass.heroShip.x-this.x,GameClass.heroShip.y-this.y);	//<<DUMMYVERSION
			velocity.x=speed*v.normalized().x;
			velocity.y=speed*v.normalized().y;*/
			super.enterFrame(e);
		}
		
		override public function kill()
		{
			if (d0.getState()==0)
			{
				d0.kill();
				d0=null;
			}
			if (d1.getState()==0)
			{
				d1.kill();
				d1=null;
			}
			if (d2.getState()==0)
			{
				d2.kill();
				d2=null;
			}
			super.kill();
			killed=true;
		}
		
		override public function takeDamage(d:Number, s:String=null){
			if (health>=0.75*maxhealth && health-d<0.75*maxhealth && d0)
				d0.fire();
			if (health>=0.5*maxhealth && health-d<0.5*maxhealth && d1)
				d1.fire();
			if (health>=0.25*maxhealth && health-d<0.25*maxhealth && d2)
				d2.fire();
			super.takeDamage(d,s);
		}
		
		override public function collide():Number
		{
			var drilldamage:Number=0;
			if (health>=maxhealth*0.75 && d0.getState()==0)
			{
				drilldamage+=bulletdamage+damagebonus;
				d0.kill();
			}
			if (health>=maxhealth*0.5 && d1.getState()==0)
			{
				drilldamage+=bulletdamage+damagebonus;
				d1.kill();
			}
			if (health>=maxhealth*0.25 && d2.getState()==0)
			{
				drilldamage+=bulletdamage+damagebonus;
				d2.kill();
			}
			if (!killed) this.kill();
			return (this.health/10+drilldamage);

		}
		
	}
	
}
