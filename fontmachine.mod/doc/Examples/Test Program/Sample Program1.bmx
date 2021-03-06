'This BMX file was edited with BLIde ( http://www.blide.org )
'Begin program:
SetGraphicsDriver GLMax2DDriver()
'Notify ("This is a test program for " + TFontMachineVersion.Version())
Graphics 800, 600, 0, 0
SetBlend ALPHABLEND

'Cargamos fondo
Global fondo:TImage = LoadImage(My.Resources.Images.GNOME_GreenField_1024x768_jpg)
'~n
DrawImage(fondo, 0, 0) 
Flip

Global fnt3:TBitmapFont = LoadBitmapFont(my.Resources.Fonts.Small_fmf)
Global fnt:TBitmapFont = LoadBitmapFont(My.Resources.Fonts.NewCaveman_fmf, LoadingProgress)    	'->Create the font object
Global fnt2:TBitmapFont = LoadBitmapFont(My.Resources.Fonts.Jungle_fmf)
Global fnt4:TBitmapFont = LoadBitmapFont(my.Resources.Fonts.Luxury_fmf)

fnt3.RenderFX = New RenderHTML
Print("width is " + fnt3.GetTxtWidth("Hello!"))

Type RenderWaves Extends iTextRendererFXBase
	Method DrawBorderChar(e:TDrawCharAction) 
		e.Y = e.Y + (20 * Sin((MilliSecs() / 4) + e.X * e.currentscaleX)) * e.CurrentScaleY
		If Self.ChainFX <> Null Then Self.ChainFX.DrawBorderChar(e) 
	End Method
	Method DrawFaceChar(e:TDrawCharAction) 
		e.Y = e.Y + (20 * Sin((MilliSecs() / 4) + e.X * e.currentscaleX)) * e.CurrentScaleY
	End Method
	Method DrawShadowChar(e:TDrawCharAction) 
		e.Y = e.Y + (20 * Cos((MilliSecs() / 4) + e.X * e.currentscaleX)) * e.currentscaleY
	End Method
	Method DrawTextBegin(e:TDrawTextAction) 
		
	End Method
	Method DrawTextEnd(e:TDrawTextAction) 
		
	End Method
End Type

Type MyRenderer Extends iTextRendererFXBase
	Method DrawFaceChar(e:TDrawCharAction)
		e.Status = eDrawCharStatus.Face
		e.Y = e.Y + Rand(- 2, 2)
	End Method
End Type

Type RenderWaves2 Extends iTextRendererFXBase
	Method DrawBorderChar(e:TDrawCharAction) 
		e.Y = e.Y + Float(20 * Sin((MilliSecs() / 4) + e.X * e.currentscaleX)) * e.CurrentScaley
	End Method
	Method DrawFaceChar(e:TDrawCharAction) 
		e.Y = e.Y + Float(20 * Tan((MilliSecs() / 4) + e.X * e.currentscaleX)) * e.CurrentScaleY
	End Method
	Method DrawShadowChar(e:TDrawCharAction) 
		e.Y = e.Y + Float(20 * Cos((MilliSecs() / 4) + e.X * e.currentscaleX)) * e.CurrentScaleY
	End Method
	Method DrawTextBegin(e:TDrawTextAction) 
	End Method
	Method DrawTextEnd(e:TDrawTextAction) 
	End Method
End Type
	
Type RenderKerning Extends iTextRendererFXBase
	Field InitialVKerning:Float
	Field InitialHKerning:Float
	Method DrawBorderChar(e:TDrawCharAction) 
		e.font.Kerning.SetHKerning(3 * Sin((MilliSecs() / 4) + e.X)) 
	End Method
	Method DrawFaceChar(e:TDrawCharAction) 
		Local factor:Float = Sin((MilliSecs() / 4) + e.X) 
		e.font.Kerning.SetHKerning(3 * factor) 
	End Method
	Method DrawShadowChar(e:TDrawCharAction) 
		e.font.Kerning.SetHKerning(3 * Sin((MilliSecs() / 4) + e.X)) 
	End Method
	Method DrawTextBegin(e:TDrawTextAction) 
		initialvkerning = e.Font.Kerning.getvkerning() 
		initialhkerning = e.Font.Kerning.gethkerning() 
	End Method
	Method DrawTextEnd(e:TDrawTextAction) 
		e.Font.Kerning.SetHKerning(initialhkerning) 
		e.Font.Kerning.SetVKerning(initialvkerning) 
	End Method
