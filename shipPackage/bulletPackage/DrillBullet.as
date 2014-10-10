package shipPackage.bulletPackage
{
	
	import effectPackage.*;
	import flash.display.MovieClip;
	import shipPackage.*;
	import menuPackage.*;
	import flash.events.Event;
	import flash.filters.GlowFilter; 
	
	public class DrillBullet extends Bullet
	{
		 private static var dmg_dec_rate:Number=0.2;
		 private static var min_dmg:Number=8;
		 private var glow_dmg:Number=10;
		 private var banlist:Array = new Array(); //A már ütközött hajókon ne fúrjon lyukat.
		 
		 public function DrillBullet(pos:Vector2D=null, velocity:Vector2D = null)
		 {
			 super(true, min_dmg*(1+TalentMenu.Instance().GetSpecTalent().GetTalent(1)/5),pos,velocity);	//ezt majd még ellenőrizni
			 //addEventListener("enterFrame", enterFrame); ez már benne van a ship-ben, csak overrideolni kell majd
			 addEventListener("enterFrame", enterFrame2);
			 glow.alpha=1;
		 }
		 
		 
		 public function enterFrame2(e:Event)
		 {			
			glow_dmg-=dmg_dec_rate;
			if (glow_dmg<0) glow_dmg=0;
			glow.alpha=glow_dmg/10;
			//this.filters=[new GlowFilter (0x6699FF,glow_dmg/10,6,4,3,3,false,false)];//minden frame-ben új filtert létrehozni
			//pazarlás, ezt csak ideiglenes megoldásnak gondoltam, hogy azért lássuk mi történik
		 }
		 
		 override public function kill()
		 {
			 removeEventListener("enterFrame", enterFrame2);
			 super.kill();
		 }
		 
		 override public function giveDamage(target:MovieClip):Number
		{
			if(target && banlist.indexOf(target) < 0)
			{	
				//if(velocity.x > 0)
					target.addChild(new LaserMark(x+width-target.x, y-target.y));
				//else
					//target.addChild(new LaserMark(x-width-target.x, y-target.y));
				banlist.push(target);
			}
							
			glow_dmg/=(1+(1/*-Game.talentFrame.talent3.skill[3]/5*/));
			damage/=(1+(1/*-Game.talentFrame.talent3.skill[3]/5*/));
			return (damage+glow_dmg);
		 }
	}
}