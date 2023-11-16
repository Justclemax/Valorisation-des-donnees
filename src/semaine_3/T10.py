import mysql.connector

cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="ecommerce",
    unix_socket= '/Applications/MAMP/tmp/mysql/mysql.sock',

)

curseur = cnx.cursor()

# Sélectionner les catégories depuis la colonne category de la table Products
curseur.execute("SELECT DISTINCT category FROM products")
categories = [row[0] for row in curseur.fetchall()]

# Fonction pour insérer les catégories dans la table Categories
def inserer_categories(categories, id_categorie_mere=0):
    for category in categories:
        # Séparer les catégories en utilisant le séparateur |
        cat_list = category.split(' | ')

        # Insérer chaque catégorie dans la table Categories
        for i, cat in enumerate(cat_list):
            curseur.execute("INSERT INTO categories (nomCategorie, idCategorieMere) VALUES (%s, %s)",
                            (cat, id_categorie_mere))

            # Récupérer l'id de la catégorie insérée
            id_categorie = curseur.lastrowid

            # Récursivement insérer les catégories suivantes avec l'id de la catégorie précédente comme mère
            if i < len(cat_list) - 1:
                inserer_categories([cat_list[i+1]], id_categorie)

# Appeler la fonction pour insérer les catégories
inserer_categories(categories)

# Valider les changements et fermer la connexion
cnx.commit()
curseur.close()
cnx.close()