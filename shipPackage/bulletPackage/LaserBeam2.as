package shipPackage.bulletPackage
{
    import shipPackage.*;
	import menuPackage.*;
    import flash.events.Event;
    import flash.display.MovieClip;
      
    public class LaserBeam2 extends LaserBeam{
		 
		 public function LaserBeam2(heroShipPos:MovieClip, firerate:Number = 5, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null){
			 super(heroShipPos, firerate, dmg, pos, velocity);
		 }
		 
		 override protected function setPos()
		 {
			 x = heroShipPos.x+heroShipPos.width;
			 y = heroShipPos.y;
		 }
	}
}