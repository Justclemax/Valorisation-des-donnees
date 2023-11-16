CREATE TABLE categories(
   idCategorie INT NOT NULL AUTO_INCREMENT,
   nomCategorie VARCHAR(50),
   idCategorieMere INT NOT NULL ,
   PRIMARY KEY(idCategorie)
  
		
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


  



