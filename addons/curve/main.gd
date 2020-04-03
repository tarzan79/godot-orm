tool
extends EditorPlugin

func _enter_tree() -> void:
    add_custom_type("Curve", "Path2D", preload("curve.gd"), preload("./curve.svg"))
    
func _exit_tree() -> void:
    remove_custom_type("Grid")
