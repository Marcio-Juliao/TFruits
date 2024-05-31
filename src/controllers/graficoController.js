var graficoModel = require("../models/graficoModel");

// TFRUIT

function historicoDiario(req, res) {
    var data = req.body.dataServer;

    graficoModel.historicoDiario(data).then((resultado) => {
        res.status(200).json(resultado);
    });

}

function contagemOcorrencia(req, res) {
    var data = req.body.dataServer;
    var idUsuario = req.body.dataServer;

    graficoModel.contagemOcorrencia(data, idUsuario).then((resultado) => {
        res.status(200).json(resultado);
    });

}

module.exports = {
    historicoDiario,
    contagemOcorrencia
};