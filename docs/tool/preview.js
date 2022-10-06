function setup() {
    createCanvas(600, 600);
}

function draw(){
    background(0);
    fill(5,255,255);
    rect(300+($('#spx').val()*1)-($('#bsize').val()*1)/2, 300+(-1*($('#spy').val()*1)-($('#bsize').val()*1)/2), $('#bsize').val()*1, $('#bsize').val()*1);
}
