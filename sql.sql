CREATE DATABASE turismo_db_dev;
use turismo_db_dev;

-- Crear tabla experiencia
CREATE TABLE experiencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    imagenDestacada VARCHAR(255) NOT NULL
);


-- Crear tabla images
CREATE TABLE images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    footer VARCHAR(255),
    url VARCHAR(255) NOT NULL,
    experiencia_id INT NULL,  -- Relación con la tabla experiencia
    FOREIGN KEY (experiencia_id) REFERENCES experiencia(id) ON DELETE CASCADE
);

-- Crear tabla services
CREATE TABLE servicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    experiencia_id INT,
    FOREIGN KEY (experiencia_id) REFERENCES experiencia(id) ON DELETE CASCADE
);

-- Crear tabla informaciones
CREATE TABLE informaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    info TEXT NOT NULL,
    experiencia_id INT,
    FOREIGN KEY (experiencia_id) REFERENCES experiencia(id) ON DELETE CASCADE
);

-- Crear tabla contacto
CREATE TABLE contacto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    experiencia_id INT,
    FOREIGN KEY (experiencia_id) REFERENCES experiencia(id) ON DELETE CASCADE
);