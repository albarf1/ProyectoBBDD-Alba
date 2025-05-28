-- 1. Carga inicial das Membresias
INSERT INTO Membresias (tipo, precio_mensual, beneficios) VALUES
('free', 0, 'Reservas limitadas, acceso básico a estadísticas'),
('premium', 19.99, 'Acceso completo a métricas y análisis'),
('gold', 39.99, 'Todas las funciones premium ');

-- 2. Carga inicial dos Usuarios 
INSERT INTO Usuarios (nombre, email, membresia_id, rol)
VALUES
('Javier Feijóo López', 'javier.feijoo@iessanmamede.com', 1, 'entrenador'),
('Hugo Alcázar González', 'hugo.alcazar@iessanmamede.com', 2, 'jugador'),
('Mauricio José Altuna Janeiro', 'mauricio.altuna@iessanmamede.com', 3, 'jugador'),
('André Sebastián Arquínigo Flores', 'andre.arquinigo@iessanmamede.com', 2, 'staff'),
('Rodrigo Barbosa Gómez', 'rodrigo.barbosa@iessanmamede.com', 1, 'jugador'),
('Xurxo Barge Blanco', 'xurxo.barge@iessanmamede.com', 2, 'jugador'),
('Francisco Bértolo Prado', 'francisco.bertolo@iessanmamede.com', 3, 'staff'),
('Raquel Blanco González', 'raquel.blanco@iessanmamede.com', 1, 'entrenador'),
('Jaime Canay Agho', 'jaime.canay@iessanmamede.com', 2, 'jugador'),
('Angely Gissell Castellanos Cala', 'angely.castellanos@iessanmamede.com', 1, 'jugador'),
('María Celia Domínguez García', 'maria.celia@iessanmamede.com', 3, 'jugador'),
('Enooc Domínguez Quiroga', 'enooc.dominguez@iessanmamede.com', 2, 'jugador'),
('Abraham Fernández Bande', 'abraham.fernandez@iessanmamede.com', 1, 'jugador'),
('Juan Bruno Fernández Pessoa', 'juanbruno.fernandezp@iessanmamede.com', 2, 'entrenador'),
('Noelia Freire Amarelo', 'noelia.freire@iessanmamede.com', 3, 'jugador'),
('Alejandro López Barros', 'alejandro.lopez@iessanmamede.com', 1, 'jugador'),
('Paula López López', 'paula.lopez@iessanmamede.com', 2, 'jugador'),
('Iago Malvido Guzmán', 'iago.malvido@iessanmamede.com', 3, 'staff'),
('Juan Diego Muñoz Sánchez', 'juandiego.munoz@iessanmamede.com', 2, 'jugador'),
('Mauro Pereira Seara', 'mauro.pereira@iessanmamede.com', 1, 'jugador'),
('Manuel Pérez Feijóo', 'manuel.perez@iessanmamede.com', 3, 'entrenador'),
('Adrian Ramos Espinosa', 'adrian.ramos@iessanmamede.com', 2, 'jugador'),
('Uxía Rodríguez Domínguez', 'uxia.rodriguez@iessanmamede.com', 1, 'jugador'),
('Anxo Vázquez Manzano', 'anxo.vazquez@iessanmamede.com', 3, 'staff'),
('David Vázquez Nóvoa', 'david.vazquez@iessanmamede.com', 2, 'jugador');

-- 3. Carga inicial das Pistas
INSERT INTO Pistas (nombre, estado) VALUES
('Pista 1 - Exterior', 'disponible'),
('Pista 2 - Interior', 'disponible'),
('Pista 3 - Interior', 'mantenimiento'),
('Pista 4 - Exterior', 'disponible'),
('Pista 5 - Interior', 'ocupada'),
('Pista 6 - Exterior', 'disponible'),
('Pista 7 - Interior', 'disponible'),
('Pista 8 - Exterior', 'disponible');

-- 4. Carga inicial dos SensoresPista
INSERT INTO SensoresPista (pista_id, tipo_sensor, ultima_calibracion) VALUES
(1, 'iluminacion', '2024-03-01'),
(1, 'humedad', '2024-03-01'),
(1, 'movimiento', '2024-03-01'),
(2, 'iluminacion', '2024-03-02'),
(2, 'humedad', '2024-03-02'),
(3, 'iluminacion', '2024-02-20'),
(4, 'humedad', '2024-03-03'),
(5, 'movimiento', '2024-03-04'),
(6, 'iluminacion', '2024-03-05'),
(7, 'humedad', '2024-03-06'),
(8, 'movimiento', '2024-03-07');

