extends CharacterBody2D

@export var speed := 80.0

func _ready() -> void:
	add_to_group("player")

func _physics_process(_delta: float) -> void:
	if DialogueBox.visible:
		return
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
