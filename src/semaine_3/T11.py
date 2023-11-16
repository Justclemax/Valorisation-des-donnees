




import mysql.connector

conn = mysql.connector.connect(
     host="localhost",
        user="root",
        password="root",
        database="ecommerce",
        unix_socket='/Applications/MAMP/tmp/mysql/mysql.sock'
)

cursor = conn.cursor()

# Récupération des données de la table Product en utilisant une jointure avec Categories
cursor.execute("SELECT `Uniq Id`, `Product Name`, `Selling Price`, `Shipping Weight`, `category` FROM products P JOIN categories c ON c.nomCategorie = TRIM(SUBSTRING_INDEX(P.category, '|', -1))")
result = cursor.fetchall()

# Insertion des données dans la table produit
insert_query = "INSERT INTO produits (idProduit, nomProduit, prix, poids, idCategorie) VALUES (%s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE nomProduit=VALUES(nomProduit), prix=VALUES(prix), poids=VALUES(poids), idCategorie=VALUES(idCategorie)"

for row in result:
    # Vérification si l'idProduit existe déjà dans la table produit
    check_query = "SELECT idProduit FROM produits WHERE idProduit = %s"
    cursor.execute(check_query, (row[0],))
    existing_row = cursor.fetchone()

    if not existing_row:
        # Si l'idProduit n'existe pas, alors on peut l'insérer
        cursor.execute(insert_query, row)

conn.commit()
conn.close()