extends Area2D

@export var owner_ghost := "Uknown"
@export_multiline var description := "A worn book. The name inside has been scratched out."

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
		GameState.carried_books.append(owner_ghost)
		DialogueBox.show_text(description)
		get_viewport().set_input_as_handled()
		queue_free()
