import mysql.connector

class GestionCategories:
    def __init__(self, host, user, password, database):
        self.conn = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database,
        
        )
        self.cursor = self.conn.cursor()

    def inserer_categories(self):
        self.cursor.execute("SELECT DISTINCT category FROM products")
        categories = self.cursor.fetchall()

        for category in categories:
            category_parts = category[0].split('|')
            for i, cat_name in enumerate(category_parts):
                parent_category_id = None if i == 0 else self.cursor.lastrowid
                self.cursor.execute("INSERT INTO categories (nomCategorie, idCategorieMere) VALUES (%s, %s)", (cat_name.strip(), parent_category_id))
            self.conn.commit()

    def fermer_connexion(self):
        self.cursor.close()
        self.conn.close()

if __name__ == "__main__":
# Utilisation de la classe GestionCategories
    gestionnaire = GestionCategories(host="localhost",
        user="root",
        password="",
        database="ecommerce",
        
    )
    gestionnaire.inserer_categories()
    gestionnaire.fermer_connexion()
