'This BMX file was edited with BLIde ( http://www.blide.org )
rem
	bbdoc:This class has a list of all available blend modes for bitmap fonts.
end rem
Type EConstBlend Final
	rem
		bbdoc: This Blend mode will draw images respecting the alpha channel.<br>This is the default blend mode for bitmap fonts.
	end rem
	Const Alpha:Int = Alphablend
	rem
		bbdoc: This Blend mode will draw images using light information on the pixels to combine them to the backbuffer.
	end rem
	Const Light:Int = LightBlend
	rem
		bbdoc: This Blend mode will draw images overwriting directly any existing pixel in the backbuffer.
	end rem
	Const Solid:Int = SolidBlend
	rem
		bbdoc: This Blend mode will draw images solid images.<br>Any alpha value will be rounded to 1 or 0.
	end rem
	Const Mask:Int = MaskBlend
	rem
		bbdoc: This Blend mode will draw images using dark information on the pixels to combine them to the backbuffer.
	end rem
	Const Shade:Int = ShadeBlend
	rem
		bbdoc: This function return the active blend mode in the active graphic context.
	end rem
	Function GetCurrent:Int() 
		Return GetBlend()    
	End Function
End Type

