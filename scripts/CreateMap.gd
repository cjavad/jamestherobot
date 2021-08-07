extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$
	pass

# WIP
func upload_map_firestore(name: String, mapdata: Dictionary, email: String):
	var data = JSON.print(mapdata);
	var collection : FirestoreCollection = Firebase.Firestore.collection("map");
	var add_task : FirestoreTask = collection.add("level-{name}".format({name=name}), {'name': name, 'hash': data.md5_text(), 'data': data, 'status': 1, 'publisher': '/maps/{email_hash}'.format({email_hash=email.md5_text()})})
	var document : FirestoreDocument = yield(add_task, "add_document")
	return document;

