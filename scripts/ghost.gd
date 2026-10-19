extends Area2D

@export var ghost_name := "Unknown"
@export_multiline var request_line := "Have you seen my book? I can't remember how it ends."
@export_multiline var thanks_line := "That's it... thank you. I can rest now."

var player_nearby := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false

func _unhandled_input(event: InputEvent) -> void:
	if player_nearby and not DialogueBox.visible and event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		if ghost_name in GameState.carried_books:
			GameState.carried_books.erase(ghost_name)
			GameState.returned_books.append(ghost_name)
			DialogueBox.show_text(thanks_line)
			_fade_away()
		else:
			DialogueBox.show_text(request_line)

func _fade_away() -> void:
	set_process_unhandled_input(false)
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 2.0)
	tween.tween_callback(queue_free)
