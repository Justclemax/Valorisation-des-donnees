import mysql.connector

connexion = mysql.connector.connect(
    user='root',
    password='',
    host='localhost',
    database='ecommerce',
)

curseur = connexion.cursor()

# Exemple : Afficher les 20 premières lignes de la table 'villes'
curseur.execute("SELECT name, country, subcountry, geonameid FROM villes LIMIT 20")

# Récupérer les résultats
resultats = curseur.fetchall()

# Définir la largeur des colonnes pour l'affichage du tableau
largeur_colonnes = [20, 20, 20, 20]

# Afficher les entêtes

print("{} ".format('-' * (sum(largeur_colonnes) + 3 + 3*len(largeur_colonnes))))
print("| {:<{}} | {:<{}} | {:<{}} | {:<{}} |".format('Nom', largeur_colonnes[0], 'Pays', largeur_colonnes[1], 'Sous-pays', largeur_colonnes[2], 'ID Géographique', largeur_colonnes[3]))
print("|{} ".format('-' * (sum(largeur_colonnes) + 3 + 3*len(largeur_colonnes))))

# Afficher les résultats sous forme de tableau
for resultat in resultats:
    print("| {:<{}} | {:<{}} | {:<{}} | {:<{}} |".format(resultat[0], largeur_colonnes[0], resultat[1], largeur_colonnes[1], resultat[2], largeur_colonnes[2], resultat[3], largeur_colonnes[3]))
    print("|{} ".format('-' * (sum(largeur_colonnes) + 3 + 3*len(largeur_colonnes))))

# Fermer le curseur et la connexion
curseur.close()
connexion.close()


