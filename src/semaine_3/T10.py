import mysql.connector


class GestionnaireCategories:
    def __init__(self, host, user, password, database, unix_socket):
        self.connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            unix_socket=unix_socket
        )
        self.curseur = self.connection.cursor()

    def femer_connexion(self):
        self.curseur.close()
        self.connection.close()


    def insertionDonnees(self):

        self.curseur.execute("SELECT category FROM products")

        categories = self.curseur.fetchall()

        for categorie in categories :
            liste_categorie = categorie[0].split(' | ')

            id_categorie_mere = None

            for id_categorie in liste_categorie:
                # Vérifier si la catégorie existe déjà
                self.curseur.execute("SELECT idCategorie FROM Categories WHERE nomCategorie = %s AND idCategorieMere = %s",
                               (id_categorie, id_categorie_mere))
                cat_id = self.curseur.fetchone()

                if cat_id:
                    parent_id = cat_id[0]
                else:
                    # Insérer la catégorie uniquement si elle n'existe pas encore
                    self.curseur.execute("INSERT INTO Categories (nomCategorie, idCategorieMere) VALUES (%s, %s)",
                                   (id_categorie, id_categorie_mere))
                    parent_id = self.curseur.lastrowid  # Récupérer l'ID de la nouvelle catégorie

        self.connection.commit()








if __name__ == "__main__":

    gestionnaire_categories= GestionnaireCategories(
        host="localhost",
        user="root",
        password="root",
        database="ecommerce",
        unix_socket='/Applications/MAMP/tmp/mysql/mysql.sock'

    )

    gestionnaire_categories.insertionDonnees()
    gestionnaire_categories.femer_connexion()