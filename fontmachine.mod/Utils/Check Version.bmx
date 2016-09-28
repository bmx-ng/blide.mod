'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Type Type contains the version information of the current FontMachine module
End Rem
Type TFontMachineVersion Abstract
	rem
		bbdoc: This function returns a string representation of the current Font Machine Module version.
	end rem
	Function Version:String()
		Return My.Application.AssemblyInfo
	End Function
End Type
