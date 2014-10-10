package shipPackage
{
	
	import shipPackage.bulletPackage.*;
	import menuPackage.*;
	import flash.events.Event;
    import flash.display.MovieClip;
	
	public class RocketShip extends HeroShip
	{
		var timeto2ndmissile:Number=-1;
		
		public function RocketShip(firerate:Number = 20, health:Number = 600, pos:Vector2D = null)
		{
			super(firerate,health,pos);
		}
		
		override protected function enterFrame(e:Event)
		{
			super.enterFrame(e);
			if (timeto2ndmissile>0) timeto2ndmissile--;
			if (timeto2ndmissile<=0 && timeto2ndmissile>-1)
			{
				if (/*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(3)>0*/true)
				{
					stage.addChild( new HomingMissile(true, 30, 45, new Vector2D(this.x-21,this.y+14), new Vector2D(15,0))); //<<DUMMYVERSION//<<DUMMYVERSION
				}
				else if (TalentMenu.Instance(stage).GetSpecTalent().GetTalent(2)>0)
				{
					stage.addChild( new Missile(true, 30, 45, new Vector2D(this.x-21,this.y+14), new Vector2D(15,0))); //<<DUMMYVERSION
				}
				timeto2ndmissile=-1;
			}
		}
		
		override protected function shoot()
		{			
			stage.addChild( new Missile(true, 30, 45, new Vector2D(this.x-21,this.y+14), new Vector2D(15,0)));
			if (/*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(2)>0*/true)
			{
				timeto2ndmissile = firerate/3;
			}
		}
	}
}