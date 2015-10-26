
; #FUNCTION# ====================================================================================================================
; Name ..........: SearchTownHallLoc
; Description ...:
; Syntax ........: SearchTownHallLoc()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #5
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func SearchTownHallLoc()
   If $searchTH <> "-" Then
        ;If FilterTH()=False Then Return False  ;already cked in functions, image search, check Townhall.au3
Local $i =0
$SearchTHLoc = 0

Local $Ax = 0
Local $Ay = 0
Local $Bx = 0
Local $By = 0

Local $AAx = 0
Local $AAy = 0
Local $BBx = 0
Local $BBy = 0
;force tile gap to range allowed 0 to 4
If $THaddtiles < 0 then
$THaddtiles =0
EndIf

If $THaddtiles > 4 then
   $THaddtiles =4
EndIf

; (Bx - Ax) * (Cy-Ay) - (By-Ay) * (Cx -Ax) result is either neg or pos or zero... neg is one side of line, pos number is the other, zero is on the line
;       for point A(x,y) B(x,y) - this forms the line and point C(x,y) the point off line ie the TH and line AB being the limit

For $z = 0 to 4 ;search from the outside edges towards center, finds closet edge to attack from
      Local $A[4][2] = [ [429 , 76 ] , [ 114 , 298 ] , [ 412 , 73 ] , [ 740 , 290 ] ] 	; $A [4][2] = [[S0TOPx,S0TOPy]   , [S1LEFTx,S1LEFTy]            , [S2TOPx,S2TOPy]        , [S3RIGHTx,S3RIGHTy]]
      Local $B[4][2] = [ [91 , 328 ] , [ 474 , 568 ] , [ 741  , 320 ] , [ 428 , 525 ] ]	; $B [4][2] = [[S0LEFTx,S0LEFTy] , [S1BOTTOMx,S1BOTTOMy] , [S2RIGHTx,S2RIGHTy] , [S3BOTTONx,S3BOTTOMy]]
      $lmtSide0 = (($B[0][0] - $A[0][0])*($THy - $A[0][1])) - (($B[0][1]-$A[0][1])*($THx-$A[0][0]))
      $lmtSide1 = (($B[1][0] - $A[1][0])*($THy - $A[1][1])) - (($B[1][1]-$A[1][1])*($THx-$A[1][0]))
      $lmtSide2 = (($B[2][0] - $A[2][0])*($THy - $A[2][1])) - (($B[2][1]-$A[2][1])*($THx-$A[2][0]))
      $lmtSide3 = (($B[3][0] - $A[3][0])*($THy - $A[3][1])) - (($B[3][1]-$A[3][1])*($THx-$A[3][0]))

If $z =1 and $THaddtiles >=1 then
      Local $A[4][2] = [ [439 , 80 ] , [ 126 , 293 ] , [ 404 , 82 ] , [ 730 , 284 ] ] 	; $A [4][2] = [[S0TOPx,S0TOPy]   , [S1LEFTx,S1LEFTy]            , [S2TOPx,S2TOPy]        , [S3RIGHTx,S3RIGHTy]]
      Local $B[4][2] = [ [106 , 335 ] , [ 484 , 551 ] , [ 732  , 327 ] , [ 518 , 519 ] ]	; $B [4][2] = [[S0LEFTx,S0LEFTy] , [S1BOTTOMx,S1BOTTOMy] , [S2RIGHTx,S2RIGHTy] , [S3BOTTONx,S3BOTTOMy]]
      $lmtSide0 = (($B[0][0] - $A[0][0])*($THy - $A[0][1])) - (($B[0][1]-$A[0][1])*($THx-$A[0][0]))
      $lmtSide1 = (($B[1][0] - $A[1][0])*($THy - $A[1][1])) - (($B[1][1]-$A[1][1])*($THx-$A[1][0]))
      $lmtSide2 = (($B[2][0] - $A[2][0])*($THy - $A[2][1])) - (($B[2][1]-$A[2][1])*($THx-$A[2][0]))
      $lmtSide3 = (($B[3][0] - $A[3][0])*($THy - $A[3][1])) - (($B[3][1]-$A[3][1])*($THx-$A[3][0]))
Endif

