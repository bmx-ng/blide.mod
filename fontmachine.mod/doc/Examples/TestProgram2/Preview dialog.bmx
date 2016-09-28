AppTitle = My.Application.AssemblyInfo
Const Space:Int = 200
If AppArgs.length = 1 Then
	Notify("Missing command parameter.")
	End
End If
SetGraphicsDriver GLMax2DDriver()
Global Fondo:Timage
Global Window:TGadget = CreateWindow("Font Machine Font Preview", 10, 10, 800, 600, Null, WINDOW_TITLEBAR | WINDOW_CENTER | WINDOW_RESIZABLE)
Global CanvPanel:TGadget = CreatePanel(0, 0, window.width - space, window.height, window, PANEL_BORDER)
SetGadgetLayout (CanvPanel, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED)

Global Canvas:TGadget = CreateCanvas(0, 0, window.width - Space, window.height, CanvPanel)
SetGadgetLayout (Canvas, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED)

'PANEL:
Global Panel:TGadget = createpanel(window.width - Space, 0, Space, window.height, window)
SetGadgetLayout (Panel, EDGE_CENTERED, EDGE_ALIGNED, EDGE_RELATIVE, EDGE_ALIGNED)
'Panel.SetColor(255, 0, 0)

'LABEL:
Global Label:TGadget = CreateLabel("Text:", 0, 0, space - 20, 17, panel)
SetGadgetLayout (Label, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)

