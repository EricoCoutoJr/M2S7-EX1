-- Exercíco 2
create table usuarios (
	id int primary key,
	nome varchar(40),
	cpf varchar(14),
	rg varchar(20),
	data_nascimento date CHECK (DATE_PART('year', age(current_date, data_nascimento)) >= 18),
	email varchar(100),
	login varchar(100) unique,
	senha varchar(50)
);

create table jogos (
	id int primary key,
	nome_jogo varchar(255),
	data_lancamento date,
	genero varchar(255),
	plataformas varchar(255),
	path_video_foto varchar(255)
);

create table biblioteca (
	id int primary key,
	id_jogo int,
	id_usuario int,
	foreign key (id_jogo) references jogos(id),
	foreign key (id_usuario) references usuarios(id)
);

-- Exerfcicio 3
insert into jogos (id, nome_jogo, data_lancamento, genero, plataformas, path_video_foto)
values (1, 'The Sims 4 Base', '2021-06-10', 'Simulação da Vida Real','Playstation 4, Playstation 5, Desktop','sim4.png');

insert into usuarios (id, nome, cpf, rg, data_nascimento, email, login, senha)
values(1, 'Derpson da Silva', '123.123.123-12','4.123.123','1991-01-01','derpinho91@hotmail.com','derpinho','derpinho91');

-- Exercicio 4
select Filme.nome, Filme.duracao
from Filme
join Genero_Filme on Filme.id = Genero_Filme.id_filme
join Genero on Genero_Filme.id = Genero.id_genero
where Genero.tipo_genero = 'Ação' and Filme.nome like '%Ação'
order by Filme.duracao;

-- Exercicio 5
select Pais.nome, Estado.nome, Cidade.nome
from Pais
join Estado on Pais.id_pais = Estado.id_pais
join Cidade on Estado.id_estado = Cidade.id_estado
where Cidade.capital = 'True'
  and Cidade.qtd_populacao > 500000
  and Pais.continente in ('América do Norte', 'América Central', 'América do Sul')
  and ( Estado.nome like 'São%' or
        Estado.nome like 'Santo%' or
        Estado.nome like 'San%' or
        Estado.nome like 'Saint%')
ORDER BY Pais.nome, Estado.nome, Cidade.nome;

-- Exercicio 6
select Pais.nome, SUM(Cidade.populacao) as populacao_total
from Pais
join Estado on Pais.id_pais = Estado.id_pais
join Cidade on Estado.id_estado = Cidade.id_estado
where Pais.nome = 'Espanha'
group by Pais.nome
having SUM(Cidade.populacao) < (
    select SUM(Cidade.populacao)
    from Pais
    join Estado ON Pais.id_pais = Estado.id_pais
    join Cidade ON Estado.id_estado = Cidade.id_estado
    where Pais.nome <> 'Espanha'
    group by Pais.nome
)

-- Exercício 7 -- Filtra pelo mês de novembro (Black Friday)
select U.nome_usuario, SUM(V.valor_produto * V.quantidade_produto) as valor_total_gasto
from Usuario U
join Venda V on U.id_usuario = V.id_usuario
where EXTRACT(MONTH from V.dt_compra) = 11 
group by U.id_usuario, U.nome_usuario
order by valor_total_gasto desc;

-- Exercício 8
select U.id, U.nome, SUM(V.valor_passagem) as valor_total_gasto
from Usuario U
join Reserva R on U.id = R.id_usuario
join Viagem V on R.id_viagem = V.id
where EXTRACT(MONTH from V.data_viagem) = 7 -- Filtra pelo mês de julho
group by U.id, U.nome
order by valor_total_gasto desc;