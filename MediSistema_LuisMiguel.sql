create database MediSistema;
use MediSistema;
create table paciente (
		paciente int primary key not null auto_increment,
        nombre varchar(45) not null
);

create table medico (
		id_medico int primary key not null auto_increment,
        nombre varchar(45) not null,
        tipo varchar(45) not null,
        horas_consulta int not null,
        dias_vacaciones int not null
);

create table empleados (
		id_empleado int primary key not null auto_increment,
        nombre varchar(45) not null,
        cargo varchar(45) not null,
        dias_vacaciones int not null
);

create table medico_paciente (
		id_medico int not null,
        id_paciente int not null,
        foreign key (id_medico) references medico(id_medico),
        foreign key (id_paciente) references paciente(paciente)
);

create table medico_sustituto (
		id_medico int not null,
        id_medico_sustituir int not null,
        estado varchar(45),
        foreign key (id_medico) references medico(id_medico),
        foreign key (id_medico_sustituir) references medico(id_medico)
);

-- Insertar Pacientes
INSERT INTO paciente (nombre) VALUES 
('Juan Pérez'),
('María López'),
('Carlos García'),
('Ana Martínez'),
('Luis Fernández'),
('Fernando Torres'),
('Lucía Fernández'),
('Pablo Martínez'),
('Isabel Gómez'),
('Carlos Rodríguez'),
('Laura Sánchez'),
('Miguel Ángel Pérez'),
('Elena Díaz'),
('Sofía Martínez'),
('Diego López');

-- Insertar Médicos
INSERT INTO medico (nombre, tipo, horas_consulta, dias_vacaciones) VALUES 
('Dr. Alberto Santos', 'Cardiología', 30, 15),
('Dra. Lucia Torres', 'Pediatría', 25, 10),
('Dr. Javier Morales', 'Dermatología', 20, 20),
('Dra. Ana Ruiz', 'Medicina General', 40, 12),
('Dr. Manuel López', 'Oftalmología', 28, 15),
('Dra. Clara Salas', 'Endocrinología', 32, 10),
('Dr. Hugo Ramírez', 'Gastroenterología', 24, 18),
('Dra. Patricia Moreno', 'Psiquiatría', 26, 14);

-- Insertar Empleados
INSERT INTO empleados (nombre, cargo, dias_vacaciones) VALUES 
('María Sánchez', 'Recepcionista', 10),
('José Hernández', 'Enfermero', 12),
('Sofía González', 'Administrativa', 15),
('Pedro Ramírez', 'Técnico', 8),
('Rosa Jiménez', 'Recepcionista', 10),
('Daniela Castro', 'Enfermera', 12),
('Jorge Pérez', 'Administrativo', 15),
('Teresa Alvarado', 'Técnica', 9);

-- Insertar relaciones Médico-Paciente
INSERT INTO medico_paciente (id_medico, id_paciente) VALUES 
(1, 1), -- Dr. Alberto Santos y Juan Pérez
(2, 2), -- Dra. Lucia Torres y María López
(3, 3), -- Dr. Javier Morales y Carlos García
(4, 4), -- Dra. Ana Ruiz y Ana Martínez
(5, 5), -- Dr. Manuel López y Luis Fernández
(6, 6), -- Dra. Clara Salas y Lucía Fernández
(7, 7), -- Dr. Hugo Ramírez y Pablo Martínez
(8, 8), -- Dra. Patricia Moreno y Isabel Gómez
(1, 9), -- Dr. Alberto Santos y Carlos Rodríguez
(2, 10), -- Dra. Lucia Torres y Laura Sánchez
(3, 11), -- Dr. Javier Morales y Miguel Ángel Pérez
(4, 12), -- Dra. Ana Ruiz y Elena Díaz
(5, 13), -- Dr. Manuel López y Sofía Martínez
(6, 14); -- Dra. Clara Salas y Diego López
INSERT INTO medico_paciente (id_medico, id_paciente) VALUES 
(5, 6);
-- Insertar Sustituciones Médicas
INSERT INTO medico_sustituto (id_medico, id_medico_sustituir, estado) VALUES 
(1, 2, 'Activo'), -- Dr. Alberto Santos sustituye a Dra. Lucia Torres
(3, 1, 'Inactivo'), -- Dr. Javier Morales sustituye a Dr. Alberto Santos
(4, 3, 'Activo'), -- Dra. Ana Ruiz sustituye a Dr. Javier Morales
(5, 6, 'Activo'), -- Dr. Manuel López sustituye a Dra. Clara Salas
(6, 7, 'Inactivo'), -- Dra. Clara Salas sustituye a Dr. Hugo Ramírez
(7, 8, 'Activo'), -- Dr. Hugo Ramírez sustituye a Dra. Patricia Moreno
(8, 4, 'Inactivo'); -- Dra. Patricia Moreno sustituye a Dra. Ana Ruiz
INSERT INTO medico_sustituto (id_medico, id_medico_sustituir, estado) VALUES 
(1, 6, 'Activo');

-- 1. **Número de pacientes atendidos por cada médico**
select id_medico , count(id_medico) as cantidad_pacientes from medico_paciente group by id_medico;

-- 2. **Total de días de vacaciones planificadas y disfrutadas por cada empleado**
select nombre , dias_vacaciones from empleados;

-- 3. **Médicos con mayor cantidad de horas de consulta en la semana**

-- 4.  **Número de sustituciones realizadas por cada médico sustituto**
select id_medico , count(id_medico) as numero_sustituciones from medico_sustituto group by id_medico;

-- 5.  **Número de médicos que están actualmente en sustitución**
select count(*) as cant_medi_sustitucion from medico_sustituto where estado='Activo';

-- 6. **Horas totales de consulta por médico por día de la semana**

-- 7.  **Médico con mayor cantidad de pacientes asignados**
select id_medico , count(id_paciente) as pasientes_asignados from medico_paciente group by id_medico order by pasientes_asignados desc limit 1;

-- 8. **Empleados con más de 10 días de vacaciones disfrutadas**
select * from empleados where dias_vacaciones > 10;

-- 9.  **Médicos que actualmente están realizando una sustitución**
select distinct id_medico from medico_sustituto where estado = 'Activo';

-- 10.  **Promedio de horas de consulta por médico por día de la semana**

-- 11.  **Empleados con mayor número de pacientes atendidos por los médicos bajo su supervisión**

-- 12.  **Médicos con más de 5 pacientes y total de horas de consulta en la semana**

-- 13.  **Total de días de vacaciones planificadas y disfrutadas por cada tipo de empleado**
select cargo , sum(dias_vacaciones) as total_vacaciones from empleados group by cargo;

-- 14. **Total de pacientes por cada tipo de médico**

-- 15. **Total de horas de consulta por médico y día de la semana**
select nombre , horas_consulta from medico;

-- 16. **Número de sustituciones por tipo de médico**

-- 17. **Total de pacientes por médico y por especialidad**
select id_medico , count(id_medico) as total_pacientes from medico_paciente group by id_medico;

-- 18. **Empleados y médicos con más de 20 días de vacaciones planificadas**
select * from empleados where dias_vacaciones > 20;
select * from medicos where dias_vacaciones > 20;

-- 19. **Médicos con el mayor número de pacientes actualmente en sustitución**

-- 20. **Total de horas de consulta por especialidad y día de la semana**

select * from paciente ;
select * from medico ;
select * from empleados ;
select * from medico_paciente ;
select * from medico_sustituto;