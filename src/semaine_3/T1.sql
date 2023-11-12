-- Active: 1698796366625@@127.0.0.1@8889@ecommerce
CREATE TABLE clients AS SELECT * FROM custormers;
ALTER TABLE `clients` CHANGE COLUMN `User id` `idClient` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `First Name` `prenom` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Last Name` `nom` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Sex` `sexe` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Email` `email` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Phone` `telephone` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Date of birth` `dateNaissance` VARCHAR(50);
ALTER TABLE clients
ADD ville VARCHAR(37),
ADD pays VARCHAR(44),
ADD mdp VARCHAR(40);


ALTER TABLE `clients` 
CHANGE COLUMN `idClient` `idClient` VARCHAR(50) NOT NULL, 
ADD PRIMARY KEY (`idClient`)

-- Exemple d'insertion de lignes de commande aléatoires-- Limitez le nombre de lignes générées si nécessaire
