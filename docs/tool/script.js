function build(){
    var box = {
        x:$('#spx').val()*1,
        y:$('#spy').val()*1,
        size:$('#bsize').val()*1,
        checktime:$('#checktime').val()*1,
        poptime:$('#spawntime').val()*1,
        rmtime:$('#removetime').val()*1,
    }
    console.log(box)
    if($('#output').val()==""){
        $('#output').val(JSON.stringify(box))
    }else{
        $('#output').val($('#output').val()+','+JSON.stringify(box))
    }
}
function previewadd(){
    var prex = {
        x:$('#spx').val()*1,
        y:$('#spy').val()*1,
        size:$('#bsize').val()*1,
    }
    if($('#pren').val()==""){
        $('#pren').val(JSON.stringify(prex))
    }else{
        $('#pren').val($('#pren').val()+','+JSON.stringify(prex))
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