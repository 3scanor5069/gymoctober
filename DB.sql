drop database ProyectoGym;
create database ProyectoGym;
use ProyectoGym;

-- Tabla admin
CREATE TABLE admin (
    id INT PRIMARY KEY auto_increment not null,
    usuario VARCHAR(30),
    password VARCHAR(40),
    cargo VARCHAR(5),
    correo VARCHAR(30)
);

-- Tabla employee
CREATE TABLE employee (
    id INT PRIMARY KEY auto_increment not null,
    name VARCHAR(40),
    usuario VARCHAR(40),
    password VARCHAR(40),
    cargo VARCHAR(8),
    correo VARCHAR(30),
    habilitado BOOLEAN,
    createdBy Int,
    foreign key (createdBy) references admin (id)
);

-- Tabla client
CREATE TABLE client (
    id INT PRIMARY KEY auto_increment not null,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    tipoDocumento VARCHAR(3),
    numeroDocumento VARCHAR(20),
    sexo VARCHAR(10),
    tipoCuerpo VARCHAR(20),
    peso INT,
    altura INT,
    usuario VARCHAR(40),
    password VARCHAR(40),
    correo VARCHAR(40),
    telefono VARCHAR(10),
    rutinas longtext,
    tickets INT,
    fechaCreacion DATE,
    horaCreacion TIME,
    habilitado BOOLEAN,
    planes text
    
);
DROP TABLE client;

-- Tabla planes
CREATE TABLE planes (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price INT(11) NOT NULL,
    image VARCHAR(255),
    duration INT(11),
    startDate DATETIME,
    endDate DATETIME,
    benefits TEXT
);

INSERT INTO planes (id, name, description, price, image, duration, startDate, endDate, benefits)
VALUES
-- Plan Mensual
('p1', 'Mensualidad', 'Acceso ilimitado durante un mes', 50000, 'planes1.jpg', 1, '2024-01-01 00:00:00', '2024-02-01 00:00:00',
 '[\"Acceso a todas las áreas\", \"Clases grupales incluidas\", \"Asesoramiento inicial\"]'),

-- Plan Trimestral
('p2', 'Trimestre', 'Acceso ilimitado durante tres meses', 130000, 'planes2.jpg', 3, '2024-01-01 00:00:00', '2024-04-01 00:00:00',
 '[\"Acceso a todas las áreas\", \"Clases grupales incluidas\", \"Descuento en eventos especiales\"]'),

-- Plan Semestral
('p3', 'Semestre', 'Acceso ilimitado durante seis meses', 280000, 'planes3.jpg', 6, '2024-01-01 00:00:00', '2024-07-01 00:00:00',
 '[\"Acceso a todas las áreas\", \"Clases grupales incluidas\", \"Entrenamiento personalizado mensual\", \"Acceso a sauna\"]'),

-- Plan Anual
('p4', 'Anual', 'Acceso ilimitado durante un año', 550000, 'planes4.jpg', 12, '2024-01-01 00:00:00', '2025-01-01 00:00:00',
 '[\"Acceso a todas las áreas\", \"Clases grupales incluidas\", \"Entrenamiento personalizado trimestral\", \"Acceso a sauna\", \"Descuento en productos\"]');
DELETE FROM planes;
TRUNCATE TABLE planes;
SELECT * FROM client WHERE id = 1;



-- Tabla clases
CREATE TABLE clases (
    id VARCHAR(10) PRIMARY KEY not null,
    nombre VARCHAR(20),
    entrenador VARCHAR(20),
    startTime TIME,
    endTime TIME,
    descripcion TEXT,
    totalCupos INT,
    cuposDisponibles INT,
    fecha DATE,
    precio DECIMAL(10, 2),
    day DATE	
);

-- Tabla ticketera
CREATE TABLE ticketera (
    id VARCHAR(10) PRIMARY KEY not null,
    clientId INT,
    nombre VARCHAR(40),
    quantity INT,
    totalPrice DECIMAL(10, 2),
    date DATE,
    time TIME,
    status VARCHAR(30),
    FOREIGN KEY (clientId) REFERENCES client (id)
);

