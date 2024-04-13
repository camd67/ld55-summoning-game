extends CharacterBody2D
class_name Summon

@export var letter_texture: Texture2D
@export var friendly_to_player := true

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = letter_texture
	if friendly_to_player:
		add_to_group("player_summon")
	else:
		add_to_group("enemy_summon")

func _process(delta: float) -> void:
	if friendly_to_player:
		velocity = Vector2(20, 0)
	else:
		velocity = Vector2(-20, 0)
	move_and_slide()


func die() -> void:
	queue_free()
