DELIMITER //

-- 1. Actualizar estadísticas después de insertar una métrica
CREATE TRIGGER actualizar_estadisticas_despues_de_metrica
AFTER INSERT ON MetricasJuego
FOR EACH ROW
BEGIN
    DECLARE victorias_actuales INT;

    -- Incrementar partidos_jugados
    UPDATE EstadisticasJugadores
    SET partidos_jugados = partidos_jugados + 1
    WHERE usuario_id = NEW.usuario_id;

    -- Incrementar victorias si velocidad > 85
    IF NEW.velocidad_max_golpe > 85 THEN
        UPDATE EstadisticasJugadores
        SET victorias = victorias + 1
        WHERE usuario_id = NEW.usuario_id;
    END IF;

    -- Actualizar 
    SELECT victorias INTO victorias_actuales
    FROM EstadisticasJugadores
    WHERE usuario_id = NEW.usuario_id;

    IF victorias_actuales >= 5 THEN
        UPDATE EstadisticasJugadores
        SET nivel_actual = 2
        WHERE usuario_id = NEW.usuario_id;
    END IF;
END;
//

-- 2. Desbloquear logro si es su primer partido
CREATE TRIGGER desbloquear_logro_primer_partido
AFTER INSERT ON MetricasJuego
FOR EACH ROW
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM MetricasJuego
    WHERE usuario_id = NEW.usuario_id;

    IF total = 1 THEN
        INSERT INTO LogrosDesbloqueados (usuario_id, logro_id, fecha)
        VALUES (NEW.usuario_id, 1, CURRENT_DATE);
    END IF;
END;
//

-- 3. Desbloquear logro por velocidad extrema
CREATE TRIGGER desbloquear_logro_velocidad_extrema
AFTER INSERT ON MetricasJuego
FOR EACH ROW
BEGIN
    IF NEW.velocidad_max_golpe > 90 THEN
        INSERT INTO LogrosDesbloqueados (usuario_id, logro_id, fecha)
        VALUES (NEW.usuario_id, 4, CURRENT_DATE);
    END IF;
END;
//

-- 4. Insertar preferencias por defecto si no existen
CREATE TRIGGER registrar_preferencias_si_no_existe
BEFORE INSERT ON MetricasJuego
FOR EACH ROW
BEGIN
    DECLARE existe INT;

    SELECT COUNT(*) INTO existe
    FROM PreferenciasJugador
    WHERE usuario_id = NEW.usuario_id;

    IF existe = 0 THEN
        INSERT INTO PreferenciasJugador (usuario_id, nivel, estilo_preferido)
        VALUES (NEW.usuario_id, 'principiante', 'mixto');
    END IF;
END;
//

-- 5. Validar conflicto de reservas con partidos
CREATE TRIGGER validar_reserva_pista_ocupada
BEFORE INSERT ON Reservas
FOR EACH ROW
BEGIN
    DECLARE conflicto INT;

    SELECT COUNT(*) INTO conflicto
    FROM Partidos
    WHERE pista_id = NEW.pista_id
      AND fecha_hora < DATE_ADD(NEW.fecha_inicio, INTERVAL NEW.duracion MINUTE)
      AND DATE_ADD(fecha_hora, INTERVAL 90 MINUTE) > NEW.fecha_inicio;

    IF conflicto > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La pista está ocupada en ese horario por un partido';
    END IF;
END;
//

-- 6. Actualizar estado de pista automáticamente
CREATE TRIGGER actualizar_estado_pista_automaticamente
AFTER INSERT ON Partidos
FOR EACH ROW
BEGIN
    UPDATE Pistas
    SET estado = 'ocupada'
    WHERE pista_id = NEW.pista_id;
END;
//

-- 7. Restaurar estado de pista a disponible al borrar un partido
CREATE TRIGGER liberar_pista_si_se_elimina_partido
AFTER DELETE ON Partidos
FOR EACH ROW
BEGIN
    -- Verifica si aún hay otros partidos en esa pista
    DECLARE partidos_restantes INT;

    SELECT COUNT(*) INTO partidos_restantes
    FROM Partidos
    WHERE pista_id = OLD.pista_id;

    IF partidos_restantes = 0 THEN
        UPDATE Pistas
        SET estado = 'disponible'
        WHERE pista_id = OLD.pista_id;
    END IF;
END;
//

-- 8. Bloquear reservas fuera del horario permitido (8:00 - 22:00)
CREATE TRIGGER bloquear_reservas_fuera_de_horario
BEFORE INSERT ON Reservas
FOR EACH ROW
BEGIN
    DECLARE hora_inicio TIME;
    DECLARE hora_fin TIME;

    SET hora_inicio = TIME(NEW.fecha_inicio);
    SET hora_fin = TIME(DATE_ADD(NEW.fecha_inicio, INTERVAL NEW.duracion MINUTE));

    IF hora_inicio < '08:00:00' OR hora_fin > '22:00:00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reservas solo permitidas entre las 08:00 y las 22:00 horas';
    END IF;
END;
//

DELIMITER ;
