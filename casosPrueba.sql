use padeltech;
INSERT INTO MetricasJuego (partido_id, usuario_id, velocidad_max_golpe, precision_media, distancia_recorrida)
VALUES (1, 3, 92.5, 87.0, 2200.0);
-- Verificar actualización de estadísticas
SELECT partidos_jugados, victorias, nivel_actual
FROM EstadisticasJugadores
WHERE usuario_id = 3;

-- Verificar desbloqueo de logros
SELECT ld.logro_id, l.nombre, ld.fecha
FROM LogrosDesbloqueados ld
JOIN Logros l ON ld.logro_id = l.logro_id
WHERE usuario_id = 3;

-- Este partido ya existe
INSERT INTO Partidos (pista_id, fecha_hora, tipo) 
VALUES (1, '2024-04-05 10:00:00', 'amistoso');

-- Intentar reservar esa misma pista a esa hora
INSERT INTO Reservas (usuario_id, pista_id, fecha_inicio, duracion, estado)
VALUES (2, 1, '2024-04-05 10:30:00', 60, 'activa');

-- Actualizar sus victorias manualmente 
UPDATE EstadisticasJugadores
SET victorias = 5
WHERE usuario_id = 5;

CALL verificar_victorias_y_desbloquear_logro(5); 

SELECT ld.usuario_id, l.nombre, ld.fecha
FROM LogrosDesbloqueados ld
JOIN Logros l ON ld.logro_id = l.logro_id
WHERE ld.usuario_id = 5;

-- Registrar el pago
CALL realizar_pago(2, NULL, 2, 1, 19.99);

-- Consultar el historial de pagos
SELECT p.monto, m.tipo, mp.detalles, p.fecha_pago
FROM Pagos p
LEFT JOIN Membresias m ON p.membresia_id = m.membresia_id
LEFT JOIN MetodosPago mp ON p.metodo_id = mp.metodo_id
WHERE p.usuario_id = 2;

-- rendimiento indivudual
SELECT 
    u.nombre,
    e.partidos_jugados,
    e.victorias,
    ROUND(AVG(mj.velocidad_max_golpe), 2) AS velocidad_promedio,
    ROUND(AVG(mj.precision_media), 2) AS precision_promedio
FROM Usuarios u
JOIN EstadisticasJugadores e ON u.user_id = e.usuario_id
JOIN MetricasJuego mj ON u.user_id = mj.usuario_id
WHERE u.user_id = 2
GROUP BY u.user_id;

-- partidos de un jugador
SELECT p.fecha_hora, p.tipo, jp.posicion
FROM Partidos p
JOIN JugadoresPartido jp ON p.partido_id = jp.partido_id
WHERE jp.usuario_id = 5;



