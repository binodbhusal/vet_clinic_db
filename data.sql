/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', '2021-05-07', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', '2017-05-12', 1, false, 11);
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES(5,'Charmander','2020-02-08',0,false,11) ;
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES(6,'Plantmon','2021-11-15',2,true,5.7) ;
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES(7,'Squirtle','1993-04-02',3,false,12.13) ;
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES(8,'Angemon','2005-06-12',1,true,45) ;
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES(9,'Boarmon','2005-06-07',7,true,20.4) ;
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES(11,'Blossom','1998-10-13',3,true,17) ;
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES(12,'Ditto','2022-05-14',4,true,22) ;

--Insert the following data into the owners table:
insert into owners(full_name,age) values('Sam Smith', 34);
insert into owners(full_name,age) values('Jenifier Orwell', 19);
insert into owners(full_name,age) values('Bob', 45);
insert into owners(full_name,age) values('Melody Pond', 77);
insert into owners(full_name,age) values('Dean Winchester', 14);
insert into owners(full_name,age) values('Jodie Whittaker', 38);

--Insert the following data into the species table:
insert into species (name)values('Pokemon');
insert into species (name)values('Digimon');

--Modify your inserted animals so it includes the species_id value:

UPDATE animals set species_id =(select id from species where name='Digimon')where name like '%mon';
UPDATE animals set species_id =(select id from species where name='Pokemon')where species_id is null;

--Modify your inserted animals to include owner information (owner_id):
update animals set owner_id=(select id from owners where full_name='Sam Smith') where name
IN ('Agumon');
update animals set owner_id=(select id from owners where full_name='Jennifer Orwell') where name
IN ('Gabumon', 'Pikachu');
update animals set owner_id=(select id from owners where full_name='Bob') where name IN('Devimon','Plantmon');
update animals set owner_id=(select id from owners where full_name='Melody Pond') where name IN('Charmander','Squirtle','Blossom');
update animals set owner_id=(select id from owners where full_name='Dean Winchester') where name
IN('Angemon','Boarmon');