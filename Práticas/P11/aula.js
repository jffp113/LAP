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
		super(ai.first());
		this.ai = ai;
		this.bi = bi;
		this.is_ai = true;
	}
	
	next(){
		
		if(this.is_ai){
			this.c = this.ai.next();
			this.is_ai = false;
		}
		else{
			this.c = this.bi.next();
			this.is_ai = true;
		}
		
		return this.curr();
	}
	
	first(){
		this.bi.first();
		return this.c = this.ai.first();
	}
	
}

class SucFilt extends Suc{
	constructor(ai,filter){
		super(0);
		this.ai = ai;
		this.filter = filter;
		this.next();
	}
	
	next(){
		do{
			this.c = this.ai.next();
		}while((this.curr() % this.filter) != 0)
		
		return this.curr();
		
	}
	
	first(){
		this.c = this.ai.first();
		if(this.c % this.filter != 0){
			return this.next()
		}
		else{
			return this.curr();
		}
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
	
		this.assertEquals(a.curr(),10);
		this.assertEquals(a.first(),10);
		this.assertEquals(a.next(),11);
		this.assertEquals(a.next(),12);
        this.assertEquals(a.next(),13);
        this.assertEquals(a.curr(),13);
		this.assertEquals(a.next(),14);
		this.assertEquals(a.curr(),14);
		this.assertEquals(a.at(10),20);
		//a.print(10);
    }
	
	static testSucAritOpt() {
        var a = new SucAritOpt(10,1);
	
		this.assertEquals(a.at(10),20);
		
		//a.print(10);
    }

	static testSucGeo() {
        var a = new SucGeo(10,2);
	
		this.assertEquals(a.curr(),10);
		this.assertEquals(a.first(),10);
		this.assertEquals(a.next(),20);
		this.assertEquals(a.next(),40);
        this.assertEquals(a.next(),80);
        this.assertEquals(a.curr(),80);
		this.assertEquals(a.next(),160);
		this.assertEquals(a.curr(),160);
		//super.assertEquals(a.at(10),20);
		//a.print(10);
    }
	
	static testSucSum() {
        var a = new SucSum(new SucArit(10,2), new SucArit(10,2));
		
		this.assertEquals(a.curr(),20);
		this.assertEquals(a.first(),20);
		this.assertEquals(a.next(),24);
		this.assertEquals(a.next(),28);
        this.assertEquals(a.next(),32);
        this.assertEquals(a.curr(),32);
		this.assertEquals(a.next(),36);
		this.assertEquals(a.curr(),36);
		//super.assertEquals(a.at(10),20);
		//a.print(10);
    }
	
	static testSucAlt() {
        var a = new SucAlt(new SucArit(1,1), new SucArit(1,1));
		
		this.assertEquals(a.curr(),1);
		this.assertEquals(a.first(),1);
		this.assertEquals(a.next(),2);
		this.assertEquals(a.next(),2);
        this.assertEquals(a.next(),3);
        this.assertEquals(a.curr(),3);
		this.assertEquals(a.next(),3);
		this.assertEquals(a.curr(),3);
		this.assertEquals(a.first(),1);
		this.assertEquals(a.next(),2);
		this.assertEquals(a.next(),2);
        this.assertEquals(a.next(),3);
        this.assertEquals(a.curr(),3);
		this.assertEquals(a.next(),3);
		this.assertEquals(a.curr(),3);
		super.assertEquals(a.at(100),51);
		//a.print(10);
    }
	
	static testSucFilt() {
		var a = new SucFilt(new SucArit(1,1),2);
		
		this.assertEquals(a.curr(),2);
		this.assertEquals(a.next(),4);
		this.assertEquals(a.curr(),4);
		this.assertEquals(a.next(),6);
		this.assertEquals(a.next(),8);
		this.assertEquals(a.first(),2);
		this.assertEquals(a.curr(),2);
		this.assertEquals(a.next(),4);
		this.assertEquals(a.curr(),4);
		this.assertEquals(a.next(),6);
		this.assertEquals(a.next(),8);
	}
	
    static run() {
        this.testSucArit();
		this.testSucGeo();
		this.testSucSum();
		this.testSucAritOpt();
		this.testSucAlt()
		this.testSucFilt();
    }
}


Tests.run();