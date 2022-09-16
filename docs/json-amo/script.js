function count(){
    let jsondata = $("#data").val()
    let datalong = Object.keys(jsondata).length;
    $("#out").val(datalong)
    console.log(datalong)
}