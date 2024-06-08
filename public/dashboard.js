function geraResult() {
    result();
    }

        esquerda.style.display = "none";
    

function Sair() {
    sessionStorage.clear();
    window.location = "./index.html";
}

b_usuario.innerHTML = sessionStorage.NOME_USUARIO;
b_empresa.innerHTML = sessionStorage.NOME_EMPRESA;


const showTimeNow = () => {
    //Selecinando a tag de destino
    const clockTag = document.querySelector('time');

    //Instanciando a classe Date
    let dateNow = new Date();
    //pegando os valores desejados
    let hh = dateNow.getHours();
    let mm = dateNow.getMinutes();
    let ss = dateNow.getSeconds();

    //validando a necessidade de adicionar zero na exibição
    hh = hh < 10 ? '0' + hh : hh;
    mm = mm < 10 ? '0' + mm : mm;
    ss = ss < 10 ? '0' + ss : ss;

    // atribuindo os valores e montando o formato da hora a ser exibido
    clockTag.innerText = hh + ':' + mm + ':' + ss;
}
//executando a funcao a cada 1 segundo
showTimeNow()
setInterval(showTimeNow, 1000);

var globalDatasSelect = [];
var globalDatasSelectDispositivo = [];


function montarSelectDispositivo() {

    var idUsuarioVar = sessionStorage.ID_USUARIO;

    fetch("/graficos/montarSelectDispositivo", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            idUsuarioServer: idUsuarioVar
        })
    }).then(function (resposta) {

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                globalDatasSelectDispositivo = json;

                for (var i = 0; i < (globalDatasSelectDispositivo.length); i++) {
                    var nomeAtual = globalDatasSelectDispositivo[i].nomeDispositivo;
                    var idAtual = globalDatasSelectDispositivo[i].idDispositivo;

                    sensor_select.innerHTML += `<option value="${idAtual}">${nomeAtual}</option>`

                }

            });

        } else {

            console.log("Houve um erro ao tentar montar o select!");

            resposta.text().then(texto => {
                console.error(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}

function montarSelect() {

    var idSensorVar = sensor_select.value;
    var idUsuarioVar = sessionStorage.ID_USUARIO;

    fetch("/graficos/montarSelect", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            idUsuarioServer: idUsuarioVar,
            idSensorServer: idSensorVar
        })
    }).then(function (resposta) {

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                globalDatasSelect = json;

                var lista_ax = [];
                for (var i = 0; i < (globalDatasSelect.length); i++) {
                    var dataAtual = globalDatasSelect[i].dataMedida;


                    if (lista_ax.indexOf(dataAtual) == -1) {
                        lista_ax.push(dataAtual);
                    }
                    select_dia.innerHTML = "<option disabled selected>data</option>"

                    for (var index = 0; index < lista_ax.length; index++) {
                        select_dia.innerHTML += `<option value="${lista_ax[index]}">${lista_ax[index]}</option>`

                    }

                }

            });

        } else {

            console.log("Houve um erro ao tentar montar o select!");

            resposta.text().then(texto => {
                console.error(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}

var dadosHistoricoDiario; // variavel global onde os dados obtidos serão armazenados, montar o grafico com essa variavel
function historicoDiario() { //precisa de um botão embaixo do select da data tipo "exibir resultados", para que quando apertar, monte este grafico

    esquerda.style.display = "flex";

    var dataVar = select_dia.value;

    var [dia, mes, ano] = dataVar.split('/')
    var dataVar = `${ano}-${mes}-${dia}`;

    console.log(dataVar);

    fetch("/graficos/historicoDiario", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            dataServer: dataVar
        })
    }).then(function (resposta) {

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                dadosHistoricoDiario = json;
                ajustaFormatoDiario();
                gerarGraficoDiario()

            });

        } else {

            console.log("Houve um erro ao tentar obter os dados do grafico de historico diario");

            resposta.text().then(texto => {
                console.error(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}

// mesma coisa aqui
var dadosContagemOcorrencia; // variavel global onde os dados obtidos serão armazenados, montar o grafico com essa variavel
function contagemOcorrencia() { //precisa de um botão embaixo do select da data tipo "exibir resultados", para que quando apertar, monte este grafico

    var dataVar = select_dia.value;

    var [dia, mes, ano] = dataVar.split('/')

    var dataVar = `${ano}-${mes}-${dia}`;
    console.log(dataVar);

    var idUsuarioVar = sessionStorage.ID_USUARIO;

    fetch("/graficos/contagemOcorrencia", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            dataServer: dataVar,
            idUsuarioServer: idUsuarioVar
        })
    }).then(function (resposta) {

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                dadosContagemOcorrencia = json;
                GerarGraficoContagem()

            });

        } else {

            console.log("Houve um erro ao tentar obter os dados do grafico de historico diario");

            resposta.text().then(texto => {
                console.error(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}

function ajustaFormatoDiario() {

    dadosHistoricoDiario[0].hora = `${dadosHistoricoDiario[0].hora}:00`;
    console.log(`ajustado!: ${dadosHistoricoDiario[0].hora}`);

}

var alertas = [];


function result() {

    var id = sensor_select.value;

    setInterval(function () {

        fetch("/graficos/result", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                idServer: id
            })
        }).then(function (resposta) {

            if (resposta.ok) {
                console.log(resposta);

                resposta.json().then(json => {
                    console.log(json);
                    console.log(JSON.stringify(json));

                    if (json[0].valor >= 12 && json[0].valor < 13) {
                        temperatura.innerHTML = `<div class="style_temp_ok">${json[0].valor}</div>`;
                    } else if (json[0].valor >= 10 && json[0].valor <= 14) {
                        temperatura.innerHTML = `<div class="style_temp_alerta">${json[0].valor}</div>`;
                    } else if (json[0].valor < 10 || json[0].valor > 14) {
                        temperatura.innerHTML = `<div class="style_temp_perigo">${json[0].valor}</div>`;
                        alerta.innerHTML = `<p>&nbsp; Caixa instável! A temperatura chegou a ${json[0].valor} &nbsp;</p>`;
                        alertas.push(json[0].valor)
                    }

                    for (var index = alertas.length; index < 0; index--) {

                        div_alertas.innerHTML +=`<p>&nbsp; Caixa instável! A temperatura chegou a ${json[0].valor} &nbsp;</p>`;
                    }




                });

            } else {

                console.log("Houve um erro ao tentar mostrar a temperatura");

                resposta.text().then(texto => {
                    console.error(texto);
                });
            }

        }).catch(function (erro) {
            console.log(erro);
        })
    }

        , 5000)
    return false;
}


