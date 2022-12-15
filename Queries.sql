-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');


-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliação, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);

select * from clients;
select * from product;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);

-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);

select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                             
-- Queries: 

use ecommerce;
show tables;
-- Quantos pedidos por categoria de produto?
select pname as Produto, category as Categoria, poQuantity as Quantidade from product p
	inner join productOrder o on idPOproduct=idProduct
    group by category;
    
-- Relação categoria de produto/pedido por cliente
select concat(Fname,' ',Lname) as Cliente, o.orderDescription as 'Tipo de compra', pr.category as Categoria   from clients c
	inner join orders o on idOrderClient=idClient
	inner join productOrder p on idPOorder=idOrder
    inner join product pr on idProduct=idPOproduct
    order by pr.category desc;
    
-- Quem são os fornecedores do maior para o menor por categoria de produto?
select s.socialname as Fornecedor, p.category as Categoria, ps.quantity as Quantidade from product p
	inner join productSupplier ps on idProduct=idPsProduct
    inner join supplier s on idSupplier=idPsSupplier
    where ps.quantity > 100
    group by p.category
    order by ps.quantity desc;

-- Localização do estoque de cada produto
select p.pname as Produto, p.category as Categoria, ps.storageLocation as Localização from product p
	inner join storageLocation s on idProduct=idLproduct
    inner join productStorage ps on idProdStorage=idLstorage;
    
-- Quais produtos são vendidos por terceiros?
select p.pname as Produto, p.category as Categoria, s.socialname as TerceiroVendedor  from product p
	inner join productSeller ps on idProduct=idPproduct
    inner join seller s on idSeller=idPseller;
    
-- Fornecedores que vendem mais de 100 produtos
select s.socialname as Fornecedor, p.category as Categoria, ps.quantity as Quantidade from product p
	inner join productSupplier ps on idProduct=idPsProduct
    inner join supplier s on idSupplier=idPsSupplier
    where ps.quantity > 100
    group by p.category
    order by ps.quantity desc;

-- Clientes que não possuem pedidos
select concat(c.Fname,' ',c.Lname) as Cliente from clients c
	left outer join orders o on idClient=idOrderClient
    where o.idorder is null;

    