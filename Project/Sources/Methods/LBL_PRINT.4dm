//%attributes = {"shared":true}
/*

PRINT LABEL コマンドの代替え


PRINT LABEL([Table_1]) → My_OPEN_EDITOR(Table(->[Table_1]);False;$Txt_labelDocument)
PRINT LABEL([Table_1];*) → $Lon_error:=My_Print_label(Table(->[Table_1]);"file:"+$Txt_labelDocument;"*")

*/


C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

If (False:C215)
	C_POINTER:C301(LBL_PRINT; $1)
	C_TEXT:C284(LBL_PRINT; $2)
	C_TEXT:C284(LBL_PRINT; $3)
End if 

C_TEXT:C284($Txt_labelDocument)
C_LONGINT:C283($Lon_error)

Case of 
	: (Count parameters:C259=0)
		LBL_C_OPEN_EDITOR(0; False:C215; "")
		
	: (Count parameters:C259=1)
		LBL_C_OPEN_EDITOR(Table:C252($1); False:C215; "")
		
	: (Count parameters:C259=2) & ($2=Char:C90(1))
		LBL_C_OPEN_EDITOR(Table:C252($1); False:C215; "")
		
	: (Count parameters:C259=2)
		$Lon_error:=LBL_C_Print_label(Table:C252($1); "file:"+$2; "")
		
	: (Count parameters:C259=3)
		$Lon_error:=LBL_C_Print_label(Table:C252($1); "file:"+$2; $3)
		
End case 