If $z =2 and $THaddtiles >=2 then
      Local $A[4][2] = [ [447 , 88 ] , [ 136 , 288 ] , [ 392 , 81 ] , [ 719 , 277 ] ] 	; $A [4][2] = [[S0TOPx,S0TOPy]   , [S1LEFTx,S1LEFTy]            , [S2TOPx,S2TOPy]        , [S3RIGHTx,S3RIGHTy]]
      Local $B[4][2] = [ [115 , 342 ] , [ 493 , 554 ] , [ 722  , 332 ] , [ 410 , 510 ] ]	; $B [4][2] = [[S0LEFTx,S0LEFTy] , [S1BOTTOMx,S1BOTTOMy] , [S2RIGHTx,S2RIGHTy] , [S3BOTTONx,S3BOTTOMy]]
      $lmtSide0 = (($B[0][0] - $A[0][0])*($THy - $A[0][1])) - (($B[0][1]-$A[0][1])*($THx-$A[0][0]))
      $lmtSide1 = (($B[1][0] - $A[1][0])*($THy - $A[1][1])) - (($B[1][1]-$A[1][1])*($THx-$A[1][0]))
      $lmtSide2 = (($B[2][0] - $A[2][0])*($THy - $A[2][1])) - (($B[2][1]-$A[2][1])*($THx-$A[2][0]))
      $lmtSide3 = (($B[3][0] - $A[3][0])*($THy - $A[3][1])) - (($B[3][1]-$A[3][1])*($THx-$A[3][0]))
Endif

If $z =3 and $THaddtiles >=3 then
      Local $A[4][2] = [ [455 , 95 ] , [ 153 , 271 ] , [ 384 , 94 ] , [ 710 , 270 ] ] 	; $A [4][2] = [[S0TOPx,S0TOPy]   , [S1LEFTx,S1LEFTy]            , [S2TOPx,S2TOPy]        , [S3RIGHTx,S3RIGHTy]]
      Local $B[4][2] = [ [123 , 348 ] , [ 515 , 539 ] , [ 711  , 340 ] , [ 400 , 503 ] ]	; $B [4][2] = [[S0LEFTx,S0LEFTy] , [S1BOTTOMx,S1BOTTOMy] , [S2RIGHTx,S2RIGHTy] , [S3BOTTONx,S3BOTTOMy]]
      $lmtSide0 = (($B[0][0] - $A[0][0])*($THy - $A[0][1])) - (($B[0][1]-$A[0][1])*($THx-$A[0][0]))
      $lmtSide1 = (($B[1][0] - $A[1][0])*($THy - $A[1][1])) - (($B[1][1]-$A[1][1])*($THx-$A[1][0]))
      $lmtSide2 = (($B[2][0] - $A[2][0])*($THy - $A[2][1])) - (($B[2][1]-$A[2][1])*($THx-$A[2][0]))
      $lmtSide3 = (($B[3][0] - $A[3][0])*($THy - $A[3][1])) - (($B[3][1]-$A[3][1])*($THx-$A[3][0]))
Endif

If $z =4 and $THaddtiles >=4 then
      Local $A[4][2] = [ [455 , 107 ] , [ 165 , 271 ] , [ 384 , 94 ] , [ 701 , 263 ] ] 	; $A [4][2] = [[S0TOPx,S0TOPy]   , [S1LEFTx,S1LEFTy]            , [S2TOPx,S2TOPy]        , [S3RIGHTx,S3RIGHTy]]
      Local $B[4][2] = [ [132 , 348 ] , [ 515 , 548 ] , [ 711  , 340 ] , [ 391 , 497 ] ]	; $B [4][2] = [[S0LEFTx,S0LEFTy] , [S1BOTTOMx,S1BOTTOMy] , [S2RIGHTx,S2RIGHTy] , [S3BOTTONx,S3BOTTOMy]]
      ;side 0 and side2 (top half) runs a bit deep so points from 3 tile gap applied to 4 tile gap for side 0 and 2 only
      $lmtSide0 = (($B[0][0] - $A[0][0])*($THy - $A[0][1])) - (($B[0][1]-$A[0][1])*($THx-$A[0][0]))
      $lmtSide1 = (($B[1][0] - $A[1][0])*($THy - $A[1][1])) - (($B[1][1]-$A[1][1])*($THx-$A[1][0]))
      $lmtSide2 = (($B[2][0] - $A[2][0])*($THy - $A[2][1])) - (($B[2][1]-$A[2][1])*($THx-$A[2][0]))
      $lmtSide3 = (($B[3][0] - $A[3][0])*($THy - $A[3][1])) - (($B[3][1]-$A[3][1])*($THx-$A[3][0]))