-- Tabla productos
CREATE TABLE productos (
    id int auto_increment PRIMARY KEY not null,
    name VARCHAR(30),
    description TEXT,
    price DECIMAL(10, 2),
    image longtext,
    category VARCHAR(25),
    createdBy Int,
    foreign key (createdBy) references admin (id)
);

CREATE TABLE inscripciones (
    id INT PRIMARY KEY auto_increment not null,
    clientId INT,
    claseId VARCHAR(10),
    fechaInscripcion DATETIME,
    estadoPago VARCHAR(30),
    FOREIGN KEY (clientId) REFERENCES client(id),
    FOREIGN KEY (claseId) REFERENCES clases(id)
);

select * from client;
select * from admin;
select * from employee;
select * from ticketera;
select * from clases;
select * from inscripciones;	
select * from planes;
select * from productos;


SET SQL_SAFE_UPDATES = 0;



INSERT INTO admin (id, usuario, password, cargo, correo) VALUES
(1, 'Juan', 'Soyadmin1234*', 'admin', 'admins1@gmail.com'),
(2, 'admin1234', 'Soyadmin1234*', 'admin', 'admins2@gmail.com'),
(3, 'Carlos', 'Soyadmin1234*', 'admin', 'admins3@gmail.com');



INSERT INTO employee (id, name, usuario, password, cargo, correo, habilitado) VALUES
(1, 'Daniel Lopez', 'Daniel', 'Soyempleado1234*', 'employee', 'admins3@gmail.com', 1),
(2, 'Carolina Rodriguez', 'Carolina', 'Soyempleado1234*', 'employee', NULL, 1),
(3, 'damond', 'targeryen', 'Soyempleado1234*', 'employee', 'damond@gmail.com', 1);



INSERT INTO client (id, nombre, apellido, tipoDocumento, numeroDocumento, sexo, tipoCuerpo, peso, altura, usuario, password, correo, telefono, rutinas, tickets, fechaCreacion, horaCreacion, habilitado)
VALUES (1, 'John', 'Doe', 'CC', '12345678', 'Masculino', 'Atlético', 70, 175, 'johndoe', 'password', 'john@example.com', '1234567890', '[]', 0, NOW(), NOW(), true);

-- 1. Relación entre admin y employee: Un admin puede crear varios empleados
ALTER TABLE employee ADD CONSTRAINT fk_employee_admin FOREIGN KEY (createdBy) REFERENCES admin(id) ON DELETE SET NULL ON UPDATE CASCADE;

-- 2. Relación entre admin y productos: Un admin puede crear varios productos
-- La tabla productos tiene la columna createdBy que hace referencia al id de admin
ALTER TABLE productos
    ADD CONSTRAINT fk_productos_admin FOREIGN KEY (createdBy) REFERENCES admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 3. Relación entre client y ticketera: Un cliente puede tener varios tickets
-- La tabla ticketera tiene la columna clientId que hace referencia al id de client
ALTER TABLE ticketera
    ADD CONSTRAINT fk_ticketera_client FOREIGN KEY (clientId) REFERENCES client(id) 
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 4. Relación entre client y inscripciones: Un cliente puede inscribirse en varias clases
-- La tabla inscripciones tiene la columna clientId que hace referencia al id de client
ALTER TABLE inscripciones
    ADD CONSTRAINT fk_inscripciones_client FOREIGN KEY (clientId) REFERENCES client(id) 
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 5. Relación entre clases e inscripciones: Una clase puede tener varias inscripciones
-- La tabla inscripciones tiene la columna claseId que hace referencia al id de clases
ALTER TABLE inscripciones
    ADD CONSTRAINT fk_inscripciones_clase FOREIGN KEY (claseId) REFERENCES clases(id) 
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 6. Relación entre client y planes: Un cliente puede suscribirse a varios planes
CREATE TABLE client_planes (
    clientId INT,
    planId VARCHAR(10),
    fechaSuscripcion DATETIME,
    PRIMARY KEY (clientId, planId),
    FOREIGN KEY (clientId) REFERENCES client(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (planId) REFERENCES planes(id) ON DELETE CASCADE ON UPDATE CASCADE
);
drop table client_planes;
