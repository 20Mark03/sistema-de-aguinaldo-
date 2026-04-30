-- =========================================
-- CREACIÓN DE BASE DE DATOS
-- =========================================
DROP DATABASE IF EXISTS TicoSoftRH;
CREATE DATABASE TicoSoftRH;
USE TicoSoftRH;

-- =========================================
-- TABLA: EMPLEADOS
-- =========================================
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =========================================
-- TABLA: SALARIOS
-- =========================================
CREATE TABLE Salarios (
    id_salario INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    anio INT NOT NULL,
    mes INT NOT NULL,
    salario_bruto DECIMAL(10,2) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES Empleados(id_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- Evita duplicados
    CONSTRAINT unique_salario_mes
        UNIQUE (id_empleado, anio, mes),

    -- Validaciones
    CONSTRAINT chk_mes CHECK (mes BETWEEN 1 AND 12),
    CONSTRAINT chk_salario CHECK (salario_bruto >= 0)
) ENGINE=InnoDB;

-- =========================================
-- INSERTAR 10 EMPLEADOS
-- =========================================
INSERT INTO Empleados (cedula, nombre, apellido, fecha_ingreso) VALUES
('101110111', 'Carlos', 'Ramirez', '2022-03-15'),
('202220222', 'Maria', 'Lopez', '2023-01-10'),
('303330333', 'Jose', 'Fernandez', '2021-07-20'),
('404440444', 'Ana', 'Martinez', '2020-11-05'),
('505550555', 'Luis', 'Gonzalez', '2019-09-12'),
('606660666', 'Sofia', 'Hernandez', '2024-02-01'),
('707770777', 'Pedro', 'Castro', '2022-06-18'),
('808880888', 'Laura', 'Vargas', '2023-08-25'),
('909990999', 'Diego', 'Morales', '2021-12-30'),
('111000111', 'Elena', 'Rojas', '2020-05-14');

-- =========================================
-- SALARIOS (Empleado 1 completo para aguinaldo)
-- =========================================
INSERT INTO Salarios (id_empleado, anio, mes, salario_bruto) VALUES
(1, 2024, 12, 500000),
(1, 2025, 1, 510000),
(1, 2025, 2, 520000),
(1, 2025, 3, 515000),
(1, 2025, 4, 530000),
(1, 2025, 5, 540000),
(1, 2025, 6, 550000),
(1, 2025, 7, 560000),
(1, 2025, 8, 570000),
(1, 2025, 9, 580000),
(1, 2025, 10, 590000),
(1, 2025, 11, 600000);

-- =========================================
-- SALARIOS BÁSICOS PARA LOS OTROS EMPLEADOS
-- =========================================
INSERT INTO Salarios (id_empleado, anio, mes, salario_bruto) VALUES
(2, 2025, 1, 450000),
(3, 2025, 1, 470000),
(4, 2025, 1, 480000),
(5, 2025, 1, 490000),
(6, 2025, 1, 500000),
(7, 2025, 1, 510000),
(8, 2025, 1, 520000),
(9, 2025, 1, 530000),
(10, 2025, 1, 540000);

-- =========================================
-- CONSULTA PARA CALCULAR AGUINALDO
-- (Ejemplo para empleado 1)
-- =========================================
SELECT 
e.id_empleado,
e.nombre,
e.apellido,
ROUND(AVG(s.salario_bruto), 2) AS aguinaldo
FROM Empleados e
JOIN Salarios s ON e.id_empleado = s.id_empleado
WHERE e.id_empleado = 1
AND (
(s.anio = 2024 AND s.mes = 12)
OR
(s.anio = 2025 AND s.mes BETWEEN 1 AND 11)
)
GROUP BY e.id_empleado;
