extends StaticBody

func interact():
	Singleton.reset_all()
	get_tree().reload_current_scene()
	$"../../CanvasLayer".visible = false
