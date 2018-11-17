const objectsArray = [];
var gForceVector;
var lastFrameDateTime;
const objectTypeEnum = { CIRCLE: 0, QUAD: 1 };
const ballsNumber = 10;
const ballSize = 20;

function setup() {

    gForceVector = createVector(0, 5);
    lastFrameDateTime = millis();


    noStroke();
    smooth();


    for (let i = 0; i < ballsNumber; i++) {
        let xPosition = (ballSize / 2) + (ballSize * 2) * i + 40 + (Math.floor(Math.random() * 20));
        let yPosition = (ballSize / 2) + (ballSize * 2) + 30 + (Math.floor(Math.random() * 350));
        // let yPosition = Math.floor(Math.random() * (height - ballSize));
        let circle = new Circle(xPosition, yPosition, ballSize);
        objectsArray.push(circle);
    }

    // circle = new Circle(500, 144, 20);
    // objectsArray.push(circle);
    // circle = new Circle(100, 144, 20);
    // objectsArray.push(circle);
    // circle = new Circle(50, 144, 20);
    // objectsArray.push(circle);
    // circle = new Circle(100, 300, 20);
    // objectsArray.push(circle);
    // circle = new Circle(120, 50, 20);
    // objectsArray.push(circle);
    // circle = new Circle(140, 200, 20);
    // objectsArray.push(circle);
    // let quad = new Quad(300, 300, 40);
    // objectsArray.push(quad);

    //     triangle(18, 18, 18, 360, 81, 360);


    //   quad(189, 18, 216, 18, 216, 360, 144, 360);


    //   ellipse(252, 144, 72, 72);

}

var i = 1;

function draw() {
    createCanvas(500, 500);
    background(220);

    const deltaTime = (millis() - lastFrameDateTime) / 1000;
    lastFrameDateTime = millis();

    // // if(deltaTime % 2 == 0){
    //     console.log(deltaTime)
    // // }

    objectsArray.sort((a,b) => {
        if(a.x > b.x){
            return 1;
        }else{
            return -1;
        }
    });

    for (let i in objectsArray) {
        objectsArray[i].update(deltaTime);

        for(let l in objectsArray){
            if (objectsArray[i] != objectsArray[l] && objectsArray[l].gamb < 0 && objectsArray[i].gamb < 0 &&
                (objectsArray[i].x + objectsArray[i].r >= objectsArray[l].x - objectsArray[l].r ||
                    objectsArray[i].y + objectsArray[i].r >= objectsArray[l].y - objectsArray[l].r)) {
                if (objectsArray[i].checkCollision(objectsArray[l])) {
                    var aux = objectsArray[l].velocity;
                    objectsArray[l].velocity = objectsArray[i].velocity;
                    objectsArray[i].velocity = aux;
                    objectsArray[l].gamb = 5;
                    objectsArray[i].gamb = 5;
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
    this.type = objectTypeEnum.CIRCLE;
    this.gamb = 0;

    this.checkCollision = function (gameObject) {

        const maxDist = this.r + gameObject.r;
        const catOp = this.x - gameObject.x;
        const catAd = this.y - gameObject.y;
        const hip = Math.sqrt(Math.pow(catOp, 2) + Math.pow(catAd, 2))

        return hip <= maxDist;
    }

    this.getExtremePoint = function (gameObject) {
        return createVector(gameObject.x, height);
    }

    this.update = function (deltaTime) {
        if (this.y + this.r > height || this.y - this.r < 0) {
            this.velocity = createVector(this.velocity.x, this.velocity.y * -1);
            this.y = this.y < this.r ? this.r : height - this.r;
        }
        else if (this.x + this.r > width || this.x - this.r < 0) {
            this.velocity = createVector(this.velocity.x * -1, this.velocity.y);
            this.x = this.x < this.r ? this.r : width - this.r;
        }
        else {
            this.velocity.add(gForceVector.x * deltaTime, gForceVector.y * deltaTime);
            this.x += this.velocity.x;
            this.y += this.velocity.y;
        }
        this.gamb -= 1;
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
    this.velocity = createVector(2, 0);
    this.type = objectTypeEnum.QUAD;

    this.checkCollision = function (gameObject) {
        return false;
    }

    this.update = function (deltaTime) {
        let halfL = this.l / 2;
        if (this.y + halfL > height || this.y - halfL < 0) {
            this.velocity = createVector(this.velocity.x, this.velocity.y * -1);
            this.y = this.y < halfL ? halfL : height - halfL;
        }
        else if (this.x + halfL > width || this.x - halfL < 0) {
            this.velocity = createVector(this.velocity.x * -1, this.velocity.y);
            this.x = this.x < halfL ? halfL : width - halfL;
        }
        else {
            this.velocity.add(gForceVector.x * deltaTime, gForceVector.y * deltaTime);
            this.x += this.velocity.x;
            this.y += this.velocity.y;
        }
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