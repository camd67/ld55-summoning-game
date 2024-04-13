extends Node2D

@onready var player_hurt_area: Area2D = $Player/HurtArea
@onready var enemy_hurt_area: Area2D = $Enemy/HurtArea
@onready var player_hp_label: Label = $BattlefieldUi/PlayerHpLabel
@onready var enemy_hp_label: Label = $BattlefieldUi/EnemyHpLabel

@export var player_health := 10
@export var enemy_health := 10


func _ready() -> void:
	player_hurt_area.body_entered.connect(on_player_hurt)
	enemy_hurt_area.body_entered.connect(on_enemy_hurt)
	update_hp_labels()


func update_hp_labels() -> void:
	player_hp_label.text = "W HP: %s" % player_health
	enemy_hp_label.text = "I HP: %s" % enemy_health


func on_player_hurt(body: Node2D) -> void:
	if body.is_in_group("enemy_summon"):
		player_health -= 1
		update_hp_labels()
		body.die()


func on_enemy_hurt(body: Node2D) -> void:
	if body.is_in_group("player_summon"):
		enemy_health -= 1
		update_hp_labels()
		body.die()
