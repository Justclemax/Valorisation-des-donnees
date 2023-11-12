-- Active: 1698796366625@@127.0.0.1@8889@ecommerce

INSERT INTO Produits (idProduit, nomproduit, prix, poids)
SELECT `Uniq Id`, `Product Name`, `Selling Price`, `Shipping Weight`
FROM `products`;
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

ALTER TABLE produits
DROP FOREIGN KEY produits_ibfk_1;
ALTER TABLE produits
MODIFY idCategorie INT AUTO_INCREMENT

ALTER TABLE produits
ADD FOREIGN KEY (idCategorie) REFERENCES categories(idCategorie);

DELETE FROM produits
WHERE prix IS NULL;
