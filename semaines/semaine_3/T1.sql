ALTER TABLE `clients` CHANGE COLUMN `User id` `idClient` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `First Name` `prénom` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Last Name` `nom` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Sex` `sexe` VARCHAR(50);
ALTER TABLE `clients` CHANGE COLUMN `Email` `email` VARCHAR(50);
ALTER TABLE clients
ADD ville VARCHAR(37),
ADD pays VARCHAR(44),
ADD mdp VARCHAR(40);