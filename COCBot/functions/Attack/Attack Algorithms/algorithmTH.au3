; #FUNCTION# ====================================================================================================================
; Name ..........: algorithmTH
; Description ...: This file contens the attack algorithm TH and Lspell
; Syntax ........: algorithmTH() , AttackTHGrid() , AttackTHNormal() , AttackTHXtreme() , LLDropheroes() , SpellTHGrid() , CastSpell()
; Parameters ....: None
; Return values .: None
; Author ........: AtoZ (2015)
; Modified ......: Barracoda (July 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func algorithmTH() ;Attack Algorithm TH
	If $iMatchMode = $TS Or $chkATH = 1 And GUICtrlRead($BottomTHType) Then ; $iMatchMode = $TS
		$LeftTHx = 40
		$RightTHx = 30
		$BottomTHy = 30
		$TopTHy = 30
		$GetTHLoc = 0
		If $THLocation = 0 Then
			SetLog("Can't get Townhall location", $COLOR_RED)
		ElseIf $THx > 227 And $THx < 627 And $THy > 151 And $THy < 419 And ($iMatchMode = $TS Or $chkATH = 1) Then ;if found outside
			SetLog("Townhall location (" & $THx & ", " & $THy & ")")
			SetLog("Townhall is in the Center of the Base. Ignore Attacking Townhall", $COLOR_RED)
			$THLocation = 0
		Else
			SetLog("Townhall location (" & $THx & ", " & $THy & ")")
		EndIf
		If _Sleep($iDelayAlgorithmTH1) Then Return
		While 1
			Local $i = 0
			If $Barb <> -1 And $THLocation <> 0 Then
				$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
				Local $numBarbPerSpot = Ceiling($atkTroops[$Barb][1] / 3)
				If $atkTroops[$Barb][1] <> 0 Then
					Click(GetXPosOfArmySlot($Barb, 68), 595, 1, 0, "#0001") ;Select Troop
					If _Sleep($iDelayAlgorithmTH1) Then ExitLoop (2)
					If $iMatchMode = $TS Or $chkATH = 1 Then
						If $GetTHLoc = 0 Then
							If $THx < 287 And $THx > 584 And $THy < 465 Then ; Leftmost, Rightmost, Topmost. If found Outside
								$i = 0
								$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
								While $atkTroops[$Barb][1] <> 0
									Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), 1, 1, "#0002") ; BottomLeft
									$AtkTroopTH = Number(ReadTroopQuantity($Barb))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$LeftTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
								$i = 0
								$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
								While $atkTroops[$Barb][1] <> 0
									Click(($THx + $RightTHx), ($THy + $RightTHx - 10), 1, 1, "#0003") ; BottomRight
									$AtkTroopTH = Number(ReadTroopQuantity($Barb))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$RightTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
							EndIf
							$i = 0
							$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
							While $atkTroops[$Barb][1] <> 0
								Click(($THx + $TopTHy - 10), ($THy - $TopTHy), 1, 1, "#0004") ; TopRight
								$AtkTroopTH = Number(ReadTroopQuantity($Barb))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$TopTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
							$i = 0
							$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
							While $atkTroops[$Barb][1] <> 0
								Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), 1, 1, "#0005") ; TopLeft
								$AtkTroopTH = Number(ReadTroopQuantity($Barb))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$BottomTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
						EndIf
						SetLog("Attacking Townhall with first wave Barbarians", $COLOR_BLUE)
						For $i = 2 To 4
							If $GetTHLoc = $i Then $numBarbPerSpot = Ceiling($numBarbPerSpot / $i)
						Next
						If $THx < 287 And $THx > 584 And $THy < 465 Then ;Leftmost, rightmost, topmost. If found outside
							Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), $numBarbPerSpot, $iDelayAlgorithmTH3, "#0006") ; BottomLeft
							Click(($THx + $RightTHx), ($THy + $RightTHx - 10), $numBarbPerSpot, $iDelayAlgorithmTH3, "#0007") ; BottomRight
						EndIf
						Click(($THx + $TopTHy - 10), ($THy - $TopTHy), $numBarbPerSpot, $iDelayAlgorithmTH3, "#0008") ; TopRight
						Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), $numBarbPerSpot, $iDelayAlgorithmTH3, "#0009") ; TopLeft
					EndIf
				EndIf
				If _Sleep($iDelayAlgorithmTH2) Then ExitLoop
			EndIf
			If $Arch <> -1 And $THLocation <> 0 Then
				$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
				Local $numArchPerSpot = Ceiling($atkTroops[$Arch][1] / 3)
				If $atkTroops[$Arch][1] <> 0 Then
					Click(GetXPosOfArmySlot($Arch, 68), 595, 1, 0, "#0010") ;Select Troop
					If _Sleep($iDelayAlgorithmTH1) Then ExitLoop (2)
					If $iMatchMode = $TS Or $chkATH = 1 Then
						If $GetTHLoc = 0 Then
							If $THx < 287 And $THx > 584 And $THy < 465 Then ; Leftmost, Rightmost and Topmost. If found outside
								$i = 0
								$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
								While $atkTroops[$Arch][1] <> 0
									Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), 1, 1, "#0011") ; BottomLeft
									$AtkTroopTH = Number(ReadTroopQuantity($Arch))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$LeftTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
								$i = 0
								$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
								While $atkTroops[$Arch][1] <> 0
									Click(($THx + $RightTHx), ($THy + $RightTHx - 10), 1, 1, "#0012") ; BottomRight
									$AtkTroopTH = Number(ReadTroopQuantity($Arch))
									SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
									$RightTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
							EndIf
							$i = 0
							$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
							While $atkTroops[$Arch][1] <> 0
								Click(($THx + $TopTHy - 10), ($THy - $TopTHy), 1, 1, "#0013") ; TopRight
								$AtkTroopTH = Number(ReadTroopQuantity($Arch))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$TopTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
							$i = 0
							$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
							While $atkTroops[$Arch][1] <> 0
								Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), 1, 1, "#0014") ; TopLeft
								$AtkTroopTH = Number(ReadTroopQuantity($Arch))
								SetLog("Getting Attack Townhall location...", $COLOR_BLUE)
								$BottomTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
						EndIf
						SetLog("Attacking Townhall with first wave of Archers", $COLOR_BLUE)
						$LeftTHx += 10
						$RightTHx += 10
						$BottomTHy += 10
						$TopTHy += 10
						For $i = 2 To 4
							If $GetTHLoc = $i Then $numArchPerSpot = Ceiling($numArchPerSpot / $i)
						Next
						If $THx < 287 And $THx > 584 And $THy < 465 Then ;Left most and Right most and tOp most. if found outside
							Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), $numArchPerSpot, $iDelayAlgorithmTH3, "#0015") ; BottomLeft
							Click(($THx + $RightTHx), ($THy + $RightTHx - 10), $numArchPerSpot, $iDelayAlgorithmTH3, "#0016") ; BottomRight
						EndIf
						Click(($THx + $TopTHy - 10), ($THy - $TopTHy), $numArchPerSpot, $iDelayAlgorithmTH3, "#0017") ; TopRight
						Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), $numArchPerSpot, $iDelayAlgorithmTH3, "#0018") ; TopLeft
					EndIf
				EndIf
			EndIf
			ExitLoop
		WEnd
		If $THLocation <> 0 Then
			PrepareAttack($iMatchMode, True) ;Check remaining quantities
		EndIf
	EndIf
