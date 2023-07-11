/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon' ;
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31' ;
SELECT name FROM animals WHERE neutered =true AND escape_attempts<3 ;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5 ;
SELECT * FROM animals WHERE neutered =true ;
SELECT * FROM animals WHERE name<>'Gabumon' ;
SELECT * FROM animals WHERE weight_kg>=10.4 AND weight_kg<= 17.3 ;

BEGIN;
update animals set species = 'unspecified' ;
SELECT * FROM animals;
ROLLBACK;

SELECT * FROM animals;
update animals set species = 'digimon' where name like '%mon';
update animals set species = 'pokemon' where species is null;

BEGIN;
delete from animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
SAVEPOINT my_savepoint;
update animals set weight_kg=weight_kg*-1;
select*from animals;
rollback to savepoint my_savepoint;
select *from animals;
update animals set weight_kg=weight_kg*-1 where weight_kg<0;
COMMIT;

select count(*) as animal_count from animals;
select count (*) as no_escape from animals where escape_attempts=0;
select avg(weight_kg) as average_weight from animals;
select neutered , count(*) as escape_count from animals where escape_attempts>0 group by neutered order by escape_count desc;
select species, min(weight_kg) as min_weight, max(weight_kg) as max_weight from animals group by species;
select species, avg(escape_attempts) as average_escape_attempts from animals where date_of_birth 
between '1990-01-01' and '2000-12-31' group by species ;