-- 5. Carga inicial das Reservas
INSERT INTO Reservas (usuario_id, pista_id, fecha_inicio, duracion, estado) VALUES
(2, 1, '2024-04-05 10:00:00', 60, 'activa'),
(3, 2, '2024-04-05 11:00:00', 90, 'cancelada'),
(5, 5, '2024-04-06 09:00:00', 60, 'activa'),
(7, 1, '2024-04-07 15:00:00', 90, 'activa'),
(9, 3, '2024-04-08 10:00:00', 60, 'activa'),
(11, 4, '2024-04-09 12:00:00', 90, 'activa'),
(13, 6, '2024-04-10 14:00:00', 60, 'activa');

-- 6. Carga inicial dos Partidos
INSERT INTO Partidos (pista_id, fecha_hora, tipo) VALUES
(1, '2024-04-05 10:00:00', 'amistoso'),
(2, '2024-04-05 11:00:00', 'torneo'),
(5, '2024-04-06 09:00:00', 'entrenamiento'),
(1, '2024-04-07 15:00:00', 'amistoso'),
(3, '2024-04-08 10:00:00', 'amistoso');

-- 7. Carga inicial dos JugadoresPartido
INSERT INTO JugadoresPartido (partido_id, usuario_id, posicion) VALUES
(1, 2, 'derecha'), (1, 3, 'izquierda'),
(2, 5, 'derecha'), (2, 7, 'izquierda'),
(3, 9, 'derecha'), (3, 11, 'izquierda'),
(4, 13, 'derecha'), (4, 15, 'izquierda'),
(5, 17, 'derecha'), (5, 19, 'izquierda');

-- 8. Carga inicial das EstadisticasJugadores
INSERT INTO EstadisticasJugadores (usuario_id, partidos_jugados, victorias, nivel_actual)
SELECT u.user_id, FLOOR(RAND() * 10), FLOOR(RAND() * 10), FLOOR(1 + RAND() * 5)
FROM Usuarios u
WHERE u.rol = 'jugador'
ORDER BY RAND()
LIMIT 15;

-- 9. Carga inicial das MetricasJuego
INSERT INTO MetricasJuego (partido_id, usuario_id, velocidad_max_golpe, precision_media, distancia_recorrida)
VALUES
(1, 2, 85.5, 78.3, 2000.0),
(1, 3, 90.2, 82.1, 2200.0),
(2, 5, 78.9, 75.0, 1900.0),
(2, 7, 88.1, 80.5, 2100.0),
(3, 9, 92.4, 85.6, 2300.0),
(3, 11, 80.0, 77.4, 2000.0),
(4, 13, 87.6, 79.0, 2150.0),
(4, 15, 91.0, 84.2, 2250.0),
(5, 17, 83.4, 76.8, 2000.0),
(5, 19, 89.7, 81.5, 2100.0);

-- 10. Carga inicial dos Logros
INSERT INTO Logros (nombre, descripcion, objetivo)
VALUES
('Primer partido', 'Jugar al menos un partido', 1),
('Campeón local', 'Ganar 5 partidos', 5),
('Profesional en ciernes', 'Jugar más de 10 partidos', 10),
('Velocidad extrema', 'Alcanzar una velocidad máxima de golpe superior a 90 km/h', 90),
('Precisión perfecta', 'Mantener una precisión media superior al 85%', 85);

-- 11. Carga inicial dos LogrosDesbloqueados
INSERT INTO LogrosDesbloqueados (usuario_id, logro_id, fecha) VALUES
(2, 1, '2024-04-05'),
(3, 1, '2024-04-05'),
(5, 1, '2024-04-06'),
(5, 2, '2024-04-10'),
(7, 1, '2024-04-07'),
(9, 1, '2024-04-08'),
(11, 1, '2024-04-08'),
(13, 1, '2024-04-09'),
(15, 1, '2024-04-10'),
(17, 1, '2024-04-10');

-- 12. Carga inicial dos MétodosPago
INSERT INTO MetodosPago (proveedor, detalles) VALUES
('tarjeta', 'Visa ending in 4242'),
('efectivo', 'Pagado en taquilla'),
('tarjeta', 'Mastercard ending in 1111'),
('efectivo', 'Efectivo entregado a staff');

-- 13. Carga inicial dos Pagos
INSERT INTO Pagos (usuario_id, reserva_id, membresia_id, metodo_id, monto)
VALUES
(2, 1, NULL, 1, 19.99),
(3, 2, NULL, 2, 19.99),
(5, 3, NULL, 3, 39.99),
(7, 4, NULL, 1, 39.99),
(9, 5, NULL, 2, 19.99),
(11, 6, NULL, 4, 19.99),
(13, 7, NULL, 1, 0); 

-- 14. Carga inicial das PreferenciasJugador
INSERT INTO PreferenciasJugador (usuario_id, nivel, estilo_preferido)
VALUES
(2, 'avanzado', 'agresivo'),
(3, 'intermedio', 'mixto'),
(5, 'principiante', 'defensivo'),
(7, 'intermedio', 'agresivo'),
(9, 'avanzado', 'mixto'),
(11, 'intermedio', 'defensivo'),
(13, 'principiante', 'defensivo');