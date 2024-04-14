extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var focus_arrows: Node2D = $FocusArrows
@onready var play_button: TextureButton = $PlayButton
@onready var mute_button: TextureButton = $MuteButton
@onready var focus_arrow_swish_1: AudioStreamPlayer = $FocusArrows/FocusArrowSwish1
@onready var ui_click_player: AudioStreamPlayer = $UiClickPlayer


func _ready() -> void:
	focus_arrows.visible = false


func hide_focus_arrows() -> void:
	focus_arrows.visible = false
	animation_player.stop()


func focus_arrows_play() -> void:
	focus_arrows.visible = true
	focus_arrows.global_position = play_button.get_global_rect().get_center()
	animation_player.play("play_hover")
	focus_arrow_swish_1.play()


func focus_arrows_mute() -> void:
	focus_arrows.visible = true
	focus_arrows.global_position = mute_button.get_global_rect().get_center()
	animation_player.play("play_hover")
	focus_arrow_swish_1.play()

func _on_play_button_pressed() -> void:
	ui_click_player.play()
	# Hacky?
	await ui_click_player.finished
	get_tree().change_scene_to_file("res://tutorial/tutorial.tscn")


func _on_play_button_focus_entered() -> void:
	# Focus was being weird
	pass


func _on_play_button_mouse_entered() -> void:
	focus_arrows_play()


func _on_play_button_focus_exited() -> void:
	# Focus was being weird
	pass


func _on_play_button_mouse_exited() -> void:
	hide_focus_arrows()


func _on_mute_button_focus_entered() -> void:
	# Focus was being weird
	pass


func _on_mute_button_focus_exited() -> void:
	# Focus was being weird
	pass


func _on_mute_button_mouse_entered() -> void:
	focus_arrows_mute()


func _on_mute_button_mouse_exited() -> void:
	hide_focus_arrows()


func _on_credit_label_2_meta_clicked(meta: Variant) -> void:
	ui_click_player.play()
	OS.shell_open("https://camd67.itch.io/battle-of-the-serifs-ld55")


func _on_mute_button_pressed() -> void:
	ui_click_player.play()
	AudioServer.set_bus_mute(0, mute_button.button_pressed)
