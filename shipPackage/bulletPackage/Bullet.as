package shipPackage.bulletPackage
{
    import shipPackage.*;
    import flash.events.Event;
    import flash.display.MovieClip;
     
    public class Bullet extends MovieClip{
         
        protected var velocity:Vector2D;
        protected var max_velocity:Vector2D;
        protected var acceleration:Vector2D;
        protected var destination:Vector2D;
		protected var isHero:Boolean;
		protected var damage:Number;
		static public var enemy_bullet_list:Array = new Array();
		static public var hero_bullet_list:Array = new Array();
		var killed:Boolean=false;	//hogy egy körben csak egyszer lehessen meghalni
         
        public function Bullet(ishero:Boolean = true, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null){
		isHero=ishero;
			damage = dmg;
            if (velocity == null) velocity = new Vector2D();
            if (pos == null) pos = new Vector2D();
            x = pos.x;
            y = pos.y;
            this.velocity = velocity;
            destination = pos;
             
            max_velocity = new Vector2D(12,12);
            acceleration = new Vector2D(03,06);
             
            addEventListener("enterFrame", enterFrame, false, 0, true);
		if (isHero)
		{
			hero_bullet_list.push(this);
		}
		else
		{
			enemy_bullet_list.push(this);
		}
        }
         
        protected function enterFrame(e:Event){
			x+=velocity.x;
			y+=velocity.y;
			if(x > 1000 || x < -100 || y > 550 || y < -100)
				kill();
			else
			{
				if (isHero)
				{
					for(var i in EnemyShip.list){
						if(this.hitTestObject(EnemyShip.list[i])){
							EnemyShip.list[i].takeDamage(this.giveDamage(EnemyShip.list[i]));
						}
					}
				}
				else
				{
					if (this.hitTestObject(GameClass.heroShip))	//<<DUMMYVERSION
					{
						GameClass.heroShip.takeDamage(this.giveDamage(GameClass.heroShip));	//<<DUMMYVERSION
					}
				}
			}
        }
         
        public function kill()
		{
			if (killed) return;
			removeEventListener("enterFrame", enterFrame);
			if (stage) stage.removeChild(this);	//szerintem itt kéne remove-olni a bullet_list-bõl is, de ezt még majd átgondolom
			for(var i in enemy_bullet_list)	//Kell. shootorialban is igy volt.
					if(enemy_bullet_list[i] == this)
						delete enemy_bullet_list[i];
			for(var j in hero_bullet_list)
					if(hero_bullet_list[j] == this)
						delete hero_bullet_list[j];
			killed=true;
		}
         
        public function setDestination(v:Vector2D)
        {
            destination=v;
        }
         
		public function giveDamage(target:MovieClip):Number
		{
			return damage;
		}
		 
    }
     
}