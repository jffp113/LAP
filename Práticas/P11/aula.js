class Suc{
	
	constructor(a){
		this.a = a;
	}
	
	first() {
		return this.a;
	}
	
	curr() {
		return this.a;
	}
	
	next() {
		return this.a;
	}
	
	at(i) {
		return this.a;
	}
	
	print(n) {
		for(var i = 0; i < n ; i++){
			console.log(this.a);
		}
	}
}


class SucArit extends Suc{
	
	constructor(a,inc){
		super(a);
		this.inc = inc;
		this.c = a;
	}
	
	first() {
		return super.first();
	}
	
	curr() {
		if(this.first() !== this.c)
			return this.c - this.inc;
		else
			return this.c;
	}
	
	next() {
		var tmp = this.c;
		this.c += this.inc;
		return tmp;
	}
	
	at(i) {
		var final = this.first();
		
		for(var j = 0; j < i; j++){
			final += this.inc;
		}
		return final;
	}
	
	print(n) {
		var tmp = this.c;
		this.c = super.first();
		
		for(var i = 0; i < n ; i++){
			console.log(this.next());
		}
		
		this.c = tmp;
	}
}


class UnitTest {
	
	
	static assertTrue(b) {
		return b === true;
	}
	static assertFalse(b){
		return b === false;
	}
	static assertEquals(x,y){
		if(x === y){
			return true;
		}
		else{
			console.log("Test Failed Receive '" + x + "' was expecting '" + y +"'");
			//return false;
		}
	}
	
}

class Tests {
	
    static testSucArit() {
        var a = new SucArit(10,1);
		var ar = [1,2,[3]];
		var br = [1,2,3];
		
		//Array.prototype.toStri
		console.log(UnitTest.assertEquals(ar.toString(),br.toString()));
		
		console.log(UnitTest.assertEquals(a.curr(),10));
		console.log(UnitTest.assertEquals(a.first(),10));
		console.log(UnitTest.assertEquals(a.next(),10));
		console.log(UnitTest.assertEquals(a.next(),11));
        console.log(UnitTest.assertEquals(a.next(),12));
        console.log(UnitTest.assertEquals(a.curr(),12));
		console.log(UnitTest.assertEquals(a.at(10),20));
		a.print(10);
    }


    static run() {
        this.testSucArit();
    }
}

Tests.run();