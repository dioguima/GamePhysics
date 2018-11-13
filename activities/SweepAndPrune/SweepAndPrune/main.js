const objectsArray = [];
var gForceVector;
var lastFrameDateTime;

function setup() {

    gForceVector = createVector(0, 10);
    lastFrameDateTime = millis();

    
    noStroke();
    smooth();


    let circle = new Circle(252, 144, 100);
    objectsArray.push(circle);
    circle = new Circle(500, 144, 100);
    objectsArray.push(circle);

    // let quad = new Quad(300, 300, 100);
    // objects.push(quad);

    //     triangle(18, 18, 18, 360, 81, 360);


    //   quad(189, 18, 216, 18, 216, 360, 144, 360);


    //   ellipse(252, 144, 72, 72);

}

var i = 1;

function draw() {
    createCanvas(700, 700);
    background(220);

    const deltaTime = (millis() - lastFrameDateTime) / 1000;
    lastFrameDateTime = millis();
    for (let i in objectsArray) {
        objectsArray[i].update(deltaTime);
        objectsArray[i].draw();
    }
}

function Circle(x, y, r) {

    this.x = x;
    this.y = y;
    this.r = r;
    this.velocity = createVector(2, 0);

    this.isColliding = function(gameObject){

        const maxDist = this.r + gameObject.r;
        const catOp = this.x - gameObject.x;
        

    }

    this.getExtremePoint = function(gameObject){
        return createVector(gameObject.x, height);
    }

    this.update = function (deltaTime) {
        if (this.y > height || this.y < 0) {
            this.velocity = createVector(this.velocity.x, this.velocity.y * -1);
            this.y = this.y < 0 ? 0 : height;
        }
        else if(this.x > width || this.x < 0){
            this.velocity = createVector(this.velocity.x * -1, this.velocity.y);
            this.x = this.x < 0 ? 0 : width;
        }
        else {
            this.velocity.add(gForceVector.x, gForceVector.y * deltaTime);
            this.x += this.velocity.x;
            this.y += this.velocity.y;
        }
    },

        this.draw = function () {
            fill(220, 10, 10);
            ellipse(this.x - (this.r / 2), this.y - (this.r / 2), this.r, this.r);
            
        }
}

function Quad(x, y, l) {

    this.x = x;
    this.y = y;
    this.l = l;

    this.draw = function () {
        fill(10, 220, 10);
        let halfL = this.l / 2;
        quad(this.x - halfL, this.y - halfL,
            this.x - halfL + this.l, this.y - halfL,
            this.x - halfL + this.l, this.y - halfL + this.l,
            this.x - halfL, this.y - halfL + this.l);
    }
}

function Triangle(b, h, l) {

    this.b = b;
    this.h = h;
    this.l = l;
    this.velocity = createVector(0, 0);

    this.update = function (deltaTime) {

    },

        this.draw = function () {
            fill(10, 220, 10);
            let halfL = this.l / 2;
            quad(this.x - halfL, this.y - halfL,
                this.x - halfL + this.l, this.y - halfL,
                this.x - halfL + this.l, this.y - halfL + this.l,
                this.x - halfL, this.y - halfL + this.l);
        }
}