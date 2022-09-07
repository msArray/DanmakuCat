function build(){
    var box = {
        x:$('#spx').val()*1,
        y:$('#spy').val()*1,
        size:$('#bsize').val()*1,
        checktime:$('#checktime').val()*1000,
        poptime:$('#spawntime').val()*1000,
        rmtime:$('#removetime').val()*1000,
    }
    console.log(box)
    if($('#output').val()==""){
        $('#output').val(JSON.stringify(box))
    }else{
        $('#output').val($('#output').val()+','+JSON.stringify(box))
    }
}
function reset(){
    $('#output').val("")
}
function copytx() {


    var text = document.getElementById("output");
    
    text.select();
    document.execCommand("copy");
    
    }