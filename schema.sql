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