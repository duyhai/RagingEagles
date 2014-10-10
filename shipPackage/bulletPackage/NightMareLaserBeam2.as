package shipPackage.bulletPackage
{
    import shipPackage.*;
	import menuPackage.*;
    import flash.events.Event;
    import flash.display.MovieClip;
      
    public class NightMareLaserBeam2 extends LaserBeam2{
		
		public function NightMareLaserBeam2(heroShipPos:MovieClip, firerate:Number = 5, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null){
			super(heroShipPos, firerate, dmg, pos, velocity);
		}
	}
}