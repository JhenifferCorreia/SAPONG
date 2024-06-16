extends CharacterBody2D

var speed := 250
var win_height: float
var sprite_height: float

func _ready():
	win_height = get_viewport_rect().size.y
	sprite_height = $Sprite2D.texture.get_height()

#Move player2 para cima e baixo
func _physics_process(_delta):
	velocity.y = Input.get_axis("player2_up", "player2_down") * speed
	move_and_slide()

#Limita a movimentação do player ao tamanho da tela (esse número foi meio gambiarra, pode dar merda dps)
func _process(delta):
	position.y = clamp(position.y, sprite_height / 8, win_height - sprite_height / 8)