End Type

Type InverseRendering Extends iTextRendererFXBase
	Method DrawShadowChar(e:TDrawCharAction) 
		e.Handled = True
		Local img:TImage
		img = e.font.Getfaceimage(e.Char) 
		If img <> Null Then DrawImage(img, e.X, e.Y) 
	End Method
	
	Method DrawFaceChar(e:TDrawCharAction) 
		e.Handled = True
		Local img:TImage
		img = e.font.GetShadowimage(e.Char) 
		If img <> Null Then DrawImage(img, e.X, e.Y) 
	End Method
	Method DrawTextBegin(e:TDrawTextAction) 
		
	End Method
	Method DrawBorderChar(e:TDrawCharAction) 
		
	End Method
	Method DrawTextEnd(e:TDrawTextAction) 
		
	End Method
End Type
Type RenderHTML Extends iTextRendererFXBase
	Field IsBold:Int = False
	Method DrawBorderChar(e:TDrawCharAction) 
		'e.font.Kerning.SetHKerning(3 * Sin((MilliSecs() / 4) + e.X)) 
	End Method
	Method DrawFaceChar(e:TDrawCharAction) 
		'e.font.Kerning.SetHKerning(3 * Sin((MilliSecs() / 4) + e.X)) 
		If e.Char = Asc("@") Then
			isbold = True
			e.Char = 0
		ElseIf e.Char = 32 Then
			isbold = False
		Else
			If isbold Then
				SetScale(e.CurrentScaleX * 1.1, e.CurrentScaleY * 1.1) 
				'DrawImage(e.font.GetFaceImage(e.Char), e.X + 1, e.Y) 
				'DrawImage(e.font.GetFaceImage(e.Char), e.X - 1, e.Y) 
				'DrawImage(e.font.GetFaceImage(e.Char), e.X, e.Y + 1) 
				DrawImage(e.font.GetFaceImage(e.Char), e.X, e.Y) 
				SetScale(e.CurrentScaleX, e.CurrentScaleY) 
				'e.Handled = True
			EndIf
		End If
	End Method
	Method DrawShadowChar(e:TDrawCharAction) 
		'e.font.Kerning.SetHKerning(3 * Sin((MilliSecs() / 4) + e.X)) 
	End Method
	Method DrawTextBegin(e:TDrawTextAction) 
		isbold = False
	End Method
	Method DrawTextEnd(e:TDrawTextAction) 
		IsBold = False
	End Method
	
	
End Type

'Run program:
'SetClsColor(255, 255, 255) 


'Framecount variables:
Global fps:Int, frms:Int = 0
Local Mil:Int = MilliSecs() + 1000
Global rot:Float = 0
Global Scale:Float = 1
GCCollect() 
While Not KeyHit(KEY_ESCAPE) 
	Cls
	DrawImage(fondo, 0, 0) 
	SetRotation(Rot) 
	SetScale Scale, Scale
	fnt.DrawText("Caveman font", 0, 12) 
	'fnt3.DrawText("Small font (abcefghijklmnopqrstuvwxyz~nABCDEFGHIJKLMNOPQRSTUVWXYZ~náéíóúñàèìòùýÿçÇ_!·$%&/()1234567890,.-{}[]", 20, 132) 
	fnt2.DrawText("Jungle Font", 0, 182)
	fnt4.DrawText("Luxury ~nfont~n...", 50, 312)
	fnt3.DrawText("@SPACE Toggle FX on/off~n@A Draw border(On/Off)~n@S Draw shadow(On/Off)~n@Z Blue channel~n@X Red channel~n@C All channels~n@Q Increase kerning~n@W Decrease kerning~n@U-I Modify rotation~n@O-P Modify scale~nFPS: @" + fps, 630, 32)
	SetRotation(0) 
	SetScale 1, 1
	Flip
	frms = frms + 1
	If MilliSecs() >= mil Then
		mil = MilliSecs() + 1000
		fps = frms
		frms = 0
	End If
	ProcessKeys() 
	'gccollect()
	'sleep 1
	Wend
