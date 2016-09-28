SuperStrict
'This is a simple example of how to create a font FX

'First, we tell BlitzMax we are using the font machine module:
Import blide.fontmachine

rem
	To create a spetial FX text drawer, we have to create ower own FX object.
	This can be easilly done by extending the iTextRendererFXBase object.
	This object has been created as a 'sort of' interface.
end rem
Type FontFx1 Extends iTextRendererFXBase
	'This method will be automatically called by the Font Machine engine before any border char is drawed.
	Method DrawBorderChar(e:TDrawCharAction) 
		
	End Method
	'This method will be automatically called by the Font Machine engine before any shadow char is drawed.
	Method DrawShadowChar(e:TDrawCharAction) 
		
	End Method

	'This method will be automatically called by the Font Machine engine before any face char is drawed.
	Method DrawFaceChar(e:TDrawCharAction) 

	End Method
	
	'This method will be called automatically by the font machine engine when a draw text operation is started.
	Method DrawTextBegin(e:TDrawTextAction) 
		e.Font.Kerning.SetHKerning(Sin(MilliSecs()))  'This is the special FX for this renderer.
	End Method

	'This method will be called automatically by the font machine engine when a draw text operation is ended.
	Method DrawTextEnd(e:TDrawTextAction) 
		
	End Method
End Type



'Start the graphics window:
Graphics 800, 600

'We tell BlitzMax that there is an object called fnt1 wich is a bitmap font:
Local fnt1:TBitmapFont

'We create the object, loading the font samplefont.fmf
fnt1 = LoadBitmapFont("samplefont.fmf") 

'We connect the font with the FX:
fnt1.RenderFX = New FontFx1

'Main loop:
While Not KeyHit(KEY_ESCAPE)
	Cls
	DrawBitMapText(fnt1, "Hello World", 0, 0) 
	Flip
Wend

