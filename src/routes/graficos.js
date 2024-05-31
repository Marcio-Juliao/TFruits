var express = require("express");
var router = express.Router();

var graficoController = require("../controllers/graficoController");

// TFRUIT

router.post("/historicoDiario", function (req, res) {
    graficoController.historicoDiario(req, res);
});

router.post("/contagemOcorrencia", function (req, res) {
    graficoController.contagemOcorrencia(req, res);
});

module.exports = router;