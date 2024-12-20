DROP TABLE IF EXISTS working_hours, users, locatarios, imobiliarias;

-- Criação da tabela de usuários
CREATE TABLE users (
    id INT(6) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    role ENUM('admin', 'locatario', 'imobiliaria') NOT NULL
);

-- Criação da tabela de horas trabalhadas
CREATE TABLE working_hours (
    id INT(6) AUTO_INCREMENT PRIMARY KEY,
    user_id INT(6),
    work_date DATE NOT NULL,
    time1 TIME,
    time2 TIME,
    time3 TIME,
    time4 TIME,
    worked_time INT,

    -- Relacionamento com a tabela de usuários
    FOREIGN KEY (user_id) REFERENCES users(id),

    -- Garantir que não haja duplicidade de registros para o mesmo usuário e data
    CONSTRAINT cons_user_day UNIQUE (user_id, work_date)
);

-- Criação da tabela de locatários
CREATE TABLE locatarios (
    id INT(6) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    rua VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cep VARCHAR(9) NOT NULL
);

-- Criação da tabela de imobiliárias
CREATE TABLE imobiliarias (
    id INT(6) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    rua VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    user_id INT(6),
    FOREIGN KEY (user_id) REFERENCES users(id),
    CHECK (
        EXISTS (
            SELECT 1 FROM users WHERE users.id = user_id AND users.role = 'imobiliaria'
        )
    )
);

INSERT INTO users (name, password, email, start_date, role)
VALUES
('Admin', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'admin@gmail.com', '2000-01-01', 'admin'),
('Ana', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'ana@gmail.com', '2000-01-01', 'admin'),
('Maria', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'maria@gmail.com', '2000-01-01', 'locatario'),
('João', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'joao@gmail.com', '2000-01-01', 'locatario'),
('Pedro', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'pedro@gmail.com', '2000-01-01', 'locatario'),
('Julia', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'julia@gmail.com', '2000-01-01', 'locatario'),
('Lucas', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'lucas@gmail.com', '2000-01-01', 'locatario'),
('Fernanda', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'fernanda@gmail.com', '2000-01-01', 'locatario'),
('Carlos', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'carlos@gmail.com', '2000-01-01', 'imobiliaria'),
('Ricardo', '$2y$10$/vC1UKrEJQUZLN2iM3U9re/4DQP74sXCOVXlYXe/j9zuv1/MHD4o.', 'ricardo@gmail.com', '2000-01-01', 'imobiliaria');

INSERT INTO working_hours (user_id, work_date, time1, time2, time3, time4, worked_time)
VALUES
(1, '2024-11-01', '09:00:00', '10:00:00', '13:00:00', '18:00:00', 8),
(2, '2024-11-01', '08:30:00', '12:30:00', '14:00:00', '17:30:00', 8),
(3, '2024-11-02', '09:00:00', '11:00:00', '13:00:00', '15:00:00', 6),
(4, '2024-11-03', '08:00:00', '10:00:00', '11:30:00', '14:00:00', 6),
(5, '2024-11-04', '09:30:00', '11:00:00', '12:30:00', '16:00:00', 7),
(6, '2024-11-05', '08:30:00', '11:30:00', '14:00:00', '18:00:00', 8),
(7, '2024-11-06', '10:00:00', '12:00:00', '14:00:00', '17:00:00', 7),
(8, '2024-11-07', '09:00:00', '12:00:00', '13:00:00', '18:00:00', 8),
(9, '2024-11-08', '08:30:00', '11:00:00', '13:30:00', '16:30:00', 7),
(10, '2024-11-09', '09:00:00', '12:00:00', '13:00:00', '18:00:00', 8);

INSERT INTO locatarios (nome, email, telefone, cidade, estado, bairro, rua, numero, cep)
VALUES
('João da Silva', 'joao@gmail.com', '1111111111', 'São Paulo', 'SP', 'Bairro X', 'Rua A', '123', '01001-000'),
('Maria Oliveira', 'maria@gmail.com', '2222222222', 'Rio de Janeiro', 'RJ', 'Bairro Y', 'Rua B', '456', '20040-002'),
('Carlos Santos', 'carlos@gmail.com', '3333333333', 'Belo Horizonte', 'MG', 'Bairro Z', 'Rua C', '789', '30140-110'),
('Ana Costa', 'ana@gmail.com', '4444444444', 'Curitiba', 'PR', 'Bairro W', 'Avenida D', '101', '80010-130'),
('Pedro Lima', 'pedro@gmail.com', '5555555555', 'Porto Alegre', 'RS', 'Bairro V', 'Travessa E', '202', '90010-150'),
('Luciana Alves', 'luciana@gmail.com', '6666666666', 'Florianópolis', 'SC', 'Bairro U', 'Rua F', '303', '88010-200'),
('Felipe Martins', 'felipe@gmail.com', '7777777777', 'Salvador', 'BA', 'Bairro T', 'Rua G', '404', '40010-300'),
('Roberta Souza', 'roberta@gmail.com', '8888888888', 'Fortaleza', 'CE', 'Bairro S', 'Rua H', '505', '60010-400'),
('Thiago Silva', 'thiago@gmail.com', '9999999999', 'Recife', 'PE', 'Bairro R', 'Rua I', '606', '50010-500'),
('Cláudia Lima', 'claudia@gmail.com', '1010101010', 'Manaus', 'AM', 'Bairro Q', 'Rua J', '707', '69010-600');

INSERT INTO imobiliarias (nome, telefone, email, cidade, estado, bairro, rua, numero, cep, user_id)
VALUES
('Imobiliária ABC', '6666666666', 'abc@imobiliaria.com', 'São Paulo', 'SP', 'Centro', 'Av. Paulista', '1000', '01310-000', 9),
('Imobiliária XYZ', '7777777777', 'xyz@imobiliaria.com', 'Rio de Janeiro', 'RJ', 'Copacabana', 'Rua Atlântica', '500', '22070-000', 10),
('Imobiliária Solar', '8888888888', 'solar@imobiliaria.com', 'Belo Horizonte', 'MG', 'Savassi', 'Rua da Bahia', '1500', '30160-011', 9),
('Imobiliária Porto', '9999999999', 'porto@imobiliaria.com', 'Porto Alegre', 'RS', 'Moinhos de Vento', 'Rua Padre Chagas', '200', '90570-080', 10),
('Imobiliária Horizonte', '1111111111', 'horizonte@imobiliaria.com', 'Fortaleza', 'CE', 'Aldeota', 'Av. Santos Dumont', '3000', '60150-161', 9),
('Imobiliária Oceano', '2222222222', 'oceano@imobiliaria.com', 'Recife', 'PE', 'Boa Viagem', 'Av. Boa Viagem', '400', '51021-040', 10),
('Imobiliária Bela Vista', '3333333333', 'belavista@imobiliaria.com', 'Florianópolis', 'SC', 'Trindade', 'Rua Lauro Linhares', '800', '88036-002', 9),
('Imobiliária Central', '4444444444', 'central@imobiliaria.com', 'Curitiba', 'PR', 'Centro', 'Rua XV de Novembro', '1200', '80060-000', 10),
('Imobiliária Prime', '5555555555', 'prime@imobiliaria.com', 'Salvador', 'BA', 'Pituba', 'Av. Manoel Dias', '2500', '41830-000', 9),
('Imobiliária Tropical', '6666666666', 'tropical@imobiliaria.com', 'Manaus', 'AM', 'Adrianópolis', 'Av. Mário Ypiranga', '130', '69057-002', 10);
