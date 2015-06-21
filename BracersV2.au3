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
   Send("{SPACE}")
   MouseClick("left",135,354,1) ;AH
EndFunc

Func SearchConfig()
   If $SearchCount = 0 Then
	  MouseClick("left",219,211,1,1)
	  MouseClick("left",121,312,1,1)
	  MouseClick("left",184,330,1,1)
	  MouseMove(239,367,1)
	  MouseDown("left")
	  MouseMove(239,462,1)
	  MouseUp("left")
	  MouseClick("left",125,432,1,1)
	  
	  MouseClick("left",204,330,1,1) ;dex amount
	  Send("160")
	  
	  MouseClick("left",184,351,1,1) ;crit chance
	  MouseClick("left",148,416,1,1)
	  
	  MouseClick("left",204,350,1,1)
	  Send("4.5")
	  
	  $buyout = random(200000,250000,1)
   ElseIf mod($SearchCount,2) = 1 Then
	  MouseClick("left",183,330,1,1) ;int
	  MouseClick("left",163,373,1,1)
	  
	  MouseMove(205,331,1)	  ;Delete
	  MouseDown("left")
	  MouseMove(234,331,1)
	  MouseUp("left")
	  Send("160")
	  
	  $buyout = random(200000,250000,1)
   ElseIf mod($SearchCount,2) = 0 Then
	  MouseClick("left",183,331,1,1) ;dex
	  MouseMove(239,496,1)
	  MouseDown("left")
	  MouseMove(239,490,1)
	  MouseUp("left")
	  MouseClick("left",138,353,1,1)
	  
	  MouseMove(205,331,1)	  ;Delete
	  MouseDown("left")
	  MouseMove(234,331,1)
	  MouseUp("left")
	  Send("160")
	  
	  $buyout = random(200000,250000,1)
   EndIf
   MouseClick("left",84,292,1,1)
   Send("{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}")
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
		 MouseClick("left",335,433,1,1)
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