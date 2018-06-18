extends "res://interface/top_level_ui.gd"

func _ready():
	$AnimationPlayer.play("intro")

func _input(event):
	if event.is_action_pressed("ui_skip"):
		if $AnimationPlayer.current_animation == "intro":
			$AnimationPlayer.play("wait")
		elif $AnimationPlayer.current_animation == "wait":
			$AnimationPlayer.play("go_away")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "intro":
		$AnimationPlayer.play("wait")
	if anim_name == "wait":
		$AnimationPlayer.play("go_away")
