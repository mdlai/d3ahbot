#include <Misc.au3>

Global $Paused

HotKeySet("=","Leave")  ;script can START by pressing =
HotKeySet("-", "Pause") ;script can be Pause by pressing -
HotKeySet("x", "Stop") ;script can be Stopped by pressing x

Dim $buys = 0
Dim $buyout = 0
Dim $char = 0
Dim $type = 0
Dim $stat = 0
Dim $itemnumber = 0

$go = True
$Leave = False

While $go
   if($Leave) Then
	  auction()
	  if $buys > 45 Then
		 $buys = 0
		 itemGrab()
	  EndIf
	  
	  $buys = 0 ;Reset Variables
	  $buyout = 0
	  $char = 0
	  $type = 0
	  $stat = 0
	  $itemnumber = 0
	  
	  Sleep(10000)
	  auction()
	  if $buys > 45 Then
		 itemGrab()
		 Exit
	  EndIf   
   EndIf
WEnd

Func auction()
   Send("{SPACE}")
   
   ;Initialize
   MouseClick("left",135,354,1) ;AH
   MouseClick("left",156,130,1) ;Equipment
   
   MouseClick("left",213,171,1) ;barb class
   MouseClick("left",132,285,1)
	  
   MouseClick("left",213,212,1) ;armor
   MouseClick("left",133,291,1)
   
   MouseClick("left",213,239,1) ;ring
   MouseClick("left",132,461,1)
   
   ;MouseClick("left",98,284,1) ;lvl60
   ;Send("60")
   
   ;MouseClick("left",214,282,1) ;rare
   ;MouseClick("left",180,399,1)
   
   MouseClick("left",179,330,1) ;crit chance
   MouseClick("left",152,501,1)
   ;dex amount
   MouseClick("left",207,332,1)
   Send("3")
   
   MouseClick("left",184,350,1) ;crit damage
   MouseClick("left",158,522,1)
   ;crit amount
   MouseClick("left",210,351,1)
   Send("20")
   
   MouseClick("left",184,374,1)
   MouseClick("left",152,490,1)
   
   MouseClick("left",210,374,1)
   ;Rotation
   
   
   
   While $buys < 50
   ToolTip($buys, 0, 0)
   ;itemStat()
   $itemnumber = 0
   $buyout = random(3250000,4000000,1)  ;test buyout
   MouseClick("left",180,422,1,1)
   Send("{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}{DEL}")
   Send($buyout)
   MouseClick("left",159,467,1,1) ;search
   buyout(524,177)  ;click item
   sleep(random(5000,5500))
   WEnd
EndFunc

Func CharSwitch()
   If mod($char,5)=0 Then
	  MouseClick("left",625,302,1,1)
	  MouseClick("left",544,516,1,1)
   ElseIf mod($char,5)=1 Then
	  MouseClick("left",624,299,1,1)
	  MouseClick("left",491,537,1,1)
   ElseIf mod($char,5)=2 Then
	  MouseClick("left",623,310,1,1)
	  MouseClick("left",499,572,1,1)
   ElseIf mod($char,5)=3 Then
	  MouseClick("left",622,309,1,1)
	  MouseClick("left",579,598,1,1)
   ElseIf mod($char,5)=4 Then
	  MouseClick("left",623,307,1,1)
	  MouseClick("left",500,623,1,1)
   EndIf
   $char = $char +.5
EndFunc


Func itemStat()
   If mod($stat,2)=0 then
	  MouseClick("left",186,331,1,1);int
	  MouseClick("left",133,393,1,1)
	  ;Delete
	  MouseMove(203,333,1)
	  MouseDown("left")
	  MouseMove(226,332,1)
	  MouseUp("left")
	  Send("160")
	  $buyout = random(300000,400000,1)
   ElseIf mod($stat,2)=1 Then
	  MouseClick("left",185,330,1,1)
	  MouseMove(209,505,1)
	  MouseDown("left")
	  MouseMove(208,489,1)
	  MouseUp("left")
	  MouseClick("left",125,379,1,1)
	  ;Delete
	  MouseMove(203,333,1)
	  MouseDown("left")
	  MouseMove(226,332,1)
	  MouseUp("left")
	  Send("215")
	  $buyout = random(300000,400000,1)
   EndIf
   $stat = $stat + 1
EndFunc


Func itemtype()
   If mod($type,4)=0 then
	  MouseClick("left",625,385,1,1)
	  MouseClick("left",547,524,1,1)
   ElseIf mod($type,4)=1 then
	  MouseClick("left",624,382,1,1)
	  MouseClick("left",530,482,1,1)
   ElseIf mod($type,4)=2 then
	  MouseClick("left",622,382,1,1)
	  MouseClick("left",524,455,1,1)
   ElseIf mod($type,4)=3 then
	  MouseClick("left",628,383,1,1)
	  MouseClick("left",534,428,1,1)
   EndIf
EndFunc

Func buyout($x,$y)
   $itemnumber = $itemnumber + 1
   MouseClick("left",$x,$y,1,random(10,12))  ;click item
   sleep(100)
   if $itemnumber < 2 then
	  if 4038468354 = PixelCheckSum(615,480,724,494) then
		 MouseClick("left",665,487,1,1)  ;buyout
		 MouseClick("left",337,399,1,1)
		 sleep(random(3000,3200))
		 MouseClick("left",398,255,1)
		 $buys = $buys + 1
		 buyout($x,$y+26)
	  EndIf
   EndIf
EndFunc

Func ItemGrab()
   dim $AHstash = 0
   MouseClick("left",579,87,1)
   While $AHstash < 50
	  MouseClick("left",157,248,1)
	  sleep(3000)
	  $AHstash = $AHstash + 1
   WEnd
   send("{space}")
   sleep(20000)
EndFunc

Func Pause()
   $Leave = False
EndFunc

Func Stop() ;to allow the script to stop
    Exit
EndFunc 

Func Leave()
    $Leave = True
 EndFunc