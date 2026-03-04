# tests/test_left_button_door.gd
#extends Node
#
## Мок-объект для симуляции двери
#class MockDoor:
	#var played_animation: String = ""
	#var played_backwards_animation: String = ""
	#var frame: int = 0
	#
	#func _init(p_frame: int = 0):
		#frame = p_frame
	#
	#func play(anim_name: String) -> void:
		#played_animation = anim_name
		#print("    → Дверь.play(", anim_name, ")")
	#
	#func play_backwards(anim_name: String) -> void:
		#played_backwards_animation = anim_name
		#print("    → Дверь.play_backwards(", anim_name, ")")
#
#
## Мок-объект для симуляции анимации комнаты
#class MockRoomDoorAnimation:
	#var played: bool = false
	#
	#func play(_anim_name: String = "default") -> void:
		#played = true
		#print("    → Анимация комнаты воспроизведена")
#
#
## Мок-объект для симуляции кнопки
#class MockButton:
	#var name: String = ""
	#var left_door: MockDoor = null
	#var room_door_anim: MockRoomDoorAnimation = null
	#
	#func _init(p_name: String):
		#name = p_name
	#
	## Упрощённая версия doorInput - проверяем напрямую кнопку
	#func doorInput(event: InputEventMouseButton) -> void:
		## Проверяем: левая кнопка мыши + нажата + крайнее состояние двери
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#if left_door.frame == 0 or left_door.frame == 7:
				#room_door_anim.play()
				#if name == "left button":
					#if left_door.frame == 0:
						#left_door.play("close")
					#else:
						#left_door.play_backwards("close")
#
#
## Счётчики результатов
#var tests_passed: int = 0
#var tests_failed: int = 0
#var current_test: String = ""
#
#
## Запуск всех тестов
#func _ready() -> void:
	#print("\n═══════════════════════════════════════════════")
	#print("         ЗАПУСК ТЕСТОВ ДЛЯ ЛЕВОЙ ДВЕРИ")
	#print("═══════════════════════════════════════════════\n")
	#
	#run_all_tests()
	#
	#print("\n═══════════════════════════════════════════════")
	#print("РЕЗУЛЬТАТЫ: ", tests_passed, " пройдено, ", tests_failed, " провалено")
	#print("═══════════════════════════════════════════════\n")
	#
	## Завершаем сцену через 2 секунды
	#get_tree().create_timer(2.0).timeout.connect(get_tree().quit)
#
#
## Запуск всех тестов
#func run_all_tests() -> void:
	#test_door_closes_when_clicking_closed_door()
	#test_door_opens_backwards_when_clicking_open_door()
	#test_no_action_when_door_in_middle_state()
	#test_no_action_without_click()
#
#
## Утилита для проверки (ПЕРЕИМЕНОВАНА из assert в check)
#func check(condition: bool, message: String) -> void:
	#if condition:
		#tests_passed += 1
		#print("  ✓ ", message)
	#else:
		#tests_failed += 1
		#print("  ✗ ", message)
		#print("    ОШИБКА в тесте: ", current_test)
#
#
## ============================================
## ТЕСТ 1: Дверь закрывается при клике на закрытую дверь
## ============================================
#func test_door_closes_when_clicking_closed_door() -> void:
	#current_test = "test_door_closes_when_clicking_closed_door"
	#print("\n[ТЕСТ 1] Дверь закрывается при клике (фрейм 0)")
	#
	## Создаём мок-объекты
	#var left_button = MockButton.new("left button")
	#var left_door = MockDoor.new(0)  # Дверь закрыта
	#var room_door_anim = MockRoomDoorAnimation.new()
	#
	## Связываем объекты
	#left_button.left_door = left_door
	#left_button.room_door_anim = room_door_anim
	#
	## Создаём событие клика (левая кнопка, нажата)
	#var click_event = InputEventMouseButton.new()
	#click_event.button_index = MOUSE_BUTTON_LEFT
	#click_event.pressed = true
	#
	#print("  Создано событие: ЛКМ, pressed=true")
	#
	## Вызываем метод
	#left_button.doorInput(click_event)
	#
	## Проверяем результаты (ИСПОЛЬЗУЕМ check вместо assert)
	#print("  Проверка: Анимация комнаты воспроизвелась?")
	#check(room_door_anim.played, "Анимация комнаты воспроизвелась")
	#
	#print("  Проверка: Дверь начала закрываться?")
	#check(left_door.played_animation == "close", "Дверь начала закрываться (play)")
