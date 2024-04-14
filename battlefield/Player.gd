extends Node2D

@onready var summonable_manager: SummonableManager = $"../SummonableManager"
@onready var hurt_area: Area2D = $HurtArea
@onready var player_summons: Node2D = $PlayerSummons

const a_summon = preload("res://summon/summon_a.tscn")
const s_summon = preload("res://summon/summon_s.tscn")
const summon_d = preload("res://summon/summon_d.tscn")

var summon_area := Rect2(0, 0, 400, 600)

var game_over := false


func _ready() -> void:
	GlobalEvent.game_over.connect(func(player_won: bool) -> void:
		game_over = true
	)


func _input(event: InputEvent) -> void:
	# don't allow any more inputs if the game is over
	if game_over:
		return

	# We're not a key event, ignore
	if not event is InputEventKey:
		return

	# We're not in our summoning rect, ignore
	var mouse_pos := get_viewport().get_mouse_position()
	if not summon_area.has_point(mouse_pos):
		return

	# Only summon if we're a valid key
	if event.is_action_pressed("summon_a"):
		var maybe_summon_a := summonable_manager.consume_summonable("a")
		if maybe_summon_a == null:
			# Play some effect?
			return
		# remove from the tree so that we don't reformat incorrectly
		maybe_summon_a.reparent(self)
		maybe_summon_a.queue_free()
		summonable_manager.reformat_summonables()

		var summon := a_summon.instantiate()
		summon.global_position = mouse_pos
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)
	elif event.is_action_pressed("summon_s"):
		var maybe_summon_s := summonable_manager.consume_summonable("s")
		if maybe_summon_s == null:
			# Play some effect?
			return
		# remove from the tree so that we don't reformat incorrectly
		maybe_summon_s.reparent(self)
		maybe_summon_s.queue_free()
		summonable_manager.reformat_summonables()

		var summon := s_summon.instantiate()
		summon.global_position = mouse_pos
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)
	elif event.is_action_pressed("summon_d"):
		var maybe_summon_d := summonable_manager.consume_summonable("d")
		if maybe_summon_d == null:
			# Play some effect?
			return
		# remove from the tree so that we don't reformat incorrectly
		maybe_summon_d.reparent(self)
		maybe_summon_d.queue_free()
		summonable_manager.reformat_summonables()
		var summon := summon_d.instantiate()
		summon.global_position = mouse_pos
		player_summons.add_child(summon)
		GlobalEvent.emit_player_summoned(summon)

