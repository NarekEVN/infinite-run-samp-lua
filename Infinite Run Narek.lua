script_name("Infinite Run")
script_description("Infinite run with key activation")
script_author("Narek")

require "lib.moonloader"
require "vkeys"
local mem = require "memory"
function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand("runinfo", runinfo)
	running = false
	while true do -- бесконечный цикл
		wait(0) -- задержка, хоть нулевая
		if isKeyDown (0x31) and not sampIsChatInputActive() and not isCharInAnyCar(PLAYER_PED) and not sampIsDialogActive() then -- если клавиша '1' нажата и чат закрыт
			sampAddChatMessage("{2D9A0A}Бесконечный бег {71FAB1}от Нарека {2D9A0A}включен",0xAA2D9A0A)--добавить сообщение о включении скрипта
			--sampAddChatMessage("{4377C8}[!] {FFFFFF}Не забывайте отключить перед ездой и перед открытия чата!",0xAAFFFFFF) -- добавить предупреждение 
			mem.setint8(0xB7CEE4, 1) --включить бесконечный бег
			mem.setint8(0x96916E, 1) -- включить бесконечный кислород
			running = true
			while (not isKeyDown (0x32)) and (not isCharInAnyCar(PLAYER_PED)) and (not sampIsChatInputActive()) and (not sampIsDialogActive()) do
				setVirtualKeyDown(0x20,true)
				wait(0)
				setVirtualKeyDown(0x20,false)
				wait(0)
			end
			while isKeyDown (0x31) do wait(5) end -- и ждём, пока клавиша не будет отпущена
		elseif isKeyDown (0x32) and not sampIsChatInputActive() and running then --если клавиша '2' нажата и чат закрыт
			mem.setint8(0xB7CEE4, 0) -- отключить бесконечный бег
			mem.setint8(0x96916E, 0) -- отключить бесконечный кослород
			running = false
			setVirtualKeyDown (0x20,false)
			sampAddChatMessage("{FD5333}Бесконченый бег {EC5F3D}от Нарека {FD5333}отключен",0xAAFD5333)-- выводть сообщение об отключении скрипта
			while isKeyDown (0x32) do wait(5) end -- и ждём, пока клавиша не будет отпущена
		end -- конец условии
	end --конец бесконечного цикла
end -- конец функции main

function runinfo() -- фунцкия диалогового окна
	sampShowDialog(1,"Информация","Скрипт бесконечный бег. Для активации нажмите клавишу 1(не NumPad). \nДля деактивации нажмите клавишу 2. \nВнимание! Скрипт будет автоматический отключен, если Вы откроете чат или сядете в любой Т/С \nПриятной игры! \n\n\nСоздатель скрипта: Нарек","ОК",DIALOG_STYLE_MSGBOX)
end