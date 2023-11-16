# Importe la bibliothèque pour interagir avec MySQL et générer des nombres aléatoires
import mysql.connector
import random

# Définit une classe pour gérer les commandes
class GestionnaireCommandes:
    def __init__(self, host, user, password, database, unix_socket):
        # Initialise la connexion à la base de données
        self.connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            unix_socket=unix_socket
        )
        # Initialise un curseur pour exécuter des requêtes SQL
        self.curseur = self.connection.cursor()

    # Méthode pour récupérer les IDs de produits depuis la table produits
    def recuperer_ids_produits(self):
        self.curseur.execute("""
        SELECT `Uniq Id`
        FROM products;
        """)
        # Retourne une liste d'IDs de produits
        return [row[0] for row in self.curseur.fetchall()]

    # Méthode pour insérer des lignes de commandes dans la base de données
    # ...

# Méthode pour insérer des lignes de commandes dans la base de données
    def inserer_lignes_commandes(self):
        # Récupère les IDs de produits existants
        ids_produits = self.recuperer_ids_produits()

        # Récupère les IDs de commandes existantes
        self.curseur.execute("""
        SELECT idCommande
        FROM commande;
        """)
        commandes = self.curseur.fetchall()

        # Pour chaque commande
        for commande in commandes:
            # Crée un ensemble pour suivre les valeurs de Noligne déjà utilisées
            used_nolignes = set()

            # Insère un nombre aléatoire de lignes de commandes
            for i in range(random.randint(1, 3)):
                # Sélectionne un ID de produit existant au hasard
                idProduit = random.choice(ids_produits)
                # Génère une quantité aléatoire
                quantite = random.randint(1, 4)

                # Génère un numéro de ligne unique entre 1 et 3
                while True:
                    noligne = random.randint(1, 3)
                    if noligne not in used_nolignes:
                        used_nolignes.add(noligne)
                        break

                    # Si la valeur de Noligne est déjà utilisée, en générer une nouvelle

                # Insère la ligne de commande dans la base de données
                self.curseur.execute("""
                INSERT INTO lignesCommandes (idCommande, quantite, idProduit, Noligne)
                VALUES (%s, %s, %s, %s);
                """, (commande[0], quantite, idProduit, noligne))

        # Commit les changements dans la base de données
        self.connection.commit()

# ...

    # Méthode pour fermer la connexion à la base de données
    def fermer_connexion(self): 
        self.curseur.close()
        self.connection.close()

# Utilisation de la classe
if __name__ == "__main__":
    # Initialise un gestionnaire de commandes avec les paramètres de connexion
    gestionnaire = GestionnaireCommandes(
        host="localhost",
        user="root",
        password="root",
        database="ecommerce",
        unix_socket='/Applications/MAMP/tmp/mysql/mysql.sock'
    )

    # Insère des lignes de commandes dans la base de données
    if gestionnaire.inserer_lignes_commandes():
        print("L'insertion des lignes de commandes a été effectuée avec succès.")
    else:
        print("Erreur lors de l'insertion des lignes de commandes.")

    # Ferme la connexion à la base de données
    gestionnaire.fermer_connexion()
