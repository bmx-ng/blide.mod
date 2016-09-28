
'This is the font machine module source code.
'Use it as you wish. If you publish any game or application using this module, please state it on the credits as:
'This program uses the Font Machine Module written by Manel Ibañez
'
'Enjoy!

Rem
	bbdoc: This is the BitMap font base class
end rem
Type TBitmapFont
	Rem
		bbdoc:This field contains the metrics of the current font.
	end rem
	Field Kerning:TFontKerning = New TFontKerning
	
	Rem
		bbdoc: This flag enables the usage of a MaskColor when loading a bitmap font. Useful only for experimental ClearType support.
	end rem
	Field UseMask:Int = False
	
	Rem
		bbdoc: This field contains the Red component of the mask color used to load the bitmap font when the UseMask flag is set to true. <br>This is experimetal.
	end rem
	Field MaskColorRed:Int = 0

	Rem
		bbdoc: This flag enables the usage of a MaskColor when loading a bitmap font. Useful only for experimental ClearType support.
	end rem
	Field MaskColorGreen:Int = 0

	Rem
		bbdoc: This flag enables the usage of a MaskColor when loading a bitmap font. Useful only for experimental ClearType support.
	end rem
	Field MaskColorBlue:Int = 0
	

	Rem
		bbdoc: This flag enables the fisical pixel rounding to prevent artifacts when the fonts are scaled down due to virtual resolution usage in some hardware configurations.
	end rem
	Field PhisicalPixelRounding:Int = False

	Rem
		bbdoc:This field contains a collection of callback function for advanced text drawing operations.
	end rem
	Field RenderFX:iTextRendererFXBase
	Rem
		bbdoc:<font color=#FF0000><b>PRIVATE DATA</b></font>
	end rem
	Field PrivateData:TPrivateBitmapFont = New TPrivateBitmapFont
	Rem
		bbdoc:Set the status of the bitmapfont shadow<br><b>True</b>: Shadow will be enabled<br><b>False</b>: Shadow will be disabled
	end rem
	Method SetDrawShadow(Value:Int) 
		privatedata.drawshadow = value
	End Method

	Rem
		bbdoc:Gets the status of the bitmapfont shadow<br><b>True</b>: Shadow is enabled<br><b>False</b>: Shadow is disabled
	end rem
	Method GetDrawShadow:Int() 
		Return privatedata.DrawShadow
	End Method

	Rem
		bbdoc:Sets the status of the bitmapfont border <br><b>True</b>: Border will be enabled<br><b>False</b>: Border will be disabled
	end rem	
	Method SetDrawBorder(Value:Int) 
		privatedata.drawBorder = value
	End Method

	Rem
		bbdoc:Gets the status of the bitmapfont border <br><b>True</b>: Border is enabled<br><b>False</b>: Border is disabled
	end rem	
	Method GetDrawBorder:Int() 
		Return privatedata.DrawBorder
	End Method

	Rem
		bbdoc:Sets the a pointer to a function that will be called while the font is being loaded, to provide load progress in the host application.
	end rem	
	Method SetProgressFunction(FunctionPointer(Percent:Float)) 
		privatedata.Progress = FunctionPointer
	End Method
	
	Rem
		bbdoc:Method to load the bitmap font (FMF file)
	end rem	
	Method Load(Url:Object, ImageFilters:Int = FILTEREDIMAGE)
		Local Read:TStream = OpenStream(url, True, False)
		Local LastProgres:Int = 0
		If read = Null Then Return
		GCSuspend()
		While read.Eof() = False
			Local Char:Int = read.ReadInt()

			If Char > 255 And Self.PrivateData.Face.Length <= 256 Then	'Activate UNICODE:
				Self.PrivateData.Face = Self.PrivateData.Face[..65536]
				Self.PrivateData.border = Self.PrivateData.border[..65536]
				Self.PrivateData.shadow = Self.PrivateData.shadow[..65536]
			End If
			If Self.PrivateData.shadow[Char] = Null Then Self.PrivateData.shadow[Char] = New TBitMapChar
			If Self.PrivateData.border[Char] = Null Then Self.PrivateData.border[Char] = New TBitMapChar
			If Self.privatedata.face[char] = Null Then Self.privatedata.face[char] = New TBitMapChar
			Local id:String = read.ReadLine() 
			Select id
				Case "SHADOW"
					'DPrint "SHADOW INT11:" + 
					read.ReadInt()  'FUTURE USE
					Self.PrivateData.shadow[Char].Image = LoadImage(Read, ImageFilters)
					Self.PrivateData.shadow[Char].Image.handle_x = 0
					Self.PrivateData.shadow[char].Image.handle_y = 0

					'DPrint
					read.ReadLine()       'FUTURE USE
					If Self.privatedata.shadow[char].Image = Null Then
						Print "ERROR LOADING PNG"
					End If
					read.ReadInt() 
					Self.privatedata.shadow[char].LoadDrawRenderingData(read) 
					SetImageHandle(Self.PrivateData.shadow[char].Image, - Self.PrivateData.shadow[char].drawoffsetx, - Self.PrivateData.shadow[char].DrawOffsetY) 

					'DPrint
					read.ReadLine()    'FUTURE USE

				Case "BORDER"
					'DPrint "BORDER INT1:" + 
					read.ReadInt()  'FUTURE USE
					Self.PrivateData.border[Char].Image = LoadImage(Read, ImageFilters)
					Self.PrivateData.border[char].Image.handle_x = 0
					Self.PrivateData.border[char].Image.handle_y = 0

					'DPrint
					read.ReadLine()      'FUTURE USE
					read.ReadInt() 
					Self.privatedata.Border[char].LoadDrawRenderingData(read)
					SetImageHandle(Self.PrivateData.border[char].Image, - Self.PrivateData.border[char].drawoffsetx, - Self.PrivateData.border[char].DrawOffsetY)
					'DPrint
					read.ReadLine()    'FUTURE USE

				Case "FACE"
					'DPrint "FACE INT1:" + 
					Read.ReadInt()  'FUTURE USE
					If UseMask = False Then
						'Local pm:TPixmap = LoadPixmap(Read)
						'For Local x:Int = 0 Until pm.width
						'	For Local y:Int = 0 Until pm.height
						'		Local PD:Int = pm.ReadPixel(x, y)
						'		If PD = 0 Then pm.WritePixel(x, y, $00090909)
						'	Next
						'Next
						'Self.PrivateData.face[Char].Image = LoadImage(pm, MIPMAPPEDIMAGE | FILTEREDIMAGE)
						Self.PrivateData.face[Char].Image = LoadImage(Read, ImageFilters)
					Else
						Local pm:TPixmap=LoadPixmap(Read)
						pm = MaskPixmap(pm, Self.MaskColorRed, Self.MaskColorGreen, Self.MaskColorBlue)
						Self.PrivateData.face[Char].Image = LoadImage(pm,MASKEDIMAGE)
					EndIf
					Self.PrivateData.face[Char].Image.handle_x = 0
					Self.PrivateData.face[char].Image.handle_y = 0
					SetImageHandle(Self.PrivateData.face[char].Image, - Self.PrivateData.face[char].drawoffsetx, - Self.PrivateData.face[char].DrawOffsetY)
					'DPrint
					read.ReadLine()   	'CHECkPOINT
					read.ReadInt() 
					Self.privatedata.Face[char].LoadDrawRenderingData(read) 
					'DPrint
					read.ReadLine()   	'CHECkPOINT
				Default
					GCResume
					Local Ex:TBitmapFontLoadException
					ex = New TBitmapFontLoadException
					ex.PrivateData.Description = "Unable to load the bitmapfont due to corrupted or unsuported file format"
					ex.PrivateData.Offending = Self
					Throw ex
			End Select
			If Self.PrivateData.Progress <> Null Then
				If Int(LastProgres) <> Int(Char / Float(Self.PrivateData.Face.Length) * 100.0) Then
					LastProgres = Char
					Self.PrivateData.Progress(char / Float(Self.PrivateData.Face.Length) * 100.0)
				End If
			End If
		Wend
		READ.Close() 
		Self.PrivateData.FontLoaded = True
		GCResume()
	End Method
	
	Rem
		bbdoc:Returns TRUE if the font has been loaded, otherwise returns false
	end rem
	Method FontLoaded:Int() 
		Return Self.PrivateData.fontloaded
	End Method
	Rem
		bbdoc:Method to draw text on the current graphics object.<br>Parameters:<br><b>TEXT</b>: The text to draw<br><b>X</b>:The X position for the text in the current graphics context<br><b>Y</b>: The Y position for the text in the current graphics context<br><b>CustomBlend</b><i> optional </i> :a boolean value to enable or disable customb blend drawing.
	end rem	
	Method DrawText(Text:String, x:Float, y:Float, CustomBlend:Int = True)
		privatedata.DrawTextLine(Text, x, y, customblend, Self)
	End Method

	Rem
		bbdoc:Method to draw text on the current graphics object with a maximum width in pixels.
	end rem	
	Method DrawTextMaxWidth(Txt:String, x:Float, y:Float, MaxWidth:Double, CustomBlend:Int = True)
	'DebugStop
		Local curLength:Double = 0
		Local Str:String = ""
		Local curY:Float = Y
		Local ScaleX:Float, ScaleY:Float
		Local skip:Int = False
		GetScale(ScaleX, ScaleY)
		For Local i:Int = 1 To Txt.Length
			Local Sum:Double = 0
			If Asc(Mid(Txt, i, 1)) <> 10 And Asc(Mid(Txt, i, 1)) < Self.PrivateData.Face.length Then
			
				If Self.privatedata.Face[Asc(Mid(Txt, i, 1))] <> Null Then
					Local Char:TBitMapChar = Self.privatedata.Face[Asc(Mid(Txt, i, 1))]
					sum = Double(char.DrawWidth) * ScaleX + kerning.PrivateData.HKF * ScaleX
					If (curlength + sum) < (MaxWidth - Abs(ScaleX)) Then	'ScaleX reduce floating poing accuracy errors.
						Str:+Mid(Txt, i, 1)
						sum = (Double(char.Charwidth)) * ScaleX + kerning.PrivateData.HKF * scalex
						curlength:+Sum
					Else
						DrawText(Str, x, CurY, CustomBlend)
						If str <> "" Then CurY:+Self.GetFontHeight() * ScaleY + Self.Kerning.PrivateData.VKF * ScaleY
						Str = Mid(Txt, i, 1)
						curLength = (Double(char.Charwidth)) * ScaleX + kerning.PrivateData.HKF * scalex
					End If
				EndIf
			Else
				DrawText(Str, x, CurY, CustomBlend)
				CurY:+Self.GetFontHeight() * ScaleY + Self.Kerning.PrivateData.VKF * ScaleY
				Str = ""
				curlength = 0
			EndIf
			If curY > GraphicsHeight() Then
				Skip = True
				Exit 'For
			EndIf
		Next
		If str <> "" And Skip = False Then
			DrawText(Str, x, CurY, CustomBlend)
		End If
	End Method
		
	Rem
		bbdoc:Method to get the drawing with, in pixels, of a given string
	end rem	
	Method GetTxtWidth:Int(Text:String) 
		Local TWidth:Int
		
		'debugstop
		Local char:Int
		Local lastchar:Int = 0
		For Local i:Int = 1 To Text.Length
			char = Asc(Mid(Text, i, 1))
			If char >= 0 And char < Self.PrivateData.Face.length Then
				If privatedata.face[char] <> Null Then
				lastchar = char
					twidth = twidth + privatedata.face[char].charwidth + kerning.PrivateData.HKF
				End If
			End If
		Next
		If lastchar >= 0 And lastchar < Self.PrivateData.Face.Length Then
				If privatedata.face[lastchar] <> Null Then
					twidth = twidth - privatedata.face[lastchar].charwidth
					twidth = twidth + privatedata.face[lastchar].drawwidth
				End If		
		End If
		Return TWidth
	End Method
	
	Rem
		bbdoc:Method to get the bitmap font height
	end rem	
	Method GetFontHeight:Int() 
		If privatedata.face[32] = Null Then Return 0
		Return privatedata.face[32].DrawHeight
	End Method

	Rem
		bbdoc:Method to get the face image object of a given char
	end rem	
	Method GetFaceImage:TImage(Char:Byte) 
		If privatedata.face[char] = Null Then Return Null
		Return privatedata.face[char].Image
	End Method
	
	Rem
		bbdoc:Method to get the border image object of a given char
	end rem	
	Method GetBorderImage:TImage(Char:Byte) 
		If privatedata.Border[char] = Null Then Return Null
		Return privatedata.Border[char].Image
	End Method

	Rem
		bbdoc:Method to get the shadow image object of a given char
	end rem	
	Method GetShadowImage:TImage(char:Byte) 
		If privatedata.shadow[char] = Null Then Return Null
		Return privatedata.shadow[char].image
	End Method

	Rem
		bbdoc:Method to get the face info of the given char.<br>The returned object represents the X and Y drawing offset, and the width and height of the face char
	end rem	
	Method GetFaceInfo:TRectangle(Char:Byte) 
		If privatedata.face[char] = Null Then Return Null
		Local R:TRectangle = New TRectangle
		Local BMC:TBitMapChar = privatedata.face[char] 
		r.X = BMC.DrawOffsetX
		r.Y = BMC.DrawOffsetY
		r.Width = BMC.DrawWidth
		r.Height = BMC.DrawHeight
		Return r
	End Method
	
	Rem
		bbdoc:Method to get the border info of the given char.<br>The returned object represents the X and Y drawing offset, and the width and height of the border char
	end rem	
	Method GetBorderInfo:TRectangle(Char:Byte) 
		If privatedata.border[char] = Null Then Return Null
		Local R:TRectangle = New TRectangle
		Local BMC:TBitMapChar = privatedata.border[char] 
		r.X = BMC.DrawOffsetX
		r.Y = BMC.DrawOffsetY
		r.Width = BMC.DrawWidth
		r.Height = BMC.DrawHeight
		Return r
	End Method

	Rem
		bbdoc:Method to get the shadow info of the given char.<br>The returned object represents the X and Y drawing offset, and the width and height of the shadow char
	end rem	
	Method GetShadowInfo:TRectangle(Char:Byte) 
		If privatedata.Shadow[char] = Null Then Return Null
		Local R:TRectangle = New TRectangle
		Local BMC:TBitMapChar = privatedata.Shadow[char] 
		r.X = BMC.DrawOffsetX
		r.Y = BMC.DrawOffsetY
		r.Width = BMC.DrawWidth
		r.Height = BMC.DrawHeight
		Return r
	End Method
	
	Rem
		bbdoc:Method to get a character spacing width to its relative next character.
	end rem	
	Method GetCharOffset:Int(Char:Byte) 
		If privatedata.face[char] = Null Then Return 0
		Return privatedata.face[char].Charwidth
	End Method
	

	Rem
		bbdoc:Returns a relative border drawing point for a speciffic char
	end rem	
	Method GetCharBorderOffset:TDrawingPoint(Char:Byte) 
		If privatedata.border[char] = Null Then
			Return CreateDrawingPoint(0, 0) 
		EndIf
		Local CharB:TBitMapChar = privatedata.border[char] 
		Return CreateDrawingPoint(charB.DrawOffsetX, charB.DrawOffsetY) 
	End Method
	
	Rem
		bbdoc:Returns a relative shadow drawing point for a speciffic char
	end rem	
	Method GetCharShadowOffset:TDrawingPoint(char:Byte) 
		If privatedata.Shadow[char] = Null Then
			Local DP:TDrawingPoint = New TDrawingPoint
			DP.X = 0
			DP.Y = 0
			Return DP
		EndIf
		Local DP:TDrawingPoint = New TDrawingPoint
		dp.X = privatedata.Shadow[char].DrawOffsetX
		dp.Y = privatedata.Shadow[char].DrawOffsetY
		Return dp
	End Method
	
	Rem
		bbdoc:This method will determine the blend mode for the face of the font.<br>By default this Blend mode is set to Alpha.
	end rem
	Method SetFaceBlend(Mode:Int = EConstBlend.Alpha) 
		Self.PrivateData.FaceBlend = Mode
	End Method
	
	Rem
		bbdoc:This method will return the current blend mode for the face of the font.
	end rem
	Method GetFaceBlend:Int() 
		Return privatedata.faceblend
	End Method
	
	Rem
		bbdoc:This method will determine the blend mode for the border of the font.<br>By default this Blend mode is set to Alpha.
	end rem
	Method SetBorderBlend(Mode:Int = EConstBlend.Alpha) 
		privatedata.BorderBlend = Mode
	End Method
	
	Rem
		bbdoc:This method will return the current blend mode for the border of the font.
	end rem
	Method GetBorderBlend:Int() 
		Return privatedata.borderblend
	End Method
	
	Rem
		bbdoc:This method will determine the blend mode for the shadow of the font.<br>By default this Blend mode is set to Alpha.
	end rem
	Method SetShadowBlend(Mode:Int = EConstBlend.Alpha) 
		privatedata.ShadowBlend = Mode
	End Method
	
	Rem
		bbdoc:This method will return the current blend mode for the shadow of the font.
	end rem
	Method GetShadowBlend:Int() 
		Return privatedata.shadowblend
	End Method

	
