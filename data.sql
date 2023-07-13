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

--Insert the following data for vets:
INSERT INTO vets(name,age, date_of_graduation)VALUES('William Tatcher', 45, '2000-04-23');
INSERT INTO vets(name,age, date_of_graduation)VALUES('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets(name,age, date_of_graduation)VALUES('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets(name,age, date_of_graduation)VALUES('Jack Harkness ', 38, '2008-06-08');

--Insert the following data for specialties
INSERT INTO specializations(vet_id, species_id) 
VALUES((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokeman'));
      ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon'));
      ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon'));
      ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));

-- Get the species_id for Pokemon and Digimon
INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
CROSS JOIN species s
WHERE v.name = 'William Tatcher' AND s.name = 'Pokemon';

INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v
CROSS JOIN species s
WHERE v.name = 'Stephanie Mendez' AND s.name IN ('Digimon', 'Pokemon');

INSERT INTO specializations (vet_id, species_id)
SELECT v.id, s.id
FROM vets v, species s
WHERE v.name = 'Jack Harkness ' AND s.name = 'Digimon';

--Insert the following data for visits:
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness '), '2021-02-21');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness '), '2021-02-24');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness '), '2020-10-03');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness '), '2020-11-04');

INSERT INTO visits (animal_id, vet_id, visit_date)
vetclinic-# VALUES 
vetclinic-# ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-02-27');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');

