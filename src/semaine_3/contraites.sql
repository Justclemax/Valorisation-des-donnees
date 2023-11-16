-- Active: 1698796366625@@127.0.0.1@8889@ecommerce

ALTER TABLE Produits MODIFY COLUMN idProduit VARCHAR(36) UNIQUE;
    
ALTER TABLE produits
DROP FOREIGN KEY produits_ibfk_1;

ALTER TABLE `clients` 
CHANGE COLUMN `idClient` `idClient` VARCHAR(50) NOT NULL, 
ADD PRIMARY KEY (`idClient`)

ALTER TABLE produits
ADD FOREIGN KEY (idCategorie) REFERENCES categories(idCategorie);






    -- Transforming prix column
   
