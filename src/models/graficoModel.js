var database = require("../database/config");

// TFRUIT

function historicoDiario(data) {
    var instrucaoSql = `
    SELECT ROUND(AVG(valor), 2) AS temperatura, date_format(horaMedida, '%H') as hora FROM temperaturaMedida 
    WHERE DATE(horaMedida) = '${data}' GROUP BY date_format(horaMedida, '%H');
    `;

    return database.executar(instrucaoSql);
}

function result(empresa) {
    var instrucaoSql =`
    SELECT valor FROM temperaturaMedida WHERE fkSensor = (SELECT idDispositivo FROM dispositivo where fkEmpresa = ${empresa} LIMIT 1) ORDER BY horaMedida DESC LIMIT 1;
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


module.exports = { contagemOcorrencia, historicoDiario, result, montarSelect, montarSelectDispositivo };