import mysql.connector
import random

# Connexion à la base de données
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="ecommerce",
    unix_socket= '/Applications/MAMP/tmp/mysql/mysql.sock',
)

curseur = cnx.cursor()

# Sélectionner les noms de ville et de pays depuis la table Villes
curseur.execute("SELECT name, country FROM villes")
villes_pays = curseur.fetchall()

# Sélectionner les idClients
curseur.execute("SELECT idClient FROM clients")
id_clients = [row[0] for row in curseur.fetchall()]

# Mettre à jour la table Clients avec les villes et pays aléatoires
for id_client in id_clients:
    ville, pays = random.choice(villes_pays)
    
    curseur.execute("UPDATE Clients SET ville = %s, pays = %s WHERE idClient = %s", (ville, pays, id_client))
        

# Valider les changements et fermer la connexion
cnx.commit()
curseur.close()
cnx.close()
