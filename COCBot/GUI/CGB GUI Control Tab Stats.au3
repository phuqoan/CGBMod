; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GkevinOD (2014)
; Modified ......: Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func btnLoots()
	Run("Explorer.exe " & $sProfilePath & "\" & $sCurrProfile & "\Loots")
EndFunc   ;==>btnLoots

Func btnLogs()
	Run("Explorer.exe " & $sProfilePath & "\" & $sCurrProfile & "\Logs")
EndFunc   ;==>btnLogs

Func btnResetStats()
	GUICtrlSetState($btnResetStats, $GUI_DISABLE)
	$FirstRun = 1
	GUICtrlSetState($lblLastAttackTemp, $GUI_SHOW)
	GUICtrlSetState($lblTotalLootTemp, $GUI_SHOW)
	GUICtrlSetState($lblHourlyStatsTemp, $GUI_SHOW) ;; added for hourly stats
	GUICtrlSetState($lblArmyCostsTemp, $GUI_SHOW)
	GUICtrlSetState($lblLastAttackBonusTemp, $GUI_SHOW)
	GUICtrlSetState($lblHourlyBonusTemp, $GUI_SHOW)
	GUICtrlSetState($lblTotalBonusTemp, $GUI_SHOW)
	GUICtrlSetState($lblNetTotalLoot1, $GUI_SHOW)
	GUICtrlSetState($lblNetTotalLoot2, $GUI_SHOW)	
	GUICtrlSetData($lblresultruntime, "00:00:00")
	GUICtrlSetData($lblWallgoldmake, "0")
	$wallgoldmake = 0
	GUICtrlSetData($lblWallelixirmake, "0")
	$wallelixirmake = 0
	GUICtrlSetData($lblresultoutofsync, "0")
	GUICtrlSetData($lblresulttrophiesdropped, "0")
	GUICtrlSetData($lblresultvillagesskipped, "0")
	GUICtrlSetData($lblresultvillagesattacked, "0")
	GUICtrlSetData($lblGoldLastAttack, "")
	GUICtrlSetData($lblElixirLastAttack, "")
	GUICtrlSetData($lblDarkLastAttack, "")
	GUICtrlSetData($lblTrophyLastAttack, "")
	GUICtrlSetData($lblGoldLoot, "")
	GUICtrlSetData($lblElixirLoot, "")
	GUICtrlSetData($lblDarkLoot, "")
	GUICtrlSetData($lblTrophyLoot, "")
	GUICtrlSetData($lblHourlyStatsGold, "")
	GUICtrlSetData($lblHourlyStatsElixir, "")
	GUICtrlSetData($lblHourlyStatsDark, "")
	GUICtrlSetData($lblHourlyStatsTrophy, "")
	GUICtrlSetData($lblresultSearchCost, "0")
	GUICtrlSetData($lblResultTHLVL, "0")
	GUICtrlSetData($lblNetTotalGold, "")
	GUICtrlSetData($lblNetTotalElixir, "")
	GUICtrlSetData($lblNetTotalTrophy, "")
	GUICtrlSetData($lblNetTotalDE, "")
	GUICtrlSetData($lblBonusGTotal, "")
	GUICtrlSetData($lblBonusETotal, "")
	GUICtrlSetData($lblBonusDETotal, "")
	GUICtrlSetData($lblBonusGHourly, "")
	GUICtrlSetData($lblBonusEHourly, "")
	GUICtrlSetData($lblBonusDEHourly, "")
	GUICtrlSetData($lblBonusGLastAttack, "")
	GUICtrlSetData($lblBonusELastAttack, "")
	GUICtrlSetData($lblBonusDELastAttack, "")	
	GUICtrlSetData($lblArmyHourlyDECost, "")
	GUICtrlSetData($lblArmyHourlyECost, "")
	GUICtrlSetData($lblArmyDECost, "")
	GUICtrlSetData($lblArmyElixirCost, "")
	$iTimePassed = 0
	$sTimer = TimerInit()
	UpdateStats()
EndFunc   ;==>btnResetStats
