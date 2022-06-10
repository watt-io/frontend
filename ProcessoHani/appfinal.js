/* Receber e inserir o nome da página anterior para essa */

var nome = sessionStorage.getItem("nome");
var h1t = document.querySelector("h1#tit");
h1t.innerHTML = `Olá, ${nome} vamos começar a <span>i</span>novar pela sua conta de luz?`

/* Fazer a barra e o input number conectar */

function mudar() {
    var valorbarra = document.getElementById("barra").value
    document.getElementById("valor").value = valorbarra
}

/* Aparecer Ofertas ao clicar botao */

function aparecer() {

    /* RESETAR A CADA PESQUISA */

    document.getElementById("oferta1").classList.remove("aparecer")
    document.getElementById("oferta2").classList.remove("aparecer")
    document.getElementById("oferta3").classList.remove("aparecer")
    document.getElementById("oferta4").classList.remove("aparecer")

    /* Lógica para valores diferentes */

    var valor = document.getElementById("valor");
    var custo = valor.value;

    if (custo >= 1000 && custo <= 40000){
        document.getElementById("oferta1").classList.add("aparecer")
        document.getElementById("oferta2").classList.add("aparecer")

        var economia = document.getElementById("economia1")
        var valoreconomia1 = custo/5 * 12

        valoreconomia1 = valoreconomia1.toFixed(2)

        var valoreconomia2 = custo/10 * 12

        valoreconomia2 = valoreconomia2.toFixed(2)
        economia.innerHTML = `R$ ${valoreconomia1}`
        economia = document.getElementById("economia2")
        economia.innerHTML = `R$ ${valoreconomia2}`
    }

    if (custo >= 10000 && custo <= 80000){

        document.getElementById("oferta3").classList.add("aparecer")

        var economia = document.getElementById("economia3")
        var valoreconomia3 = custo/4 * 12

        valoreconomia3 = valoreconomia3.toFixed(2)
        economia.innerHTML = `R$ ${valoreconomia3}`
    }

    if (custo >= 40000 && custo <= 100000){

        document.getElementById("oferta4").classList.add("aparecer")

        var economia = document.getElementById("economia4")
        var valoreconomia4 = custo/10 * 36

        valoreconomia4 = valoreconomia4.toFixed(2)
        economia.innerHTML = `${valoreconomia4} R$`
    }

    if (custo < 1000) {
        window.alert("Insira Um valor válido de 1000 a 100000")
    }
}