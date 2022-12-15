create database ecommerce;
use ecommerce;

-- Tabela Produto
create table product (
	idproduct INT auto_increment primary key,
    category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
    attribute VARCHAR(45),
    review float default 0,
    valor FLOAT NOT NULL
);

-- Tabela Cliente
create table clients (
	idclient int auto_increment not null primary key,
    fname VARCHAR(45) not null,
    lname VARCHAR(45),
    id char(11) not null,
    address varchar(50),
    pj tinyint,
    pf tinyint
);

-- Tabela entrega
create table delivery (
	iddelivery int not null auto_increment primary key,
    codedelivery varchar(45),
    deliverystatus enum('postado', 'em transito', 'entregue'),
    deliveryprice float
);

-- Tabela pedido
create table orders (
	idorder int auto_increment not null primary key,
	orderstatus enum ('cancelado', 'processando', 'concluido') default 'processando',
    paymenttype enum('credito', 'debito', 'boleto'),
	idclientorder int,
	iddeliverorder int,
    constraint fk_idclient foreign key (idclientorder) references clients(idclient),
    constraint fk_iddelivery foreign key (iddeliverorder) references delivery(iddelivery)
);

-- Tabela produto/pedido
create table productorder (
	idproductfk int,
    idorderfk int,
    quantity int not null default 1,
    constraint fk_idproduct foreign key (idproductfk) references product(idproduct),
    constraint fk_idorder foreign key (idorderfk) references orders(idorder)
);

-- Tabela estoque
create table pstorage(
	idstorage int auto_increment not null primary key,
    quantity int default 0,
    location varchar(200) not null,
    idprodstrg int,
    constraint fk_productstorage foreign key (idprodstrg) references product(idproduct)
);

-- Tabela fornecedor
create table suplier (
	idsuplier int not null auto_increment primary key,
    sname varchar(100) not null,
    cnpj char(14) not null,
    constraint supliername unique (sname),
	constraint cnpj unique (cnpj)
);

-- Tabela fornecedor/produto
create table productsuplier (
	suplierid int,
    productid int,
    constraint fk_suplierid foreign key (suplierid) references suplier(idsuplier),
    constraint fk_productid foreign key (productid) references product(idproduct)
);

-- Tabela terceiro vendedor
create table seller (
	idseller int not null primary key auto_increment,
    sellername varchar (100) not null,
    location varchar (50)
);

-- Tabela terceiro/produto
create table productseller (
	idprodfk int,
    idsellfk int,
    quantity int not null default 0,
    constraint fk_idprodfk foreign key (idprodfk) references product(idproduct),
    constraint fk_idsellfk foreign key (idsellfk) references seller(idseller)
);






