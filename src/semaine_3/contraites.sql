
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
    `Uniq Id` as `idProduit`,
    `Product Name` as `nomproduit`,
    `Selling Price` as prix,
    `Shipping Weight` as poids,
    c.idCategorie as idCategorie
FROM products p
JOIN Categories c ON   c.nomCategorie =TRIM(SUBSTRING_INDEX(p.Category, '|', -1));
    
INSERT INTO Produits (idProduit, nomproduit, prix, poids, idCategorie)
SELECT 
    products.`Uniq Id` AS idProduit,
    products.`Product Name` AS nomproduit,
    -- Transforming prix column
    CASE
        WHEN products.`Selling Price` LIKE '%USD%' THEN 
            CAST(SUBSTRING_INDEX(products.`Selling Price`, ' ', 1) AS DECIMAL(10,2))
        ELSE NULL  -- Handle uninterpretable values, you can modify this accordingly
    END AS prix,
    -- Transforming poids column
    CASE
        WHEN products.`Shipping Weight` LIKE '%ounce%' THEN 
            CAST(SUBSTRING_INDEX(products.`Shipping Weight`, ' ', 1) AS DECIMAL(10,4)) * 0.0625
        WHEN products.`Shipping`  ;
ALTER TABLE produits
DROP FOREIGN KEY produits_ibfk_1;
ALTER TABLE produits
MODIFY idCategorie INT AUTO_INCREMENT

ALTER TABLE produits
ADD FOREIGN KEY (idCategorie) REFERENCES categories(idCategorie);

ALTER TABLE categories
DROP FOREIGN KEY idCategorie_ibfk_1;




INSERT INTO Produits (idProduit, nomproduit, prix, poids, idCategorie)
SELECT 
    products.`Uniq Id` AS idProduit,
    products.`Product Name` AS nomproduit,
    -- Transforming prix column
    CASE
        WHEN products.`Selling Price` LIKE '%$%' THEN 
            CAST(SUBSTRING_INDEX(products.`Selling Price`, ' ', 1) AS DECIMAL(10,2))
        ELSE NULL  -- Handle uninterpretable values, you can modify this accordingly
    END AS prix,
    -- Transforming poids column
    CASE
        WHEN products.`Shipping Weight` LIKE '%ounce%' THEN 
            CAST(SUBSTRING_INDEX(products.`Shipping Weight`, ' ', 1) AS DECIMAL(10,4)) * 0.0625
        WHEN products.`Shipping Weight` LIKE '%pound%' THEN 
            CAST(SUBSTRING_INDEX(products.`Shipping Weight`, ' ', 1) AS DECIMAL(10,4))
        ELSE NULL  -- Handle uninterpretable values, you can modify this accordingly
    END AS poids,
    categories.idCategorie
FROM 
    products
JOIN 
    categories ON products.`Category` = categories.nomCategorie;
