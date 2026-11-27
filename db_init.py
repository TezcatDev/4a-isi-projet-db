import sqlite3

connexion = sqlite3.connect("db_pol-eat-heck.db")
connexion.executescript(open("db_creation.sql", encoding="utf-8").read())
connexion.close()

print("DB créée")
