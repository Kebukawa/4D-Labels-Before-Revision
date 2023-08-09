// ----------------------------------------------------
// Object method : LABEL_WIZARD.push.print - (4D Labels)
// ID[EA55106AE9CD415E9F9B6F45228862DB]
// Created #15-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me; $Ptr_table)
C_TEXT:C284($Txt_me)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$Ptr_table:=Table:C252(C_MASTER_TABLE)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		If (Not:C34(Is nil pointer:C315($Ptr_table)))
			
			If (Records in selection:C76($Ptr_table->)>0)
				
				$Boo_OK:=True:C214
				
			End if 
		End if 
		
		OBJECT SET ENABLED:C1123(*; $Txt_me; $Boo_OK)
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If (OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; "no-print"; Is boolean:K8:9))
			
			// a text is in edition - validate the input
			EXECUTE METHOD IN SUBFORM:C1085("editor"; "Editor_TEXT_EDIT_VALIDATE_INPUT")
			
		End if 
		
		// Force preview
		SET PRINT PREVIEW:C364(True:C214)
		
		// Print
		//Print_label(C_MASTER_TABLE; OB Get((OBJECT Get pointer(Object named; "object"))->; "dom"; Is text); True)
		LBL_Print_label(C_MASTER_TABLE; OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; "dom"; Is text:K8:3); True:C214)  //by kebu
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 