function gerarGraficoDiario() {

    var dadosGrafico = [];
    var horasGrafico = [];
    var constanteTemp = [];
    for (var i = 0; i < dadosHistoricoDiario.length; i++) {

        dadosGrafico.push(dadosHistoricoDiario[i].temperatura);
        horasGrafico.push(dadosHistoricoDiario[i].hora);
        constanteTemp.push(12);

    }

    const data = {
        labels: horasGrafico,
        datasets: [{
            label: 'Temperatura',
            backgroundColor: '#F29F05',
            borderColor: '#F29F05',
            data: dadosGrafico
        },
                {
                    label: 'Temperatura Ideal',
                    data: constanteTemp,
                    fill: false,
                    backgroundColor: '#36A2EB',
                    borderColor: '#168EE0',
                    type: 'line',
                    order: 1,
                    pointRadius: 6
                }]
    };

    const config = {
        type: 'line',
        data: data,
        options: {

            scales: {
                y: {
                    min: 0,
                    max: 30
                }
            }
        }
    };
    const myChart = new Chart(document.getElementById('myChart'),
        config
    );



}
function GerarGraficoContagem() {

    var dadosGraficoOk = [];
    var dadosGraficoAlerta = [];
    var dia = [];
    var total = 0;

    dadosGraficoOk.push(dadosContagemOcorrencia[0].OK)
    dadosGraficoAlerta.push(dadosContagemOcorrencia[0].ALERTA)

    total = dadosGraficoOk[0] + dadosGraficoAlerta[0];
    
    var porcentagemOk = [(dadosGraficoOk[0] / total) * 100];
    var porcentagemAlerta = [(dadosGraficoAlerta[0] / total) * 100];
    
    dia.push(select_dia.value)
    
    //está muito bom, mas tente manipular as variaveis porcentagemOk e porcentagemAlerta para que elas sejam exibidas em porcentagem
    //exemplo: 50% ou 50.0% por favor, tente fazer isso. acredito que




    const data2 = {
        labels: dia,
        datasets: [{
            label: 'Temperatura Ultrapassou',
            backgroundColor: '#A60303',
            borderColor: '#A60303',
            data: porcentagemAlerta
        }, {
            label: 'Temperatura Mantida',
            backgroundColor: '#558C03',
            borderColor: '#558C03',
            data: porcentagemOk
        }]
    };

    const config2 = {
        type: 'bar',
        data: data2,
        options: {

            scales: {
                y: {
                    min: 0,
                    max: 30
                }
            }
        }
    };

    const myChart2 = new Chart(document.getElementById('myChart2'),
        config2
    );
}