'This BMX file was edited with BLIde ( http://www.blide.org )

rem
	bbdoc: This class stores all the kerning-releated operations for a bitmap font class.
endrem
Type TFontKerning
	rem
		bbdoc:<font color=#FF0000><b>PRIVATE DATA</b></font>
	end rem
	Field PrivateData:TPrivateFontKerning = New TPrivateFontKerning
	
	rem
		bbdoc:Set the horizontal kerning for the font, in pixels.
	end rem
	Method SetHKerning(Value:Float) 
		privatedata.HKF = value
	End Method
	rem
		bbdoc:Set the vertical kerning for the font, in pixels
	end rem
	Method SetVKerning(Value:Float) 
		privatedata.VKF = value
	End Method
	rem
		bbdoc:Get the current horizontal kerning for this font, in pixels
	end rem
	Method GetHKerning:Float() 
		Return privatedata.HKF
	End Method
	rem
		bbdoc:Get the current vertical kerning for this font, in pixels
	end rem
	Method GetVKerning:Float() 
		Return privatedata.vkf
	End Method
End Type

Private
Type TPrivateFontKerning
	Field HKF:Float = 0	'Horizontal kerning factor
	Field VKF:Float = 0	'Vertical kerning factor
End Type
Public