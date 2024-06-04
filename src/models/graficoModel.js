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

function montarSelect(idUsuario, idSensor) {
    var instrucaoSql = `
    SELECT DISTINCT DATE_FORMAT(tm.horaMedida, '%d/%m/%Y') AS dataMedida
    FROM temperaturaMedida tm
    JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
    JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
    WHERE u.idUsuario = ${idUsuario} AND d.idDispositivo = ${idSensor}
    ORDER BY dataMedida;
    `;

    return database.executar(instrucaoSql);
}

function montarSelectDispositivo(idUsuario) {
    var instrucaoSql = `
    SELECT 
    d.idDispositivo,
    d.fkEmpresa,
    d.nome AS nomeDispositivo
    FROM 
    usuario u
    JOIN 
    empresa e ON u.fkEmpresa = e.idEmpresa
    JOIN 
    dispositivo d ON e.idEmpresa = d.fkEmpresa
    WHERE 
    u.idUsuario = ${idUsuario};
    `;

    return database.executar(instrucaoSql);
}


module.exports = { contagemOcorrencia, historicoDiario, montarSelect, montarSelectDispositivo };