'This BMX file was edited with BLIde ( http://www.blide.org )
rem
	bbdoc: Renderer effect base class (interface)
end rem
Type iTextRendererFXBase Abstract
	'Field PrivateData:TTextRendererPrivateData = New TTextRendererPrivateData
	Field ChainFX:iTextRendererFXBase
	rem
		bbdoc: This method will be called whenever a DrawText operation starts from the bitmap font owning this object instance.
	end rem
	Method DrawTextBegin(e:TDrawTextAction)
	End Method
	rem
		bbdoc: This method will be called whenever a DrawText operation ends from the bitmap font owning this object instance.
	end rem
	Method DrawTextEnd(e:TDrawTextAction) 
	End Method
	rem
		bbdoc: This method will be called before a shadow of a character is drawn from the bitmap font owning this object instance.
	end rem
	Method DrawShadowChar(e:TDrawCharAction)
	End Method
	rem
		bbdoc: This method will be called before a border of a character is drawn from the bitmap font owning this object instance.
	end rem
	Method DrawBorderChar(e:TDrawCharAction) 
	End Method
	rem
		bbdoc: This method will be called before the face of a character is drawn from the bitmap font owning this object instance.
	end rem
	Method DrawFaceChar(e:TDrawCharAction) 
	End Method
	
End Type

rem
	bbdoc: This class is instantiated and passed as a parameter for any DrawTextAction callback used for advanced text drawing.
end rem
Type TDrawTextAction
	rem
		bbdoc: The text to be drawed.
	end rem
	Field Text:String
	rem
		bbdoc: The X position where the text is going to be drawed.
	end rem
	Field X:Float
	rem
		bbdoc: The Y position where the text is going to be drawed.
	end rem
	Field Y:Float
	rem
		bbdoc: The bitmapfont object that has fired the Draw Char action. This is read only.
	end rem
	Field Font:TBitmapFont
End Type
rem
	bbdoc: This class is instantiated and passed as a parameter for any DrawActionChar callback used for advanced text drawing.
end rem
Type TDrawCharAction
	rem
		bbdoc: 16 BIT unicode character to be printed. This is overridable
	end rem
	Field Char:Int
	rem
		bbdoc: the X position where the character is going to be drawed. This is overridable
	end rem
	Field X:Float
	rem
		bbdoc: the Y position where the character is going to be drawed. This is overridable
	end rem
	Field Y:Float
	rem
		bbdoc: Read only ScaleX factor when the DrawChar ation was fired.
	end rem
	Field CurrentScaleX:Float
	rem
		bbdoc: Read only ScaleY factor when the DrawChar ation was fired.
	end rem
	Field CurrentScaleY:Float
	rem
		bbdoc: The bitmapfont object that has fired the Draw Char action. This is read only.
	end rem
	Field font:TBitmapFont

	rem
		bbdoc: Handled flag. If this is set to true, the character won't be automatically drawn after the DrawCharAction has ended.
	end rem	
	Field Handled:Int = False

	rem
		bbdoc: Has a value of type eDrawCharStatus that indicates if the character is being drawn as FACE, BORDER or SHADOW. This is read only.
	end rem	
	Field Status:Int
End Type

Type eDrawCharStatus Final
	Const Face:Int = 1
	Const Border:Int = 2
	Const Shadow:Int = 4
End Type
