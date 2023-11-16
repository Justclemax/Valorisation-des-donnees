import mysql.connector
import random

from datetime import datetime, timedelta


# la classe 
class AjouDonneeCommandes:
    def __init__(self, host, user, password, database, unix_socket) :
        self.connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            unix_socket=unix_socket
        )
        self.curseur = self.connection.cursor()


    def inserer_lignes_commandes(self):
        self.curseur.execute("SELECT idClient FROM Clients")
        id_clients = [row[0] for row in self.curseur.fetchall()]

        for client in id_clients:
            for _ in range(random.randint(0, 5)):
                start_date = datetime(2020, 1, 1)
                end_date = datetime(2022, 9, 1)
                random_date = start_date + timedelta(days=random.randint(0, (end_date - start_date).days))
                statut = random.choice(['en cours', 'payée', 'livrée', 'annulée'])
                self.curseur.execute("""
                INSERT INTO commande (idClient, dateCommande, statut)
                VALUES (%s, %s, %s);
                """, (client, random_date, statut))
        self.connection.commit()

    def femer_connexion(self):
        self.curseur.close()
        self.connection.close()

if __name__ == "__main__":

    ajout= AjouDonneeCommandes(
        host="localhost",
        user="root",
        password="root",
        database="ecommerce",
        unix_socket='/Applications/MAMP/tmp/mysql/mysql.sock'

    )
    ajout.inserer_lignes_commandes()
    ajout.femer_connexion()

