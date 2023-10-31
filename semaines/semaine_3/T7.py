import random
import secrets
import string
def generateur_mot_passe(pwd: str, taille: int) -> str:

    lettres = string.ascii_letters
    chiffres = string.digits
    special_chars = string.punctuation
    alphabet = [lettres, chiffres, special_chars]

    for i in range(taille):
        pwd += random.choice(alphabet)

    return pwd
pwd = generateur_mot_passe("", 10)
print(list(pwd))


