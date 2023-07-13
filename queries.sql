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

--What animals belong to Melody Pond?
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT a.*
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';
--List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name AS owner_name, a.*
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

--Who owns the most animals?
SELECT o.full_name AS owner_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;
--How many animals are there per species?
SELECT s.name AS species_name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

--List all Digimon owned by Jennifer Orwell.
SELECT a.*
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

--Who was the last animal seen by William Tatcher?
SELECT animals.name AS last_animal_seen
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;
--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT visits.animal_id) AS animal_count
FROM visits
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name, COALESCE(string_agg(species.name, ', '), 'No specialties') AS specialties
FROM vets
LEFT JOIN specializations ON specializations.vet_id = vets.id
LEFT JOIN species ON species.id = specializations.species_id
GROUP BY vets.name;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.animal_id) AS visit_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name AS first_visit
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

--Details for the most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS mismatched_visits
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
LEFT JOIN specializations ON specializations.vet_id = vets.id AND specializations.species_id = animals.species_id
WHERE specializations.vet_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS recommended_specialty
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;

