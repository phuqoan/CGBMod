#cs ----------------------------------------------------------------------------
	AutoIt Version: 3.3.6.1
	This file was made to software CoCgameBot v2.0
	Author: Zombie  ( Modified By The Master)

	Script Function: BetterWallFind
	CoCgameBot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
	CoCgameBot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
	You should have received a copy of the GNU General Public License along with CoCgameBot.  If not, see ;<http://www.gnu.org/licenses/>.
#ce ----------------------------------------------------------------------------

Func BetterWallFind()

	SetLog("Using Zombie additional wall find", $COLOR_GREEN)

	Local $WallPos
	Local $WallX, $WallY


	;Additional Wall Finding
	If _Sleep(500) Then Return
	_CaptureRegion()
	Local $WallLoopCounter = 0

	For $icountWalls = 6 To 10

		For $ImageIndex = 0 To 2
			If Not FileExists($Wall[$icmbWalls][$ImageIndex]) Then
				SetLog("File Not Found", $COLOR_RED)
				Return False
			EndIf
			$res = ""

			If _Sleep(500) Then Return
			_CaptureRegion()
			$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
			$res = DllCall($LibDir & "\ImageSearch.dll", "str", "searchTile", "handle", $sendHBitmap, "str", $Wall[$icmbWalls][$ImageIndex], "float", ($icountWalls * 0.1)) ; MrPhu's modify
			_WinAPI_DeleteObject($sendHBitmap)

			If IsArray($res) Then
				;SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
				If $res[0] = "0" Then
					; failed to find any wall of current Level
					$res = ""
				ElseIf $res[0] = "-1" Then
					SetLog("DLL Error", $COLOR_RED)
					Return False
				Else

					$expRet = StringSplit($res[0], "|", 2)
					For $j = 1 To UBound($expRet) - 1 Step 2
						$WallX = Int($expRet[$j])
						$WallY = Int($expRet[$j + 1])

						If IsInsideDiamondXY($WallX, $WallY) Then
							If $debugSetlog = 1 Then
								SetLog("Wall level: " & $icmbWalls + 4 & " • Position: [" & $WallX & "," & $WallY & "], Verifying..", $COLOR_PURPLE)
							Else
								SetLog("Wall level: " & $icmbWalls + 4 & ", Verifying..", $COLOR_GREEN)
							EndIf

							GemClick($WallX, $WallY, 1, 0, "#0122")
							If _Sleep(500) Then Return
							$sBldgName = getNameBuilding(250, 520) ; Get Unit name and level with OCR
							If $sBldgName = "" Then ; try a 2nd time after a short delay if slow PC
								If _Sleep(1000) Then Return
								$sBldgName = getNameBuilding(250, 520) ; Get Unit name and level with OCR
							EndIf


							$aString = StringSplit($sBldgName, "(") ; Spilt the name and building level
							If $aString[0] = 2 Then ; If we have name and level then use it
								If $aString[2] <> "" Then ; check for bad read of level
									$sBldgLevel = $aString[2] ; store level text
									$aString = StringSplit($sBldgLevel, ")") ;split off the closing parenthesis
									If $aString[0] = 2 Then ; If we have "level XX" cleaned up
										If $aString[1] <> "" Then $sBldgLevel = $aString[1] ; store "level XX"
									EndIf
									$aString = StringSplit($sBldgLevel, " ") ;split off the level number
									If $aString[0] = 2 Then ; If we have level number then use it
										If $aString[2] <> "" And Number($aString[2]) = $icmbWalls + 4 Then Return True
									EndIf
								EndIf
							EndIf
						EndIf
						$WallLoopCounter += 1
						If ($WallLoopCounter > 4) Then ExitLoop
					Next
				EndIf
				If _Sleep(250) Then Return
			EndIf
		Next

	Next

EndFunc   ;==>BetterWallFind
