# Gestão de Aluguel de Equipamentos para Eventos

**Estudante:** Edil Borge Figueiredo  
**Curso:** Licenciatura em Informática — 2º Ano  
**Disciplina:** Tecnologias de Base de Dados  
**Tema:** Gestão de Aluguel de Equipamentos para Eventos

## Descrição do Problema

Uma empresa especializada em aluguel de equipamentos para eventos (sistemas de som, iluminação, tendas, mesas, cadeiras, geradores, etc.) enfrenta dificuldades em controlar a disponibilidade dos equipamentos, as reservas dos clientes, os pagamentos e o histórico de utilização.

O sistema deve permitir:
- Registar clientes e equipamentos
- Fazer reservas com datas de início e fim
- Controlar a quantidade disponível de cada equipamento
- Registar pagamentos (parciais ou totais)
- Consultar histórico de reservas e disponibilidade
- Gerir utilizadores do sistema (funcionários e administradores)

Este sistema servirá de base para um futuro sistema web de gestão de alugueres, onde o cliente poderá consultar disponibilidade e fazer reservas online, e os funcionários gerirão o stock e os pagamentos.

## Regras de Negócio

1. Um equipamento só pode ser reservado se a quantidade disponível for suficiente para o período solicitado.
2. Cada reserva tem data de início e data de fim obrigatórias.
3. Um cliente pode ter várias reservas.
4. Uma reserva pode conter vários equipamentos (itens).
5. O pagamento pode ser parcial ou total e deve estar associado a uma reserva.
6. O estado da reserva pode ser: Pendente, Confirmada, Em curso, Concluída ou Cancelada.
7. Apenas utilizadores autenticados (funcionários/administradores) podem criar e alterar reservas e pagamentos.
8. Não é permitido eliminar um equipamento que já tenha sido usado em alguma reserva.
9. A quantidade de um equipamento não pode ficar negativa.

## Sistema Web Futuro

Pretende-se desenvolver um sistema web onde:
- Clientes se registam e consultam disponibilidade de equipamentos
- Fazem pedidos de reserva online
- Funcionários aprovam reservas, registam pagamentos e controlam o stock
- Existe painel de administração com relatórios de utilização e faturação

## Estrutura do Repositório

- `README.md` — este ficheiro
- `modelo_relacional.md` — modelo relacional + descrição do diagrama ER
- `01_criacao_e_insercao.sql` — script de criação das tabelas + inserção de dados (≥20 registos por tabela)
- `02_manipulacao.sql` — comandos de manipulação (SELECT, JOIN, UPDATE, DELETE e teste de integridade)

## Link do Vídeo

*(Colocar aqui o link do vídeo no YouTube quando estiver disponível)*
