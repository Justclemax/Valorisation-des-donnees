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
ALTER TABLE `produits` CHANGE `idProduit` `idProduit` VARCHAR(50) NOT NUL;
INSERT INTO produits (idProduit)
SELECT `Uniq Id`
FROM products;


CREATE TABLE lignescommandes(
   idCommande INT,
   noligne INT,
   quantité INT,
   idProduit VARCHAR(50 ),
   PRIMARY KEY(idCommande, noligne),
   FOREIGN KEY(idCommande) REFERENCES commande(idCommande),
   FOREIGN KEY(idProduit) REFERENCES produits(idProduit)
);


INSERT INTO Produits (idProduit, nomproduit, prix, poids)
SELECT `Uniq Id`, `Product Name`, `Selling Price`, `Shipping Weight`
FROM `products`;
INSERT INTO Produits (`idCategorie`)
SELECT `idCategorie`
FROM categories;

ALTER TABLE `clients` 
CHANGE COLUMN `idClient` `idClient` VARCHAR(50) NOT NULL, 
ADD PRIMARY KEY (`idClient`);

