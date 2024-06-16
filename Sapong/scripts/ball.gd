extends CharacterBody2D

@onready var player1: PackedScene = preload("res://scenes/player1.tscn")
@onready var player2: PackedScene = preload("res://scenes/player2.tscn")
@onready var border = $"../Borders"

var win_size: Vector2
var dir: Vector2
const START_SPEED: int = 130
const MAX_SPEED: int = 400
var speed: int
var acelleration: int = 8
const MAX_Y_VECTOR: float = 0.6

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
		speed += acelleration
		print(speed)
		#Se a bola atingir a velocidade máxima
		if speed == MAX_SPEED:
			acelleration = 0
		collider = collision.get_collider()
		#Se a bola bater nos Sapos
		if collider == player1 or collider == player2:
			dir = new_direction(collider)
		#Se a bola bater nas bordas
		else:
			dir = dir.bounce(collision.get_normal())

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1,-1].pick_random()
	new_dir.y = randf_range(-1,1)
	return new_dir.normalized()

func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	#Muda a direção horizontal
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
