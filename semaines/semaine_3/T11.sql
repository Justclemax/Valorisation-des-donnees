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
