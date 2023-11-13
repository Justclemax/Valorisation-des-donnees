-- Active: 1698920915378@@127.0.0.1@3306@ecommerce
CREATE TABLE Categories(
   idCategorie INT,
   nomCategorie VARCHAR(50),
   idCategorieMere INT,
   PRIMARY KEY(idCategorie)
);

CREATE TABLE Commande(
   idCommande INT,
   dateCommande DATE,
   statut VARCHAR(50),
   idClient INT,
   PRIMARY KEY(idCommande),
   FOREIGN KEY(idClient) REFERENCES clients(idClient)
);

CREATE TABLE Produits(
   idProduit INT,
   nomproduit VARCHAR(50),
   prix DECIMAL(10,2),
   poids DECIMAL(5,2),
   idCategorie INT,
   PRIMARY KEY(idProduit),
   FOREIGN KEY(idCategorie) REFERENCES Categories(idCategorie)
);

CREATE TABLE LignesCommandes(
   idCommande INT,
   noligne INT,
   quantité INT,
   idProduit INT,
   PRIMARY KEY(idCommande, noligne),
   UNIQUE(idProduit),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande),
   FOREIGN KEY(idProduit) REFERENCES Produits(idProduit)
);

--------------------------------------
ALTER TABLE commande
MODIFY COLUMN idCommande INT AUTO_INCREMENT;
"Cette commande modifie la colonne idCommande dans la table Commandes pour qu'elle soit définie comme auto-incrémentée."
---------------------------------------
ALTER TABLE Categories
MODIFY COLUMN idCategorie INT AUTO_INCREMENT;
"Cette commande modifie la colonne idCategorie dans la table categories pour qu'elle soit définie comme auto-incrémentée."
---------------------------------------
"#1833 - Cannot change column 'idCategorie': used in a foreign key constraint 'produits_ibfk_1' of table 'ecommerce.produits'"
ALTER TABLE Produits DROP FOREIGN KEY produits_ibfk_1;

ALTER TABLE Categories
MODIFY COLUMN idCategorie INT AUTO_INCREMENT;

ALTER TABLE Produits ADD FOREIGN KEY (idCategorie) REFERENCES Categories(idCategorie);
