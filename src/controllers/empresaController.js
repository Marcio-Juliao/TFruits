var empresaModel = require("../models/empresaModel");

function buscarPorCnpj(req, res) {
  var cnpj = req.query.cnpj;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listar(req, res) {
  empresaModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;

  empresaModel.buscarPorId(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrar(req, res) {
  var cnpj = req.body.cnpj;
  var razaoSocial = req.body.razaoSocial;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    if (resultado.length > 0) {
      res
        .status(401)
        .json({ mensagem: `a empresa com o cnpj ${cnpj} já existe` });
    } else {
      empresaModel.cadastrar(razaoSocial, cnpj).then((resultado) => {
        res.status(201).json(resultado);
      });
    }
  });
}

// TFRUIT

function cadastrarEmpresa(req, res) {
  var nome = req.body.nomeServer;
  var email = req.body.emailServer;
  var telFixo = req.body.telFixoServer;
  var cnpj = req.body.cnpjServer;
  var cep = req.body.cepServer;
  var numEnd = req.body.numEndServer;
  var complemento = req.body.complementoServer;

  empresaModel.cadastrarEmpresa(nome, email, telFixo, cnpj, cep, numEnd, complemento).then((resultado) => {
    res.status(201).json(resultado);
  });

}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  cadastrarEmpresa
};
