;--------------------------------------------------------------------- ;
; ------------------------ Function List --------------------------- ;
;--------------------------------------------------------------------- ;
;BeginBuy() - Opens The AH, selects equpment, sets static search variables
;SearchConfig() - Enters the initial search configuration: Quality, Type, Stat 1, Stat 2, Stat 3
;SearchAH() - Searches AH
;Buyout() - Attempts to Buyout

; ------------------------ AuctionHouse Variables --------------------------- ;
Dim $SearchCount = 0
Dim $Buys = 0
Dim $Buyout = 0


; ------------------------ Hotkey Setup --------------------------- ;
Dim $Started = False
Dim $Paused

HotKeySet("=","Start")  ;script can START by pressing =
HotKeySet("-", "Pause") ;script can be Pause by pressing -
HotKeySet("x", "Stop") ;script can be Stopped by pressing x

;--------------------------------------------------------------------- ;
; ------------------------ Main Loop --------------------------- ;
;--------------------------------------------------------------------- ;
While(1=1)
   if($Started) Then
	  BeginAH()
	  Buy()
   EndIf
WEnd

;--------------------------------------------------------------------- ;
; ------------------------ Functions --------------------------- ;
;--------------------------------------------------------------------- ;

; ------------------------ Auction House Functions - General --------------------------- ;
Func BeginAH()
   Sleep(100)
   Send("{SPACE}")
   MouseClick("left",135,354,1) ;AH
EndFunc

Func SearchConfig()
   If $SearchCount = 0 Then
	  MouseClick("left",183,331,1,1) ;Crit Hit DMG
	  MouseMove(255,371,1)
	  MouseDown("left")
	  MouseMove(258,392,1)
	  MouseUp("left")
	  MouseClick("left",147,446,1,1)
	  
	  MouseClick("left",212,329,1,1)
	  Send("80")
	  
	  MouseClick("left",184,350,1,1) ;STR
	  MouseMove(255,389,1)
	  MouseDown("left")
	  MouseMove(253,498,1)
	  MouseUp("left")
	  MouseClick("left",143,428,1,1)
	  MouseClick("left",217,350,1,1)
	  Send("150")
	  
	  MouseClick("left",183,371,1) ;lifesteal
	  MouseMove(255,411)
	  MouseDown("left")
	  MouseMove(260,479)
	  MouseUp("left")
	  MouseClick("left",135,449,1)
	  
	  MouseClick("left",184,392,1,1) ;has socket
	  MouseMove(255,435,1)
	  MouseDown("left")
	  MouseMove(252,576,1)
	  MouseUp("left")
	  MouseClick("left",137,546,1,1)
	  
	  $buyout = random(200000,250000,1)
   ElseIf mod($SearchCount,2) = 1 Then
	  MouseClick("left",182,371,1,1)
	  MouseClick("left",144,435,1,1)
	  MouseMove(204,371,1)
	  MouseDown("left")
	  MouseMove(235,375,1)
	  MouseUp("left")
	  Send("400")
	  
	  $buyout = random(200000,250000,1)
	  
   ElseIf mod($SearchCount,2) = 0 Then
	  MouseClick("left",184,373,1,1)
	  MouseMove(255,496,1)
	  MouseDown("left")
	  MouseMove(254,488,1)
	  MouseUp("left")
	  MouseClick("left",138,413,1,1)
	  
	  MouseMove(203,373,1)
	  MouseDown("left")
	  MouseMove(231,375,1)
	  MouseUp("left")
	  
	  Send("{DEL}")
	  
	  $buyout = random(200000,250000,1)
   EndIf
   MouseMove(84,292,1)
   MouseDown("left")
   MouseMove(200,292,1)
   Send($buyout)
   
   $SearchCount = $SearchCount + 1
EndFunc

Func SearchAH()
   MouseClick("left",159,467,2,1) ;search
EndFunc

; ------------------------ Auction House Functions - Buy --------------------------- ;
Func Buy()
   MouseClick("left",156,130,1) ;Equipment
   
   MouseClick("left",218,171,1) ;barb class
   MouseClick("left",132,285,1)
	  
   ;MouseClick("left",218,191,1) ;armor
   ;MouseClick("left",141,272,1)
   
   MouseClick("left",94,248,1) ;lvl60
   Send("60")
   While 1
	  SearchConfig()
	  SearchAH()
	  Buyout(524,177)
   WEnd
EndFunc

Func Buyout($x,$y)
   Local $AttemptNumber = 0
   $AttemptNumber = $AttemptNumber + 1
   MouseClick("left",$x,$y,1,random(10,12))  ;click item
   sleep(100)
   if $AttemptNumber < 3 then
	  if 4038468354 = PixelCheckSum(615,480,724,494) then
		 MouseClick("left",665,487,1,1)  ;buyout
		 sleep(50)
		 MouseClick("left",335,433,2,1)
		 sleep(random(3000,3200))
		 MouseClick("left",398,255,1)
		 $buys = $buys + 1
		 ;buyout($x,$y+26)
	  EndIf
   EndIf
   Sleep(random(5000,5500))
EndFunc

; ------------------------ Auction House Functions - Stash --------------------------- ;

; ------------------------ Auction House Functions - Sell --------------------------- ;


; ------------------------ Hotkey Functions --------------------------- ;
Func Pause()
   $paused = NOT $paused
   While $paused
        sleep(100)
   WEnd
EndFunc

Func Stop() ;to allow the script to stop
    Exit
EndFunc 

Func Start()
    $Started = True
EndFunc