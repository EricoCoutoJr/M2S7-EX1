create table usuarios (
	id int primary key,
	nome varchar(40),
	cpf varchar(11),
	rg varchar(20),
	data_nascimento date CHECK (DATE_PART('year', age(current_date, data_nascimento)) >= 18),
	login varchar(100),
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