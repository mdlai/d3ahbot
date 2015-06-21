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
	  MouseClick("left",217,213,1,1) ;helm
	  MouseClick("left",141,380,1,1)
	  
	  MouseClick("left",182,329,1,1) 
	  MouseMove(282,371,1)
	  MouseDown("left")
	  MouseMove(282,429,1)
	  MouseUp("left")
	  MouseClick("left",183,473,1,1) ;dex
	  
	  MouseClick("left",204,330,1,1) ;dex amount
	  Send("120")
	  
	  MouseClick("left",182,350,1,1) ;crit chance
	  MouseClick("left",174,412,1,1)
	  
	  MouseClick("left",204,350,1,1)
	  Send("4")
	  
	  MouseClick("left",182,372,1,1) ;has sockets
	  MouseMove(282,410,1)
	  MouseDown("left")
	  MouseMove(282,545,1)
	  MouseUp("left")
	  MouseClick("left",134,488,1,1)
	  
	  MouseClick("left",213,368,1,1)
	  Send("1")
	  
	  $buyout = random(500000,600000,1)
   ElseIf mod($SearchCount,2) = 1 Then
	  MouseClick("left",183,330,1,1) ;int
	  MouseClick("left",163,373,1,1)
	  
	  MouseMove(205,331,1)	  ;Delete
	  MouseDown("left")
	  MouseMove(234,331,1)
	  MouseUp("left")
	  Send("200")
	  
	  $buyout = random(500000,600000,1)
   ElseIf mod($SearchCount,2) = 0 Then
	  MouseClick("left",183,331,1,1)
	  MouseMove(282,449,1)
	  MouseDown("left")
	  MouseMove(282,446,1)
	  MouseUp("left")
	  MouseClick("left",149,352,1,1)
	  
	  MouseMove(205,331,1)	  ;Delete
	  MouseDown("left")
	  MouseMove(234,331,1)
	  MouseUp("left")
	  Send("120")
	  
	  $buyout = random(500000,600000,1)
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
   if $AttemptNumber < 2 then
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