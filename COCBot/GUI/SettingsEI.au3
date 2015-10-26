$settingsMenu = GUICtrlCreateMenu("&Settings")

$exportMenuItem = GUICtrlCreateMenuItem("Export to Clipboard", $settingsMenu)
 GUICtrlSetOnEvent(-1, "copySettingsToClip")
$importMenuItem = GUICtrlCreateMenuItem("Import from Clipboard", $settingsMenu)
 GUICtrlSetOnEvent(-1, "importSettingsFromClip")

Func copySettingsToClip()

   $configSettings = FileRead($config, -1)
   $buildingSettings = FileRead($building, -1)
   $settingsStr = $configSettings
   ClipPut ($settingsStr)
   MsgBox($MB_SYSTEMMODAL, "Info", "Settings copied to clipboard, ready to paste in forum.")

EndFunc

Func importSettingsFromClip()

If $RunState Then
        MsgBox($MB_SYSTEMMODAL, "Info", "Please stop the bot before importing settings.")
Else
    local $hFile
    If MsgBox($MB_YESNO, "Are you sure", "This will overwrite your current settings with what you've copied to your clipboard, are you sure? (it is recommended you make copies of your settings first or switch profiles)") = $IDYES Then
        if UBound($settingsArr) = 3 then
          $hFile = FileOpen($config, $FO_OVERWRITE)
          FileWrite($hFile, $settingsArr[1])
          FileClose($hFile)

		readConfig()
		applyConfig()
        Else
          MsgBox($MB_SYSTEMMODAL, "Not Settings", "You didn't copy settings to your clipboard. Copy settings and try again.")
        EndIf
	EndIf
EndIf

EndFunc