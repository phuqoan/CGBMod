Func UpdateStats()
   If $FirstRun = 1 Then
	  $FirstRun = 0
	  $FirstAttack = 1
	  $GoldStart = $GoldCount
	  $ElixirStart = $ElixirCount
	  $DarkStart = $DarkCount
	  $TrophyStart = $TrophyCount

	  GUICtrlSetState($lblResultStatsTemp, $GUI_HIDE)
	  GUICtrlSetState($lblVillageReportTemp, $GUI_HIDE)
	  GUICtrlSetState($picResultGoldTemp, $GUI_HIDE)
	  GUICtrlSetState($picResultElixirTemp, $GUI_HIDE)
	  GUICtrlSetState($picResultDETemp, $GUI_HIDE)

	  GUICtrlSetState($lblResultGoldNow, $GUI_SHOW)
	  GUICtrlSetState($picResultGoldNow, $GUI_SHOW)
	  GUICtrlSetData($lblResultGoldStart, _NumberFormat($GoldCount))

	  GUICtrlSetState($lblResultElixirNow, $GUI_SHOW)
	  GUICtrlSetState($picResultElixirNow, $GUI_SHOW)
	  GUICtrlSetData($lblResultElixirStart, _NumberFormat($ElixirCount))

	  If $DarkCount <> "" Then
		 GUICtrlSetData($lblResultDEStart, _NumberFormat($DarkCount))
		 GUICtrlSetState($lblResultDeNow, $GUI_SHOW)
		 GUICtrlSetState($picResultDeNow, $GUI_SHOW)
	  Else
		 GUICtrlSetState($picResultDEStart, $GUI_HIDE)
		 GUICtrlSetState($picDarkLoot, $GUI_HIDE)
		 GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
		 GUICtrlSetState($picHourlyStatsDark, $GUI_HIDE)
	  EndIf

	  GUICtrlSetData($lblResultTrophyStart, _NumberFormat($TrophyCount))
	  GUICtrlSetState($lblResultTrophyNow, $GUI_SHOW)
	  GUICtrlSetState($lblResultBuilderNow, $GUI_SHOW)
	  GUICtrlSetState($lblResultGemNow, $GUI_SHOW)
	  
	  GUICtrlSetState($btnResetStats, $GUI_ENABLE)
   Else
	  ; Add last attack numbers to total numbers
	  $totalLootGold += $lootGold
	  $totalLootElixir += $lootElixir
	  $totalLootDarkElixir += $lootDarkElixir
	  $totalLootTrophies += $lootTrophies

	  If $FirstAttack = 1 Then
		 $FirstAttack = 0
		 GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)
		 GUICtrlSetState($lblTotalLootTemp, $GUI_HIDE)
		 GUICtrlSetState($lblHourlyStatsTemp, $GUI_HIDE) ;; added for hourly stats
		 GUICtrlSetState($lblLastAttackBonusTemp, $GUI_HIDE)
		 GUICtrlSetState($lblHourlyBonusTemp, $GUI_HIDE)
		 GUICtrlSetState($lblTotalBonusTemp, $GUI_HIDE)
		 GUICtrlSetState($lblNetTotalLoot1, $GUI_HIDE)
		 GUICtrlSetState($lblNetTotalLoot2, $GUI_HIDE)
	  EndIf

	  ; Last Attack stats
	  GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
	  GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblDarkLastAttack, _NumberFormat($lootDarkElixir))
	  EndIf
	  GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))

	  ; Total stats
	  GUICtrlSetData($lblGoldLoot, _NumberFormat($totalLootGold))
	  GUICtrlSetData($lblElixirLoot, _NumberFormat($totalLootElixir))
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblDarkLoot, _NumberFormat($totalLootDarkElixir))
	  EndIf
	  GUICtrlSetData($lblTrophyLoot, _NumberFormat($totalLootTrophies))

	  ; Hourly stats
	  GUICtrlSetData($lblHourlyStatsGold, _NumberFormat(Round($totalLootGold / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
	  GUICtrlSetData($lblHourlyStatsElixir, _NumberFormat(Round($totalLootElixir / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblHourlyStatsDark, _NumberFormat(Round($totalLootDarkElixir / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")
	  EndIf
	  GUICtrlSetData($lblHourlyStatsTrophy, _NumberFormat(Round($totalLootTrophies / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")

	  ; Last Attack Bonus stats
	  GUICtrlSetData($lblBonusGLastAttack, _NumberFormat($BonusLeagueG))
	  GUICtrlSetData($lblBonusELastAttack, _NumberFormat($BonusLeagueE))
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblBonusDELastAttack, _NumberFormat($BonusLeagueD))
	  EndIf
	  
	  ; Hourly Attack Bonus
	  $GBonusTotal += $BonusLeagueG
	  $EBonusTotal += $BonusLeagueE
	  $DBonusTotal += $BonusLeagueD
	  
	  GUICtrlSetData($lblBonusGHourly, _NumberFormat(Round($GBonusTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
	  GUICtrlSetData($lblBonusEHourly, _NumberFormat(Round($EBonusTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 ))& "K / h")
	  GUICtrlSetData($lblBonusDEHourly, _NumberFormat(Round($DBonusTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600* 1000)) & "/h")
 
	  ; Total Attack Bonus
	  GUICtrlSetData($lblBonusGTotal, _NumberFormat($GBonusTotal))
	  GUICtrlSetData($lblBonusETotal, _NumberFormat($EBonusTotal))
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblBonusDETotal, _NumberFormat($DBonusTotal))
	  EndIf

	; DE Smart Zap
	If $smartZapGain <> "" Then
		GUICtrlSetData($lblSmartZap, _NumberFormat($smartZapGain))
		GUICtrlSetData($lblLightningUsed, _NumberFormat($NumLTSpellsUsed))
		LightingSpellCost()
		GUICtrlSetData($lblLTSpellCost, _NumberFormat($LTSpellCost))
	EndIf  
	  
	;Net Total Loot
	$NetGLoot = $GBonusTotal + $totalLootGold - $searchCost
	$NetELoot = $EBonusTotal + $totalLootElixir - $ArmyECost
	$NetDELoot = $DBonusTotal + $totalLootDarkElixir - $ArmyDCost
	$NetTrophy = $TrophyCount - $TrophyStart

	GUICtrlSetData($lblNetTotalGold, _NumberFormat($NetGLoot))
	GUICtrlSetData($lblNetTotalElixir, _NumberFormat($NetELoot))
		If $DarkStart <> "" Then
			GUICtrlSetData($lblNetTotalDE, _NumberFormat($NetDELoot))
		EndIf
	GUICtrlSetData($lblNetTotalTrophy, _NumberFormat($NetTrophy))
	EndIf	
EndFunc

Func ReadResTrain()
	Local $iCount = 0
	While _CheckPixel($aIsMain, $bCapturePixel) = False
		If _Sleep(100) Then Return
		$iCount += 1
		If $iCount > 50 Then
			$ECountBeforeTrain = 0
            $DCountBeforeTrain = 0
            Return
		EndIf
	WEnd
		If _Sleep(100) Then Return

	$ECountBeforeTrain = 0
    $DCountBeforeTrain = 0

	$ECountBeforeTrain = getResourcesMainScreen(710, 74)
	If _ColorCheck(_GetPixelColor(812, 141, True), Hex(0x000000, 6), 10) Then ; check if the village have a Dark Elixir Storage
	$DCountBeforeTrain = getResourcesMainScreen(731, 123)
	Else
	$DCountBeforeTrain = 0
	EndIf

    If _Sleep(100) Then Return
EndFunc

Func GetArmyCost()
	PureClickP($aAway, 1, 0, "#0319") ;Click Away
	Local $iCount = 0
	While _CheckPixel($aIsMain, $bCapturePixel) = False
		If _Sleep(100) Then Return
		$iCount += 1
		If $iCount > 50 Then Return
	WEnd
	If $ECountBeforeTrain = 0 And $DCountBeforeTrain = 0 Then Return

    $ECountAfterTrain = 0
    $DCountAfterTrain = 0
	If _Sleep(500) Then Return
	$ECountAfterTrain = getResourcesMainScreen(710, 74)
	If _ColorCheck(_GetPixelColor(812, 141, True), Hex(0x000000, 6), 10) Then ; check if the village have a Dark Elixir Storage
	$DCountAfterTrain = getResourcesMainScreen(731, 123)
	Else
	$DCountAfterTrain = 0
	EndIf

	If $ECountAfterTrain = "" And $DCountAfterTrain = "" Then Return

	local $LastECost= $ECountBeforeTrain - $ECountAfterTrain
	local $LastDCost= $DCountBeforeTrain - $DCountAfterTrain

	$ArmyECost += $LastECost
	$ArmyDCost += $LastDCost

	GUICtrlSetState($lblArmyCostsTemp, $GUI_HIDE)

	If $ArmyECost = "" Then
		GUICtrlSetData($lblArmyElixirCost , "0" )
	Else
		GUICtrlSetData($lblArmyElixirCost , _NumberFormat($ArmyECost) )
	EndIf

	If $ArmyDCost = "" Then
		GUICtrlSetData($lblArmyDECost , "0" )
	Else
		GUICtrlSetData($lblArmyDECost , _NumberFormat($ArmyDCost) )
	EndIf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GUICtrlSetData($lblArmyHourlyECost, StringFormat("%d",Int( $ArmyECost / Int(TimerDiff($sTimer)) * 3600)) & "k/h")
	GUICtrlSetData($lblArmyHourlyDECost, StringFormat("%d",Int( $ArmyDCost / Int(TimerDiff($sTimer)) * 3600 * 1000)) & "/h")
EndFunc

Func SearchCost()
	Switch $iTownHallLevel
		Case 1
			$NextCost = 10
		Case 2
			$NextCost = 50
		Case 3
			$NextCost = 75
		Case 4
			$NextCost = 110
		Case 5
			$NextCost = 170
		Case 6
			$NextCost = 250
		Case 7
			$NextCost = 380
		Case 8
			$NextCost = 580
		Case 9
			$NextCost = 750
		Case 10
			$NextCost = 1000
	EndSwitch

	$searchCost = Int (GUICtrlRead($lblresultvillagesskipped)* $NextCost)
	GUICtrlSetData($lblresultSearchCost , _NumberFormat($searchCost) )
EndFunc

Func LightingSpellCost()
	Switch $iLTSpellCost
		Case 1
			$LTSCost = 15000
		Case 2
			$LTSCost = 16500
		Case 3
			$LTSCost = 18000
		Case 4
			$LTSCost = 20000
		Case 5
			$LTSCost = 22000
		Case 6
			$LTSCost = 24000
		Case 7
			$LTSCost = 26000
	EndSwitch

	$LTSpellCost = Int (GUICtrlRead($NumLTSpellsUsed)* $LTSCost)
EndFunc ;LTspell cost