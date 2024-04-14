extends Node
class_name SummonableManager

@onready var player_summonables: Node2D = $"../Player/Summonables"
@onready var enemy_summonables: Node2D = $"../Enemy/Summonables"

const A = preload("res://summon/a.png")
const S = preload("res://summon/s.png")
const D = preload("res://summon/d.png")

const J = preload("res://summon/j.png")
const K = preload("res://summon/k.png")
const L = preload("res://summon/l.png")


const max_summons = 15


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func consume_summonable(key: String) -> Sprite2D:
	for idx in player_summonables.get_child_count():
		var child := player_summonables.get_child(idx)
		if child.name.begins_with(key):
			return child as Sprite2D

	return null


func consume_enemy_summonable(key: String) -> Sprite2D:
	for idx in enemy_summonables.get_child_count():
		var child := enemy_summonables.get_child(idx)
		if child.name.begins_with(key):
			return child as Sprite2D

	return null


func reformat_summonables() -> void:
	for idx in player_summonables.get_child_count():
		var target_y_pos := idx * 30
		# Add a little extra so we jump over our summoner
		if idx > 6:
			target_y_pos += 100
		player_summonables.get_child(idx).position = Vector2(15, target_y_pos)

	for idx in enemy_summonables.get_child_count():
		var target_y_pos := idx * 30
		# Add a little extra so we jump over our summoner
		if idx > 6:
			target_y_pos += 100
		enemy_summonables.get_child(idx).position = Vector2(15, target_y_pos)


func add_player_summon(key: String) -> void:
	if player_summonables.get_child_count() >= max_summons:
		# Popup something like "max summon queue reached"?
		return

	match key:
		"a":
			var tex := Sprite2D.new()
			tex.texture = A
			tex.name = "a_%s" % Time.get_ticks_usec()
			player_summonables.add_child(tex)
			reformat_summonables()
		"s":
			var tex := Sprite2D.new()
			tex.texture = S
			tex.name = "s_%s" % Time.get_ticks_usec()
			player_summonables.add_child(tex)
			reformat_summonables()
		"d":
			var tex := Sprite2D.new()
			tex.texture = D
			tex.name = "d_%s" % Time.get_ticks_usec()
			player_summonables.add_child(tex)
			reformat_summonables()
		_:
			push_error("unknown summonable type: %s" % key)

func _on_player_summon_a_timer_timeout() -> void:
	add_player_summon("a")


func _on_player_summon_s_timer_timeout() -> void:
	add_player_summon("s")


func _on_player_summon_d_timer_timeout() -> void:
	add_player_summon("d")



func add_enemy_summon(key: String) -> void:
	if enemy_summonables.get_child_count() >= max_summons:
		# Popup something like "max summon queue reached"?
		return

	match key:
		"j":
			var tex := Sprite2D.new()
			tex.texture = J
			tex.name = "j_%s" % Time.get_ticks_usec()
			enemy_summonables.add_child(tex)
			reformat_summonables()
		"k":
			var tex := Sprite2D.new()
			tex.texture = K
			tex.name = "k_%s" % Time.get_ticks_usec()
			enemy_summonables.add_child(tex)
			reformat_summonables()
		"l":
			var tex := Sprite2D.new()
			tex.texture = L
			tex.name = "l_%s" % Time.get_ticks_usec()
			enemy_summonables.add_child(tex)
			reformat_summonables()
		_:
			push_error("unknown summonable type: %s" % key)


func _on_enemy_summon_a_timer_timeout() -> void:
	add_enemy_summon("j")


func _on_enemy_summon_s_timer_timeout() -> void:
	add_enemy_summon("k")


func _on_enemy_summon_d_timer_timeout() -> void:
	add_enemy_summon("l")