'TEXTFIELD:
Global Text:TGadget = CreateTextField(0, 17, Space - 20, 20, panel)
SetGadgetLayout (Text, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)
Text.SetText("Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

'SIZELABEL:
Global Label2:TGadget = CreateLabel("Size:", 0, text.ypos + 23, space - 20, 17, panel)
SetGadgetLayout (Label2, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)

'SIZER:
Global Sizer:TGadget = CreateSlider(0, label2.ypos + 17, space - 20, 17, panel, SLIDER_HORIZONTAL)
SetGadgetLayout (Sizer, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)
SetSliderRange(Sizer, 5, 350)
Sizer.SetProp(100)

'HKERNING LABEL:
Global Label3:TGadget = CreateLabel("Horizontal Kerning", 0, Sizer.ypos + 23, space - 20, 17, panel)
SetGadgetLayout (Label3, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)

'HKERNING:
Global HKERNING:TGadget = CreateSlider(0, label3.ypos + 17, space - 20, 17, panel, SLIDER_HORIZONTAL)
SetGadgetLayout (HKERNING, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)
SetSliderRange(HKERNING, 0, 250)
HKERNING.SetProp(50)

'VKERNING LABEL:
Global Label4:TGadget = CreateLabel("Vertical Kerning", 0, HKERNING.ypos + 23, space - 20, 17, panel)
SetGadgetLayout (Label4, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)

'VKERNING:
Global VKERNING:TGadget = CreateSlider(0, label4.ypos + 17, space - 20, 17, panel, SLIDER_HORIZONTAL)
SetGadgetLayout (VKERNING, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)
SetSliderRange(VKERNING, 0, 250)
VKERNING.SetProp(50)


'Color
Global ButColor:TGadget = CreateButton("Set back color", 0, VKERNING.ypos + 20, space - 20, 20, panel)
SetGadgetLayout (ButColor, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)

'Border:
Global Chkborder:TGadget = CreateButton("Draw border", 0, butcolor.ypos + 20, space - 20, 20, panel, BUTTON_CHECKBOX)
SetGadgetLayout (Chkborder, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)
'Chkborder.SetProp(True)
SetButtonState(Chkborder, 1)

'Shadow:
Global Chkshadow:TGadget = CreateButton("Draw shadow", 0, chkborder.ypos + 20, space - 20, 20, panel, BUTTON_CHECKBOX)
SetGadgetLayout (Chkshadow, EDGE_ALIGNED, EDGE_CENTERED, EDGE_ALIGNED, EDGE_CENTERED)
'Chkshadow.SetProp(True)
SetButtonState(Chkshadow, 1)


Global BackRed:Int = 255, BackGreen:Int = 255, backblue:Int = -255

SetGraphics(canvas.CanvasGraphics())

AddHook EmitEventHook, MyHook

'Graphics 400, 300
SetClsColor 255, 255, 255
Cls
Flip
Global fntsmall:TBitmapFont = LoadBitmapFont(My.Resources.TestForn1.Small_fmf)

Global fnt:TBitmapFont = New TBitmapFont
Cls
SetColor 0, 0, 0
Local MSG:String = "Loading the font..."
fntsmall.DrawText(MSG, GadgetWidth(Canvas) / 2 - fntsmall.GetTxtWidth(MSG) / 2, GadgetHeight(Canvas) / 2 - fntsmall.GetFontHeight())

Global Scale:Float = 1

Flip
fnt.SetProgressFunction(Loading)
fnt.UseMask = True
fnt.MaskColorBlue = 255
fnt.MaskColorGreen = 255
fnt.MaskColorRed = 255
'fnt.SetFaceBlend(EConstBlend.Mask )
fnt.SetDrawBorder (False)
'DebugStop
fnt.SetDrawshadow (False)
fnt.Load(AppArgs[1])
If fnt.FontLoaded() = False Then
	Notify("The font could not be loaded.")
	'debugstop
	End
End If
Flip()
Repeat
	WaitEvent()
Forever


'While Not KeyHit(KEY_ESCAPE)
'Wend


Function MyHook:Object(iId:Int, tData:Object, tContext:Object)
	Local Event:TEvent = TEvent(TData)
	'Print event.ToString()
  	If event = Null Return Null
	
	If (Event.ID = EVENT_GADGETPAINT) Or (Event.ID = EVENT_WINDOWSIZE) Or (Event.ID = EVENT_WINDOWMOVE) Or (Event.ID = Event_AppResume) Then 
		'ReDraw the canvas when requested (GadgetPaint) or when the window was moved, sized, resumed..
		Canvas.SetArea(0, 0, Window.width, Window.height)
		ReDraw()
	ElseIf (event.id = EVENT_WINDOWCLOSE)
		End
	ElseIf (event.id = EVENT_GADGETACTION)
		If event.source = Text Then
			ReDraw()
		ElseIf event.source = Sizer Or event.source = HKERNING Or event.source = VKERNING Then
			'Print event.ToString()
			ReDraw()
		ElseIf event.source = ButColor Then
			RequestColor(BackRed, BackGreen, backblue)
			BackRed = RequestedRed()
			BackGreen = RequestedGreen()
			backblue = RequestedBlue()
			ReDraw()
		ElseIf event.source = Chkborder Or event.source = Chkshadow Then
			ReDraw()
		End If
	End If
	Return TData
End Function

Function ReDraw()
	SetGraphics CanvasGraphics (Canvas)
	If Fondo = Null Then
		Fondo = LoadImage(My.Resources.Images.fondo_png)
	End If
	SetViewport 0, 0, GadgetWidth(Canvas), GadgetHeight(Canvas)
	SetColor 255, 255, 255
	If backblue >= 0 Then
		SetClsColor BackRed, BackGreen, backblue
		Cls
	Else
		Cls 
		TileImage(Fondo, 0, 0)
	EndIf
	
	fnt.SetDrawBorder(ButtonState(Chkborder) <> 0)
	fnt.SetDrawshadow(ButtonState(Chkshadow) <> 0)
	fnt.Kerning.SetHKerning(HKERNING.GetProp() - 50)
	fnt.Kerning.SetVKerning(VKERNING.GetProp() - 50)
	Local Txt:String = Text.GetText()
	Local resize:Float = Float(Sizer.GetProp() / 100.0)
	SetScale resize, resize

	fnt.DrawTextMaxWidth (txt, 10, 10, GadgetWidth(Canvas) - (Space + 20),True)
	SetScale 1, 1
	Flip
End Function

Function Loading(Percent:Float)
	Global lastpercent:Int = MilliSecs()
	If MilliSecs() - lastpercent > 200 Then
		lastpercent = MilliSecs()
		Cls
		SetColor 0, 0, 0
		Local MSG:String = "Loading the font (" + Int(percent) + "%)..."
		Local Width:Float = fntsmall.GetTxtWidth(MSG)
		Local X:Float = GadgetWidth(Canvas) / 2 - width / 2
		Local Y:Float = GadgetHeight(Canvas) / 2 - fntsmall.GetFontHeight()
		fntsmall.DrawText(MSG, X, Y)
		SetColor(100, 100, 100)
		y:+fntsmall.GetFontHeight()
		Const progHeight:Int = 6
		DrawRect(x, y, width, progHeight)
		SetColor(255, 255, 255)
		DrawRect(x + 1, y + 1, width - 2, progHeight - 2)
		SetColor (155, 155, 155)
		DrawRect(x + 1, y + 1, (percent / 100.0) * (width - 2), progHeight - 2)
		Flip
	EndIf
End Function