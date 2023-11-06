
import mysql.connector
import string
import secrets


# Connexion à la base de données
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="ecommerce",
    unix_socket= '/Applications/MAMP/tmp/mysql/mysql.sock',

)

curseur = cnx.cursor()

# Fonction pour générer un mot de passe aléatoire
def generer_mot_de_passe():
    alphabet = string.ascii_letters + string.digits + string.punctuation
    mot_de_passe = ''.join(secrets.choice(alphabet) for i in range(12))
    return mot_de_passe


# Sélectionner les idClients
curseur.execute("SELECT idClient FROM clients")
id_clients = [row[0] for row in curseur.fetchall()]

# Mettre à jour la table Clients avec des mots de passe aléatoires
for id_client in id_clients:
    mot_de_passe = generer_mot_de_passe()
    curseur.execute("UPDATE clients SET mdp = %s WHERE idClient = %s", (mot_de_passe, id_client))

# Valider les changements et fermer la connexion
cnx.commit()
curseur.close()
cnx.close()