EndFunc   ;==>algorithmTH

Func AttackTHGrid($troopKind, $spots, $numperspot, $Sleep, $waveNb, $maxWaveNb, $BoolDropHeroes)
	Local $aThx, $aThy, $num
	Local $TroopCountBeg
	If $iMatchMode = $TS Or $chkATH = 1 And SearchTownHallLoc() Then

		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then Return ;exit if 1 star

		If  $troopKind >= $eLSpell And $troopKind <= $eHaSpell Then
			SpellTHGrid($troopKind)
			Return
		EndIf

		Local $THtroop = -1
		Local $troopNb = 0
		Local $name = ""
		For $i = 0 To UBound($atkTroops) - 1
			If $atkTroops[$i][0] = $troopKind Then
				$THtroop = $i
				$troopNb = $spots * $numperspot
				Local $plural = 0
				If $troopNb > 1 Then $plural = 1
				$name = NameOfTroop($troopKind, $plural)
			EndIf
		Next

		If  $troopKind >= $eLSpell And $troopKind <= $eHaSpell Then
			SpellTHGrid($troopKind)
			Return
		EndIf


	    If $troopKind = $eKing Or $troopKind = $eQueen Or $troopKind = $eCastle Then
			If ($THtroop = -1) Then Return False
			$spots = 1
			$numperspot = 1
			$troopNb = 1
			$BoolDropHeroes = 0
		    SetLog("Dropping " & $name, $COLOR_GREEN)
			If $troopKind = $eKing Then $checkKPower = True
			If $troopKind = $eQueen Then $checkQPower = True

	    EndIf

	    If $troopKind >= $eBarb And $troopKind <= $eLava Then
			$TroopCountBeg = Number(ReadTroopQuantity($THtroop))

			If ($THtroop = -1) Or ($TroopCountBeg = 0) Then SetLog("No " & $name & " troop Found!!!")
		    If ($THtroop = -1) Or ($TroopCountBeg = 0) Then Return False

		    Local $waveName = "first"
		    If $waveNb = 2 Then $waveName = "second"
		    If $waveNb = 3 Then $waveName = "third"
		    If $maxWaveNb = 1 Then $waveName = "only"
		    If $waveNb = 0 Then $waveName = "last"
		    SetLog("Dropping " & $waveName & " wave of " & $troopNb & " " & $name, $COLOR_GREEN)
		EndIf

		SelectDropTroop($THtroop) ;Select Troop
		If _Sleep(500) Then Return
		
		If $THi <= 81 Or $THside = 0 Or $THside = 2 Then
			Switch $THside
				Case 0 ;UL
					 If $THx <=200 and $Thy < 350 and $Thy > 280 then  ; In Left Corner
					For $num = 0 To $numperspot - 1
					For $ii = $THi - 1 To $THi - 1 + ($spots - 1)
							 $aThx = 430 - ($ii * 4)
							$aThy = 15 + ($ii * 3)
							Click(35,314,1,0,"#0019") ; Left Corner
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							; SetLog("Thside " & $THside & " THi " & $THi & " aThx, Thx " & $aThx & "," & $Thx & " aThy,Thy " & $aThy & "," & $Thy, $COLOR_GREEN)
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
				 Else
				; in upper corner
					  If $THy < 110 and $THx > 400 and $THx < 470 then ; In Top Corner
					     For $num = 0 To $numperspot - 1
						 For $ii = $THi - 1 To $THi - 1 + ($spots - 1)
							 $aThx = 430 - ($ii * 4)
							 $aThy = 15 + ($ii * 3)
							Click(428,30,1,0,"#0019") ; Top Corner
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							 ;SetLog("Thside " & $THside & " THi " & $THi & " aThx, Thx " & $aThx & "," & $Thx & " aThy,Thy " & $aThy & "," & $Thy, $COLOR_GREEN)
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)

					  Else
					     ; Along Side 0 (Top Left Side)
					     For $num = 0 To $numperspot - 1
						 For $ii = $THi - 1 To $THi - 1 + ($spots - 1)
							$aThx = 430 - ($ii * 4)
							$aThy = 15 + ($ii * 3)
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0019")
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
					     EndIf
					     EndIf
				Case 1 ;LL
					 If $THx <=200 and $Thy < 350 and $Thy > 280 then  ; In Left Corner
					For $num = 0 To $numperspot - 1
					  For $ii = $THi -1 To $THi -1 + ($spots - 1)
							$aThx = 30 + ($ii * 4)
							$aThy = 315 + ($ii * 3)
							Click(35,314,1,0,"#0019")
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							 ;SetLog("Thside " & $THside & " THi " & $THi & " aThx, Thx " & $aThx & "," & $Thx & " aThy,Thy " & $aThy & "," & $Thy, $COLOR_GREEN)
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
				    Else
					; Along Side 1 (Bottom Left Side)
						 For $num = 0 To $numperspot - 1
						For $ii = $THi -1 To $THi -1 + ($spots - 1)
							$aThx = 30 + ($ii * 4)
							$aThy = 315 + ($ii * 3)
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0020")
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
						EndIf

				Case 2 ;UR
					 If $THy < 110 and $THx > 400 and $THx < 470 then ; In Top Corner
					For $num = 0 To $numperspot - 1
					  For $ii = $THi -1 To $THi -1 + ($spots - 1)
							$aThx = 430 + ($ii * 4)
							$aThy = 15 + ($ii * 3)
							Click(428,30,1,0,"#0019") ; Top Corner
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							; SetLog("Thside " & $THside & " THi " & $THi & " aThx, Thx " & $aThx & "," & $Thx & " aThy,Thy " & $aThy & "," & $Thy, $COLOR_GREEN)
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
				 Else
					  If $THx >=700 and $Thy < 350 and $Thy > 280 then  ; In Right Corner
					     For $num = 0 To $numperspot - 1
						For $ii = $THi -1 To $THi -1 + ($spots - 1)
							$aThx = 430 + ($ii * 4)
							$aThy = 15 + ($ii * 3)
							Click(810,314,1,0,"#0019") ; Right Corner
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							 ;SetLog("Thside " & $THside & " THi " & $THi & " aThx, Thx " & $aThx & "," & $Thx & " aThy,Thy " & $aThy & "," & $Thy, $COLOR_GREEN)
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)

					  Else
					     ;Along Side 2 (Top Right Side)
					     For $num = 0 To $numperspot - 1
						For $ii = $THi -1 To $THi -1 + ($spots - 1)
							$aThx = 430 + ($ii * 4)
							$aThy = 15 + ($ii * 3)
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0021")
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
					     EndIf
					     EndIf

				Case 3 ;LR
					  If $THx >=700 and $Thy < 350 and $Thy > 280 then  ; In Right Corner
					 For $num = 0 To $numperspot - 1
						For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
							$aThx = 830 - ($ii * 4)
							$aThy = 315 + ($ii * 3)
							Click(810,314,1,0,"#0019") ; Right Corner
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							 ;SetLog("Thside " & $THside & " THi " & $THi & " aThx, Thx " & $aThx & "," & $Thx & " aThy,Thy " & $aThy & "," & $Thy, $COLOR_GREEN)
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
				    Else
					 ;Along Side 3 (Bottom Right Side)
					 For $num = 0 To $numperspot - 1
						For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
							$aThx = 830 - ($ii * 4)
							$aThy = 315 + ($ii * 3)
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0022")
							If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then Return
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
						Next
						If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)
						EndIf
			EndSwitch
		EndIf

		If $THi>= 81 Then
			Switch (_GUICtrlComboBox_GetCurSel($cmbAttackbottomType) + 1)
			   Case 1
				  ModerateZoomed($numperspot , $spots)
			   Case 2
				  SideSnipe($numperspot , $spots)
			EndSwitch
			EndIf

		If _Sleep($iDelayAttackTHGrid1) Then Return
		
		If $troopKind >= $eBarb And $troopKind <= $eLava Then
		    If $TroopCountBeg <> Number(ReadTroopQuantity($THtroop)) Then
			   SetLog("Deployment of " & $name & " was Successful!")
			   If _Sleep($Sleep) Then Return
		    Else
			   SetLog("Deployment of " & $name & " wasn't Successful!")
		    EndIf
        EndIf

	EndIf

