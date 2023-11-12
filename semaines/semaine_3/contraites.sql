-- Active: 1698796366625@@127.0.0.1@8889@ecommerce
ALTER TABLE `produits` CHANGE `idProduit` `idProduit` VARCHAR(50) NOT NULL;




ALTER TABLE produits
ADD idCategorie INT,
ADD FOREIGN KEY (idCategorie) REFERENCES categories(idCategorie);

ALTER TABLE produits
DROP FOREIGN KEY produits_ibfk_1;

ALTER TABLE produits
MODIFY idCategorie INT AUTO_INCREMENT;
ALTER TABLE produits
ADD FOREIGN KEY (idCategorie) REFERENCES categories(idCategorie);






