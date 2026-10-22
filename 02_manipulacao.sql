-- =====================================================
-- GESTÃO DE ALUGUEL DE EQUIPAMENTOS PARA EVENTOS
-- Script de Manipulação de Dados
-- =====================================================

USE aluguel_equipamentos;

-- -----------------------------------------------------
-- 1. SELECT SIMPLES (com WHERE e ORDER BY) - 3 exemplos
-- -----------------------------------------------------

-- 1.1 Listar todos os equipamentos disponíveis ordenados por preço
SELECT id_equipamento, nome, quantidade_disponivel, preco_diario
FROM equipamento
WHERE estado = 'disponivel'
ORDER BY preco_diario DESC;

-- 1.2 Clientes registados depois de uma data, ordenados por nome
SELECT id_cliente, nome, telefone, email
FROM cliente
WHERE data_registo >= '2026-01-01'
ORDER BY nome ASC;

-- 1.3 Reservas confirmadas com data de início no mês de novembro
SELECT id_reserva, id_cliente, data_inicio, data_fim, estado
FROM reserva
WHERE estado = 'confirmada' AND MONTH(data_inicio) = 11
ORDER BY data_inicio;

-- -----------------------------------------------------
-- 2. SELECT com JOIN - 2 exemplos
-- -----------------------------------------------------

-- 2.1 Reservas com nome do cliente e do funcionário que a criou
SELECT r.id_reserva, c.nome AS cliente, u.nome AS funcionario,
       r.data_inicio, r.data_fim, r.estado
FROM reserva r
JOIN cliente c ON r.id_cliente = c.id_cliente
JOIN utilizador u ON r.id_utilizador = u.id_utilizador
ORDER BY r.data_inicio;

-- 2.2 Itens de cada reserva com nome do equipamento e categoria
SELECT r.id_reserva, c.nome AS cliente, e.nome AS equipamento,
       cat.nome AS categoria, ir.quantidade, ir.preco_unitario,
       (ir.quantidade * ir.preco_unitario) AS subtotal
FROM item_reserva ir
JOIN reserva r ON ir.id_reserva = r.id_reserva
JOIN cliente c ON r.id_cliente = c.id_cliente
JOIN equipamento e ON ir.id_equipamento = e.id_equipamento
JOIN categoria cat ON e.id_categoria = cat.id_categoria
ORDER BY r.id_reserva, e.nome;

-- -----------------------------------------------------
-- 3. UPDATE - 2 exemplos
-- -----------------------------------------------------

-- 3.1 Atualizar o estado de uma reserva de pendente para confirmada
UPDATE reserva
SET estado = 'confirmada'
WHERE id_reserva = 3 AND estado = 'pendente';

-- 3.2 Reduzir a quantidade disponível de um equipamento após reserva
UPDATE equipamento
SET quantidade_disponivel = quantidade_disponivel - 2
WHERE id_equipamento = 1 AND quantidade_disponivel >= 2;

-- -----------------------------------------------------
-- 4. DELETE - 1 exemplo (respeitando chaves estrangeiras)
-- -----------------------------------------------------

-- Primeiro eliminar os pagamentos e itens associados a uma reserva cancelada,
-- depois a própria reserva (exemplo seguro)

-- Vamos cancelar a reserva 8 (que está pendente) e depois eliminá-la
UPDATE reserva SET estado = 'cancelada' WHERE id_reserva = 8;

DELETE FROM pagamento WHERE id_reserva = 8;
DELETE FROM item_reserva WHERE id_reserva = 8;
DELETE FROM reserva WHERE id_reserva = 8 AND estado = 'cancelada';

-- -----------------------------------------------------
-- 5. TESTE DE INTEGRIDADE - 1 exemplo
-- -----------------------------------------------------

-- Tentar inserir um item_reserva com um id_equipamento que não existe
-- Isto deve gerar erro de chave estrangeira

-- INSERT INTO item_reserva (id_reserva, id_equipamento, quantidade, preco_unitario)
-- VALUES (1, 9999, 2, 100.00);

-- Resultado esperado:
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- (`aluguel_equipamentos`.`item_reserva`, CONSTRAINT `item_reserva_ibfk_2`
-- FOREIGN KEY (`id_equipamento`) REFERENCES `equipamento` (`id_equipamento`))

-- Explicação:
-- O SGBD impede a inserção porque o valor 9999 não existe na tabela equipamento.
-- Isto garante a integridade referencial da base de dados.

SELECT 'Script de manipulação executado. Verifique os resultados acima.' AS mensagem;
