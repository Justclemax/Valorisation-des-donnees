
def test()-> list:
    pass


import mysql.connector

connexion = mysql.connector.connect(
    user='root',
    password='root',
    host='localhost',
    unix_socket='/Applications/MAMP/tmp/mysql/mysql.sock',
    database='ecommerce',
)

curseur = connexion.cursor()

# Exemple : Afficher les 20 premières lignes de la table 'products'
curseur.execute("SELECT name, country, subcountry, geonameid FROM products LIMIT 20")

# Récupérer les résultats
resultats = curseur.fetchall()

# Trouver les longueurs maximales de chaque colonne
max_lengths = [max(len(str(row[i])) for row in resultats) for i in range(len(resultats[0]))]

# Afficher les résultats sous forme de tableau
print("+------------------------+-------------+---------------+--------------+")
print("| Name                   | Country     | Subcountry    | GeonameID    |")
print("+------------------------+-------------+---------------+--------------+")

for resultat in resultats:
    print(f"| {str(resultat[0]).ljust(max_lengths[0])} | {str(resultat[1]).ljust(max_lengths[1])} | {str(resultat[2]).ljust(max_lengths[2])} | {str(resultat[3]).ljust(max_lengths[3])} |")

print("+------------------------+-------------+---------------+--------------+")

# Fermer le curseur et la connexion
curseur.close()
connexion.close()