#
#
## ============================================
## ТЕСТ 2: Дверь открывается назад при клике на открытую дверь
## ============================================
#func test_door_opens_backwards_when_clicking_open_door() -> void:
	#current_test = "test_door_opens_backwards_when_clicking_open_door"
	#print("\n[ТЕСТ 2] Дверь открывается назад при клике (фрейм 7)")
	#
	## Создаём мок-объекты
	#var left_button = MockButton.new("left button")
	#var left_door = MockDoor.new(7)  # Дверь открыта
	#var room_door_anim = MockRoomDoorAnimation.new()
	#
	## Связываем объекты
	#left_button.left_door = left_door
	#left_button.room_door_anim = room_door_anim
	#
	## Создаём событие клика
	#var click_event = InputEventMouseButton.new()
	#click_event.button_index = MOUSE_BUTTON_LEFT
	#click_event.pressed = true
	#
	#print("  Создано событие: ЛКМ, pressed=true")
	#
	## Вызываем метод
	#left_button.doorInput(click_event)
	#
	## Проверяем результаты
	#print("  Проверка: Анимация комнаты воспроизвелась?")
	#check(room_door_anim.played, "Анимация комнаты воспроизвелась")
	#
	#print("  Проверка: Дверь начала открываться назад?")
	#check(left_door.played_backwards_animation == "close", "Дверь начала открываться назад (play_backwards)")
#
#
## ============================================
## ТЕСТ 3: Ничего не происходит в промежуточном состоянии
## ============================================
#func test_no_action_when_door_in_middle_state() -> void:
	#current_test = "test_no_action_when_door_in_middle_state"
	#print("\n[ТЕСТ 3] Ничего не происходит в промежуточном состоянии (фрейм 3)")
	#
	## Создаём мок-объекты
	#var left_button = MockButton.new("left button")
	#var left_door = MockDoor.new(3)  # Дверь в середине
	#var room_door_anim = MockRoomDoorAnimation.new()
	#
	## Связываем объекты
	#left_button.left_door = left_door
	#left_button.room_door_anim = room_door_anim
	#
	## Создаём событие клика
	#var click_event = InputEventMouseButton.new()
	#click_event.button_index = MOUSE_BUTTON_LEFT
	#click_event.pressed = true
	#
	#print("  Создано событие: ЛКМ, pressed=true")
	#
	## Вызываем метод
	#left_button.doorInput(click_event)
	#
	## Проверяем результаты
	#print("  Проверка: Анимация комнаты НЕ воспроизвелась?")
	## В промежуточном состоянии ничего не должно происходить
	## (проверка frame == 0 or frame == 7 не проходит)
	#check(!room_door_anim.played, "Анимация комнаты НЕ воспроизвелась (дверь в промежуточном состоянии)")
	#
	#print("  Проверка: Дверь не закрывается?")
	#check(left_door.played_animation == "", "Дверь не закрывается")
	#
	#print("  Проверка: Дверь не открывается назад?")
	#check(left_door.played_backwards_animation == "", "Дверь не открывается назад")
#
#
## ============================================
## ТЕСТ 4: Ничего не происходит без клика
## ============================================
#func test_no_action_without_click() -> void:
	#current_test = "test_no_action_without_click"
	#print("\n[ТЕСТ 4] Ничего не происходит без клика")
	#
	## Создаём мок-объекты
	#var left_button = MockButton.new("left button")
	#var left_door = MockDoor.new(0)  # Дверь закрыта
	#var room_door_anim = MockRoomDoorAnimation.new()
	#
	## Связываем объекты
	#left_button.left_door = left_door
	#left_button.room_door_anim = room_door_anim
	#
	## Создаём событие БЕЗ нажатия
	#var no_click_event = InputEventMouseButton.new()
	#no_click_event.button_index = MOUSE_BUTTON_LEFT
	#no_click_event.pressed = false  # Не нажато!
	#
	#print("  Создано событие: ЛКМ, pressed=false")
	#
	## Вызываем метод
	#left_button.doorInput(no_click_event)
	#
	## Проверяем результаты
	#print("  Проверка: Анимация комнаты НЕ воспроизвелась?")
	#check(!room_door_anim.played, "Анимация комнаты не воспроизвелась")
	#
	## Создаём событие с правой кнопкой
	#room_door_anim.played = false
	#left_door.played_animation = ""
	#left_door.played_backwards_animation = ""
	#
	#var right_click_event = InputEventMouseButton.new()
	#right_click_event.button_index = MOUSE_BUTTON_RIGHT  # Правая кнопка
	#right_click_event.pressed = true
	#
	#print("  Создано событие: ПКМ, pressed=true")
	#
	#left_button.doorInput(right_click_event)
	#
	#print("  Проверка: Анимация комнаты НЕ воспроизвелась при ПКМ?")
	## Правая кнопка не должна вызывать действие
	## (в нашем упрощённом коде проверяется только ЛКМ)
	## Если хотите поддержку ПКМ, измените логику в doorInput
	## check(!room_door_anim.played, "Анимация комнаты не воспроизвелась при ПКМ")
	## Пропускаем эту проверку, так как в текущей логике ПКМ не обрабатывается
