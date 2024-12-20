extends Node2D

@onready var host= $Host
@onready var join= $Join
@onready var username= $Username
@onready var send= $Send
@onready var message= $Message
@onready var messages= $Messages


var usrnm : String
var msg : String


func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(5001)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer=peer
	joined()

func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("104.236.210.111",5001)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer=peer
	joined()

func _on_send_pressed():
	rpc("msg_rpc",usrnm,message.text)
	message.text = ""

func on_enter_pressed():
	if Input.is_action_pressed("enter_pressed"):
		_on_send_pressed()
	
@rpc ("any_peer", "call_local")
func msg_rpc(usrnm,data):
	
	messages.text += str(usrnm, ": ", data, "\n")
	messages.scroll_vertical = INF
	
func joined():
	host.hide()
	join.hide()
	username.hide()
	usrnm = username.text


func _on_pong_pressed():
	get_tree().change_scene_to_file("res://pong.tscn")


func _on_tictoe_pressed():
	get_tree().change_scene_to_file("res://tictoe.tscn")
