extends Control

@onready var player1_scene: PackedScene = preload("res://scenes/player1.tscn")
@onready var player2_scene: PackedScene = preload("res://scenes/player2.tscn")
@onready var ball_scene: PackedScene = preload("res://scenes/ball.tscn")

var random = RandomNumberGenerator.new()

var player1
var player2
var ball

func _ready():
	# Instanciar e adicionar os jogadores e a bola à árvore de cena
	
	player1 = player1_scene.instantiate()
	player2 = player2_scene.instantiate()
	ball = ball_scene.instantiate()
	
	random.randomize()

# Detectar a colisão da bola com a área de pontuação
func _on_score_left_body_entered(local_ball):
	player2.take_damage()
	local_ball.new_ball()
	
func _on_score_right_body_entered(local_ball):
	player1.take_damage()
	local_ball.new_ball()

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().change_scene_to_file.bind("res://scenes/main.tscn").call_deferred()
