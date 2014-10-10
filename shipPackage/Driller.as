package shipPackage
{
	
	import shipPackage.bulletPackage.*;
	import menuPackage.*;
	import flash.events.Event;
    import flash.display.MovieClip;
	
	public class Driller extends HeroShip
	{
		public function Driller(firerate:Number = 5, health:Number = 600, pos:Vector2D = null)
		{
			super(firerate,health,pos);
		}
		
		override protected function shoot()
		{
			stage.addChild(new DrillBullet(new Vector2D(this.x-21,this.y+14), new Vector2D(10,0)));
		}
	}
}