End Type

Rem
	bbdoc:Create a BitMapFont object from an existing FMF file.
	returns: A @TBitmapFont object if load succeed. Otherwise returns @NULL
	about: Parameters:<br>
	@URL: The place to load the font from<br>
	@ProgressPointer: This parameter is optional. It is a function pointer to the function to be called to inform about loading progress. the function has to have one float parameter called progress. This parameter will get the loading percent while the font is being loaded.
end rem
Function LoadBitmapFont:TBitmapFont(Url:Object, ProgressPointer(Progress:Float) = Null, ImageFilters:Int = FILTEREDIMAGE)
	Local BMF:TBitmapFont = New TBitmapFont
	bmf.SetProgressFunction(ProgressPointer) 
	bmf.Load(Url) 
	If bmf.FontLoaded() = True Then
		Return bmf
	Else
		Return Null
	End If
End Function
Rem
	bbdoc:Function to draw text using a bitmap font.
	returns: Nothing
	about: Parameters:<br>
	@BitMapFont: The bitmap font to be used in the draw operation<br>
	@Text: The text to be draw<br>
	@X: the X position to draw the text<br>
	@Y: the Y position to draw the text<br>
	@CustomBlend: To enable or disable the custom blending mode. defaults to TRUE
end rem	
Function DrawBitMapText(BitMapfont:TBitmapFont, Text:String, X:Int, Y:Int, customBlend:Int = True) 
	If bitmapfont = Null Then
		Local ex:TDrawTextException
		ex = New TDrawTextException
		ex.PrivateData.Description = "Can't draw text becouse the bitmapfont is null."
		ex.PrivateData.Offending = Null
		Throw ex
		Return
	End If
	Try
		bitmapfont.DrawText(Text, x, y, customblend)
	Catch ex:Object
		Local newex:TDrawTextException
		newex = New TDrawTextException
		newex.PrivateData.Description = "There was an unhandled exception inside this drawtext operation. The exception source is: " + TTypeId.ForObject(ex).Name() + ":" + ex.ToString()
		Throw newex
	End Try
