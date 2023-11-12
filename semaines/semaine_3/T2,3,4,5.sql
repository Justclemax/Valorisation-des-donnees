CREATE TABLE categories(
   idCategorie INT NOT NULL AUTO_INCREMENT,
   nomCategorie VARCHAR(50),
   idCategorieMere INT ,
   PRIMARY KEY(idCategorie),
   FOREIGN KEY(idCategorieMere) REFERENCES categories(idCategorie)
		
);


CREATE TABLE commandes(
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
   idCategorie INT,
   PRIMARY KEY(idProduit)
   );


ALTER TABLE clients
MODIFY COLUMN idClient VARCHAR(50) NOT NULL,
ADD PRIMARY KEY (idClient);

CREATE TABLE lignescommandes(
   idCommande INT,
   noligne INT,
   quantite INT,
   idProduit VARCHAR(32),
   PRIMARY KEY(idCommande, noligne),
   FOREIGN KEY(idCommande) REFERENCES commandes(idCommande),
   FOREIGN KEY(idProduit) REFERENCES produits(idProduit)
);