package effectPackage
{
	import shipPackage.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import soundPackage.SoundMaster;
	
	public class Explosion extends MovieClip{
		
		protected var damage:Number;
		
		function Explosion(damage:Number = 0, pos:Vector2D = null){
			
			if(pos == null)	pos = new Vector2D();
			this.x = pos.x;
			this.y = pos.y;
			this.damage = damage;
			addEventListener("enterFrame", enterFrame, false, 0, true);
			SoundMaster.PlayExplosionSound();
			
		}
		
		function enterFrame(e:Event){
			
			if(damage != 0)
				for(var i in EnemyShip.list)				
					if(this.hitTestObject(EnemyShip.list[i]))										
						EnemyShip.list[i].takeDamage(damage);			
			
			if(this.currentFrame == this.totalFrames){
				
				removeEventListener("enterFrame", enterFrame);
				stage.removeChild(this);
				
			}
			
		}
		
	}
	
}