-- Active: 1698796366625@@127.0.0.1@8889@ecommerce


--Clients avec le nombre total d'achats (Jointure avec Clients et Commandes) :
SELECT c.idClient, c.prenom, c.nom, COUNT(cmd.idCommande) AS NombreAchats
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient
GROUP BY c.idClient;

--"Nombre de Produits par Catégorie:"
SELECT c.nomCategorie, COUNT(p.idProduit) AS NombreDeProduits
FROM produits p
JOIN categories c ON p.idCategorie = c.idCategorie
GROUP BY c.nomCategorie;

--"Produits les Plus Vendus:"
SELECT p.nomProduit, SUM(lc.quantite) AS QuantiteVendue
FROM produits p
JOIN lignescommandes lc ON p.idProduit = lc.idProduit
GROUP BY p.nomProduit
ORDER BY QuantiteVendue DESC
LIMIT 10;

--"Commandes en Cours par Ville:"
SELECT c.ville, COUNT(cmd.idCommande) AS CommandesEnCours
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient AND cmd.statut = 'en cours'
GROUP BY c.ville;


--Produits Vendus par Pays:
SELECT c.pays, COUNT(DISTINCT p.idProduit) AS NombreProduitsVendus
FROM clients c
JOIN commande cmd ON c.idClient = cmd.idClient
JOIN lignescommandes lc ON cmd.idCommande = lc.idCommande
JOIN produits p ON lc.idProduit = p.idProduit
GROUP BY c.pays;

--"Produits Commandés au Moins 3 Fois:"
SELECT p.nomProduit, COUNT(lc.idCommande) AS NombreCommandes
FROM produits p
LEFT JOIN lignescommandes lc ON p.idProduit = lc.idProduit
GROUP BY p.nomProduit
HAVING NombreCommandes >= 3;

--Meilleurs Clients (par Montant Total des Achats):
SELECT c.idClient, c.prenom, c.nom, SUM(p.prix * lc.quantite) AS MontantTotalAchats
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient
LEFT JOIN lignescommandes lc ON cmd.idCommande = lc.idCommande
LEFT JOIN produits p ON lc.idProduit = p.idProduit
GROUP BY c.idClient
ORDER BY MontantTotalAchats DESC
LIMIT 10;


--Produits avec le prix moyen par catégorie (Jointure, Group by et HAVING) :
SELECT p.idCategorie, AVG(p.prix) AS PrixMoyen
FROM produits p
JOIN categories c ON p.idCategorie = c.idCategorie
GROUP BY p.idCategorie
HAVING PrixMoyen > 50;

--Clients avec des achats supérieurs à 500 euros (Jointure avec Clients, Commandes et LignesCommandes) :

SELECT c.idClient, c.prenom, c.nom, SUM(p.prix * lc.quantite) AS MontantTotalAchats
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient
LEFT JOIN lignescommandes lc ON cmd.idCommande = lc.idCommande
LEFT JOIN produits p ON lc.idProduit = p.idProduit
GROUP BY c.idClient
HAVING MontantTotalAchats > 500;

--Commandes en Cours par Ville:
SELECT c.ville, COUNT(cmd.idCommande) AS CommandesEnCours
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient AND cmd.statut = 'en cours'
GROUP BY c.ville;

--Clients avec plus de 2 achats annulés (Jointure, Group by et HAVING) :

SELECT c.idClient, c.prenom, c.nom, COUNT(cmd.idCommande) AS NombreAchatsAnnules
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient
WHERE cmd.statut = 'annulée'
GROUP BY c.idClient
HAVING NombreAchatsAnnules > 2;

--Produits Non Commandés (Jointure avec LignesCommandes) :
SELECT p.nomProduit
FROM produits p
LEFT JOIN lignescommandes lc ON p.idProduit = lc.idProduit
WHERE lc.idProduit IS NULL;


--Clients avec Plus de 5 Commandes non Livrées (utilisant HAVING):
SELECT c.idClient, COUNT(cmd.idCommande) AS NombreCommandesNonLivre
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient AND cmd.statut != 'livrée'
GROUP BY c.idClient
HAVING NombreCommandesNonLivre > 5;

--Nombre de Lignes par Relation:
SELECT 'clients' AS Relation, COUNT(*) AS NombreLignes FROM clients
UNION
SELECT 'produits' AS Relation, COUNT(*) AS NombreLignes FROM produits
UNION
SELECT 'categories' AS Relation, COUNT(*) AS NombreLignes FROM categories
UNION
SELECT 'commande' AS Relation, COUNT(*) AS NombreLignes FROM commande
UNION
SELECT 'lignescommandes' AS Relation, COUNT(*) AS NombreLignes FROM lignescommandes;


--Produits les Moins Vendus:
SELECT p.nomProduit, SUM(lc.quantite) AS QuantiteVendue
FROM produits p
LEFT JOIN lignescommandes lc ON p.idProduit = lc.idProduit
GROUP BY p.nomProduit
ORDER BY QuantiteVendue ASC
LIMIT 10;


--LES VUES

--Vue pour le nombre total d'achats par client :
CREATE VIEW VueNombreAchats AS
SELECT c.idClient, c.prenom, c.nom, COUNT(cmd.idCommande) AS NombreAchats
FROM clients c
LEFT JOIN commande cmd ON c.idClient = cmd.idClient
GROUP BY c.idClient;

--Vue pour les produits non vendus :
CREATE VIEW VueProduitsNonVendus AS
SELECT p.nomProduit
FROM produits p
LEFT JOIN lignescommandes lc ON p.idProduit = lc.idProduit
WHERE lc.idProduit IS NULL;

--Vue pour les Produits les Plus Vendus
CREATE VIEW ProduitsPlusVendus AS
SELECT
    p.idProduit,
    p.nomProduit,
    COUNT(l.idProduit) AS NombreVentes
FROM
    produits p
JOIN
    lignescommandes l ON p.idProduit = l.idProduit
GROUP BY
    p.idProduit, p.nomProduit
ORDER BY
    NombreVentes DESC;