EndFunc   ;==>AttackTHGrid

Func AttackTHNormal()
    SetLog($thinfo)
	Setlog("Normal Attacking TH Outside with BAM PULSE!")

	;---1st wave
	AttackTHGrid($eBarb, 3, 2, 1800, 1, 5, 0) ; deploys 6 barbarians
	AttackTHGrid($eArch, 3, 2, 1200, 1, 4, 0) ; deploys 6 archers
	AttackTHGrid($eMini, 3, 2, 1000, 1, 4, 0) ; deploys 6 minions
	$count = 0
	While $count < 30
		If _Sleep($iDelayAttackTHNormal1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---2nd wave
	AttackTHGrid($eBarb, 3, 2, 1500, 2, 5, 0) ; deploys 6 barbarians
	AttackTHGrid($eArch, 3, 2, 1400, 2, 4, 0) ; deploys 6 archers
	AttackTHGrid($eMini, 3, 2, 1300, 2, 4, 0) ; deploys 6 minions
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHNormal1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---3rd wave 10 secs
	AttackTHGrid($eBarb, 3, 2, 1400, 3, 5, 0) ; deploys 6 barbarians
	AttackTHGrid($eMini, 3, 2, 1300, 3, 4, 0) ; deploys 6 minions
	AttackTHGrid($eArch, 3, 2, 1200, 3, 4, 0) ; deploys 6 archers
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHNormal1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	Setlog("Normal Attacking TH Outside in FULL!")
	AttackTHGrid($eGiant, 3, 1, 1000, 1, 2, 0) ;releases 3 giants
	AttackTHGrid($eWall, 2, 2, 1100, 1, 1, 0) ; deploys 4 wallbreakers
	AttackTHGrid($eArch, 5, 5, 1200, 4, 4, 0) ;releases 25 archers
	AttackTHGrid($eBarb, 5, 5, 1150, 4, 5, 0) ;releases 25 barbs
	AttackTHGrid($eMini, 5, 2, 1000, 4, 4, 1) ;releases 10 minions and Heroes
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHNormal1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;Final Wave
	AttackTHGrid($eGiant, 5, 1, 1100, 2, 2, 0) ;releases 5 giants
	AttackTHGrid($eHogs, 5, 1, 1300, 2, 4, 0) ;releases 5 Hogs
	AttackTHGrid($eArch, 5, 5, 1000, 4, 4, 0) ;releases 25 archers
	AttackTHGrid($eBarb, 5, 5, 1100, 4, 5, 0) ;releases 25 barbs
	AttackTHGrid($eMini, 5, 2, 1050, 4, 4, 0) ;releases 10 minions
	AttackTHGrid($eWiza, 3, 2, 1000, 1, 1, 1) ;releases 6 wizards and releases hero
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHNormal1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	SetLog("~Finished Attacking, waiting to finish", $COLOR_GREEN)

EndFunc   ;==>AttackTHNormal

Func AttackTHXtreme()
    SetLog($thinfo)
	Setlog("Extreme Attacking TH Outside with BAM PULSE!")

	;---1st wave 15 secs
	;		SetLog("Attacking TH with 1st wave of BAM COMBO")
	AttackTHGrid($eBarb, 5, 1, 1000, 1, 5, 0) ; deploys 5 barbarians
	AttackTHGrid($eArch, 5, 1, 1000, 1, 4, 0) ; deploys 5 archers
	AttackTHGrid($eMini, 5, 1, 1000, 1, 4, 0) ; deploys 5 minions
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHXtreme1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---2nd wave 20 secs
	;		 SetLog("Attacking TH with 2nd wave of BAM COMBO")
	AttackTHGrid($eBarb, 5, 1, 1000, 2, 5, 0) ; deploys 5 barbarians
	AttackTHGrid($eMini, 5, 1, 1000, 2, 4, 0) ; deploys 5 minions
	AttackTHGrid($eArch, 5, 1, 1000, 2, 4, 0) ; deploys 5 archers
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHXtreme1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---3nd wave 10 secs
	;		 SetLog("Attacking TH with 3rd wave of BAM COMBO")
	AttackTHGrid($eBarb, 5, 1, 1000, 3, 5, 0) ; deploys 5 barbarians
	AttackTHGrid($eMini, 5, 1, 1000, 3, 4, 0) ; deploys 5 minions
	AttackTHGrid($eArch, 5, 1, 1200, 3, 4, 0) ; deploys 5 archers
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHXtreme1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---4th wave
	Setlog("Extreme Attacking TH Outside in FULL!")
	AttackTHGrid($eGiant, 3, 1, 1000, 1, 4, 0) ;releases 3 giants
	AttackTHGrid($eWall, 2, 2, 100, 1, 1, 0) ; deploys 4 wallbreakers
	AttackTHGrid($eArch, 5, 5, 1200, 4, 4, 0) ;releases 25 archers
	AttackTHGrid($eBarb, 5, 5, 1200, 4, 5, 0) ;releases 25 barbs
	AttackTHGrid($eMini, 5, 2, 1200, 4, 4, 0) ; deploys 5 minions
	AttackTHGrid($eGiant, 5, 1, 1000, 2, 4, 0) ;releases 5 giants
	AttackTHGrid($eHogs, 5, 1, 1000, 2, 4, 0) ;releases 5 Hogs
	AttackTHGrid($eBarb, 5, 5, 1200, 5, 5, 0) ;releases 25 barbs
	AttackTHGrid($eWiza, 3, 2, 1000, 1, 1, 1) ;releases 6 wizards and releases hero
	$count = 0
	While $count < 20
		If _Sleep($iDelayAttackTHXtreme1) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog("Townhall has been destroyed!")
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	SetLog("~Finished Attacking, waiting to finish", $COLOR_GREEN)

EndFunc   ;==>AttackTHXtreme

Func AttackTHGbarch()
    SetLog($thinfo)
	Setlog("Sending 1st wave of archers.")
	AttackTHGrid($eArch, 4, 1, 2000, 1, 4, 0) ; deploys 4 archers - take out possible bombs
	AttackTHGrid($eArch, 3, Random(5, 6, 1), 1000, 1, 4, 0) ; deploys 15-18 archers

	For $count = 0 To 30
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next

	Setlog("Sending second wave of archers.")
	AttackTHGrid($eArch, 4, Random(4, 5, 1), 1000, 2, 4, 0) ;deploys 16-20 archers

	For $count = 0 To 30
		If CheckOneStar() Then Return
	If _Sleep(1000) Then Return
	Next

	Setlog("Still no star - Let's send in more diverse troops!")
	    If  $optSpellNone = 1  Then
	       Switch $optSpellType
	       Case 0
		  local $spell = $eLSpell

	       Case 1
		  local $spell = $eHSpell

	      Case 2
		  local $spell = $eRSpell

	       EndSwitch
	      SpellTHGrid($spell)
	    EndIf
	AttackTHGrid($eGiant, 2, 1, 1240, 1, 2, 0) ;deploys 2 giants in case of spring traps
		If CheckOneStar() Then Return
	AttackTHGrid($eGiant, 2, Random(3, 4, 1), 1500, 2, 2, 0) ;deploys 6-8 giants to take heat
		If CheckOneStar() Then Return
	AttackTHGrid($eBarb, 3, Random(4, 5, 1), 1000, 1, 5, 0) ; deploys up to 12-15 barbarians
		If CheckOneStar() Then Return
	AttackTHGrid($eBarb, 4, Random(4, 5, 1), 1500, 1, 5, 0) ; deploys up to 16-20 barbarians
		If CheckOneStar() Then Return
	AttackTHGrid($eArch, 3, 8, 1200, 3, 4, 0) ; deploys 24 archers
		If CheckOneStar() Then Return
	AttackTHGrid($eArch, 4, 7, 1000, 3, 4, 0) ; deploys 28 archers

	For $count = 0 To 30
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next

	Setlog("Hope the rest of your troops can finish the job!")
	    If  $optSpellNone = 1  Then
	       Switch $optSpellType
	       Case 0
		  local $spell = $eLSpell

	       Case 1
		  local $spell = $eHSpell

	      Case 2
		  local $spell = $eRSpell

	       EndSwitch
	      SpellTHGrid($spell)
	    EndIf
		If CheckOneStar() Then Return
	AttackTHGrid($eGiant, 2, 9, 100, 3, 2, 1) ;deploys 18 giants
		If CheckOneStar() Then Return
	AttackTHGrid($eCastle,1,1,100,4,1,0) ; deploys CC
		If CheckOneStar() Then Return
	AttackTHGrid($eKing,1,1,100,4,1,0) ; deploys King
		If CheckOneStar() Then Return
	AttackTHGrid($eQueen,1,1,100,4,1,0) ; deploys Queen
		If CheckOneStar() Then Return
	AttackTHGrid($eBarb, 4, 8, 100, 2, 5, 0) ; deploys up to 32 barbarians
		If CheckOneStar() Then Return
	AttackTHGrid($eArch, 3, 13, 100, 4, 4, 0) ;deploys up to 39 archers
		If CheckOneStar() Then Return
	AttackTHGrid($eBarb, 3, 11, 100, 2, 5, 0) ; deploys up to 33 barbarians
		If CheckOneStar() Then Return
	AttackTHGrid($eArch, 2, 20, 100, 4, 4, 0) ;deploys up to 40 archers
		If CheckOneStar() Then Return
	AttackTHGrid($eBarb, 4, 9, 100, 2, 5, 0) ; deploys up to 36 barbarians
		If CheckOneStar() Then Return
	AttackTHGrid($eArch, 2, 20, 100, 4, 4, 0) ;deploys up to 40 archers

	For $count = 0 To 35
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next

	SetLog("All Giants, Barbs, and Archers should be deployed, in addition to Heroes & CC (if options are selected). Other troops are not meant to be deployed in this algorithm.", $COLOR_GREEN)
EndFunc   ;==>AttackTHGbarch

Func CheckOneStar()
	;Check Heroes Health
	CheckHeroesHealth()
	;check for one star
	If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
	SetLog("Townhall has been destroyed!",$COLOR_ORANGE)

	;Activate King and Queen powers to restore health before exit if they are deployed
	If $checkKPower = True Then
		SelectDropTroop($King)
		$checkKPower = False
	EndIf

	If $checkQPower = True Then
		SelectDropTroop($Queen)
		$checkQPower = False
	EndIf

	If _Sleep(1000) Then Return ;wait 1 seconds... antiban purpose...
	Return True ;exit if you get a star
	Else
	Return False
	EndIf
	;end check for one star
EndFunc

Func AttackTHSmartBarch()
SetLog($thinfo)
;;;;; Created by swvr ;;;;;;;;  Modified by The Master

Setlog("Sniping TH with SmartBarch",$COLOR_BLUE)

;AttackTHGrid($troopKind, $spots, $numperspot, $Sleep, $waveNb, $maxWaveNb, $BoolDropHeroes)

; 1st wave 30 secs, total 4 barbs 8 archers, works for totally unprotected TH ___________________________________________________________________________________________
SetLog("Attacking TH with 1st wave of BARCH", $COLOR_BLUE)

AttackTHGrid($eBarb,4,1,2000,1,4,0) ; deploys 4 barbarians to take out traps waits 2 seconds for bombs to go off
    If CheckOneStar() Then Return
AttackTHGrid($eArch,2,4,1000,1,4,0) ; deploys 8 archers

For $count = 0 To 27
	If CheckOneStar() Then Return
	If _Sleep(1000) Then Return
Next

; 2nd wave 25 secs total 16 barbs, 22 archers, works for TH partially covered by defenses _______________________________________________________________________________
SetLog("Attacking TH with 2nd wave of BARCH", $COLOR_BLUE)

AttackTHGrid($eBarb,4,2,1000,2,4,0) ; deploys 8 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,2,5,1000,2,4,0) ; deploys 10 archers
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,4,2,1000,2,4,0) ; deploys 8 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,4,3,1000,2,4,0) ; deploys 12 archers


