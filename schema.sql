/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer PRIMARY KEY,
    name varchar(100),
    date_of_birth date not null,
    escape_attempts integer not null,
    neutered boolean not null,
    weight_kg decimal 
    
);
ALTER TABLE animals ADD column species VARCHAR(100) ;

--Create a table named owners
CREATE TABLE owners (
id SERIAL PRIMARY KEY,
full_name VARCHAR(100) not null,
age integer
);
--Create a table named species
CREATE TABLE species (
id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

--Modify animals table:
--Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE animals
DROP CONSTRAINT IF EXISTS animals_pkey;
ALTER TABLE animals
ALTER COLUMN id SET DATA TYPE integer;
CREATE SEQUENCE animals_id_seq;
ALTER TABLE animals
ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');
ALTER TABLE animals
ADD PRIMARY KEY (id);

--Remove column species
ALTER TABLE animals drop column species;

--Add column species_id which is a foreign key referencing species table
alter table animals add column species_id integer references species (id);
alter table animals add column owner_id integer references owners (id);

--Create a table named vets with the following columns:
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age integer,
    date_of_graduation date
);

--Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
vet_id integer references vets (id),
species_id integer references species(id),
PRIMARY KEY (vet_id, species_id)
);
-- Create a "join table" called visits to handle this relationship
CREATE TABLE visits (
    animal_id integer REFERENCES animals (id),
    vet_id integer REFERENCES vets (id),
    visit_date date,
    PRIMARY KEY (animal_id, vet_id)
);