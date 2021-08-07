extends Node

var userdata: Dictionary = {};

func _ready():
	Firebase.Auth.check_auth_file()
	
	if Firebase.Auth.auth != null and Firebase.Auth.auth.has("idtoken") != false:
		Firebase.Auth.get_user_data()
	
	Firebase.Auth.connect("login_succeeded", self, "_on_login_succeeded")
	Firebase.Auth.connect("login_failed", self, "_on_login_failed")
	Firebase.Auth.connect("auth_request", self, "_on_auth_request")
	Firebase.Auth.connect("userdata_received", self, "_on_userdata_received")

func _on_login_failed():
	$Button.set_text("Failed to login");

func _on_auth_request(result_code: int, result_content: String):
	$Button.set_text("Code: {code} & Content: {content}".format({code=result_code, content=result_content}));

func _on_login_succeeded(user : Dictionary):
	Firebase.Auth.save_auth(Firebase.Auth.auth);
	userdata = user;
	$Button.set_text("Logged in as {email}".format({email=userdata.email}));

func _on_userdata_received(user: Dictionary):
	userdata = user;
	print(user);
	$Button.set_text("Logged in as {email}".format({email=userdata.email}));

func _on_GetGoogleAuth_button_pressed() -> void:
	if userdata:
		return

	$Button.set_text("Waiting for an authorization code...");
	Firebase.Auth.get_google_auth_localhost();


func _on_Level0_pressed():
	get_tree().change_scene("res://scenes/level0.tscn")
	pass # Replace with function body.
