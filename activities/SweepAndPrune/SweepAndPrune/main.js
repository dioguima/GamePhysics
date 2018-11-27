const objectsArray = [];
var gForceVector;
var lastFrameDateTime;
const objectTypeEnum = { CIRCLE: 0, QUAD: 1 };
const ballSize = 15;
const quadSize = 15;

var uniformGrid;

function setup() {

    gForceVector = createVector(0, 5);
    lastFrameDateTime = millis();
    uniformGrid = new UniformGrid();

    noStroke();
    smooth();


    // for (let i = 0; i < ballsNumber; i++) {
    //     let xPosition = (ballSize / 2) + (ballSize * 2) * i + 40 + (Math.floor(Math.random() * 20));
    //     let yPosition = (ballSize / 2) + (ballSize * 2) + 30 + (Math.floor(Math.random() * 350));
    //     // let yPosition = Math.floor(Math.random() * (height - ballSize));
    //     let circle = new Circle(xPosition, yPosition, ballSize);
    //     objectsArray.push(circle);
    // }



    let circle = new Circle(500, 100, 20);
    objectsArray.push(circle);
    circle = new Circle(100, 50, 20);
    objectsArray.push(circle);
    circle = new Circle(50, 300, 20);
    objectsArray.push(circle);
    let quad = new Quad(200, 200, 40);
    objectsArray.push(quad);
    quad = new Quad(400, 100, 40);
    objectsArray.push(quad);
}

var i = 1;

function draw() {
    createCanvas(600, 600);
    background(220);

    const deltaTime = (millis() - lastFrameDateTime) / 1000;
    lastFrameDateTime = millis();

    objectsArray.sort((a, b) => {
        if (a.x > b.x) {
            return 1;
        } else {
            return -1;
        }
    });

    for (let i in objectsArray) {
        objectsArray[i].update(deltaTime);

        for (let l in objectsArray) {
            // if (objectsArray[i] != objectsArray[l] && objectsArray[l].cooldown < 0 && objectsArray[i].cooldown < 0 &&
            //     (objectsArray[i].x + objectsArray[i].r >= objectsArray[l].x - objectsArray[l].r ||
            //         objectsArray[i].y + objectsArray[i].r >= objectsArray[l].y - objectsArray[l].r)) {
            //     if (objectsArray[i].checkCollision(objectsArray[l])) {
            //         var aux = objectsArray[l].velocity;
            //         objectsArray[l].velocity = objectsArray[i].velocity;
            //         objectsArray[i].velocity = aux;
            //         objectsArray[l].cooldown = 5;
            //         objectsArray[i].cooldown = 5;
            //     }
            // }
        }

        objectsArray[i].draw();
    }

    uniformGrid.resolveColisions(objectsArray);
}

function Circle(x, y, r) {

    this.x = x;
    this.y = y;
    this.r = r;
    this.restituitionCoefficient = 0.99;
    this.velocity = createVector(2, 0);
    this.type = objectTypeEnum.CIRCLE;
    this.cooldown = 0;

    this.getExtremeLeft = function (gameObject) {
        return this.x - this.r;
    }

    this.getExtremeRight = function (gameObject) {
        return this.x + this.r;
    }

    this.getExtremeTop = function (gameObject) {
        return this.y - this.r;
    }

    this.getExtremeBottom = function (gameObject) {
        return this.y + this.r;
    }

    this.update = function (deltaTime) {
        if (this.y + this.r > height || this.y - this.r < 0) {
            this.velocity = createVector(this.velocity.x, this.velocity.y * -1);
            this.velocity.mult(this.restituitionCoefficient);
            this.y = this.y < this.r ? this.r : height - this.r;
        }
        else if (this.x + this.r > width || this.x - this.r < 0) {
            this.velocity = createVector(this.velocity.x * -1, this.velocity.y);
            this.velocity.mult(this.restituitionCoefficient);
            this.x = this.x < this.r ? this.r : width - this.r;
        }
        else {
            this.velocity.add(gForceVector.x * deltaTime, gForceVector.y * deltaTime);
            this.x += this.velocity.x;
            this.y += this.velocity.y;
        }
        this.cooldown -= 1;
    }

    this.draw = function () {
        fill(220, 10, 10);
        ellipse(this.x, this.y, this.r * 2, this.r * 2);
    }
}

function Quad(x, y, l) {

    this.x = x;
    this.y = y;
    this.l = l;
    this.restituitionCoefficient = 0.99;
    this.velocity = createVector(2, 0);
    this.type = objectTypeEnum.QUAD;
    this.cooldown = 0;

    this.getExtremeLeft = function (gameObject) {
        return this.x - this.l / 2;
    }

    this.getExtremeRight = function (gameObject) {
        return this.x + this.l / 2;
    }

    this.getExtremeTop = function (gameObject) {
        return this.y - this.l / 2;
    }

    this.getExtremeBottom = function (gameObject) {
        return this.y + this.l / 2;
    }

    this.update = function (deltaTime) {
        let halfL = this.l / 2;
        if (this.y + halfL > height || this.y - halfL < 0) {
            this.velocity = createVector(this.velocity.x, this.velocity.y * -1);
            this.velocity.mult(this.restituitionCoefficient);
            this.y = this.y < halfL ? halfL : height - halfL;
        }
        else if (this.x + halfL > width || this.x - halfL < 0) {
            this.velocity = createVector(this.velocity.x * -1, this.velocity.y);
            this.velocity.mult(this.restituitionCoefficient);
            this.x = this.x < halfL ? halfL : width - halfL;
        }
        else {
            this.velocity.add(gForceVector.x * deltaTime, gForceVector.y * deltaTime);
            this.x += this.velocity.x;
            this.y += this.velocity.y;
        }
        this.cooldown -= 1;
    }

    this.draw = function () {
        fill(10, 220, 10);
        let halfL = this.l / 2;
        quad(this.x - halfL, this.y - halfL,
            this.x - halfL + this.l, this.y - halfL,
            this.x - halfL + this.l, this.y - halfL + this.l,
            this.x - halfL, this.y - halfL + this.l);
    }
}

