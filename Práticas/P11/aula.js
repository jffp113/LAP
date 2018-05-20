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
		return this.first() + (i-1)*this.inc;
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
	
	static logErr(a,b) {
		console.error("Test Failed Receive '" + a + "' was expecting '" + b +"'");
	}
	static assertEquals(x,y){
		if(x === y){
			return true;
		}
		this.logErr(x,y);
		return false;
	}
	
	static assertTrue(b) {
		return this.assertEquals(b,true);
	}
	static assertFalse(b){
		return this.assertEquals(b,false);
	}
	
	static assertUndefined(x){
		return this.assertEquals(x,undefined);
	}
	
	static assertNull(x){
		return this.assertEquals(x,null);
	}
	
}

class Tests extends UnitTest{
	
    static testSucArit() {
        var a = new SucArit(10,1);
	
		
		super.assertEquals(a.curr(),10);
		super.assertEquals(a.first(),10);
		super.assertEquals(a.next(),10);
		super.assertEquals(a.next(),11) ;
        super.assertEquals(a.next(),12);
        super.assertEquals(a.curr(),12);
		super.assertEquals(a.at(10),19);
		a.print(10);
    }
	
	static testSucGeo() {
		
        var a = new SucArit(10,1);
	
		super.assertEquals(a.curr(),10);
		super.assertEquals(a.first(),10);
		super.assertEquals(a.next(),10);
		super.assertEquals(a.next(),11) ;
        super.assertEquals(a.next(),12);
        super.assertEquals(a.curr(),12);
		super.assertEquals(a.at(10),19);
		a.print(10);
    }

    static run() {
		console.groupCollapsed("Test");
        this.testSucArit();
		this.testSucGeo();
    }
}

Tests.run();