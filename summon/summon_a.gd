extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_timer: Timer = $AttackTimer
@onready var enemy_detector: Area2D = $EnemyDetector

@export var damage_range: Vector2
@export var speed: Vector2
@export var is_enemy := false

var is_attacking := false
var is_dying := false

func _ready() -> void:
	GlobalEvent.game_over.connect(func(player_won: bool) -> void:
		# If we're part of the side that lost, immediately die
		# This way we don't potentially end up in a stalemate where
		# one player lost but units keep moving forward
		if player_won == is_enemy:
			_on_health_component_on_death()
	)

	if is_enemy:
		remove_from_group("player_summon")
		speed *= Vector2(-1, 1)

func _process(delta: float) -> void:
	if is_dying:
		return

	if not is_attacking:
		velocity = speed
		animation_player.play("walk")
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func _physics_process(delta: float) -> void:
	if is_dying:
		return

	if enemy_detector.has_overlapping_bodies() and not is_attacking:
		is_attacking = true
		animation_player.play("attack")


func die() -> void:
	queue_free()


func _on_attack_timer_timeout() -> void:
	if not enemy_detector.has_overlapping_bodies():
		is_attacking = false
		return

	animation_player.play("attack")


func _on_health_component_on_death() -> void:
	is_dying = true
	animation_player.play("die")


func _on_hitbox_body_entered(body: Node2D) -> void:
	var health_component := body.get_node_or_null("HealthComponent")
	if health_component != null:
		var actual_damage := randf_range(damage_range.x, damage_range.y)
		health_component.do_damage(actual_damage)
