var database = require("../database/config");

// TFRUIT

function historicoDiario(data) {
    var instrucaoSql = `
    SELECT valor AS temperatura, TIME(horaMedida) AS hora FROM temperaturaMedida WHERE DATE(horaMedida) = '${data}';
    `;
  
    return database.executar(instrucaoSql);
  }

function contagemOcorrencia(data, idUsuario) {
  var instrucaoSql = `
  SELECT
       
    (SELECT COUNT(tm.valor) 
     FROM temperaturaMedida tm
     JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
     JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
     WHERE (tm.valor > 11 AND tm.valor < 13)
       AND (DATE(tm.horaMedida) = '${data}')
       AND (u.idUsuario = ${idUsuario})) AS 'OK',
       
    (SELECT COUNT(tm.valor) 
     FROM temperaturaMedida tm
     JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
     JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
     WHERE (tm.valor >= 13 OR tm.valor <= 11)
       AND (DATE(tm.horaMedida) = '${data}')
       AND (u.idUsuario = ${idUsuario})) AS 'ALERTA';
  `;

  return database.executar(instrucaoSql);
}

module.exports = { contagemOcorrencia, historicoDiario };