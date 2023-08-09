//%attributes = {}

C_TEXT:C284($document)
//LBL_PRINT(->[Table_1]; $document)

PRINT LABEL:C39  //コメント
PRINT LABEL:C39([Table_1:1]; Char:C90(1))  //コメント
PRINT LABEL:C39([Table_1:1])  //→ LBL_PRINT(->[Table_1])
PRINT LABEL:C39([Table_1:1]; $document)  //→ LBL_PRINT(->[Table_1];$document)
PRINT LABEL:C39([Table_1:1]; $document; *)  //→ LBL_PRINT(->[Table_1];$document;"*")
PRINT LABEL:C39([Table_1:1]; $document; >)  //→ LBL_PRINT(->[Table_1]; $document; ">")
