'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:This exception is thrown when a draw operation using a bitmap font can't be completed.
End Rem
Type TDrawTextException
	Field PrivateData:TPrivateException = New TPrivateException
	rem
		bbdoc: This method contains a explanation of the exception
	end rem
	Method ToString:String()
		If privatedata.description <> "" Then
			Return privatedata.description
		Else
			Return "The requested action could not be completed."
		EndIf
	End Method
	
	rem
		bbdoc: This method will return a instance of the offending @TBitmapFont object, if available.
	end rem
	Method GetFontObject:TBitmapFont()
		Return privatedata.Offending
	End Method
End Type

Rem
	bbdoc: This exception is thrown when a load operation of a bitmap font can't be completed.
end rem
Type TBitmapFontLoadException Extends TDrawTextException
	rem
		bbdoc: This method contains a explanation of the exception
	end rem
	Method ToString:String()
		Return Super.ToString()
	End Method
	rem
		bbdoc: This method will return a instance of the offending @TBitmapFont object, if available.
	end rem
	Method GetFontObject:TBitmapFont()
		Return Super.GetFontObject()
	End Method
End Type

Private
Type TPrivateException
	Field Description:String = ""
	Field Offending:TBitmapFont
End Type
Public