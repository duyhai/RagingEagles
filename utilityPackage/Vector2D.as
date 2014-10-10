package utilityPackage
{
	import flash.utils.ByteArray;
	
	public class Vector2D{
	
		public var x:Number;
		public var y:Number;
		
		public function Vector2D(x:Number = 0, y:Number = 0){
		
			this.x = x;
			this.y = y;
		
		}
		
		public function length():Number{
		
			return Math.sqrt(x*x + y*y);
		
		}
		
		public function add(v:Vector2D):Vector2D{
		
			return new Vector2D(x + v.x, y + v.y);
		
		}
		
		public function subtract(v:Vector2D):Vector2D{
		
			return new Vector2D(x - v.x, y - v.y);
		
		}
		
		public function incrementBy(v:Vector2D):void{
		
			x += v.x;
			y += v.y;
		
		}
		
		public function decrementBy(v:Vector2D):void{
		
			x -= v.x;
			y -= v.y;
		
		}
		
		public function scaleBy(n:Number):void{
			x*=n;
			y*=n;
		}
		
		public function dotProduct(v:Vector2D):Number{
		
			return x*v.x + y*v.y;
		
		}
		
		public function copyFrom(v:Vector2D):void{
		
			x = v.x;
			y = v.y;
		
		}
		
		public function clone():Vector2D{
		
			return new Vector2D(x, y);
		
		}
		
		public function equals(v:Vector2D):Boolean{
		
			return (x == v.x && y == v.y);
		
		}
		
		public function nearEquals(v:Vector2D, tolerance:Number):Boolean{
		
			return (Math.sqrt((x-v.x)*(x-v.x) + (y-v.y)*(y-v.y)) < tolerance);
		
		}		
		
		public function negate():void{
		
			 x *= -1;
			 y *= -1;
		
		}		
		
		public function normalize():void{	//ez normailizálja a vektort
		
			x /= this.length(); // biztos jó ez így? ha x-et leosztod akkor a 
			y /= this.length(); // következő length hívás már más értéket ad
		
		}
		
		public function normalized():Vector2D{	//ez visszaad egy normalizált klónt
			var v:Vector2D=this.clone();
			v.normalize();
			return v;
		}
		
		public static function angleBetween(v:Vector2D, w:Vector2D):Number{
		
			return Math.acos((v.x*w.x + v.y*w.y)/v.length()/w.length());
		
		}		
		
		public static function distance(v:Vector2D, w:Vector2D):Number{
		
			return Math.sqrt((w.x-v.x)*(w.x-v.x) + (w.y-v.y)*(w.y-v.y));
		
		}
		
		public static function sgn(n:Number):Number{
			if (n==0) return 0;
			else
				if (n<0) return -1;
				else return 1;
		}
	
		public static function deepcopy(source:Object):* //ezt az adobe honlapjáról néztem, elvileg így lehet a legegyszerűbben tömböt klónozni
		{ 
    		var myBA:ByteArray = new ByteArray(); 
    		myBA.writeObject(source); 
    		myBA.position = 0; 
    		return(myBA.readObject()); 
		}
	
	}

}