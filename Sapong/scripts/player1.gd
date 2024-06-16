extends CharacterBody2D

var speed := 250
var win_height: float
var sprite_height: float

func _ready():
	win_height = get_viewport_rect().size.y
	sprite_height = $Sprite2D.texture.get_height()

#Move player1 para cima e baixo
func _physics_process(_delta):
	velocity.y = Input.get_axis("player1_up", "player1_down") * speed
	move_and_slide()

#Limita a movimentação do player ao tamanho da tela (esse número foi meio gambiarra por causa do tananho da sprite, pode dar merda dps)
func _process(_delta):
	position.y = clamp(position.y, sprite_height / 8, win_height - sprite_height / 8)
