#isto do robot.api.deco servira para eu criar uma palavra reservada no robot
from robot.api.deco import keyword
from pymongo import MongoClient

#Isto aqui eu peguei direto no meu site do mongoDB
client = MongoClient('mongodb+srv://qa:qamaster@cluster1.4uktuax.mongodb.net/?retryWrites=true&w=majority&appName=Cluster1')

db = client['markdb']

#aqui o que faço é, cada vez que eu chamar a palavra reservada remove user from database, ira ser usado o metodo abaixo
@keyword('remove user from database')
def remove_user(email):
	usuarios = db['users']
	usuarios.delete_many({'email': email})
	print('removing user by' + email)
