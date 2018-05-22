class Suc{
	
	constructor(a0){
		this.a0 = a0;
		this.c = a0;
	}
	
	first() {
		this.c = this.a0;
		return this.a0;
	}
	
	curr() {
		return this.c;
	}
	
	at(i) {
		this.first();
		for(var j = 0 ; j < i ; j++){
			this.next();
		}
		return this.curr();
	}
	
	print(n) {
		var tmp = this.c;
		this.c = this.first();
		
		for(var i = 0; i < n ; i++){
			console.log("[" + this.next() + "]");
		}
		
		this.c = tmp;
	}
}

class SucArit extends Suc{
	
	constructor(a0,inc){
		super(a0);
		this.inc = inc;
	}
	
	next() {
		this.c  += this.inc;
		return this.curr();
	}
	
}

class SucAritOpt extends SucArit{
	
	constructor(a0,inc){
		super(a0,inc);
	}
	
	at(i) {
		return (this.c = this.first() + i*this.inc);
	}
	
}

class SucGeo extends Suc{
	
	constructor(a0,factor){
		super(a0);
		this.factor = factor;
	}
	
	next() {
		this.c *= this.factor;
		return this.curr();
	}
	
	
}

class SucSum extends Suc{
	
	constructor(ai,bi){
		super(ai.first()+bi.first());
		this.ai = ai;
		this.bi = bi;
	}
	
	next() {
		this.c = this.ai.next() + this.bi.next(); 
		return this.curr();
	}
	
	first() {
		this.c = this.ai.first() + this.bi.first();
		return this.c
	}
}

class SucAlt extends Suc{
	constructor(ai,bi){
		super(ai.first)
		this.ai = ai;
		this.bi = bi;
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
		super.assertEquals(a.next(),11);
		super.assertEquals(a.next(),12);
        super.assertEquals(a.next(),13);
        super.assertEquals(a.curr(),13);
		super.assertEquals(a.next(),14);
		super.assertEquals(a.curr(),14);
		super.assertEquals(a.at(10),20);
		a.print(10);
    }
	
	static testSucAritOpt() {
        var a = new SucAritOpt(10,1);
	
		super.assertEquals(a.at(10),20);
		
		a.print(10);
    }

	static testSucGeo() {
        var a = new SucGeo(10,2);
	
		super.assertEquals(a.curr(),10);
		super.assertEquals(a.first(),10);
		super.assertEquals(a.next(),20);
		super.assertEquals(a.next(),40);
        super.assertEquals(a.next(),80);
        super.assertEquals(a.curr(),80);
		super.assertEquals(a.next(),160);
		super.assertEquals(a.curr(),160);
		//super.assertEquals(a.at(10),20);
		a.print(10);
    }
	
	static testSucSum() {
        var a = new SucSum(new SucArit(10,2), new SucArit(10,2));
		
		super.assertEquals(a.curr(),20);
		super.assertEquals(a.first(),20);
		super.assertEquals(a.next(),24);
		super.assertEquals(a.next(),28);
        super.assertEquals(a.next(),32);
        super.assertEquals(a.curr(),32);
		super.assertEquals(a.next(),36);
		super.assertEquals(a.curr(),36);
		//super.assertEquals(a.at(10),20);
		a.print(10);
    }
	
    static run() {
        this.testSucArit();
		this.testSucGeo();
		this.testSucSum();
		this.testSucAritOpt()
    }
}


Tests.run();