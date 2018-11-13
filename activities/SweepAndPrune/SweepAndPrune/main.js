const objectsArray = [];
var gForceVector;
var lastFrameDateTime;

function setup() {

    gForceVector = createVector(0, 10);
    lastFrameDateTime = millis();

    
    noStroke();
    smooth();


    let circle = new Circle(252, 144, 30);
    objectsArray.push(circle);
    circle = new Circle(500, 144, 30);
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

        for(let l in objectsArray){
            if(objectsArray[i] != objectsArray[l]){
                if(objectsArray[i].checkCollision(objectsArray[l])){
                    const velocitiesSum = createVector(
                        objectsArray[i].velocity.x + objectsArray[l].velocity.x, 
                        objectsArray[i].velocity.y + objectsArray[l].velocity.y);
                     *= -0.9;
                    objectsArray[l].velocity.x *= -0.9;
                }
            }
        }

        objectsArray[i].draw();
    }
}

function Circle(x, y, r) {

    this.x = x;
    this.y = y;
    this.r = r;
    this.velocity = createVector(2, 0);

    this.checkCollision = function(gameObject){

        const maxDist = this.r + gameObject.r;
        const catOp = this.x - gameObject.x;
        const catAd = this.y - gameObject.y;
        const hip = Math.sqrt(Math.pow(catOp, 2) + Math.pow(catAd, 2))

        return hip <= maxDist;
    }

    this.getExtremePoint = function(gameObject){
        return createVector(gameObject.x, height);
    }

    this.update = function (deltaTime) {
        if (this.y + this.r > height || this.y - this.r < 0) {
            this.velocity = createVector(this.velocity.x, this.velocity.y * -0.9);
            this.y = this.y < this.r ? this.r : height - this.r;
        }
        else if(this.x + this.r > width || this.x - this.r < 0){
            this.velocity = createVector(this.velocity.x * -0.9, this.velocity.y);
            this.x = this.x < this.r ? this.r : width - this.r;
        }
        else {
            this.velocity.add(gForceVector.x * deltaTime, gForceVector.y * deltaTime);
            this.x += this.velocity.x;
            this.y += this.velocity.y;
        }
    },

        this.draw = function () {
            fill(220, 10, 10);
            ellipse(this.x, this.y, this.r * 2, this.r * 2);
            
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