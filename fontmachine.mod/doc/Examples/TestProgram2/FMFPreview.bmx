'This is a simple font machine test program
REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: FontMachine preview
'Version: 0
'Subversion: 1
'Revision: 2
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
Strict
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Import blide.fontmachine
Import maxgui.drivers
Import maxgui.maxgui
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'GUI
'guid:9f486ac6_cae1_4dac_985e_db3ff45ca63d
Private
TYPE z_9f486ac6_cae1_4dac_985e_db3ff45ca63d_3_0 abstract  'Resource folder
    Global TestForn1:z_9f486ac6_cae1_4dac_985e_db3ff45ca63d_3_1 '<b>Resource folder</b>
    Global Images:z_9f486ac6_cae1_4dac_985e_db3ff45ca63d_3_2 '<b>Resource folder</b>
End Type


TYPE z_9f486ac6_cae1_4dac_985e_db3ff45ca63d_3_1 abstract  'Resource folder
    Const Small_fmf:String = "incbin::TestForn1\Small.fmf" 'String constant containing the value: "<b><font color=#0000AA>incbin::TestForn1\Small.fmf</font></b>"
End Type


TYPE z_9f486ac6_cae1_4dac_985e_db3ff45ca63d_3_2 abstract  'Resource folder
    Const fondo_png:String = "incbin::Images\fondo.png" 'String constant containing the value: "<b><font color=#0000AA>incbin::Images\fondo.png</font></b>"
End Type


TYPE z_blide_bg9f486ac6_cae1_4dac_985e_db3ff45ca63d Abstract
    Const Name:string = "FontMachine preview" 'This string contains the name of the program
    Const MajorVersion:Int = 0  'This Const contains the major version number of the program
    Const MinorVersion:Int = 1  'This Const contains the minor version number of the program
    Const Revision:Int =  2  'This Const contains the revision number of the current program version
    Const VersionString:String = MajorVersion + "." + MinorVersion + "." + Revision   'This string contains the assembly version in format (MAJOR.MINOR.REVISION)
    Const AssemblyInfo:String = Name + " " + MajorVersion + "." + MinorVersion + "." + Revision   'This string represents the available assembly info.
    ?win32
    Const Platform:String = "Win32" 'This constant contains "Win32", "MacOs" or "Linux" depending on the current running platoform for your game or application.
    ?
    ?MacOs
    Const Platform:String = "MacOs"
    ?
    ?Linux
    Const Platform:String = "Linux"
    ?
    ?PPC
    Const Architecture:String = "PPC" 'This const contains "x86" or "Ppc" depending on the running architecture of the running computer. x64 should return also a x86 value
    ?
    ?x86
    Const Architecture:String = "x86" 
    ?
    ?debug
    Const DebugOn : Int = True    'This const will have the integer value of TRUE if the application was build on debug mode, or false if it was build on release mode
    ?
    ?not debug
    Const DebugOn : Int = False
    ?
EndType


Type z_My_9f486ac6_cae1_4dac_985e_db3ff45ca63d Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg9f486ac6_cae1_4dac_985e_db3ff45ca63d  'This item has all the currently available assembly version information.
    Global Resources:z_9f486ac6_cae1_4dac_985e_db3ff45ca63d_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_9f486ac6_cae1_4dac_985e_db3ff45ca63d 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "Preview dialog.bmx"
 
Incbin "TestForn1\Small.fmf"
Incbin "Images\fondo.png"
'#EndRegion &H03

