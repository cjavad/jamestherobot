extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	upload_map("test-2", {
		"version": "1.0.0",
		"height": 9,
		"width": 9,
		"agents": [
			{   
				"pos": [0, 0],
				"ins": [
					0,
					1,
					3,
					4
				]
			},
			{   
				"pos": [8, 8],
				"ins": [
					0,
					1,
					3,
					4
				]
			}
		],
		"tiles":[
			[[0], [9], [0], [0], [0], [0], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [0], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]],
			[[0], [0], [0], [0], [0], [2], [0], [0], [0]]
		],
		"building_tiles": [
			[7, 2],
			[6, 2],
			[2, 2]
		]    
	}, "javadshafique@gmail.com")
	pass # Replace with function body.

func upload_map(name: String, mapdata: Dictionary, email: String):
	var data = JSON.print(mapdata);
	var collection : FirestoreCollection = Firebase.Firestore.collection("map");
	var add_task : FirestoreTask = collection.add("level-{name}".format({name=name}), {'name': name, 'hash': data.md5_text(), 'data': data, 'status': 1, 'publisher': '/maps/{email_hash}'.format({email_hash=email.md5_text()})})
	var document : FirestoreDocument = yield(add_task, "add_document")
	return document;
