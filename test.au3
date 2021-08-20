#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ship-icon.ico
#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_Res_Description=Dev by ThienPhong
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductName=Auto ModernWarship
#AutoIt3Wrapper_Res_CompanyName=ThienPhong
#AutoIt3Wrapper_Res_Language=1066
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <FastFind.au3>
#include <Date.au3>

#Region ### START Koda GUI section ### Form=
$Form_1 = GUICreate("Auto MW", 316, 261, 383, 193, -1, BitOR($WS_EX_TRANSPARENT,$WS_EX_WINDOWEDGE))
GUISetFont(5, 400, 0, "MS Sans Serif")
$Button_auToFire = GUICtrlCreateButton("Auto Fire", 152, 8, 155, 25, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0xFF0000)
$Button_autoALL = GUICtrlCreateButton("Auto ALL", 152, 40, 155, 25, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0xFF0000)
$Label_run = GUICtrlCreateLabel("Ðã chạy 0 lần trong vòng 0s", 10, 207, 295, 21, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
GUICtrlSetColor(-1, 0xFF0000)
$Label_noxName = GUICtrlCreateLabel("Nox name:", 16, 8, 71, 21, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Input_noxName = GUICtrlCreateInput("NW1", 88, 8, 57, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label_loop = GUICtrlCreateLabel("Loop:", 16, 40, 39, 21, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Input_soLan = GUICtrlCreateInput("∞", 88, 40, 57, 28, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_UPPERCASE))
GUICtrlSetFont(-1, 13, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x000000)
$Pic1 = GUICtrlCreatePic("D:\AutoIT\Modern Warship\1.bmp", 24, 96, 272, 36)
$Label_before = GUICtrlCreateLabel("BEFORE", 136, 72, 55, 21, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Pic2 = GUICtrlCreatePic("D:\AutoIT\Modern Warship\2.bmp", 24, 160, 272, 36)
$Label_after = GUICtrlCreateLabel("AFTER", 136, 136, 55, 21, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Label_trungbinh = GUICtrlCreateLabel("Trung bình 0p", 10, 231, 295, 21, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
GUICtrlSetColor(-1, 0xFF0000)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


HotKeySet("{F1}","_exit")
;~ Global $hwnd = WinGetHandle(GUICtrlRead($Input_noxName))
Global $hwnd = WinGetHandle("MW_Type100")
Global $hour, $minute, $second,$timer
FFSetWnd($hwnd)
Opt("MouseClickDelay",1)
Opt("MouseClickDownDelay",1)
$chup_landau = False

Func _exit()
	Exit
EndFunc

Func close_qcbanhang()
	Local $qc_Banhang = FFColorCount(0x004E8B,10,True,507, 41,526, 63);106
	if $qc_Banhang>100 Then
		ControlClick($hwnd,'','','left',1,517, 52) ;X tắt quảng cáo bán hàng
		Sleep(500)
	EndIf
EndFunc

Func nhan_30vang()
	Local $received = False
	Local $qc_30vang = FFColorCount(0xCDB856,10,True,474, 218,495, 236);15 (+30)
	Local $command = 'nox_adb shell input keyevent 4'
	while 1
		if $qc_30vang>10 Then
			ControlClick($hwnd,'','','left',1,500, 227) ;nhấn vào +30 vàng
			Sleep(3000)
			Local $qc_30vang = FFColorCount(0xCDB856,10,True,474, 218,495, 236);15 (+30)
			If $qc_30vang>10 Then
				ConsoleWrite("-Get gold error")
				ExitLoop
			EndIf
			Sleep(30000)
			Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
			While Not $received
				Local $received_gold = FFColorCount(0xF9F195,10,True,242, 178,268, 209);31
				if $received_gold >25 Then
					ControlClick($hwnd,'','','left',1,275, 266)
					$received = True
					ExitLoop
				EndIf
				Sleep(100)
			WEnd
		Else
			ExitLoop
		EndIf
	WEnd
EndFunc

Func raTran()
	Local $vaotran = False
	Local $nhanvang = False
	while Not $vaotran
		Local $ratran = FFColorCount(0x8A1F00,10,True,305, 289,327, 312);342
		Local $trochoingoaituyen = FFColorCount(0xFFFFFF,0,True,213, 76,234, 114);539
		Local $chonmap = FFColorCount(0xFFFFFF,0,True,406, 187,432, 222);76
		Local $mapbaotap = FFColorCount(0x101821,10,True,258, 198,290, 217);320
		close_qcbanhang()
		If $ratran >340 Then
			;~ ConsoleWrite("RT")
			if $nhanvang = False Then
				nhan_30vang()
				$nhanvang = True
			EndIf
			If $chup_landau = False Then
				Sleep(100)
				FileDelete ( "1.bmp" )
				FFSaveBMP("1", True, 381, 39, 513, 61, $FFLastSnap, $hwnd)
				GUICtrlSetImage($Pic1,"1.bmp")
				$chup_landau = True
			EndIf
			Sleep(100)
			FileDelete ( "2.bmp" )
			FFSaveBMP("2", True, 381, 39, 513, 61, $FFLastSnap, $hwnd)
			GUICtrlSetImage($Pic2,"2.bmp")
			Sleep(200)
			ControlClick($hwnd,'','','left',1,345, 301)
		EndIf
		If $trochoingoaituyen >530 Then
			;~ ConsoleWrite("Tcnt")
			ControlClick($hwnd,'','','left',2,281, 207)
		EndIf
		If $chonmap >70 Then
			;~ ConsoleWrite("cm")
			Local $chonmap = False
			while Not $chonmap
				if ($mapbaotap>300) Then
					ControlClick($hwnd,'','','left',1,328, 320)
					$chonmap = True
					$vaotran = True
				Else
					ControlClick($hwnd,'','','left',1,418, 206)
					Sleep(300)
					Local $mapbaotap = FFColorCount(0x101821,10,True,258, 198,290, 217);320
				EndIf	
			WEnd
		EndIf
	WEnd
EndFunc

Func find_and_kill()
	$fight_end = False
	$command1 = 'nox_adb shell input swipe 300 300 750 300 4000'
	while $fight_end = False
		Run(@ComSpec & " /c " & $command1,"",@SW_HIDE)
		$timer1 = TimerInit()
		Do	
			Local $ten = FFColorCount(0xFFFFFF,100,True,207, 137,348, 156)
			Local $mau = FFColorCount(0xFF0000,0,True,208, 156,353, 178)
			Local $end = FFColorCount(0x081821,0,True,232, 276,322, 300)
			if $end >15 Then
				Sleep(200)
				ConsoleWrite("-End Battle"&@LF)
				ControlClick($hwnd,'','','left',2,280, 279)
				$fight_end = True
				ExitLoop
			EndIf
			if $ten > 10 and $mau > 15 Then
				ControlClick($hwnd,'','','left',4,428, 272) ;ten lua 2
				Sleep(200)
				Local $ten = FFColorCount(0xFFFFFF,100,True,239, 138,318, 152)
				Local $mau = FFColorCount(0xFF0000,0,True,241, 157,314, 167)
				if $ten > 15 and $mau > 35 Then
					Do
						ControlClick($hwnd,'','','left',4,446, 234)
						ControlClick($hwnd,'','','left',4,428, 272)
						ControlClick($hwnd,'','','left',4,445, 314)
						ControlClick($hwnd,'','','left',4,501, 314)
						ControlClick($hwnd,'','','left',4,520, 273)
						ControlClick($hwnd,'','','left',4,499, 236)
						Local $ten = FFColorCount(0xFFFFFF,100,True,239, 138,318, 152)
						Local $mau = FFColorCount(0xFF0000,0,True,241, 157,314, 167)
						Sleep(700)
					Until ($ten<15) or ($mau<35)
				Else
					$time1=45001
				EndIf
			EndIf
			Sleep(10)
			$time1 = Int(TimerDiff($timer1))
		Until ($time1>4500)
	WEnd
EndFunc

Func auto()
    $soLan = GUICtrlRead($Input_soLan)
    if $soLan = '∞' Then
        $soLan = 9999999
    EndIf
    for $i=1 to $soLan
		$vaotran = False
		raTran()
		while Not $vaotran
			Local $mauxanh = FFColorCount(0x00FF90,0,True,462, 182,497, 193)
			if $mauxanh >50 Then
				$vaotran = True
			EndIf
			Sleep(200)
		WEnd
		ControlClick($hwnd,'','','left',4,93, 236) ;tiến lên
		Sleep(1000)
		$Command = 'nox_adb shell input swipe 250 400 250 400 9000' ;nhấn sang phải
		Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
		Sleep(11000)
		$Command = 'nox_adb shell input swipe 300 300 300 265' ;chinh cam cao len
		Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
		Sleep(10000)
		ControlClick($hwnd,'','','left',2,96, 291) ;tiến lên
		find_and_kill()
		$playTime = Int(TimerDiff($timer))
		_TicksToTime($playTime, $hour, $minute, $second)
		if $hour>0 Then
			$Time = StringFormat("%ih%im%is", $hour, $minute, $second)
		ElseIf $minute>0 Then
			$Time = StringFormat("%im%is", $minute, $second)
		Else
			$Time = StringFormat("%is", $second)
		EndIf
		$a = 3456731 / 13 / 60000
		$b = Mod((3456731 / 13),1)*60
		$TB = StringFormat("%im%is",$playTime/60000/$i,Mod($playTime/60000/$i,1)*60)
		GUICtrlSetData($Label_run,"Đã chạy "&$i&" lần trong "&$Time)
		GUICtrlSetData($Label_trungbinh,"Trung bình "&$TB)
		Sleep(1000)
	Next
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
        Case $Button_auToFire
            find_and_kill()
        Case $Button_autoALL
            $timer = TimerInit()
            auto()
	EndSwitch
WEnd




;~ Local $a = FFColorCount(0x081821,0,True,410, 472,553, 501)
;~ ConsoleWrite($a  &@LF)

