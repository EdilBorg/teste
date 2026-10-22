# Modelo Relacional e Diagrama ER

## Diagrama Entidade-Relacionamento (Descrição)

### Entidades

- **Utilizador** (id_utilizador, nome, email, palavra_passe, tipo, data_criacao)
- **Cliente** (id_cliente, nome, telefone, email, morada, data_registo)
- **Categoria** (id_categoria, nome, descricao)
- **Equipamento** (id_equipamento, nome, id_categoria, quantidade_total, quantidade_disponivel, preco_diario, estado)
- **Reserva** (id_reserva, id_cliente, id_utilizador, data_inicio, data_fim, estado, data_criacao, observacoes)
- **Item_Reserva** (id_item, id_reserva, id_equipamento, quantidade, preco_unitario)
- **Pagamento** (id_pagamento, id_reserva, valor, data_pagamento, metodo, estado)

### Relacionamentos e Cardinalidades

- Utilizador **1:N** Reserva (um utilizador cria várias reservas)
- Cliente **1:N** Reserva (um cliente faz várias reservas)
- Reserva **1:N** Item_Reserva (uma reserva tem vários itens)
- Equipamento **1:N** Item_Reserva (um equipamento pode aparecer em vários itens de reservas)
- Categoria **1:N** Equipamento
- Reserva **1:N** Pagamento

### Nota sobre Diagrama Visual

O diagrama ER visual deve ser criado em draw.io ou MySQL Workbench e guardado como `diagrama_er.png`.

## Modelo Relacional (Tabelas)

```sql
Utilizador (
  id_utilizador     INT PK AUTO_INCREMENT,
  nome              VARCHAR(100) NOT NULL,
  email             VARCHAR(100) UNIQUE NOT NULL,
  palavra_passe     VARCHAR(255) NOT NULL,
  tipo              ENUM('admin','funcionario') NOT NULL,
  data_criacao      DATETIME DEFAULT CURRENT_TIMESTAMP
)

Cliente (
  id_cliente        INT PK AUTO_INCREMENT,
  nome              VARCHAR(100) NOT NULL,
  telefone          VARCHAR(20),
  email             VARCHAR(100),
  morada            VARCHAR(200),
  data_registo      DATETIME DEFAULT CURRENT_TIMESTAMP
)

Categoria (
  id_categoria      INT PK AUTO_INCREMENT,
  nome              VARCHAR(50) NOT NULL,
  descricao         TEXT
)

Equipamento (
  id_equipamento    INT PK AUTO_INCREMENT,
  nome              VARCHAR(100) NOT NULL,
  id_categoria      INT NOT NULL,
  quantidade_total  INT NOT NULL,
  quantidade_disponivel INT NOT NULL,
  preco_diario      DECIMAL(10,2) NOT NULL,
  estado            ENUM('disponivel','manutencao','indisponivel') DEFAULT 'disponivel',
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
)

Reserva (
  id_reserva        INT PK AUTO_INCREMENT,
  id_cliente        INT NOT NULL,
  id_utilizador     INT NOT NULL,
  data_inicio       DATE NOT NULL,
  data_fim          DATE NOT NULL,
  estado            ENUM('pendente','confirmada','em_curso','concluida','cancelada') DEFAULT 'pendente',
  data_criacao      DATETIME DEFAULT CURRENT_TIMESTAMP,
  observacoes       TEXT,
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
)

Item_Reserva (
  id_item           INT PK AUTO_INCREMENT,
  id_reserva        INT NOT NULL,
  id_equipamento    INT NOT NULL,
  quantidade        INT NOT NULL,
  preco_unitario    DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),
  FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento)
)

Pagamento (
  id_pagamento      INT PK AUTO_INCREMENT,
  id_reserva        INT NOT NULL,
  valor             DECIMAL(10,2) NOT NULL,
  data_pagamento    DATETIME DEFAULT CURRENT_TIMESTAMP,
  metodo            ENUM('dinheiro','mpesa','transferencia','cartao') NOT NULL,
  estado            ENUM('pendente','confirmado','cancelado') DEFAULT 'confirmado',
  FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
)
```
