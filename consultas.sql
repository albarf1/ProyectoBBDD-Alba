use padeltech;
-- 1. Usuarios y membresías
SELECT u.nombre, u.email, m.tipo AS membresia, m.precio_mensual
FROM Usuarios u
LEFT JOIN Membresias m ON u.membresia_id = m.membresia_id;


-- mostrar los jugadores de un partido
SELECT u.nombre, jp.posicion
FROM JugadoresPartido jp
JOIN Usuarios u ON jp.usuario_id = u.user_id
WHERE jp.partido_id = 1;

-- ver estadiscita del jugador
SELECT e.usuario_id, e.partidos_jugados, e.victorias, e.nivel_actual
FROM EstadisticasJugadores e
WHERE e.usuario_id = 2;


-- ver pagos realizados de un usuario
SELECT p.pago_id, m.tipo AS membresia, r.duracion, p.monto, p.fecha_pago
FROM Pagos p
LEFT JOIN Membresias m ON p.membresia_id = m.membresia_id
LEFT JOIN Reservas r ON p.reserva_id = r.reserva_id
WHERE p.usuario_id = 7;

-- listar pasrtido, pista y tipo
SELECT p.partido_id, pt.nombre AS pista, p.fecha_hora, p.tipo
FROM Partidos p
JOIN Pistas pt ON p.pista_id = pt.pista_id;

-- promedio de velocidad y precision del jugador
SELECT usuario_id,
       AVG(velocidad_max_golpe) AS velocidad_promedio,
       AVG(precision_media) AS precision_promedio
FROM MetricasJuego
GROUP BY usuario_id;


-- top 5 jugadores
SELECT u.nombre, e.victorias
FROM EstadisticasJugadores e
JOIN Usuarios u ON e.usuario_id = u.user_id
ORDER BY e.victorias DESC
LIMIT 5;

-- rendimiento por partido
  SELECT mj.metrica_id, p.fecha_hora, u.nombre,
       mj.velocidad_max_golpe, mj.precision_media, mj.distancia_recorrida
FROM MetricasJuego mj
JOIN Partidos p ON mj.partido_id = p.partido_id
JOIN Usuarios u ON mj.usuario_id = u.user_id
ORDER BY p.fecha_hora DESC;
-- Estado de todas las pistas
SELECT pista_id, nombre, estado
FROM Pistas;


-- Estadísticas de jugadores
SELECT u.nombre, e.partidos_jugados, e.victorias, e.nivel_actual
FROM EstadisticasJugadores e
JOIN Usuarios u ON e.usuario_id = u.user_id;

-- Logros de un usuario (id = 2)
SELECT u.nombre, l.nombre AS logro, ld.fecha
FROM LogrosDesbloqueados ld
JOIN Usuarios u ON ld.usuario_id = u.user_id
JOIN Logros l ON ld.logro_id = l.logro_id
WHERE u.user_id = 2;

-- Historial de pagos
SELECT u.nombre, p.monto, p.fecha_pago,
       CASE
           WHEN p.reserva_id IS NOT NULL THEN CONCAT('Reserva ', p.reserva_id)
           WHEN p.membresia_id IS NOT NULL THEN CONCAT('Membresía ', m.tipo)
           ELSE 'Otro pago'
       END AS concepto
FROM Pagos p
JOIN Usuarios u ON p.usuario_id = u.user_id
LEFT JOIN Membresias m ON p.membresia_id = m.membresia_id
ORDER BY p.fecha_pago DESC;

-- Métricas promedio por jugador
SELECT usuario_id, AVG(velocidad_max_golpe) AS velocidad_media,
       AVG(precision_media) AS precision_media,
       SUM(distancia_recorrida) AS distancia_total
FROM MetricasJuego
GROUP BY usuario_id;

-- Ranking de jugadores por victorias
SELECT u.nombre, e.victorias
FROM EstadisticasJugadores e
JOIN Usuarios u ON e.usuario_id = u.user_id
ORDER BY e.victorias DESC
LIMIT 5;