For $count = 0 To 20
	If CheckOneStar() Then Return
	If _Sleep(1000) Then Return
Next

;---3nd wave 17 secs (rather short interval until ALL IN) total 2 giants, 30 barbs, 57 archers ______________________________________________________________________
SetLog("Oh Shit! Seems like a trapped TH!", $COLOR_BLUE)
AttackTHGrid($eGiant,2,1,200,3,4,0) ; deploys 2 giants as meat shield
    If CheckOneStar() Then Return
AttackTHGrid($eKing,1,1,100,4,1,0) ; deploys king
    If CheckOneStar() Then Return
AttackTHGrid($eQueen,1,1,100,4,1,0) ; deploys queen
    If CheckOneStar() Then Return
AttackTHGrid($eCastle,1,1,100,4,1,0) ; deploys cc
    If CheckOneStar() Then Return
SpellTHGrid($eRSpell)
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,3,3,200,3,4,0) ; deploys 9 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,3,5,200,3,4,0) ; deploys 15 archers
	If CheckOneStar() Then Return
AttackTHGrid($eBarb,3,3,200,3,4,0) ; deploys 9 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,3,6,200,3,4,0) ; deploys 18 archers
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,4,3,200,3,4,0) ; deploys 12 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,4,6,200,3,4,0) ; deploys 24 archers
    If CheckOneStar() Then Return