function UniformGrid() {


    this.resolveColisions = function (objectsArray) {


        let cellSizeX = width / 4;
        let cellSizeY = height / 4;

        let matrix = makeMatrix(4, 4);
        for (let i = 0; i < 4; i++) {
            for (let j = 0; j < 4; j++) {
                for (let objIndex = 0; objIndex < objectsArray.length; objIndex++) {
                    let currentObject = objectsArray[objIndex];
                    if (currentObject.getExtremeLeft() >= cellSizeX * i && currentObject.getExtremeLeft() <= cellSizeX * (i + 1) ||
                        currentObject.getExtremeRight() >= cellSizeX * i && currentObject.getExtremeRight() <= cellSizeX * (i + 1) ||
                        currentObject.getExtremeTop() >= cellSizeY * i && currentObject.getExtremeTop() <= cellSizeY * (i + 1) ||
                        currentObject.getExtremeBottom() >= cellSizeY * i && currentObject.getExtremeBottom() <= cellSizeY * (i + 1)) {
                        matrix[i][j].push(objectsArray[objIndex]);
                    }
                }
            }
        }

        for (let i = 0; i < 4; i++) {
            for (let j = 0; j < 4; j++) {
                for (let objIndex = 0; objIndex < matrix[i][j].length - 1; objIndex++) {
                    if (this.checkCollision(objectsArray[objIndex], objectsArray[objIndex + 1]) &&
                        objectsArray[objIndex + 1].cooldown < 0 &&
                        objectsArray[objIndex].cooldown < 0) {

                        let aux = objectsArray[objIndex].velocity;
                        objectsArray[objIndex].velocity = objectsArray[objIndex + 1].velocity;
                        objectsArray[objIndex + 1].velocity = aux;
                        objectsArray[objIndex].velocity.mult(objectsArray[objIndex].restituitionCoefficient);
                        objectsArray[objIndex + 1].velocity.mult(objectsArray[objIndex].restituitionCoefficient);
                        objectsArray[objIndex + 1].cooldown = 5;
                        objectsArray[objIndex].cooldown = 5;
                    }
                }
            }
        }
    }

    this.checkCollision = function (objectA, objectB) {
        if (objectA.type == objectTypeEnum.CIRCLE && objectB.type == objectTypeEnum.CIRCLE) {
            return this.checkCollisionBetweenCircles(objectA, objectB);
        } else if (objectA.type == objectTypeEnum.QUAD && objectB.type == objectTypeEnum.QUAD) {
            return this.checkCollisionBetweenQuads(objectA, objectB);
        } else if (objectA.type == objectTypeEnum.CIRCLE && objectB.type == objectTypeEnum.QUAD){
            return this.checkCollisionBetweenCircleAndSquare(objectA, objectB);
        }else if (objectA.type == objectTypeEnum.QUAD && objectB.type == objectTypeEnum.CIRCLE){
            return this.checkCollisionBetweenCircleAndSquare(objectB, objectA);
        }else {
            return false;
        }
    }

    this.checkCollisionBetweenCircles = function (objectA, objectB) {
        const maxDist = objectA.r + objectB.r;
        const catOp = objectA.x - objectB.x;
        const catAd = objectA.y - objectB.y;
        const hip = Math.sqrt(Math.pow(catOp, 2) + Math.pow(catAd, 2))
        return hip <= maxDist;
    }

    this.checkCollisionBetweenQuads = function (objectA, objectB) {
        let xAxisCriteria = (objectA.getExtremeLeft() <= objectB.getExtremeLeft() &&
        objectA.getExtremeRight() >= objectB.getExtremeRight() ||
        objectA.getExtremeRight() >= objectB.getExtremeLeft() &&
        objectA.getExtremeLeft() <= objectB.getExtremeLeft());

        let yAxisCriteia = (objectA.getExtremeTop() >= objectB.getExtremeTop() &&
        objectA.getExtremeTop() <= objectB.getExtremeBottom() ||
        objectA.getExtremeBottom() >= objectB.getExtremeTop() &&
        objectA.getExtremeTop() <= objectB.getExtremeTop());

        return xAxisCriteria && yAxisCriteia;
    }

    this.checkCollisionBetweenCircleAndSquare = function(circleA, squareB){
        return circleA.r >= dist(circleA.x, circleA.y, squareB.getExtremeLeft(), squareB.getExtremeTop()) ||
            circleA.r >= dist(circleA.x, circleA.y, squareB.getExtremeLeft(), squareB.getExtremeBottom()) ||
            circleA.r >= dist(circleA.x, circleA.y, squareB.getExtremeRight(), squareB.getExtremeTop()) ||
            circleA.r >= dist(circleA.x, circleA.y, squareB.getExtremeRight(), squareB.getExtremeBottom());
    }

}

function makeMatrix(x, y) {
    let ret = [];
    for (let i = 0; i < x; i++) {
        ret[i] = [];
        for (let j = 0; j < y; j++) {
            ret[i][j] = [];
        }
    }
    return ret;
}