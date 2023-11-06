CREATE TABLE categories(
   idCategorie INT NOT NULL AUTO_INCREMENT,
   nomCategorie VARCHAR(50),
   idCategorieMere VARCHAR(200),
   PRIMARY KEY(idCategorie),
   FOREIGN KEY(idCategorieMere) REFERENCES categories(idCategorie)
		
);

CREATE TABLE commande(
   idCommande INT NOT NULL AUTO_INCREMENT,
   dateCommande DATE,
   statut VARCHAR(50),
   idClient VARCHAR(15),
   PRIMARY KEY(idCommande),
   FOREIGN KEY(idClient) REFERENCES clients(idClient)
);

CREATE TABLE produits(
   idProduit VARCHAR(32),
   nomproduit VARCHAR(200),
   prix VARCHAR(19),
   poids VARCHAR(12),
   idCategorie INT,
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