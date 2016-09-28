'This is a simple fonrmachine test program
REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: FontMachine Test Program 1
'Version: 0
'Subversion: 2
'Revision: 1
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
Strict
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Import blide.fontmachine
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'GUI
'guid:6daa6268_2f2d_4b47_82b1_681021ebb211
Private
TYPE z_6daa6268_2f2d_4b47_82b1_681021ebb211_3_0 abstract  'Resource folder
    Global Fonts:z_6daa6268_2f2d_4b47_82b1_681021ebb211_3_1 '<b>Resource folder</b>
    Global Images:z_6daa6268_2f2d_4b47_82b1_681021ebb211_3_2 '<b>Resource folder</b>
End Type


TYPE z_6daa6268_2f2d_4b47_82b1_681021ebb211_3_1 abstract  'Resource folder
    Const luxury_fmf:String = "incbin::Fonts\luxury.fmf" 'String constant containing the value: "<b><font color=#0000AA>incbin::Fonts\luxury.fmf</font></b>"
    Const NewCaveman_fmf:String = "incbin::Fonts\NewCaveman.fmf" 'String constant containing the value: "<b><font color=#0000AA>incbin::Fonts\NewCaveman.fmf</font></b>"
    Const Small_fmf:String = "incbin::Fonts\Small.fmf" 'String constant containing the value: "<b><font color=#0000AA>incbin::Fonts\Small.fmf</font></b>"
    Const Jungle_fmf:String = "incbin::Fonts\Jungle.fmf" 'String constant containing the value: "<b><font color=#0000AA>incbin::Fonts\Jungle.fmf</font></b>"
End Type


TYPE z_6daa6268_2f2d_4b47_82b1_681021ebb211_3_2 abstract  'Resource folder
    Const GNOME_GreenField_1024x768_jpg:String = "incbin::Images\GNOME-GreenField_1024x768.jpg" 'String constant containing the value: "<b><font color=#0000AA>incbin::Images\GNOME-GreenField_1024x768.jpg</font></b>"
End Type


TYPE z_blide_bg6daa6268_2f2d_4b47_82b1_681021ebb211 Abstract
    Const Name:string = "FontMachine Test Program 1" 'This string contains the name of the program
    Const MajorVersion:Int = 0  'This Const contains the major version number of the program
    Const MinorVersion:Int = 2  'This Const contains the minor version number of the program
    Const Revision:Int =  1  'This Const contains the revision number of the current program version
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


Type z_My_6daa6268_2f2d_4b47_82b1_681021ebb211 Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg6daa6268_2f2d_4b47_82b1_681021ebb211  'This item has all the currently available assembly version information.
    Global Resources:z_6daa6268_2f2d_4b47_82b1_681021ebb211_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_6daa6268_2f2d_4b47_82b1_681021ebb211 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "Sample Program1.bmx"
 
Incbin "Fonts\luxury.fmf"
Incbin "Fonts\NewCaveman.fmf"
'#EndRegion &H03
Incbin "Fonts\Small.fmf"

Incbin "Images\GNOME-GreenField_1024x768.jpg"

Incbin "Fonts\Jungle.fmf"