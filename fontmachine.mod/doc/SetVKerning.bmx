SuperStrict
'First, we tell BlitzMax we are using the font machine module:
Import blide.fontmachine

'Start the graphics window:
Graphics 800, 600

'We tell BlitzMax that there is an object called fnt1 wich is a bitmap font:
Local fnt1:TBitmapFont

'We create the object, loading the font samplefont.fmf
fnt1 = LoadBitmapFont("samplefont.fmf") 

'Main loop:
While Not KeyHit(KEY_ESCAPE) 
	Cls
	DrawBitMapText(fnt1, "Q,W change the~nfont vertical~nkerning", 0, 0) 
	If KeyDown(KEY_Q) Then
		Local TempValue:Float
		TempValue = fnt1.Kerning.GetVKerning() 
		fnt1.Kerning.SetVKerning(TempValue + 0.5) 
	EndIf
	If KeyDown(KEY_W) Then
		Local TempValue:Float
		TempValue = fnt1.Kerning.GetVKerning() 
		fnt1.Kerning.SetVKerning(TempValue - 0.5) 
	End If
	Flip
Wend