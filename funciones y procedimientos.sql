
-- ========================
-- FUNCIONES PADLETECH
-- ========================

DELIMITER //
CREATE FUNCTION calcular_nivel_jugador(usuario_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE nivel INT;
    SELECT nivel_actual INTO nivel
    FROM EstadisticasJugadores
    WHERE user_id = usuario_id;
    RETURN nivel;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION calcular_precision_media(usuario_id INT)
RETURNS DECIMAL(5,2)
READS SQL DATA
BEGIN
    DECLARE precision_promedio DECIMAL(5,2);
    SELECT AVG(precision_media) INTO precision_promedio
    FROM MetricasJuego
    WHERE usuario_id = usuario_id;
    RETURN IFNULL(precision_promedio, 0);
END //
DELIMITER ;

-- ========================
-- PROCEDIMIENTOS PADLETECH
-- ========================

DELIMITER //
CREATE PROCEDURE crear_reserva_con_validacion(
    IN id_usuario INT,
    IN id_pista INT,
    IN inicio DATETIME,
    IN duracion INT
)
BEGIN
    DECLARE hay_conflicto INT DEFAULT 0;

    SELECT COUNT(*) INTO hay_conflicto
    FROM Reservas
    WHERE pista_id = id_pista
      AND estado = 'activa'
      AND DATE_ADD(fecha_inicio, INTERVAL duracion MINUTE) > inicio
      AND fecha_inicio < DATE_ADD(inicio, INTERVAL duracion MINUTE);

    IF hay_conflicto = 0 THEN
        INSERT INTO Reservas (usuario_id, pista_id, fecha_inicio, duracion, estado)
        VALUES (id_usuario, id_pista, inicio, duracion, 'activa');
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La pista ya está reservada en ese horario';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE registrar_logro_si_cumple(
    IN id_usuario INT,
    IN id_logro INT,
    IN valor_obtenido INT
)
BEGIN
    DECLARE objetivo_logro INT;

    SELECT objetivo INTO objetivo_logro
    FROM Logros
    WHERE logro_id = id_logro;

    IF valor_obtenido >= objetivo_logro THEN
        INSERT INTO LogrosDesbloqueados (usuario_id, logro_id, fecha)
        VALUES (id_usuario, id_logro, CURRENT_DATE);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE desbloquear_logro_por_victorias(
    IN id_usuario INT
)
BEGIN
    DECLARE total_victorias INT;

    SELECT victorias INTO total_victorias
    FROM EstadisticasJugadores
    WHERE user_id = id_usuario;

    CALL registrar_logro_si_cumple(id_usuario, 2, total_victorias);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE realizar_pago(
    IN id_usuario INT,
    IN id_reserva INT,
    IN id_membresia INT,
    IN id_metodo INT,
    IN monto_base DECIMAL(8,2)
)
BEGIN
    DECLARE monto_final DECIMAL(8,2) DEFAULT monto_base;

    IF id_membresia IS NOT NULL THEN
        SET monto_final = monto_base * 0.9;
    END IF;

    INSERT INTO Pagos (usuario_id, reserva_id, membresia_id, metodo_id, monto)
    VALUES (id_usuario, id_reserva, id_membresia, id_metodo, monto_final);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE establecer_preferencias_jugador(
    IN p_usuario_id INT,
    IN p_nivel ENUM('principiante','intermedio','avanzado'),
    IN p_estilo ENUM('agresivo','defensivo','mixto')
)
BEGIN
    INSERT INTO PreferenciasJugador (usuario_id, nivel, estilo_preferido)
    VALUES (p_usuario_id, p_nivel, p_estilo)
    ON DUPLICATE KEY UPDATE
        nivel = VALUES(nivel),
        estilo_preferido = VALUES(estilo_preferido);
END //
DELIMITER ;