Endif


For $i=0 to 100 ; makes 97 tiny slices of the the sides and finds which slice the Town hall is in.. Used later in the attack as $THi
$Ax = 430 -(4*$i)
$Ay = 15  +(3*$i)
$Bx = 830 -(4*$i)
$By = 315 +(3*$i)

$AAx = 430 -(4*($i+1))
$AAy = 15  +(3*($i+1))
$BBx = 830 -(4*($i +1))
$BBy = 315 +(3*($i+1))

$THLimit0 = (($Bx - $Ax) * ($THy - $Ay)) - (($By -  $Ay) * ($THx -  $Ax))
$THLimit1 = (($BBx - $AAx) * ($THy - $AAy)) - (($BBy -  $AAy) * ($THx -  $AAx))
; Side 0
;Setlog ("side 0 - Thi,"&$i&"  limit0 > "&$THLimit0&" limit1 < "&$THLimit1&" limit side >"&$lmtSide0)
		 If $THLimit0 >= 0 And $THLimit1 <= 0 And  $lmtSide0 >=0 Then
			$THi=$i  ; TH index  used to locate postion on side
			$THside=0 ;  the side the TH is on, 0 upper left, 1 bottom left, 2 upper right, 3 bottom right
			$SearchTHLoc = 1 ; <=== used instead of calling this function three other times per attack.
			Return True
		     EndIf
 ;side 3
;Setlog ("side 3 - Thi,"&$i&"  limit0 > "&$THLimit0&" limit1 < "&$THLimit1&" limit side >"&$lmtSide3)
		If $THLimit0 >= 0 And $THLimit1 <= 0 And  $lmtSide3 <=0 Then
			$THi=$i
			$THside=3
			$SearchTHLoc = 1
			Return True
		     EndIf

$Ax = 30 +(4*$i)
$Ay = 315  +(3*$i)
$Bx = 430 +(4*$i)
$By = 15 +(3*$i)

$AAx = 30+(4*($i+1))
$AAy = 315+(3*($i+1))
$BBx = 430+(4*($i +1))
$BBy = 15+(3*($i+1))

$THLimit2 =(($Bx - $Ax) * ($THy - $Ay)) - (($By -  $Ay) * ($THx -  $Ax))
$THLimit3 =(($BBx - $AAx) * ($THy - $AAy)) - (($BBy -  $AAy) * ($THx -  $AAx))
;side 2
;Setlog ("side 2 - Thi,"&$i&"  limit2 > "&$THLimit2&" limit3 < "&$THLimit3&" limit side >"&$lmtSide2)
    If $THLimit2 >= 0 And $THLimit3 <= 0 And  $lmtSide2 <=0  Then
			$THi=$i
			$THside=2
			$SearchTHLoc = 1
			Return True
		     EndIf
;side 1
;Setlog ("side 1 - Thi,"&$i&"  limit2 > "&$THLimit2&" limit3 < "&$THLimit3&" limit side >"&$lmtSide1)
    If $THLimit2 >= 0 And $THLimit3 <= 0 And   $lmtSide1 >=0  Then
			$THi=$i
			$THside=1
			$SearchTHLoc = 1
			Return True
		     EndIf
		  Next
	       Next
EndIf
	Return False
EndFunc ;--- SearchTownHallLoc

Func FilterTH()
   	  For $i=0 to 20
		 If $Thx<52+$i*19 And $Thy<315-$i*14 Then Return False
		 If $Thx<52+$i*19 And $Thy>315+$i*14 Then Return False
 		 If $Thx>802-$i*19 And $Thy<315-$i*14 Then Return False
		 If $Thx>802-$i*19 And $Thy>315+$i*14 Then Return False
	  Next
			Return True
EndFunc

