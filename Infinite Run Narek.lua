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
	while true do -- ����������� ����
		wait(0) -- ��������, ���� �������
		if isKeyDown (0x31) and not sampIsChatInputActive() and not isCharInAnyCar(PLAYER_PED) and not sampIsDialogActive() then -- ���� ������� '1' ������ � ��� ������
			sampAddChatMessage("{2D9A0A}����������� ��� {71FAB1}�� ������ {2D9A0A}�������",0xAA2D9A0A)--�������� ��������� � ��������� �������
			--sampAddChatMessage("{4377C8}[!] {FFFFFF}�� ��������� ��������� ����� ����� � ����� �������� ����!",0xAAFFFFFF) -- �������� �������������� 
			mem.setint8(0xB7CEE4, 1) --�������� ����������� ���
			mem.setint8(0x96916E, 1) -- �������� ����������� ��������
			running = true
			while (not isKeyDown (0x32)) and (not isCharInAnyCar(PLAYER_PED)) and (not sampIsChatInputActive()) and (not sampIsDialogActive()) do
				setVirtualKeyDown(0x20,true)
				wait(0)
				setVirtualKeyDown(0x20,false)
				wait(0)
			end
			while isKeyDown (0x31) do wait(5) end -- � ���, ���� ������� �� ����� ��������
		elseif isKeyDown (0x32) and not sampIsChatInputActive() and running then --���� ������� '2' ������ � ��� ������
			mem.setint8(0xB7CEE4, 0) -- ��������� ����������� ���
			mem.setint8(0x96916E, 0) -- ��������� ����������� ��������
			running = false
			setVirtualKeyDown (0x20,false)
			sampAddChatMessage("{FD5333}����������� ��� {EC5F3D}�� ������ {FD5333}��������",0xAAFD5333)-- ������� ��������� �� ���������� �������
			while isKeyDown (0x32) do wait(5) end -- � ���, ���� ������� �� ����� ��������
		end -- ����� �������
	end --����� ������������ �����
end -- ����� ������� main

function runinfo() -- ������� ����������� ����
	sampShowDialog(1,"����������","������ ����������� ���. ��� ��������� ������� ������� 1(�� NumPad). \n��� ����������� ������� ������� 2. \n��������! ������ ����� �������������� ��������, ���� �� �������� ��� ��� ������ � ����� �/� \n�������� ����! \n\n\n��������� �������: �����","��",DIALOG_STYLE_MSGBOX)
end