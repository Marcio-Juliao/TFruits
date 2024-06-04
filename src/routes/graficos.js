var express = require("express");
var router = express.Router();

var graficoController = require("../controllers/graficoController");

// TFRUIT

router.post("/result", function (req, res) {
    graficoController.result(req, res);
});

router.post("/historicoDiario", function (req, res) {
    graficoController.historicoDiario(req, res);
});

router.post("/contagemOcorrencia", function (req, res) {
    graficoController.contagemOcorrencia(req, res);
});

router.post("/montarSelect", function (req, res) {
    graficoController.montarSelect(req, res);
});

router.post("/montarSelectDispositivo", function (req, res) {
    graficoController.montarSelectDispositivo(req, res);
});


module.exports = router;