-- Crear base de datos
CREATE DATABASE LodgesDB;
USE LodgesDB;

-- Crear tabla para los lodges
CREATE TABLE Lodges (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    logo VARCHAR(255)
);

-- Crear tabla para las imágenes
CREATE TABLE Gallery (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lodge_id INT,
    url VARCHAR(255) NOT NULL,
    footer TEXT,
    FOREIGN KEY (lodge_id) REFERENCES Lodges(id) ON DELETE CASCADE
);

-- Crear tabla para los servicios
CREATE TABLE Services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lodge_id INT,
    name VARCHAR(255),
    FOREIGN KEY (lodge_id) REFERENCES Lodges(id) ON DELETE CASCADE
);

-- Crear tabla para la información adicional
CREATE TABLE Information (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lodge_id INT,
    name VARCHAR(255),
    FOREIGN KEY (lodge_id) REFERENCES Lodges(id) ON DELETE CASCADE
);

-- Crear tabla para la información de contacto
CREATE TABLE Contact (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lodge_id INT,
    phone VARCHAR(50),
    page VARCHAR(255),
    email VARCHAR(255),
    place TEXT,
    FOREIGN KEY (lodge_id) REFERENCES Lodges(id) ON DELETE CASCADE
);

-- Crear tabla para los atractivos turísticos
CREATE TABLE Attractions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lodge_id INT, -- Relación con la tabla Lodges
    category VARCHAR(255) NOT NULL, -- Categoría del atractivo
    title VARCHAR(255) NOT NULL, -- Título del atractivo
    image_url VARCHAR(255), -- URL de la imagen del atractivo
    FOREIGN KEY (lodge_id) REFERENCES Lodges(id) ON DELETE CASCADE
);




