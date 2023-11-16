-- Active: 1698796366625@@127.0.0.1@8889@ecommerce

ALTER TABLE Produits MODIFY COLUMN idProduit VARCHAR(36) UNIQUE;

INSERT INTO Produits (idProduit, nomproduit, prix, poids, idCategorie)
SELECT 
    `Uniq Id` as `idProduit`,
    `Product Name` as `nomproduit`,
    `Selling Price` as prix,
    `Shipping Weight` as poids,
    c.idCategorie as idCategorie
FROM products p
JOIN Categories c ON c.nomCategorie = TRIM(SUBSTRING_INDEX(p.Category, '|', -1))
ON DUPLICATE KEY UPDATE 
    nomproduit = VALUES(nomproduit),
    prix = VALUES(prix),
    poids = VALUES(poids),
    idCategorie = VALUES(idCategorie);
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