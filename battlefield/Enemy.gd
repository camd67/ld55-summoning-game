extends Node2D

@onready var enemy_summons: Node2D = $EnemySummons
@onready var summonable_manager: SummonableManager = $"../SummonableManager"

const summon_j = preload("res://summon/summon_j.tscn")
const summon_k = preload("res://summon/summon_k.tscn")
const summon_l = preload("res://summon/summon_l.tscn")
const summon_rect = Rect2(400, 0, 400, 600)

const base_skip_chance = .5
var current_skip_chance := base_skip_chance

const summons = ["j", "k", "l"]


func _on_enemy_ai_timer_timeout() -> void:
	if randf() <= base_skip_chance:
		# Skip AI's turn! But make it less likely next time
		current_skip_chance /= 2
		print("Skipping AI due to skip chance")
		return

	# Reset our skip chances
	current_skip_chance = base_skip_chance
	var summon_type: String = summons.pick_random()

	var summonable := summonable_manager.consume_enemy_summonable(summon_type)
	if summonable == null:
		print("skipped AI due to unsumonable type: %s" % summon_type)
		return

	var location := Vector2(randf_range(400, 750), randf_range(0, 530))
	match summon_type:
		"j":
			var summon := summon_j.instantiate()
			summon.global_position = location
			enemy_summons.add_child(summon)
			print("AI summoned J")
		"k":
			var summon := summon_k.instantiate()
			summon.global_position = location
			enemy_summons.add_child(summon)
			print("AI summoned K")
		"l":
			var summon := summon_l.instantiate()
			summon.global_position = location
			enemy_summons.add_child(summon)
			print("AI summoned L")
		_:
			push_error("Enemy AI tried to summon an unknown type %s" % summon_type)
