extends Node2D

# This is really duplicated but... tis a jam

@onready var player_hurt_area: Area2D = $Player/HurtArea
@onready var player_health_component: HealthComponent = $Player/HealthComponent
@onready var player_barrier: Sprite2D = $Player/Barrier
@onready var player_animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var player_win_overlay: Node2D = $PlayerWinOverlay

@onready var enemy_hurt_area: Area2D = $Enemy/HurtArea
@onready var enemy_health_component: HealthComponent = $Enemy/HealthComponent
@onready var enemy_barrier: Sprite2D = $Enemy/Barrier
@onready var enemy_animation_player: AnimationPlayer = $Enemy/AnimationPlayer
@onready var enemy_win_overlay: Node2D = $EnemyWinOverlay

@onready var focus_arrows: Node2D = $FocusArrows
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var game_over_emitted := false


func _ready() -> void:
	player_hurt_area.body_entered.connect(on_player_hurt)
	enemy_hurt_area.body_entered.connect(on_enemy_hurt)
	player_win_overlay.visible = false
	focus_arrows.visible = false
	enemy_win_overlay.visible = false


func on_player_hurt(body: Node2D) -> void:
	if game_over_emitted:
		return

	if body.is_in_group("enemy_summon"):
		# Before damaging, check for game over
		if player_health_component.health <= 0:
			game_over_emitted = true
			GlobalEvent.emit_enemy_won()
			player_animation_player.play("summoner_death")
			enemy_win_overlay.visible = true
			enemy_win_overlay.get_node("AnimationPlayer").play("default")
		else:
			player_health_component.do_damage(1)
			body._on_health_component_on_death()


func on_enemy_hurt(body: Node2D) -> void:
	if game_over_emitted:
		return

	if body.is_in_group("player_summon"):
		if enemy_health_component.health <= 0:
			game_over_emitted = true
			GlobalEvent.emit_player_won()
			enemy_animation_player.play("summoner_death")
			player_win_overlay.visible = true
			player_win_overlay.get_node("AnimationPlayer").play("default")
		else:
			enemy_health_component.do_damage(1)
			body._on_health_component_on_death()


func _on_player_health_component_on_death() -> void:
	create_tween().tween_property($Player/Barrier, "modulate", Color.hex(0xff1f0f00), 1)


func _on_enemy_health_component_on_death() -> void:
	create_tween().tween_property($Enemy/Barrier, "modulate", Color.hex(0xff1f0f00), 1)


# NOTE: These are NOT only for sans-serif, but shared with serif.
# Jam's almost over...
func _on_sans_serif_victory_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_sans_serif_victory_button_mouse_entered() -> void:
	focus_arrows.visible = true
	animation_player.play("arrow_bounce")


func _on_sans_serif_victory_button_mouse_exited() -> void:
	focus_arrows.visible = false
	animation_player.stop()
