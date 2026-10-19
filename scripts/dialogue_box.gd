extends CanvasLayer

@onready var text_label: Label = $Panel/Margin/Text

func _ready() -> void:
	hide()

func show_text(text: String) -> void:
	text_label.text = text
	show()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("interact"):
		hide()
		get_viewport().set_input_as_handled()
