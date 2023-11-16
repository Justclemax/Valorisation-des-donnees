CREATE TABLE categories(
   idCategorie INT NOT NULL AUTO_INCREMENT,
   nomCategorie VARCHAR(50),
   idCategorieMere INT NOT NULL ,
   PRIMARY KEY(idCategorie),
  
		
);

CREATE TABLE commande(
   idCommande INT NOT NULL AUTO_INCREMENT,
   dateCommande DATE,
   statut VARCHAR(50),
   idClient VARCHAR(50),
   PRIMARY KEY(idCommande),
   FOREIGN KEY(idClient) REFERENCES clients(idClient)
);

CREATE TABLE produits(
   idProduit VARCHAR(32),
   nomproduit VARCHAR(200),
   prix VARCHAR(19),
   poids VARCHAR(12),
   idCategorie INT NOT NULL,
   PRIMARY KEY(idProduit),
   FOREIGN KEY(idCategorie) REFERENCES categories(idCategorie)
   );




CREATE TABLE lignescommandes(
   idCommande INT,
   noligne INT,
   quantite INT,
   idProduit VARCHAR(32),
   PRIMARY KEY(idCommande, noligne),
   FOREIGN KEY(idCommande) REFERENCES commande(idCommande),
   FOREIGN KEY(idProduit) REFERENCES produits(idProduit)
);

UPDATE produits
SET prix = CAST(REPLACE(prix, '$', '') AS DECIMAL(10,2))
WHERE prix NOT LIKE '%from%' AND 
      REPLACE(prix, '$', '') REGEXP '^[0-9]+(\.[0-9]+)?$';

UPDATE produits
SET poids = 
  CASE 
    WHEN poids LIKE '%ounce%' THEN CAST(REPLACE(poids, ' ounce', '') * 0.0625 AS DECIMAL(10,2))
    WHEN poids LIKE '%pound%' THEN CAST(REPLACE(poids, ' pound', '') AS DECIMAL(10,2))
    ELSE poids
  END;
  

INSERT INTO Produits (idProduit, nomproduit, prix, poids, idCategorie)
SELECT 
    `Uniq Id`,  -- Remplacez 255 par la taille appropriée
    `Product Name`, 
    `Selling Price`, 
    `Shipping Weight`
FROM 
    products
JOIN 
    Categories ON products.`Category` = Categories.nomCategorie;  -- Remplacez `Category` par le nom exact de la colonne dans la table products

ALTER TABLE produits
DROP FOREIGN KEY produits_ibfk_1;
ALTER TABLE produits
MODIFY idCategorie INT AUTO_INCREMENT

ALTER TABLE produits
ADD FOREIGN KEY (idCategorie) REFERENCES categories(idCategorie);

