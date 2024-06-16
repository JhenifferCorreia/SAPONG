extends CharacterBody2D

@onready var player1 = "res://scenes/player1.tscn"
@onready var player2 = "res://scenes/player2.tscn"
@onready var border = $"../Borders"

var win_size: Vector2
var dir: Vector2
const START_SPEED: int = 130
const MAX_SPEED: int = 400
var speed: int
var acelleration: int = 8

func _ready():
	win_size = get_viewport_rect().size
	new_ball()

#Spawna nova bola no centro da tela e ela vai em uma direção aleatória
func new_ball():
	position.x = win_size.x /2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		print(speed)
		#Se a bola bater nos Sapos
		collider = collision.get_collider()
		if player1 or player2:
			speed += acelleration
			if speed == MAX_SPEED:
				acelleration = 0
			dir = dir.bounce(collision.get_normal())
		#Se a bola bater nas bordas
		else:
			dir = dir.bounce(collision.get_normal())

func random_direction():
	var new_dir: Vector2
	new_dir.x = [1,-1].pick_random()
	new_dir.y = randf_range(-1,1)
	return new_dir.normalized()
	
	# Estamos usando "R" e "F" para o player 1 para se locomover e mouse1 e mouse 2 para o player 2 se locomover.