SpellTHGrid($eHSpell)


For $count = 0 To 15
	If CheckOneStar() Then Return
	If _Sleep(1000) Then Return
Next

;---4th wave 20 secs throw in everything ______________________________________________________________________________________________________________________________
Setlog("Dammit! ALL IN!", $COLOR_BLUE)

AttackTHGrid($eArch,2,10,100,4,4,0) ; deploys 20 archers
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,2,10,100,4,4,0) ; deploys 20 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eGiant,3,10,100,4,4,0) ; deploys 30 giants
    If CheckOneStar() Then Return
AttackTHGrid($eGobl,2,10,100,4,4,0) ; deploys 20 goblins
    If CheckOneStar() Then Return
AttackTHGrid($eWiza,2,10,100,4,4,0) ; deploys 20 wizards
    If CheckOneStar() Then Return
AttackTHGrid($eMini,2,10,100,4,4,0) ; deploys 20 minions
    If CheckOneStar() Then Return
AttackTHGrid($eArch,2,10,100,4,4,0) ; deploys 20 archers
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,2,10,100,4,4,0) ; deploys 20 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,2,10,100,4,4,0) ; deploys 20 archers
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,2,10,100,4,4,0) ; deploys 20 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,4,10,100,4,4,0) ; deploys 40 archers
    If CheckOneStar() Then Return