End Function

Private

Type TPrivateBitmapFont
	Field Shadow:TBitMapChar[256] 
	Field Border:TBitMapChar[256] 
	Field Face:TBitMapChar[256] 
	Field Progress(Percent:Float) 
	Field DrawShadow:Int = True
	Field DrawBorder:Int = True
	Field FontLoaded:Int = False
	Field ShadowBlend:Int = EConstBlend.Alpha
	Field FaceBlend:Int = EConstBlend.Alpha
	Field BorderBlend:Int = EConstBlend.Alpha
	Field RenderStatus:TRenderStatus = New TRenderStatus
	Method DrawFaceText(Text:String, X:Float, Y:Float, Base:TBitmapFont)
		Local DRX:Float = X, DRY:Float = y
		Local OldX:Float = x', OldY:Float = y
		Local scalex:Float = RenderStatus.ScaleX, scaley:Float = RenderStatus.scaley
		'GetScale(scalex, scaleY) 
		Local center:TDrawingPoint = CreateDrawingPoint(x, y) 
		Local rotation:Float = RenderStatus.rotation
		Local DoCallBack:Int = (base.renderfx <> Null) 
		For Local i:Int = 1 To Text.Length
			Local char:Int = Asc(Mid(Text, i, 1)) 
			If char >= 0 And char <= Self.Face.Length Then
				If char = 10 Then
					'DRx = OldX
					DRY = DRy + face[32].DrawHeight * scaley + Base.kerning.PrivateData.VKF * scaley
					Self.DrawFaceText(Mid(Text, i + 1), oldx, dry, base)
					Return

				ElseIf face[char] <> Null Then
					If face[char].Image <> Null Then
						Local DrawPos:TDrawingPoint = New TDrawingPoint
						Local Origin:TDrawingPoint
						Origin = New TDrawingPoint
						Origin.X = DRx '+ privatedata.shadow[char].DrawOffsetX * scalex
						Origin.Y = DRy '+ privatedata.shadow[char].DrawOffsetY * scaley
						DrawPos = GetRotationCords(Rotation, Origin, Center) 
						'DrawImage(face[char].Image, drawpos.x, drawpos.y) 
						If Not DoCallBack
							If Base.PhisicalPixelRounding = False Then
								DrawImage(Face[char].Image, DrawPos.X, DrawPos.Y)  'OLD
							Else
								Local VRWidth:Float = VirtualResolutionWidth() , VRHeight:Float = VirtualResolutionHeight()
								Local PhisicalX:Float = DrawPos.X * (Double(GraphicsWidth()) / VRWidth)
								Local PhisicalY:Float = DrawPos.y * (Double(GraphicsHeight()) / VRHeight)
								SetVirtualResolution(GraphicsWidth(), GraphicsHeight())
								Local RScaleX:Double = scalex * Double(GraphicsWidth()) / VRWidth
								Local RScaleY:Double = scaley * Double(GraphicsHeight()) / VRHeight
								
								RScaleX = FM_Round (RScaleX * Double(Face[char].Image.width)) / Double(Face[char].Image.width)
								RScaleY = FM_Round (RScaleY * Double(Face[char].Image.height)) / Double(Face[char].Image.height)

								
								SetScale(Float(RScaleX), Float(RScaleY))
								
								'SetScale 1, 1
								DrawImage(Face[char].Image, FM_Round (PhisicalX), FM_Round (PhisicalY))
								If char = Asc("m") Then
									Print "(" + FM_Round (PhisicalX) + ", " + FM_Round(PhisicalY) + ")" + Double(Face[char].Image.width * RScaleX) + "  -  " + RScaleX
								EndIf
								SetVirtualResolution(VRWidth, VRHeight)
								SetScale scalex, scaley
							EndIf
						Else
							Local DrawFace:TDrawCharAction = New TDrawCharAction
							DrawFace.Char = char
							DrawFace.font = base
							DrawFace.Handled = False
							DrawFace.Status = eDrawCharStatus.Face
							DrawFace.X = drawpos.X
							DrawFace.Y = drawpos.y
							drawface.CurrentScaleX = renderstatus.ScaleX
							drawface.CurrentScaleY = renderstatus.scaley
							Local Call:iTextRendererFXBase = base.renderfx
							While Call <> Null
								Call.DrawFaceChar (DrawFace) 
								Call = Call.chainfx
							Wend
							char = DrawFace.char							
							If DrawFace.Handled = False Then
								If face[char] <> Null Then DrawImage(Face[char].Image, DrawFace.X, DrawFace.y) 
							EndIf
						EndIf
						If face[char] <> Null Then
							DRx:+face[char].charwidth * ScaleX + base.kerning.PrivateData.HKF * scalex
							'DRx:+face[char].charwidth * ScaleX + base.kerning.PrivateData.HKF * scalex
						EndIf
					End If
				End If
			End If
		Next
	End Method
	
	Method DrawBorderText(Text:String, X:Float, Y:Float, Base:TBitmapFont)
		Local OldX:Float = X ' RenderStatus.scalex', OldY:Float = RenderStatus.scaley
		Local scalex:Float = renderstatus.scalex, scaley:Float = renderstatus.scaley
		Local center:TDrawingPoint = CreateDrawingPoint(x, y) 
		Local rotation:Float = RenderStatus.rotation
		Local DoCallBack:Int = (base.renderfx <> Null) 
		For Local i:Int = 1 To Text.Length
			Local char:Int = Asc(Mid(Text, i, 1)) 
			If char >= 0 And char < Self.Face.Length Then
				If char = 10 Then
					x = OldX
					Y = y + face[32].DrawHeight * scaley + base.kerning.PrivateData.VKF * scaley
					'Local drawpos:TDrawingPoint
					'Local origin:TDrawingPoint = CreateDrawingPoint(x, y) 
					'drawpos = GetRotationCords(rotation, origin, center) 
					Self.drawbordertext(Mid(Text, i + 1), x, y, base)
					Return
				ElseIf Border[char] <> Null Then
					If Border[char].Image <> Null Then
						Local DrawPos:TDrawingPoint = New TDrawingPoint
						Local Origin:TDrawingPoint
						Origin = New TDrawingPoint
						Origin.X = x
						Origin.Y = y
						Drawpos = GetRotationCords(Rotation, Origin, Center) 
						If Not DoCallBack
							If Base.PhisicalPixelRounding = False Then
								DrawImage(Border[char].Image, DrawPos.X, DrawPos.Y)
							Else							
								Local VRWidth:Float = VirtualResolutionWidth() , VRHeight:Float = VirtualResolutionHeight()
								Local PhisicalX:Float = DrawPos.X * (GraphicsWidth() / VRWidth)
								Local PhisicalY:Float = DrawPos.y * (GraphicsHeight() / VRHeight)
								SetVirtualResolution(GraphicsWidth(), GraphicsHeight())
								
								
								Local RScaleX:Double = scalex * Double(GraphicsWidth()) / VRWidth
								Local RScaleY:Double = scaley * Double(GraphicsHeight()) / VRHeight
								
								RScaleX = FM_Round (RScaleX * Double(Border[char].Image.width)) / Double(Border[char].Image.width)
								RScaleY = FM_Round (RScaleY * Double(Border[char].Image.height)) / Double(Border[char].Image.height)

								SetScale(Float(RScaleX), Float(RScaleY))
								'SetScale 1, 1
								DrawImage(Border[char].Image, FM_Round (PhisicalX), FM_Round(PhisicalY))
								SetVirtualResolution(VRWidth, VRHeight)
								SetScale scalex, scaley
							EndIf
							
						Else
							Local DrawBorder:TDrawCharAction = New TDrawCharAction
							DrawBorder.Char = char
							DrawBorder.font = base
							DrawBorder.Handled = False
							DrawBorder.Status = eDrawCharStatus.Border
							DrawBorder.X = drawpos.X
							DrawBorder.Y = drawpos.y
							drawborder.CurrentScaleY = renderstatus.ScaleY
							drawborder.CurrentScaleX = renderstatus.ScaleX
							'base.renderfx.DrawborderChar(DrawBorder) 							
							Local Call:iTextRendererFXBase = base.renderfx
							While Call <> Null
								Call.DrawBorderChar (DrawBorder) 
								Call = Call.chainfx
							Wend
							char = drawborder.char
							If DrawBorder.Handled = False Then
								If face[char] <> Null Then DrawImage(Border[char].Image, DrawBorder.X, DrawBorder.y) 
							EndIf
						EndIf

						'DrawImage(Border[char].Image, X, y) 
						If face[char] <> Null Then
							x:+face[char].charwidth * ScaleX + base.kerning.PrivateData.HKF * scalex
						EndIf
					End If
				End If
			End If
		Next
	End Method
	
	Method DrawShadowText(Text:String, x:Float, y:Float, Base:TBitmapFont)
		Local OldX:Float = x', OldY:Float = y
		Local scalex:Float = RenderStatus.ScaleX, scaley:Float = RenderStatus.scaley
		Local center:TDrawingPoint = CreateDrawingPoint(x, y) 
		Local rotation:Float = RenderStatus.rotation
		Local DoCallBack:Int = (base.renderfx <> Null) 
		'Local FaceX:Int = OldX
		For Local i:Int = 1 To Text.Length
			Local char:Int = Asc(Mid(Text, i, 1)) 
			If char >= 0 And char < Self.Face.Length Then
			If char = 10 Then
				x = OldX
				'FaceX = x
				Y = y + face[32].DrawHeight * scaley + base.kerning.PrivateData.VKF * scaley
				Self.drawshadowtext(Mid(Text, i + 1), oldx, y, base)
				Return
				'Print "ENTER " + privatedata.face[32].drawheight
			ElseIf shadow[char] <> Null Then
					If shadow[char].Image <> Null Then
						Local DrawPos:TDrawingPoint = New TDrawingPoint
						Local Origin:TDrawingPoint = New TDrawingPoint
						Origin.X = x
						Origin.Y = y
						drawpos = GetRotationCords(Rotation, Origin, center) 
						If Not docallback
							DrawImage(shadow[char].Image, DrawPos.X, DrawPos.y) 
						Else
							Local drawshadow:TDrawCharAction = New TDrawCharAction
							drawshadow.Char = char
							drawshadow.font = base
							drawshadow.Handled = False
							drawshadow.Status = eDrawCharStatus.Shadow
							drawshadow.X = drawpos.X
							drawshadow.Y = drawpos.y
							Local Call:iTextRendererFXBase = base.renderfx
							While Call <> Null
								Call.DrawShadowChar (DrawShadow) 
								Call = Call.chainfx
							Wend
							char = drawshadow.char
							If drawshadow.Handled = False Then
								If face[char] <> Null Then DrawImage(shadow[char].Image, drawshadow.X, drawshadow.y) 
							EndIf
						EndIf
						'DrawImage(shadow[char].Image, X, y) 
						If face[char] <> Null Then
							x:+face[char].charwidth * ScaleX + base.kerning.PrivateData.HKF * scalex
						EndIf
					End If
				End If
			End If
		Next

	End Method
	
	Method DrawTextLine(Text:String, x:Float, y:Float, customblend:Int = True, base:TBitmapFont)
		'Local OldBlend:Int = GetBlend() 
		If base.renderfx <> Null Then
			Local DTBA:TDrawTextAction = New TDrawTextAction
			DTBA.Font = base
			dtba.Text = Text
			dtba.X = x
			dtba.Y = y
			base.RenderFX.DrawTextBegin(DTBA)
		End If
		RenderStatus.OldBlend = GetBlend() 
		GetScale(RenderStatus.ScaleX, RenderStatus.ScaleY) 
		renderstatus.Rotation = GetRotation() 
		If drawshadow Then
			If CustomBlend = True Then SetBlend(ShadowBlend) 
			DrawShadowText(Text, x, y, base)
		EndIf
		If drawborder Then
			If CustomBlend = True Then SetBlend(borderblend) 
			DrawBorderText(Text, x, y, base)
		EndIf
		If CustomBlend = True Then SetBlend(faceblend) 
		DrawFaceText(Text, x, y, base)
		SetBlend RenderStatus.oldblend
		If base.renderfx <> Null Then
			Local DTBA:TDrawTextAction = New TDrawTextAction
			DTBA.Font = base
			dtba.Text = Text
			dtba.X = x
			dtba.Y = y
			base.renderfx.DrawTextEnd(dtba) 
		End If
	End Method
End Type

Type TRenderStatus
	Field OldBlend:Int
	Field Rotation:Float
	Field ScaleX:Float
	Field ScaleY:Float
End Type

Public
