########################

import mysql.connector




def se_connecter() -> object:
    connexion = mysql.connector.connect(
         user='root',
        password='',
        host='localhost',
        database='ecommerce',
    )
    return connexion

def executer_requete(connexion, requete:str)-> object:
    curseur = connexion.cursor()
    curseur.execute(requete)
    resultats = curseur.fetchall()
    curseur.close()
    return resultats

def afficher_resultats(resultats, largeur_colonnes):
    print("{} ".format('-' * (sum(largeur_colonnes) + 3 + 3*len(largeur_colonnes))))
    print("| {:<{}} | {:<{}} | {:<{}} | {:<{}} |".format('Nom', largeur_colonnes[0], 'Pays', largeur_colonnes[1], 'Sous-pays', largeur_colonnes[2], 'ID Géographique', largeur_colonnes[3]))
    print("|{} ".format('-' * (sum(largeur_colonnes) + 3 + 3*len(largeur_colonnes))))

    for resultat in resultats:
        print("| {:<{}} | {:<{}} | {:<{}} | {:<{}} |".format(resultat[0], largeur_colonnes[0], resultat[1], largeur_colonnes[1], resultat[2], largeur_colonnes[2], resultat[3], largeur_colonnes[3]))
        print("|{} ".format('-' * (sum(largeur_colonnes) + 3 + 3*len(largeur_colonnes))))

def fermer_connexion(connexion: object):
    connexion.close()

# Exemple d'utilisation

connexion = se_connecter()
requete = "SELECT name, country, subcountry, geonameid FROM villes LIMIT 20"
resultats = executer_requete(connexion, requete)
largeur_colonnes = [20, 20, 20, 20]

# excution
if __name__=="__main__":
    afficher_resultats(resultats, largeur_colonnes)
    fermer_connexion(connexion)