AttackTHGrid($eBarb,4,10,100,4,4,0) ; deploys 40 barbarians
    If CheckOneStar() Then Return
AttackTHGrid($eArch,4,10,600,4,4,0) ; deploys 40 archers


SetLog("All troops deployed and waiting for a star...",$COLOR_BLUE)

For $count = 0 To 15
	If CheckOneStar() Then Return
	If _Sleep(1000) Then Return
Next

If _Sleep(100) Then Return
SetLog("~Finished Attacking, waiting to finish",$COLOR_GREEN)
EndFunc   ;==>AttackTHSmartBarch


Func AttackTrappedTH()
	$TrappedAllIn = False
	SetLog($thinfo)
	AttackTHGrid($eArch,4,1,2000,1,5,0) ; deploys 4 archers to "reveal" teslas or bombs
	AttackTHGrid($eGiant,2,1,850,1,4,0) ;releases 2 giants to trigger spring traps
	AttackTHGrid($eGiant,1,2,1200,2,4,0) ;releases 2 giants
	AttackTHGrid($eArch,2,8,950,2,5,0) ; deploys 16 archers

	For $count = 0 To 20
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next
	
	SetLog("Still Not DesTroyed The Traps Send More Troop!")
	; while giants are distracting, loop through barb/arch until you get a star
	    If  $optSpellNone = 1  Then
	       Switch $optSpellType
	       Case 0
		  local $spell = $eLSpell

	       Case 1
		  local $spell = $eHSpell

	      Case 2
		  local $spell = $eRSpell

	       EndSwitch
	      SpellTHGrid($spell)
	    EndIf
	AttackTHGrid($eGiant,2,3,1250,3,4,0) ; deploys 6 giant
	AttackTHGrid($eBarb,2,4,1020,1,3,0) ; deploys up to 12 barbarians
	AttackTHGrid($eArch,3,8,950,3,5,0) ; deploys 24 archers
	
	For $count = 0 To 20
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next
	
	SetLog("Are u Kidding Me What Kind Of Traps Is That Let Me Do This!")
	    If  $optSpellNone = 1  Then
	       Switch $optSpellType
	       Case 0
		  local $spell = $eLSpell

	       Case 1
		  local $spell = $eHSpell

	      Case 2
		  local $spell = $eRSpell

	       EndSwitch
	      SpellTHGrid($spell)
	    EndIf
	AttackTHGrid($eGiant,3,2,500,4,4,0) ; deploys 6 giant
	AttackTHGrid($eKing,1,1,100,4,1,0) ; deploys King
	AttackTHGrid($eQueen,1,1,100,4,1,0) ; deploys Queen
	AttackTHGrid($eCastle,1,1,100,4,1,0) ; deploys CC
	AttackTHGrid($eBarb,3,4,100,2,3,0) ; deploys up to 12 barbarians
	AttackTHGrid($eArch,2,8,100,4,5,0) ; deploys 16 archers
	
	For $count = 0 To 20
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next
	
	SetLog("I Hate To Do This But I Need To Destroy All Traps Send More Troops!")
	    If  $optSpellNone = 1  Then
	       Switch $optSpellType
	       Case 0
		  local $spell = $eLSpell

	       Case 1
		  local $spell = $eHSpell

	      Case 2
		  local $spell = $eRSpell

	       EndSwitch
	      SpellTHGrid($spell)
	    EndIf
	AttackTHGrid($eBarb,3,4,100,3,3,0) ; deploys up to 12 barbarians
	AttackTHGrid($eArch,3,5,100,5,5,0) ; deploys 15 archers

	_Sleep(Random(700,1350))
	
	For $count = 0 To 20
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next

	Setlog("This Is Hard TH This Is The Last Sending All Troops")

	For $i = $eGole To $eLava ; Deploy Remaining troops
		AttackTHGrid($i,5,2,2000,0,4,0)
	Next

	If CheckOneStar() Then Return

	For $i = $eGiant To $eValk ; Deploy Remaining troops
		AttackTHGrid($i,6,5,2000,0,4,0)
	Next

	If CheckOneStar() Then Return

	For $i = $eBarb To $eArch ; Deploy Remaining Barb,archers
		AttackTHGrid($i,5,15,2000,0,4,0)
	Next
	
	For $count = 0 To 20
		If CheckOneStar() Then Return
		If _Sleep(1000) Then Return
	Next
	
	SetLog("~Finished Attacking, waiting to finish", $COLOR_GREEN)
