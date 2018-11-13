const objects = [];

function setup(){

    createCanvas(700, 700);

    background(150);
    noStroke();
    smooth();


    let circle = new Circle(252, 144, 100);
    objects.push(circle);

    let quad = new Quad(300, 300, 100);
    objects.push(quad);

//     triangle(18, 18, 18, 360, 81, 360);


//   quad(189, 18, 216, 18, 216, 360, 144, 360);


//   ellipse(252, 144, 72, 72);

}

var i = 1;
function draw(){
    for(let i in objects){
        objects[i].draw();
    }
}

function Circle(x, y, r){

    this.x = x;
    this.y = y;
    this.r = r;

    this.draw = function(){
        fill(220, 10, 10);
        ellipse(this.x - (this.r / 2), this.y - (this.r / 2), this.r, this.r);
    }
}

function Quad(x, y, l){

    this.x = x;
    this.y = y;
    this.l = l;

    this.draw = function(){
        fill(10, 220, 10);
        let halfL = this.l / 2;
        quad(this.x - halfL, this.y - halfL, 
             this.x - halfL + this.l, this.y - halfL, 
             this.x - halfL + this.l, this.y - halfL + this.l,
             this.x- halfL, this.y - halfL + this.l);
    }
}

function Triangle(b, h, l){

    this.b = b;
    this.h = h;
    this.l = l;

    this.draw = function(){
        fill(10, 220, 10);
        let halfL = this.l / 2;
        quad(this.x - halfL, this.y - halfL, 
             this.x - halfL + this.l, this.y - halfL, 
             this.x - halfL + this.l, this.y - halfL + this.l,
             this.x- halfL, this.y - halfL + this.l);
    }
}