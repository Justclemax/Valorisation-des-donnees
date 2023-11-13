import mysql.connector
import random

# Connexion à la base de données
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="ecommerce",
)

curseur = cnx.cursor()

# Sélectionner les idProduits depuis la table Produits
curseur.execute("SELECT idProduit FROM produits")
id_produits = [row[0] for row in curseur.fetchall()]

# Sélectionner les idCommandes
curseur.execute("SELECT idCommande FROM commande")
id_commandes = [row[0] for row in curseur.fetchall()]

# Générer des lignes de commande pour chaque commande
for id_commande in id_commandes:
    nb_lignes = random.randint(1, 3)
    for noligne in range(1, nb_lignes + 1):
        id_produit = random.choice(id_produits)
        quantite = random.randint(1, 4)

        # Insérer la ligne de commande dans la table LignesCommandes
        curseur.execute("INSERT INTO lignescommandes (idCommande, noligne, idProduit, quantité) VALUES (%s, %s, %s, %s)",
                        (id_commande, noligne, id_produit, quantite))

# Valider les changements et fermer la connexion
cnx.commit()
curseur.close()
cnx.close()
