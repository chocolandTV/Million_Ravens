extends Node

class_name HighscoreUISystem

@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")

var game_API_key = "dev_0e36fc6a869c4616a00d895124bd13cb"
var development_mode = true
var leaderboard_key = "MillionRavens20240309_MF"
var session_token =""
var highscore_Table : Array[HighScore]


var player_session_exists = false

# HTTP Request node can only handle one call per node
var auth_http
var leaderboard_http
var submit_score_http

var set_name_http
var get_name_http


func _ready():
	print("authenticate")
	_authentication_request()
	# _change_player_name(globalVars.gv_Settings["player_name"])
	#_get_player_name()

func _authentication_request():
	# Check if a player session exists
	player_session_exists = false
	var player_identifier : String
	var file = FileAccess.open("user://LootLocker.data", FileAccess.READ)
	if file != null:
		player_identifier = file.get_as_text()
		print("player ID="+player_identifier)
		file.close()
	
	if player_identifier != null and player_identifier.length() > 1:
		print("player session exists, id="+player_identifier)
		player_session_exists = true
	if(player_identifier.length() > 1):
		player_session_exists = true
		
	## Convert data to json string:
	var data = { "game_key": game_API_key, "game_version": globalVars.gv_Settings["game_version"], "development_mode": true }
	
	# If a player session already exists, send with the player identifier
	if(player_session_exists == true):
		data = { "game_key": game_API_key, "player_identifier":player_identifier, "game_version": globalVars.gv_Settings["game_version"], "development_mode": true }
	
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	
	# Create a HTTPRequest node for authentication
	auth_http = HTTPRequest.new()
	add_child(auth_http)
	auth_http.request_completed.connect(_on_authentication_request_completed)
	# Send request
	auth_http.request("https://api.lootlocker.io/game/v2/session/guest", headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	# Print what we're sending, for debugging purposes:
	print(data)


func _on_authentication_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Save the player_identifier to file
	var file = FileAccess.open("user://LootLocker.data", FileAccess.WRITE)
	file.store_string(json.get_data().player_identifier)
	file.close()
	
	# Save session_token to memory
	session_token = json.get_data().session_token
	print("Session_token" + session_token)
	# Print server response
	print(json.get_data())
	
	# Clear node
	auth_http.queue_free()
	# Get leaderboards
	_get_leaderboards()
	_get_player_name()

func _get_leaderboards():
	print ("Getting Leaderboards")
	# var url
	var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/list?count=10"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	#create a request node for getting the highscore
	leaderboard_http = HTTPRequest.new()
	add_child(leaderboard_http)
	leaderboard_http.request_completed.connect(_on_leaderboard_request_complete)
	# send request
	leaderboard_http.request(url, headers, HTTPClient.METHOD_GET,"")
	


func _on_leaderboard_request_complete(result, response_code, headers, body):
	# new json
	var json = JSON.new()
	# json parse
	json.parse(body.get_string_from_utf8())
	# Print data
	print(json.get_data())

	highscore_Table.clear()
	
	for n in json.get_data().items.size():
		var metadata = json.get_data().items[n].metadata.rsplit(",", true, 3)
		
		highscore_Table.append(HighScore.new(
		str(json.get_data().items[n].rank),
		str(json.get_data().items[n].player.name),
		str(json.get_data().items[n].score),
		metadata[0],
		metadata[1],
		metadata[2]))

	print(json.get_data().items.size())
	GameEvents.win_game_highscore_show_after_signal.emit()
	# clear node
	# if leaderboard_http != null:
	# 	print("is null request_token")
	leaderboard_http.queue_free()
	

func _upload_score(score :int, _metadata : String):
	# data verifier  is boss down && new score is higher >
	var data = {"score": str(score), "metadata": _metadata}
	var headers = ["Content-Type: application/json", "x-session-token:" + session_token]
	submit_score_http = HTTPRequest.new()
	add_child(submit_score_http)
	submit_score_http.request_completed.connect(_on_upload_score_request_completed)
	submit_score_http.request("https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/submit",headers,HTTPClient.METHOD_POST, JSON.stringify(data))
	print(data)

func _on_upload_score_request_completed(result, response_code, header, body):
	# new json
	var json = JSON.new()
	# json parse body get string
	json.parse(body.get_string_from_utf8())
	# print data
	print(json.get_data())
	# clear node
	submit_score_http.queue_free()

func _change_player_name(player_name :String):
	print("Changing player name")
	
	var data = { "name":player_name }
	var url =  "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	set_name_http = HTTPRequest.new()
	add_child(set_name_http)
	set_name_http.request_completed.connect(_on_player_set_name_request_completed)
	# Send request
	set_name_http.request(url, headers, HTTPClient.METHOD_PATCH, JSON.stringify(data))
	
func _on_player_set_name_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print(json.get_data())
	set_name_http.queue_free()
	_get_leaderboards()

func _get_player_name():
	print("Getting player name")
	var url = "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	get_name_http = HTTPRequest.new()
	add_child(get_name_http)
	get_name_http.request_completed.connect(_on_player_get_name_request_completed)
	# Send request
	get_name_http.request(url, headers, HTTPClient.METHOD_GET, "")

func _on_player_get_name_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	print("HighscoreSystem: get Playername:" + json.get_data().name)
	GlobalVariables.gv_Settings["player_name"] = json.get_data().name
	get_name_http.queue_free()