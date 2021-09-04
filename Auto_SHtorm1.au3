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
#include <GuiListBox.au3>

$Form_1 = GUICreate("Auto MW", 605, 294, 218, 602, -1, BitOR($WS_EX_TRANSPARENT,$WS_EX_WINDOWEDGE))
GUISetFont(5, 400, 0, "MS Sans Serif")
$Button_auToFire = GUICtrlCreateButton("Auto Fire", 16, 40, 131, 33, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0xFF0000)
$Button_autoALL = GUICtrlCreateButton("Auto ALL", 160, 40, 139, 33, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0xFF0000)
$Label_run = GUICtrlCreateLabel("Ðã chạy 0 lần trong vòng 0s", 18, 231, 279, 21, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
GUICtrlSetColor(-1, 0xFF0000)
$Label_noxName = GUICtrlCreateLabel("Nox name:", 16, 8, 71, 21, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Input_noxName = GUICtrlCreateInput("MW1", 88, 8, 57, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Label_loop = GUICtrlCreateLabel("Loop:", 160, 8, 39, 21, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Input_soLan = GUICtrlCreateInput("∞", 216, 8, 81, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_UPPERCASE))
GUICtrlSetFont(-1, 13, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x000000)
$Pic1 = GUICtrlCreatePic("1.bmp", 24, 112, 272, 36)
$Label_before = GUICtrlCreateLabel("BEFORE", 136, 88, 55, 21, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Pic2 = GUICtrlCreatePic("2.bmp", 24, 176, 272, 36)
$Label_after = GUICtrlCreateLabel("AFTER", 136, 152, 55, 21, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 800, 0, "Nirmala UI")
GUICtrlSetColor(-1, 0x000000)
$Label_trungbinh = GUICtrlCreateLabel("Trung bình 0p", 18, 255, 287, 21, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
GUICtrlSetColor(-1, 0xFF0000)
$List = GUICtrlCreateList("", 312, 8, 273, 266)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;~ Global $hwnd = WinGetHandle("MW1")
Global $idNox = " -s 127.0.0.1:59889 "
Global $hwnd = WinGetHandle(GUICtrlRead($Input_noxName))
Global $hour, $minute, $second,$timer,$ten_minute_start
Global $chup_landau = False
Global $shiptype[6]
Global $list_id=0
FFSetWnd($hwnd)
HotKeySet("{F1}","_exit")
Opt("MouseClickDelay",1)
Opt("MouseClickDownDelay",1)


Func _exit()
	Exit
EndFunc

Func writeLog($list_name,$msg)
    GUICtrlSetData($list_name, _NowTime()&": "&$msg)
	_GUICtrlListBox_SetSel($list_name, $list_id-1)
	_GUICtrlListBox_SetSel($list_name, $list_id-1)
    $list_id = $list_id +1
EndFunc

Func get30Gold()
	Local $click_ok = False
	Local $add_30gold = FFColorCount(0xCDB856,10,True,832, 361,868, 382);>40
	Local $command = 'nox_adb '&$idNox&' shell input keyevent 4'
	while 1
		if $add_30gold>40 Then
			writeLog($List,"Click +30 gold")
			ControlClick($hwnd,'','','left',1,877, 367) ;nhấn vào +30 vàng
			Sleep(3000)
			Local $add_30gold = FFColorCount(0xCDB856,10,True,832, 361,868, 382);>40
			If $add_30gold>40 Then
				writeLog($List,"Get gold error")
				ExitLoop
			EndIf
			Sleep(32000)
			Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
			Sleep(1000)
			While Not $click_ok
				Local $ok_button = FFColorCount(0xDEDEDE,10,True,466, 432,500, 454);27
				if $ok_button >25 Then
					ControlClick($hwnd,'','','left',1,480, 445)
					$click_ok = True
					writeLog($List,"Get gold success")
					ExitLoop
				EndIf
				Sleep(100)
			WEnd
		Else
			ExitLoop
		EndIf
	WEnd
EndFunc

Func checkNetwork()
	$network_error = FFColorCount(0xFFFFFF,0,True,431, 188,536, 211);124
	if $network_error>120 and $network_error<130 Then
		ControlClick($hwnd,'','','left',1,484, 394) ;ok
		writeLog($List,"Network error")
	EndIf
EndFunc

Func toBattle()
	Local $in_battle = False
	Local $check_add_gold = False
	while Not $in_battle
		Local $to_battle = FFColorCount(0x8A1F00,10,True,540, 473,573, 498);275
		Local $offline_game = FFColorCount(0xE9E9E9,10,True,425, 215,543, 234);93
		Local $chosse_map = FFColorCount(0xFFFFFF,0,True,708, 302,750, 367);289
		Local $storm_map = FFColorCount(0x040F1C,5,True,401, 370,423, 378);192
		Local $x_button = FFColorCount(0xEEEEEE,20,True,888, 54,911, 81);76
		Local $gold_shop = FFColorCount(0xFDCC16,0,True,680, 500,700, 510);231
		Local $out_game = FFColorCount(0x00E0FF,0,True,241, 96,257, 116);48
		checkNetwork()
		If $out_game>45 and $out_game<50 Then
			ControlClick($hwnd,'','','left',1,692, 203) ; mo lai game
			Sleep(5000)
		EndIf
		If $gold_shop>200 Then
			ControlClick($hwnd,'','','left',1,88, 68) ; nhấn quay lại
			Sleep(500)
		EndIf
		If $x_button>70 Then
			writeLog($List,"Close AD")
			ControlClick($hwnd,'','','left',1,898, 68) ; nhấn X tắt quảng cáo bán hàng
			Sleep(500)
		EndIf
		If $to_battle>240 Then ;đang ở home
			If $chup_landau = False Then
				Sleep(2000)
				FileDelete ( "1.bmp" )
				FFSaveBMP("1", True, 667, 47, 938, 82, $FFLastSnap, $hwnd)
				GUICtrlSetImage($Pic1,"1.bmp")
				writeLog($List,"Capture Before")
				$chup_landau = True
			EndIf
			if $check_add_gold = False Then
				get30Gold()
				$check_add_gold = True
			EndIf
			FileDelete ( "2.bmp" )
			Sleep(2000)
			FFSaveBMP("2", True, 667, 47, 938, 82, $FFLastSnap, $hwnd)
			GUICtrlSetImage($Pic2,"2.bmp")
			writeLog($List,"Capture After")
			ControlClick($hwnd,'','','left',2,600, 480)
		EndIf
		If $offline_game >90 Then
			writeLog($List,"Offline game found")
			ControlClick($hwnd,'','','left',2,486, 339)
		EndIf
		If $chosse_map >280 Then
			Local $chosse_storm = False
			while Not $chosse_storm
				if ($storm_map>190) Then
					ControlClick($hwnd,'','','left',2,568, 533)
					writeLog($List,"Choose Storm map")
					$chosse_storm = True
					$in_battle = True
				Else
					ControlClick($hwnd,'','','left',1,738, 334)
					Sleep(300)
					Local $storm_map = FFColorCount(0x040F1C,5,True,401, 370,423, 378);192
				EndIf	
			WEnd
		EndIf
		Sleep(500)
	WEnd
EndFunc

func onlySubmarine()
	$shiptype[1] = FFColorCount(0xFF0000,5,True,565, 56,565, 61)
	$shiptype[2] = FFColorCount(0xFF0000,5,True,591, 56,591, 61)
	$shiptype[3] = FFColorCount(0xFF0000,5,True,617, 56,617, 61)
	$shiptype[4] = FFColorCount(0xFF0000,5,True,643, 56,643, 61)
	$shiptype[5] = FFColorCount(0xFF0000,5,True,669, 56,669, 61)
	writeLog($List,"Ship:"&$shiptype[1]&","&$shiptype[2]&","&$shiptype[3]&","&$shiptype[4]&","&$shiptype[5])
	If $shiptype[1]=0 and $shiptype[2]=0 and $shiptype[3]=0 and $shiptype[4]=0 and $shiptype[5]=0 Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func findAndKill()
	Local $done = False
	$Command = 'nox_adb '&$idNox&' shell input swipe 300 300 550 300 2000'
	While Not $done
		checkNetwork()
		$timer1 = TimerInit()
		do
			$ten_tau = FFColorCount(0xA8A9A9,20,True,400, 210,550, 245)
			$mau_tau = FFColorCount(0xFF0000,0,True,423, 252,538, 265)
			$ketthuc = FFColorCount(0x081821,0,True,410, 472,553, 501)
			if $ketthuc >15 Then ;ketthuctran
				ConsoleWrite("End battle"&@LF)
				ControlClick($hwnd,'','','left',2,478, 479) ;nhấn trở lại
				$done = True
				ExitLoop
			EndIf
			if ($mau_tau >35) and ($ten_tau>5) Then
                ConsoleWrite("-Enermy found (health:"&$mau_tau&",name: "&$ten_tau&")"&@LF)
				$tieudiet = False
				While Not $tieudiet
				ControlClick($hwnd,'','','left',4,775, 520) ;
				ControlClick($hwnd,'','','left',4,873, 384) ;
				ControlClick($hwnd,'','','left',4,777, 387) ;
					for $i=1 to 3
						Sleep(2000)
						ControlClick($hwnd,'','','left',4,742, 457) ;ten lua 1
						ControlClick($hwnd,'','','left',4,776, 389) ;ten lua 2
						ControlClick($hwnd,'','','left',4,742, 457) ;ten lua 1
					Next
					$ten_tau = FFColorCount(0xA8A9A9,20,True,419, 220,546, 237)
					$mau_tau = FFColorCount(0xFF0000,0,True,423, 252,538, 265)
					if ($mau_tau <50) or ($ten_tau<30) Then
						Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
                        ConsoleWrite("-Don't see enermy (health:"&$mau_tau&",name: "&$ten_tau&")"&@LF)
						$tieudiet = True
						Sleep(850)
					EndIf
				WEnd
			EndIf
			Sleep(10)
			$time1 = Int(TimerDiff($timer1))
		Until ($time1>3000)
		ControlClick($hwnd,'','','left',4,775, 520) ;ten lua 3
		ControlClick($hwnd,'','','left',4,873, 384) ;ten lua 5
		ControlClick($hwnd,'','','left',4,777, 387) ;ten lua 1
		Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
	WEnd
EndFunc

Func auto()
    $soLan = GUICtrlRead($Input_soLan)
    if $soLan = '∞' Then
        $soLan = 9999999
    EndIf
    for $i=1 to $soLan
		Local $fight_start = False
		toBattle()
		while Not $fight_start
			Local $mauxanh = FFColorCount(0x00FF90,0,True,806, 298,847, 309)
			if $mauxanh >50 Then
				$ten_minute_start = TimerInit()
				$fight_start = True
			EndIf
			Sleep(200)
		WEnd
		ControlClick($hwnd,'','','left',5,775, 520) ;ten lua 3
		ControlClick($hwnd,'','','left',5,871, 523) ;ten lua 4
		ControlClick($hwnd,'','','left',5,873, 384) ;ten lua 5
		ControlClick($hwnd,'','','left',5,900, 456) ;ten lua 6
		ControlClick($hwnd,'','','left',4,164, 392) ;tiến lên
		Sleep(1000)
		$Command = 'nox_adb ' &$idNox& ' shell input swipe 250 400 250 400 15000' ;nhấn sang phải
		Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
		Sleep(30000)
		$Command = 'nox_adb ' &$idNox& ' shell input swipe 300 300 300 265' ;chinh cam cao len
		Run(@ComSpec & " /c " & $Command,"",@SW_HIDE)
		;~ Sleep(5000)
		;~ ControlClick($hwnd,'','','left',2,165, 483) ;lùi
		Sleep(500)
		findAndKill()
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
            findAndKill()
        Case $Button_autoALL
            $timer = TimerInit()
            auto()
	EndSwitch
WEnd
