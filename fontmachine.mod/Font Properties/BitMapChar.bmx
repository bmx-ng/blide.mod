'This BMX file was edited with BLIde ( http://www.blide.org )
Private
Type TBitMapChar
	Field DrawOffsetX:Int
	Field DrawOffsetY:Int
	Field DrawWidth:Int
	Field DrawHeight:Int
	Field Charwidth:Int
	Field Image:TImage
	
	Method LoadDrawRenderingData(Url:Object) 
		Local LS:TStream
		Ls = OpenStream(Url, True, False) 
		Self.DrawOffsetX = ls.ReadInt() 
		Self.DrawOffsetY = ls.ReadInt() 
		Self.DrawWidth = ls.ReadInt() 
		Self.DrawHeight = ls.ReadInt() 
		Self.Charwidth = ls.ReadInt() 
		'Print charwidth
		ls.Close()
	End Method
End Type
Public
