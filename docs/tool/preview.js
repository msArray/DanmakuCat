function setup() {
    createCanvas(600, 600);
}

function draw(){
    background(0);
    fill(5,255,255);
    rect(300+($('#spx').val()*1)-($('#bsize').val()*1)/2, 300+(-1*($('#spy').val()*1)-($('#bsize').val()*1)/2), $('#bsize').val()*1, $('#bsize').val()*1);

    let pree = "["+$('#pren').val()+"]"
    const obj = JSON.parse(pree);
    for(let i=0;i<Object.keys(obj).length;i++){
        rect(300+(obj[i].x*1)-(obj[i].size*1)/2, 300+(-1*(obj[i].y*1)-(obj[i].size*1)/2), obj[i].size*1, obj[i].size*1);
    }
}
