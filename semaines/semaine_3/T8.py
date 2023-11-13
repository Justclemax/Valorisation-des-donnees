import mysql.connector
import random
from datetime import datetime, timedelta

# Connexion à la base de données
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="ecommerce",
)

curseur = cnx.cursor()

# Sélectionner les idClients
curseur.execute("SELECT idClient FROM clients")
id_clients = [row[0] for row in curseur.fetchall()]

# Statuts possibles
statuts = ['en cours', 'payée', 'livrée', 'annulée']

# Générer des commandes pour chaque client
for id_client in id_clients:
    nb_commandes = random.randint(0, 5)
    for _ in range(nb_commandes):
        date_commande = datetime(2020, 1, 1) + timedelta(days=random.randint(0, 981))  # 1/9/2022 - 1/1/2020 = 981 days
        statut = random.choice(statuts)
        
        # Insérer la commande dans la table Commandes
        curseur.execute("INSERT INTO commande (idClient, dateCommande, statut) VALUES (%s, %s, %s)",
                        (id_client, date_commande, statut))

# Valider les changements et fermer la connexion
cnx.commit()
curseur.close()
cnx.close()
