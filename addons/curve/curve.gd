extends Path2D

export (Color) var pathColour = Color.yellow setget set_color
export (float) var width = 1.0 setget set_width
export (NodePath) var path_start setget set_start
export (NodePath) var path_end setget set_end
export var _in = Vector2(0, 0)
export var _out = Vector2(0, 0)
var start:Vector2
var end:Vector2
var node_start
var node_end

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
    path_start = value

    if get_node(path_start):
        node_start = get_node(path_start)
        start = node_start.position
        curve.add_point(start)
    
func set_end(value):
    path_end = value
    if get_node(path_start):
        node_end = get_node(path_end)
        end = node_end.position
        curve.add_point(end, _in, _out)
    
  
func _process(delta):
    set_start(path_start)
    set_end(path_end)
    if node_start && start != node_start.position:
        start = node_start.position
    if node_end && end != node_end.position:
        end = node_end.position
    update()
    
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
