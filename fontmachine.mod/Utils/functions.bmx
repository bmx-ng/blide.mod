'This BMX file was edited with BLIde ( http://www.blide.org )
'Private
Function GetRotationCords:TDrawingPoint(Angle:Float, Source:TDrawingPoint, Center:TDrawingPoint) 
?Not debug
	If angle >= - 0.01 And angle <= 0.01 Then	'Little optimization for release mode
		Return CreateDrawingPoint(source.X, source.Y) 
	End If
?
	Local Radius:Double = ((source.X - center.x) ^ 2 + (source.Y - center.Y) ^ 2) ^ 0.5
	Local NewX:Double = Double(Center.X) + Double(radius) * Cos(angle) 
	Local NewY:Double = Double(Center.Y) + Double(radius) * Sin(angle) 
	Return CreateDrawingPoint(Float(newx), Float(newy)) 
End Function

Function DPrints(T:String) 
	?debug
		Print t
	?

End Function


Rem
	bbdoc: This function rounds properly a decimal value.
end rem
Function FM_Round:Int(number:Double)
	Return Int(number + 0.5:Double * Sgn(number))
End Function

'Public
