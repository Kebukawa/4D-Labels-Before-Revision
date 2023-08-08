//%attributes = {"shared":true}

//作業用変数定義
C_TEXT:C284($code)  //メソッドコード用
ARRAY LONGINT:C221($pos; 0)  //Match regex用
ARRAY LONGINT:C221($len; 0)  //Match regex用

//全メソッドのパスを得る
//ARRAY TEXT($methods; 0)
C_COLLECTION:C1488($methods)
$methods:=LBL_XF_Get_all_methods  //(->$methods)

//インストール済みか検査する
$not_install:=True:C214
For each ($m; $methods) While ($not_install)
	METHOD GET CODE:C1190($m; $code; *)
	If (Match regex:C1019("(?m)^\\s*LBL_PRINT[ \\(]*$"; $code; 1))
		$not_install:=False:C215  //インストールされていた
	End if 
End for each 

If ($not_install)
	//インストールされていないとき
	CONFIRM:C162("コンポーネントメソッドをインストールしますか？"; "インストールする"; "しない")
Else 
	//インストールされているとき
	CONFIRM:C162("コンポーネントメソッドをアンインストールしてもとに戻しますか？"; "もとに戻す"; "そのままにする")
End if 

Case of 
	: (OK=1) & ($not_install)
		
		
/*
		
対応するパターンは下記のものに限る
コメントは//のみ対応
		
PRINT LABEL → LBL_PRINT
PRINT LABEL([Table_1];Char(1)) → LBL_PRINT(->[Table_1];Char(1))
PRINT LABEL([Table_1]) → LBL_PRINT(->[Table_1])
PRINT LABEL([Table_1]; $document) → LBL_PRINT(->[Table_1]; $document)
PRINT LABEL([Table_1]; $document; *) → LBL_PRINT(->[Table_1]; $document; "*")
PRINT LABEL([Table_1]; $document; >) → LBL_PRINT(->[Table_1]; $document; ">")
		
*/
		
		For each ($path; $methods)
			METHOD GET CODE:C1190($path; $code; *)
			$lines:=Split string:C1554($code; "\r")
			$modified:=False:C215
			$code:=""
			For each ($row; $lines)
				
				Case of 
					: (Match regex:C1019("^\\s*PRINT LABEL.*?(\\(\\s?(\\[.*?\\])\\s?;\\s?Char\\(1\\)\\s*?\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$bonus:=Substring:C12($row; $pos{3}; $len{3})
						$modified:=True:C214
						$code:=$code+"LBL_PRINT(->"+$param1+";Char(1))"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*PRINT LABEL.*?(\\(\\s?(\\[.*?\\])\\s?;\\s?(\\S*?)\\s?;\\s?([*|>])\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$param2:=Substring:C12($row; $pos{3}; $len{3})
						$param3:=Substring:C12($row; $pos{4}; $len{4})
						$bonus:=Substring:C12($row; $pos{5}; $len{5})
						$modified:=True:C214
						$code:=$code+"LBL_PRINT(->"+$param1+";"+$param2+";\""+$param3+"\")"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*PRINT LABEL.*?(\\(\\s?(\\[.*?\\])\\s?;\\s?(\\S*?)\\s?\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$param2:=Substring:C12($row; $pos{3}; $len{3})
						$bonus:=Substring:C12($row; $pos{4}; $len{4})
						$modified:=True:C214
						$code:=$code+"LBL_PRINT(->"+$param1+";"+$param2+")"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*PRINT LABEL.*?(\\(\\s?(\\[.*?\\])\\s?\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$bonus:=Substring:C12($row; $pos{3}; $len{3})
						$modified:=True:C214
						$code:=$code+"LBL_PRINT(->"+$param1+")"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*PRINT LABEL(\\s?.*)$"; $row; 1; $pos; $len))
						$bonus:=Substring:C12($row; $pos{1}; $len{1})
						$modified:=True:C214
						$code:=$code+"LBL_PRINT"+$bonus+"\r"
						
					Else 
						$code:=$code+$row+"\r"
						
				End case 
			End for each 
			If ($modified)  //修正があったか？
				METHOD SET CODE:C1194($path; $code; *)
			End if 
		End for each 
		
		
		
	: (OK=1)
		
		//アンインストールして、もとに戻す
		
		For each ($path; $methods)
			METHOD GET CODE:C1190($path; $code; *)
			$lines:=Split string:C1554($code; "\r")
			$modified:=False:C215
			$code:=""
			For each ($row; $lines)
				
				Case of 
					: (Match regex:C1019("^\\s*LBL_PRINT.*?(\\(\\s?\\->(\\[.*?\\])\\s?;\\s?Char\\(1\\)\\s*?\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$bonus:=Substring:C12($row; $pos{3}; $len{3})
						$modified:=True:C214
						$code:=$code+"PRINT LABEL("+$param1+";Char(1))"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*LBL_PRINT.*?(\\(\\s?\\->(\\[.*?\\])\\s?;\\s?(\\S*?)\\s?;\\s?\"([*|>])\"\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$param2:=Substring:C12($row; $pos{3}; $len{3})
						$param3:=Substring:C12($row; $pos{4}; $len{4})
						$bonus:=Substring:C12($row; $pos{5}; $len{5})
						$modified:=True:C214
						$code:=$code+"PRINT LABEL("+$param1+";"+$param2+";"+$param3+")"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*LBL_PRINT.*?(\\(\\s?\\->(\\[.*?\\])\\s?;\\s?(\\S*?)\\s?\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$param2:=Substring:C12($row; $pos{3}; $len{3})
						$bonus:=Substring:C12($row; $pos{4}; $len{4})
						$modified:=True:C214
						$code:=$code+"PRINT LABEL("+$param1+";"+$param2+")"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*LBL_PRINT.*?(\\(\\s?\\->(\\[.*?\\])\\s?\\))(.*)$"; $row; 1; $pos; $len))
						$param:=Substring:C12($row; $pos{1}; $len{1})
						$param1:=Substring:C12($row; $pos{2}; $len{2})
						$bonus:=Substring:C12($row; $pos{3}; $len{3})
						$modified:=True:C214
						$code:=$code+"PRINT LABEL("+$param1+")"+$bonus+"\r"
						
					: (Match regex:C1019("^\\s*LBL_PRINT(\\s?.*)$"; $row; 1; $pos; $len))
						$bonus:=Substring:C12($row; $pos{1}; $len{1})
						$modified:=True:C214
						$code:=$code+"PRINT LABEL"+$bonus+"\r"
						
					Else 
						$code:=$code+$row+"\r"
						
				End case 
			End for each 
			If ($modified)  //修正があったか？
				METHOD SET CODE:C1194($path; $code; *)
			End if 
		End for each 
		
		
End case 
