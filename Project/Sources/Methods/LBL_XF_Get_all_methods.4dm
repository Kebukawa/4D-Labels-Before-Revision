//%attributes = {}
/*

目的
全メソッドのパスを得る

参考
http://tech.4d-japan.com/Tips/2385/

*/

C_COLLECTION:C1488($0)
$0:=New collection:C1472

ARRAY TEXT:C222($ref_objects; 0)
C_LONGINT:C283($i)

//プロジェクトメソッド（注：現行バージョンはプロジェクトメソッド名＝パス）
METHOD GET NAMES:C1166($ref_objects; *)
For ($i; 1; Size of array:C274($ref_objects))
	$0.push(METHOD Get path:C1164(Path project method:K72:1; $ref_objects{$i}))
End for 

//プロジェクトフォーム
METHOD GET PATHS FORM:C1168($ref_objects; *)
For ($i; 1; Size of array:C274($ref_objects))
	$0.push($ref_objects{$i})
End for 

//テーブルフォーム
C_LONGINT:C283($table_NO)
For ($table_NO; 1; Get last table number:C254)
	If (Is table number valid:C999($table_NO))
		METHOD GET PATHS FORM:C1168(Table:C252($table_NO)->; $ref_objects; *)
		For ($i; 1; Size of array:C274($ref_objects))
			$0.push($ref_objects{$i})
		End for 
	End if 
End for 