End

Function LoadingProgress(percent:Float)   '--> Called by the module!
	If percent Mod 10 = 0 Then
		SetColor(255, 255, 255) 
		DrawImage(fondo, 0, 0) 
		fnt3.DrawText("LOADING (" + Int(percent) + "%)", 0, 0) 
		Flip
	EndIf
End Function
'Summary: Process all the user keys 
Function ProcessKeys() 
	If KeyHit(KEY_A) Then
		fnt.SetDrawBorder(Not fnt.GetDrawBorder()) 
		fnt2.SetDrawBorder(Not fnt2.GetDrawBorder()) 
		fnt3.SetDrawBorder(Not fnt3.GetDrawBorder()) 
	ElseIf KeyHit(KEY_S) Then
		fnt.SetDrawShadow(Not fnt.GetDrawShadow()) 
		fnt2.SetDrawShadow(Not fnt2.GetDrawShadow()) 
		fnt3.SetDrawShadow(Not fnt3.GetDrawShadow()) 
	ElseIf KeyDown(KEY_Z) Then
		SetColor 0, 0, 255
	ElseIf KeyHit(KEY_X) Then
		SetColor 255, 0, 0
	ElseIf KeyHit(KEY_C) 
		SetColor 255, 255, 255
	ElseIf KeyHit(KEY_D) Then
		DebugStop
	ElseIf KeyDown(KEY_Q) Then
		fnt.Kerning.SetHKerning(fnt.kerning.GetHKerning() +.1) 
		fnt2.kerning.SetHKerning(fnt.kerning.GetHKerning() +.1) 
		fnt3.kerning.SetHKerning(fnt.kerning.GetHKerning() +.1) 
		fnt4.kerning.SetHKerning(fnt.kerning.GetHKerning() +.1) 
		fnt.kerning.SetVKerning(fnt.kerning.GetvKerning() +.1) 
		fnt2.kerning.setVKerning (fnt.kerning.GetvKerning() +.1) 
		fnt3.kerning.SetvKerning(fnt.kerning.GetvKerning() +.1) 
		fnt4.kerning.SetvKerning(fnt.kerning.GetvKerning() +.1) 
	ElseIf KeyDown(KEY_W) Then
		fnt.kerning.SetHKerning(fnt.kerning.GetHKerning() -.1) 
		fnt2.kerning.SetHKerning(fnt.kerning.GetHKerning() -.1) 
		fnt3.kerning.SetHKerning(fnt.kerning.GetHKerning() -.1) 
		fnt4.kerning.SetHKerning(fnt.kerning.GetHKerning() -.1) 
		fnt.kerning.SetVKerning(fnt.kerning.GetvKerning() -.1) 
		fnt2.kerning.setVKerning (fnt.kerning.GetvKerning() -.1) 
		fnt3.kerning.SetvKerning(fnt.kerning.GetvKerning() -.1) 
		fnt4.kerning.SetvKerning(fnt.kerning.GetvKerning() -.1) 
	ElseIf KeyDown(KEY_I) Then
		rot:+.5
	ElseIf KeyDown(KEY_U) Then
		rot:-.5
	ElseIf KeyDown(KEY_P) 
		Scale = Scale * 1.01
	ElseIf KeyDown(KEY_O) 
		Scale = Scale * 0.99
	ElseIf KeyHit(KEY_SPACE) Then
		If fnt2.RenderFX = Null Then
			fnt2.RenderFX = New RenderWaves
			fnt.RenderFX = New RenderWaves2
			'fnt.RenderFX.ChainFX = New RenderKerning
			fnt3.RenderFX = New RenderHTML
			fnt3.RenderFX = New RenderKerning
			fnt3.RenderFX.ChainFX = New RenderWaves
			fnt3.RenderFX.ChainFX.chainfx = New RenderHTML
			fnt4.RenderFX = New RenderKerning
		Else
			fnt2.RenderFX = Null
			fnt.RenderFX = Null
			fnt4.RenderFX = Null
			fnt3.RenderFX = New RenderHTML
		EndIf
	ElseIf KeyHit(KEY_D) Then
			DebugStop
	End If
	'FlushKeys
End Function
