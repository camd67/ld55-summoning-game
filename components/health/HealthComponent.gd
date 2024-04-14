extends Node
class_name HealthComponent

signal on_death

@export var sprite: Sprite2D
@export var health: float
@export var health_gradient: GradientTexture1D

var max_health: float

func _ready() -> void:
	max_health = health
	sprite.self_modulate = health_gradient.gradient.sample(health / max_health)

func do_damage(amount: float = 1) -> void:
	health -= amount
	sprite.self_modulate = health_gradient.gradient.sample(health / max_health)
	if health <= 0:
		on_death.emit()
