'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc: Rectangle type
end rem
Type TRectangle
	rem
		bbdoc: X coordinate of the rectangle
	end rem
	Field X:Float
	rem
		bbdoc: Y coordinate of the rectangle
	end rem
	Field Y:Float
	rem
		bbdoc: Rectangle width
	end rem
	Field Width:Float
	rem
		bbdoc: Rectangle height
	end rem
	Field Height:Float

	rem
		bbdoc: Create a rectangle with the specified X, Y coordinates, and the given Width and Height
	end rem
	Function Create:TRectangle(X:Float, Y:Float, Width:Float, Height:Float) 
		Local RC:TRectangle = New TRectangle
		rc.X = x
		rc.Y = y
		rc.Width = width
		rc.Height = height
		Return rc
	End Function
	Method Clone:TRectangle() 
		Return CreateRectangle(Self.X, Self.Y, Self.Width, Self.Height) 
	End Method
End Type

rem
	bbdoc: Create a rectangle with the specified X, Y coordinates, and the given Width and Height
end rem
Function CreateRectangle:TRectangle(X:Float, Y:Float, Width:Float, Height:Float) 
	Return TRectangle.Create(x, y, width, height) 
End Function

rem
	bbdoc: Drawing Point type
end rem

Type TDrawingPoint
	rem
		bbdoc:X coordinate of a drawing point
	end rem
	Field X:Float
	rem
		bbdoc:Y corrdinate of a drawing point
	end rem
	Field Y:Float
	
	rem
		bbdoc: Create a DrawingPoint with the specified X and Y coordinates
	end rem
	Function Create:TDrawingPoint(X:Float, Y:Float) 
		Local DP:TDrawingPoint = New TDrawingPoint
		dp.X = x
		dp.Y = y
		Return dp
	End Function
	Method Clone:TDrawingPoint() 
		Return CreateDrawingPoint(Self.X, Self.Y) 
	End Method
End Type

rem
	bbdoc: Create a DrawingPoint with the specified X and Y coordinates
end rem
Function CreateDrawingPoint:TDrawingPoint(X:Float, Y:Float) 
	Return TDrawingPoint.Create(x, y) 
End Function

