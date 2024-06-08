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
    var idUsuario = req.body.idUsuarioServer;

    graficoModel.contagemOcorrencia(data, idUsuario).then((resultado) => {
        res.status(200).json(resultado);
    });

}

function result(req, res) {

    var id = req.body.idServer;
    
    graficoModel.result(id).then((resultado) => {
        res.status(200).json(resultado);
    });

}

function montarSelect(req, res) {
    var idUsuario = req.body.idUsuarioServer;
    var idSensor = req.body.idSensorServer;

    graficoModel.montarSelect(idUsuario, idSensor).then((resultado) => {
        res.status(200).json(resultado);
    });

}

function montarSelectDispositivo(req, res) {
    var idUsuario = req.body.idUsuarioServer;

    graficoModel.montarSelectDispositivo(idUsuario).then((resultado) => {
        res.status(200).json(resultado);
    });

}

function buscarMediaDiaria(req, res) {
    var fkDispositivo = req.body.fkDispositivoServer;
    var data = req.body.dataServer;

    graficoModel.buscarMediaDiaria(fkDispositivo, data).then((resultado) => {
        res.status(200).json(resultado);
    });

}


module.exports = {
    historicoDiario,
    contagemOcorrencia,
    result,
    montarSelect,
    montarSelectDispositivo,
    buscarMediaDiaria
};