EndFunc ;---AttackTrappedTH

Func ALLDropheroes($x, $y)
	dropHeroes($x, $y, $King, $Queen)
	If _Sleep($iDelayALLDropheroes1) Then Return

	dropCC($x, $y, $CC)

	If _Sleep($iDelayALLDropheroes2) Then Return

	;Activate KQ's power
	If $checkKPower Or $checkQPower Then
		SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating King/Queen", $COLOR_ORANGE)
		If _Sleep($delayActivateKQ) Then Return
		If $checkKPower Then
			SetLog("Activate King's power", $COLOR_BLUE)
			SelectDropTroop($King)
		EndIf
		If $checkQPower Then
			SetLog("Activate Queen's power", $COLOR_BLUE)
			SelectDropTroop($Queen)
		EndIf
	EndIf
EndFunc   ;==>ALLDropheroes

Func SpellTHGrid($S)
   Setlog("start spell SpellTHGride " &$S)
	If $THi <= 84 Or $THside = 0 Or $THside = 2 Then
	    Switch $THside
		Case 0
		   If $THx <=200 and $Thy < 326 and $Thy > 318 then  ; In Left Corner
		      If $optSpellType = 0 Then
			 CastSpell($S,$THx,$THy)
		      EndIf
			CastSpell($S,55,314) ; Left Corner
		     Else
			If $THy < 110 and $THx > 425 and $THx < 435 then ; In Top Corner
			   If $optSpellType = 0 Then
			      CastSpell($S,$THx,$THy)
			   EndIf
			   CastSpell($S,428,50) ; Top Corner
			Else
			   If $optSpellType = 0 Then
			      CastSpell($S,$THx,$THy)
			   EndIf
			   ;$aThx = 430 - ($ii * 4)
			   ;$aThy = 30 + ($ii * 3)
			   CastSpell($S, 430 - ($THi * 4) + 8 , 30 + ($THi * 3)+6) ;Along Side
			EndIf
		     EndIf

		  Case 1
		      If $THx <=200 and $Thy < 326 and $Thy > 318 then  ; In Left Corner
			 If $optSpellType = 0 Then
			   CastSpell($S,$THx,$THy)
			   EndIf
			CastSpell($S,55,314) ; Left Corner
		     Else
			If $optSpellType = 0 Then
			 CastSpell($S,$THx,$THy)
			EndIf
			CastSpell($S, 70 + ($THi * 4) , 295 + ($THi * 3)) ;Along Side
		     EndIf

		  Case 2
			If $THy < 110 and $THx > 425 and $THx < 435 then ; In Top Corner
			   If $optSpellType = 0 Then
			      CastSpell($S,$THx,$THy)
			   EndIf
			      CastSpell($S,428,50) ; TopCorner
			Else
			      If $THx >=700 and $Thy < 3326 and $Thy > 318 then  ; In Right Corner
				 If $optSpellType = 0 Then
				    CastSpell($S,$THx,$THy)
				 EndIf
				 CastSpell($S,790,314) ; Right Corner
			      Else
				    If $optSpellType = 0 Then
				       CastSpell($S,$THx,$THy)
				    EndIf
				 CastSpell($S, 410 + ($THi * 4) , 50 + ($THi * 3)) ;Along Side
			      EndIf
			EndIf

		     Case 3
			If $THx >=700 and $Thy < 326 and $Thy > 318 then  ; In Right Corner
			   If $optSpellType = 0 Then
			      CastSpell($S,$THx,$THy)
			   EndIf
			   CastSpell($S,790,314) ; Right Corner
			Else
			   If $optSpellType = 0 Then
			      CastSpell($S,$THx,$THy)
			   EndIf
			   CastSpell($S, 790 - ($THi * 4) , 295 + ($THi * 3)) ;Along Side
			EndIf

	    EndSwitch
	 Else
	    If $THi > 84 And ($optSpellType =1 or $optSpellType = 2) Then
		  If ($THside = 1 Or $THside = 3) And $zoomedin = True Then
			CastSpell($S,730,430)
		  EndIf
	    EndIf
	 EndIf
