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
    $('#output').val(JSON.stringify(box))
}