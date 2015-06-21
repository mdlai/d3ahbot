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
	  MouseClick("left",216,214,1,1);Gloves
	  MouseClick("left",125,367,1,1)
	  
	  MouseClick("left",183,330,1)
	  MouseMove(202,369)
	  MouseDown("left")
	  MouseMove(201,456)
	  MouseUp("left")
	  MouseClick("left",118,469,1)
	  Send("x")
	  MouseClick("left",182,331,1)
	  MouseClick("left",125,373,1)
	  
	  MouseClick("left",184,351,1) ;Crit Chance
	  MouseClick("left",138,431,1)
	  MouseClick("left",215,351,1)
	  Send("8")
	  
	  MouseClick("left",183,371,1) ;Crit Damage
	  MouseClick("left",134,450,1)
	  MouseClick("left",217,369,1)
	  Send("40")
	  
	  $buyout = random(100000,150000,1)
   ElseIf mod($SearchCount,2) = 1 Then
	  MouseClick("left",182,331,1)
	  MouseClick("left",125,373,1)
	  
	  ;MouseMove(205,331,1)	  ;Delete
	  ;MouseDown("left")
	  ;MouseMove(234,331,1)
	  ;MouseUp("left")
	  ;Send("200")
	  
	  $buyout = random(100000,150000,1)
   ElseIf mod($SearchCount,2) = 0 Then
	  MouseClick("left",182,331,1)
	  MouseMove(203,501)
	  MouseDown("left")
	  MouseMove(201,494)
	  MouseUp("left")
	  MouseClick("left",122,358,1)
	  
	  ;MouseMove(205,331,1)	  ;Delete
	  ;MouseDown("left")
	  ;MouseMove(234,331,1)
	  ;MouseUp("left")
	  ;Send("120")
	  
	  $buyout = random(100000,150000,1)
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
	  
   MouseClick("left",218,191,1) ;armor
   MouseClick("left",141,272,1)
   
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
		 buyout($x,$y+26)
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