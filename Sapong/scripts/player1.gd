extends CharacterBody2D

var speed := 250
var win_height: float
var p_height : float
var health = 3

func _ready():
	win_height = get_viewport_rect().size.y
	p_height = 30

#Move player1 para cima e baixo
func _physics_process(_delta):
	velocity.y = Input.get_axis("player1_up", "player1_down") * speed
	$AnimatedSprite2D.play("walking")
	move_and_slide()

#Limita a movimentação do player ao tamanho da tela (esse número foi meio gambiarra por causa do tananho da sprite, pode dar merda dps)
func _process(_delta):
	position.y = clamp(position.y, p_height / 8, win_height - p_height / 8)

func take_damage():
	health -= 1
	print(health)
	# Animação e mudança de cor aqui
	if health == 0:
		player_died()

func player_died():
	print("MORREU PLAYER 2")
