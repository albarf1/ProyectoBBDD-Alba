CREATE DATABASE padeltech CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE padeltech;

-- 2. Tablas Base del Sistema
CREATE TABLE Membresias (
  membresia_id INT PRIMARY KEY AUTO_INCREMENT,
  tipo ENUM('free','premium','gold') NOT NULL,
  precio_mensual DECIMAL(6,2) NOT NULL,
  beneficios TEXT
) ENGINE=InnoDB;

CREATE TABLE Usuarios (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  membresia_id INT,
  rol ENUM('jugador','entrenador','staff') NOT NULL,
  fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE),
  FOREIGN KEY (membresia_id) REFERENCES Membresias(membresia_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Pistas (
  pista_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE NOT NULL,
  estado ENUM('disponible','mantenimiento','ocupada') NOT NULL DEFAULT 'disponible',
  ultima_revision DATE
) ENGINE=InnoDB;

-- 3. Reservas y Partidos
CREATE TABLE Reservas (
  reserva_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  pista_id INT NOT NULL,
  fecha_inicio DATETIME NOT NULL,
  duracion INT NOT NULL CHECK (duracion BETWEEN 60 AND 90),
  estado ENUM('activa','cancelada') NOT NULL DEFAULT 'activa',
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (pista_id) REFERENCES Pistas(pista_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Partidos (
  partido_id INT PRIMARY KEY AUTO_INCREMENT,
  pista_id INT NOT NULL,
  fecha_hora DATETIME NOT NULL,
  tipo ENUM('amistoso','torneo','entrenamiento') NOT NULL DEFAULT 'amistoso',
  FOREIGN KEY (pista_id) REFERENCES Pistas(pista_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE JugadoresPartido (
  partido_id INT NOT NULL,
  usuario_id INT NOT NULL,
  posicion ENUM('derecha','revés') NOT NULL,
  PRIMARY KEY (partido_id, usuario_id),
  FOREIGN KEY (partido_id) REFERENCES Partidos(partido_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Análisis y Estadísticas
CREATE TABLE MetricasJuego (
  metrica_id INT PRIMARY KEY AUTO_INCREMENT,
  partido_id INT NOT NULL,
  usuario_id INT NOT NULL,
  velocidad_max_golpe DECIMAL(5,2),
  precision_media DECIMAL(3,1),
  distancia_recorrida DECIMAL(5,2),
  FOREIGN KEY (partido_id) REFERENCES Partidos(partido_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE EstadisticasJugadores (
  estadistica_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT UNIQUE NOT NULL,
  partidos_jugados INT NOT NULL DEFAULT 0,
  victorias INT NOT NULL DEFAULT 0,
  nivel_actual INT NOT NULL DEFAULT 1,
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Gamificación y Preferencias
CREATE TABLE Logros (
  logro_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE NOT NULL,
  descripcion TEXT,
  objetivo INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE LogrosDesbloqueados (
  desbloqueo_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  logro_id INT NOT NULL,
  fecha DATE NOT NULL DEFAULT (CURRENT_DATE),
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (logro_id) REFERENCES Logros(logro_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE PreferenciasJugador (
  preferencia_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT UNIQUE NOT NULL,
  nivel ENUM('principiante','intermedio','avanzado'),
  estilo_preferido ENUM('agresivo','defensivo','mixto'),
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. Mantenimiento y Monitoreo
CREATE TABLE SensoresPista (
  sensor_id INT PRIMARY KEY AUTO_INCREMENT,
  pista_id INT NOT NULL,
  tipo_sensor ENUM('movimiento','humedad','iluminacion') NOT NULL,
  ultima_calibracion DATE,
  FOREIGN KEY (pista_id) REFERENCES Pistas(pista_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Métodos y Registro de Pagos
CREATE TABLE MetodosPago (
  metodo_id INT PRIMARY KEY AUTO_INCREMENT,
  proveedor ENUM('tarjeta','efectivo') NOT NULL,
  detalles VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Pagos (
  pago_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  reserva_id INT,
  membresia_id INT,
  metodo_id INT NOT NULL,
  monto DECIMAL(8,2) NOT NULL,
  fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(user_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (reserva_id) REFERENCES Reservas(reserva_id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (membresia_id) REFERENCES Membresias(membresia_id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (metodo_id) REFERENCES MetodosPago(metodo_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

