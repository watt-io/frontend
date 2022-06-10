function fazer(){
    var name = document.querySelector("input#nome")
    var res = document.querySelector("div#resultado")
    res.innerHTML= `${name.value}`
    sessionStorage.setItem('nome', name.value);
    window.location.href='index2.html'
}