-- Reservas activas de hoy
SELECT r.reserva_id, u.nombre, p.nombre AS pista, r.fecha_inicio, r.duracion
FROM Reservas r
JOIN Usuarios u ON r.usuario_id = u.user_id
JOIN Pistas p ON r.pista_id = p.pista_id
WHERE DATE(r.fecha_inicio) = CURDATE()
  AND r.estado = 'activa';

-- Uso total por pista
SELECT p.nombre AS pista, COUNT(r.reserva_id) AS total_reservas,
       ROUND(SUM(TIMESTAMPDIFF(MINUTE, r.fecha_inicio, NOW()) / 60), 2) AS horas_uso
FROM Pistas p
LEFT JOIN Reservas r ON p.pista_id = r.pista_id
GROUP BY p.pista_id;

-- Métricas de juego con fecha y jugador
SELECT mj.metrica_id, p.fecha_hora, u.nombre,
       mj.velocidad_max_golpe, mj.precision_media
FROM MetricasJuego mj
JOIN Partidos p ON mj.partido_id = p.partido_id
JOIN Usuarios u ON mj.usuario_id = u.user_id
ORDER BY p.fecha_hora DESC;

-- Sensores instalados en pista 1
SELECT sp.sensor_id, sp.tipo_sensor, sp.ultima_calibracion
FROM SensoresPista sp
WHERE sp.pista_id = 1;

-- Jugadores con más de 10 victorias y precisión media mayor al 75%
SELECT ej.usuario_id, ej.victorias, AVG(mj.precision_media) AS promedio_precision
FROM EstadisticasJugadores ej
JOIN MetricasJuego mj ON mj.usuario_id = ej.usuario_id
GROUP BY ej.usuario_id, ej.victorias
HAVING ej.victorias > 10 AND promedio_precision > 75;

-- Logros no desbloqueados aún por un usuario
SELECT l.*
FROM Logros l
WHERE l.logro_id NOT IN (
    SELECT logro_id
    FROM LogrosDesbloqueados
    WHERE usuario_id = 2
);

-- Pistas disponibles en una fecha y hora determinada
SELECT p.pista_id, p.nombre
FROM Pistas p
WHERE p.estado = 'disponible'
  AND NOT EXISTS (
      SELECT 1
      FROM Reservas r
      WHERE r.pista_id = p.pista_id
        AND r.estado = 'activa'
        AND r.fecha_inicio < '2025-05-20 18:00:00'
        AND DATE_ADD(r.fecha_inicio, INTERVAL r.duracion MINUTE) > '2025-05-20 18:00:00'
  );
-- Obtener las estadísticas generales de un jugador
SELECT *
FROM EstadisticasJugadores
WHERE usuario_id = 2;

-- Promedio de precisión de un jugador
SELECT AVG(precision_media) AS precision_promedio
FROM MetricasJuego
WHERE usuario_id = 2;

-- Velocidad máxima registrada por cada jugador
SELECT usuario_id, MAX(velocidad_max_golpe) AS velocidad_maxima
FROM MetricasJuego
GROUP BY usuario_id;

 -- rendimiento por usuario
SELECT p.fecha_hora AS fecha_partido,
       mj.velocidad_max_golpe,
       mj.precision_media,
       mj.distancia_recorrida
FROM MetricasJuego mj
JOIN Partidos p ON mj.partido_id = p.partido_id
WHERE mj.usuario_id = 2
ORDER BY p.fecha_hora DESC
LIMIT 50000;

-- ver pagos realizados de un usuario
SELECT p.pago_id, m.tipo AS membresia, r.duracion, p.monto, p.fecha_pago
FROM Pagos p
LEFT JOIN Membresias m ON p.membresia_id = m.membresia_id
LEFT JOIN Reservas r ON p.reserva_id = r.reserva_id
WHERE p.usuario_id = 2;

-- listar pasrtido, pista y tipo
SELECT p.partido_id, pt.nombre AS pista, p.fecha_hora, p.tipo
FROM Partidos p
JOIN Pistas pt ON p.pista_id = pt.pista_id;

-- promedio de velocidad y precision del jugador
SELECT usuario_id,
       AVG(velocidad_max_golpe) AS velocidad_promedio,
       AVG(precision_media) AS precision_promedio
FROM MetricasJuego
GROUP BY usuario_id;



