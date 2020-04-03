tool
extends Path2D

export (Color) var pathColour = Color.red setget set_color
export (float) var width = 1.0 setget set_width
export var _in = Vector2(0, 0)
export var _out = Vector2(0, 0)
var node_start setget set_start
var node_end setget set_end
var start:Vector2
var end:Vector2
var node_start_buff
var node_end_buff

func _enter_tree():
    curve.clear_points()

func _draw():
    if curve.get_point_count() > 1:
        draw_polyline(curve.get_baked_points(), pathColour, width)

func set_color(value):
    pathColour = value
    update()

func set_width(value):
    width = value
    update()

func set_start(value):
    curve.clear_points()
    if value != null:
        node_start = value#.get_node("Position2D")
        start = node_start.position
        node_start_buff = node_start.global_position
        curve.add_point(start)

func set_end(value):
    if value != null:
        node_end = value#.get_node("Position2D")
        end = node_end.global_position - node_start.global_position + node_end.position
        node_end_buff = node_end.global_position
        curve.add_point(end, _in, _out)
    
func _process(delta):
    if node_end_buff != node_end.global_position || node_start_buff != node_start.global_position:
        set_start(node_start)
        set_end(node_end)
    if curve.get_point_count() > 1:
        if start.x < end.x:
            _in.x = -(int(end.x) - int(start.x))
    #        _in.y = (int(end.y) - int(start.y))
            curve.set_point_in(1, _in)
    #        curve.set_point_out(1, _out)
        elif start.x > end.x:
            _in.x = (int(start.x) - int(end.x))
    #        _in.y = (int(end.y) - int(start.y))
            curve.set_point_in(1, _in)
        if start.y < end.y:
            _in.y = -(int(end.y) - int(start.y)) * 2 - 250 + (int(end.y) - int(start.y))
    #        _in.y = -150
            curve.set_point_in(1, _in)
        elif start.y > end.y:
    #        _in.x = -(int(end.x) - int(start.x)) / 2
            _in.y = -250
            curve.set_point_in(1, _in)
    update()
