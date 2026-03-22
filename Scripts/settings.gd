extends Sprite2D

# Путь к файлу настроек
const SETTINGS_PATH = "res://settings/settings.cfg"

# Ссылки на элементы управления
var volume_slider = null
var mute_checkbox = null
var display_option = null


func _ready() -> void:
	print("\n=== НАЧАЛО ЗАГРУЗКИ НАСТРОЕК ===")
	
	# Показываем путь к текущему узлу
	# (закомментировано для чистоты вывода)
	# print("Текущий узел: ", get_path())
	
	# Находим узлы
	_find_ui_nodes()
	
	# Загружаем настройки
	_load_settings()
	
	print("=== ЗАГРУЗКА НАСТРОЕК ЗАВЕРШЕНА ===\n")


# Найти UI узлы в дереве сцены
func _find_ui_nodes() -> void:
	# Поиск всех узлов в сцене
	_find_by_class("HSlider", "HSlider")
	_find_by_class("CheckBox", "CheckBox")
	_find_by_class("OptionButton", "OptionButton")
	
	# Проверяем результаты
	if !volume_slider:
		print("❌ HSlider не найден!")
	else:
		print("✓ HSlider найден")
	
	if !mute_checkbox:
		print("❌ CheckBox не найден!")
	else:
		print("✓ CheckBox найден")
	
	if !display_option:
		print("❌ OptionButton не найден!")
	else:
		print("✓ OptionButton найден")


# Найти узел по классу
func _find_by_class(target_class: String, var_name: String) -> void:
	var nodes = get_tree().get_nodes_in_group("_" + target_class)
	if nodes.size() > 0:
		match var_name:
			"HSlider":
				volume_slider = nodes[0]
			"CheckBox":
				mute_checkbox = nodes[0]
			"OptionButton":
				display_option = nodes[0]
		return
	
	# Если не нашли по группе, ищем рекурсивно
	_recursive_find_by_class(self, target_class, var_name)


# Рекурсивный поиск по классу
func _recursive_find_by_class(node: Node, target_class: String, var_name: String) -> void:
	if node.get_class() == target_class:
		match var_name:
			"HSlider":
				volume_slider = node as HSlider
			"CheckBox":
				mute_checkbox = node as CheckBox
			"OptionButton":
				display_option = node as OptionButton
	
	for child in node.get_children():
		_recursive_find_by_class(child, target_class, var_name)


func _on_h_slider_value_changed(value: float) -> void:
	# Устанавливаем громкость
	AudioServer.set_bus_volume_db(0, value)
	
	# Сохраняем настройку
	_save_setting("volume", value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	# Выключаем/включаем звук
	AudioServer.set_bus_mute(0, toggled_on)
	
	# Сохраняем настройку
	_save_setting("mute", toggled_on)


func _on_option_button_item_selected(index: int) -> void:
	# Проверяем, не в редакторе ли мы
	if Engine.is_editor_hint():
		print("⚠️ Полноэкранный режим недоступен в редакторе")
		# Всё равно сохраняем выбор, чтобы применить при следующем запуске
		_save_setting("display_mode", index)
		return
	
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			print("✓ Режим: Полноэкранный")
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			print("✓ Режим: Оконный")
	
	# Сохраняем настройку
	_save_setting("display_mode", index)


# Загрузить настройки из файла
func _load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_PATH)
	
	if err == OK:
		print("✓ Файл настроек найден")
		
		# Загружаем громкость
		if config.has_section_key("audio", "volume") and volume_slider:
			var volume = config.get_value("audio", "volume")
			volume_slider.value = volume
			AudioServer.set_bus_volume_db(0, volume)
			print("  ✓ Громкость: ", volume, " дБ")
		
		# Загружаем состояние выключения звука
		if config.has_section_key("audio", "mute") and mute_checkbox:
			var mute = config.get_value("audio", "mute")
			mute_checkbox.button_pressed = mute
			AudioServer.set_bus_mute(0, mute)
			print("  ✓ Звук: ", "выключен" if mute else "включён")
		
		# Загружаем режим отображения
		_load_display_mode()
		
		print("✓ Настройки загружены из ", SETTINGS_PATH)
	else:
		print("ℹ️ Файл настроек не найден, создаём новый")
		# Сохраняем настройки по умолчанию
		_save_default_settings()


# Загрузить режим отображения (ИСПРАВЛЕНО)
func _load_display_mode() -> void:
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_PATH)
	
	if err == OK and config.has_section_key("display", "mode"):
		var mode = config.get_value("display", "mode")
		
		# Устанавливаем значение в OptionButton
		if display_option:
			display_option.selected = mode
			print("  ✓ Режим экрана в UI: ", "Полноэкранный" if mode == 0 else "Оконный")
		
		# Применяем режим (только вне редактора)
		if !Engine.is_editor_hint():
			match mode:
				0:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
					print("  ✓ Режим экрана применён: Полноэкранный")
				1:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					print("  ✓ Режим экрана применён: Оконный")
		else:
			print("  ℹ️ Режим экрана не применён (режим редактора)")
			# Но значение в UI установлено, чтобы игрок видел свой выбор
			# При следующем запуске вне редактора режим применится
	else:
		print("  ℹ️ Режим экрана не найден в настройках")


# Сохранить настройку
func _save_setting(section_key: String, value: Variant) -> void:
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_PATH)
	
	if err != OK:
		# Файл не существует, создаём новый
		config = ConfigFile.new()
	
	# Определяем секцию в зависимости от ключа
	var section: String
	match section_key:
		"volume", "mute":
			section = "audio"
		"display_mode":
			section = "display"
		_:
			section = "settings"
	
	# Сохраняем значение
	config.set_value(section, section_key, value)
	
	# Сохраняем файл
	err = config.save(SETTINGS_PATH)
	
	if err == OK:
		print("✓ Настройка сохранена: ", section_key, " = ", value)
	else:
		print("❌ Ошибка сохранения настройки: ", err)


# Сохранить настройки по умолчанию
func _save_default_settings() -> void:
	var config = ConfigFile.new()
	
	# Аудио настройки
	if volume_slider:
		config.set_value("audio", "volume", volume_slider.value)
	if mute_checkbox:
		config.set_value("audio", "mute", mute_checkbox.button_pressed)
	
	# Настройки отображения (по умолчанию оконный режим)
	config.set_value("display", "mode", 1)  # 1 = оконный режим
	
	# Сохраняем файл
	var err = config.save(SETTINGS_PATH)
	
	if err == OK:
		print("✓ Настройки по умолчанию сохранены")
		
		# Применяем значение в UI
		if display_option:
			display_option.selected = 1
	else:
		print("❌ Ошибка сохранения настроек: ", err)


# Сбросить настройки к значениям по умолчанию
func reset_to_defaults() -> void:
	# Сбрасываем значения
	if volume_slider:
		volume_slider.value = 0.0
		AudioServer.set_bus_volume_db(0, 0.0)
	
	if mute_checkbox:
		mute_checkbox.button_pressed = false
		AudioServer.set_bus_mute(0, false)
	
	# Сбрасываем режим экрана
	if display_option:
		display_option.selected = 1  # Оконный режим по умолчанию
	
	# Применяем режим окна (только вне редактора)
	if !Engine.is_editor_hint():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	# Сохраняем
	_save_default_settings()
	print("✓ Настройки сброшены к значениям по умолчанию")