EndFunc   ;==>SpellTHGrid

Func CastSpell($THSpell, $x, $y)
	Local $Spell = -1
	Local $name = ""
	For $i = 0 To UBound($atkTroops) - 1
		If $atkTroops[$i][0] = $THSpell Then
			$Spell = $i
			$name = NameOfTroop($THSpell, 0)
		EndIf
	Next

	If ($Spell = -1) Then Return False
	If $Spell > -1 Then
		SetLog("Dropping " & $name & " Spell!")
		SelectDropTroop($Spell)
		If _Sleep($iDelayCastSpell1) Then Return
		Click($x, $y, 1, 0, "#0029")
	Else
		SetLog("No " & $name & " Found")
	EndIf
EndFunc   ;==>CastSpell

Func ModerateZoomed($numperspot, $spots)
	Local $count

	;Zooming and scrolling _______________________________________________________________
	If ($THside = 1 Or $THside = 3) And $zoomedin = False Then
		SetLog("Attacking Th With Master Moderate Zoomed Mod ...")
		;Few zooming and Scrolling to bottom
		SetLog("Zooming in a little and scrolling to bottom ...")
		SendKeepActive($Title)
    	While $zCount < 2 And $sCount < 2  ; 2 Zooms and scrolls only
			ControlSend($Title, "", "", "{UP}")
			If _Sleep(1000) Then Return
			ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
			If _Sleep(1000) Then Return
			$zCount += 1
			$sCount += 1
		WEnd
		SendKeepActive("")
		If $debugSetlog = 1 Then SetLog("Done zooming and Scrolling.")
		_Sleep(5000)
		$zoomedin = True
	EndIf
	;End zooming and scrolling ____________________________________________________________

	;Attacking ____________________________________________________________________________
	If $THi = 81 And $Thx > 400 And $Thx < 455 And $Thy > 450 And $Thy < 580 Then
		If $debugSetlog = 1 Then Setlog("Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
		For $count = 1 To $numperspot * $spots

			If CheckOneStar() Then Return
			Click(Random(460, 560, 1), Random(564, 566, 1))
			If _Sleep(Random(30, 60)) Then Return
		Next
	Else
		If $THside = 1 Then
			If $debugSetlog = 1 Then Setlog("Left Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots

				If CheckOneStar() Then Return
				Click(Random(290, 340, 1), Random(564, 566, 1))
				If _Sleep(Random(30, 60)) Then Return
			Next
		EndIf
		If $THside = 3 Then
			If $debugSetlog = 1 Then Setlog("Right Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				If CheckOneStar() Then Return
				Click(Random(630, 700, 1), Random(564, 566, 1))
				If _Sleep(Random(30, 60)) Then Return
			Next
		EndIf
	EndIf
EndFunc   ;==>ModerateZoomed

Func SideSnipe($numperspot, $spots)
	Local $count
	Local $i = 0
    SetLog("Attacking Th With Master No Zoom side attack Mod ...")
	;Attacking ________________________________________________________________________
	If $THi > 81 And $Thx > 400 And $Thx < 455 And $Thy > 450 And $Thy < 580 Then
		If $debugSetlog = 1 Then Setlog("Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
		For $count = 1 To $numperspot * $spots
			If $i = 0 Then
				If CheckOneStar() Then Return
				Click(Random(355, 365, 1), Random(564, 566, 1))
				$i = 1
			Else
				If CheckOneStar() Then Return
				Click(Random(488, 500, 1), Random(564, 566, 1))
				$i = 0
			EndIf
			If _Sleep(Random(30, 60)) Then Return
		Next
	Else
		If $THside = 1 Then
			If $debugSetlog = 1 Then Setlog("Left Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				If CheckOneStar() Then Return
				Click(Random($Thx - 70, $Thx - 40, 1), Random(564, 566, 1))
				If _Sleep(Random(30, 60)) Then Return
			Next
		EndIf

		If $THside = 3 Then
			If $debugSetlog = 1 Then Setlog("Right Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				If CheckOneStar() Then Return
				Click(Random($Thx + 40, $Thx + 70, 1), Random(564, 566, 1))
				If _Sleep(Random(30, 60)) Then Return
			Next
		EndIf
	EndIf
EndFunc   ;==>SideSnipe