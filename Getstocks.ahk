



FileAppend, % codes(), r:\aa.txt

return

;~ 得到最新股票代码  ######################################################################
codes()
{
	astock := "http://www.shdjt.com/js/lib/astock.js"
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("Get", astock, true)
	whr.Send()
	whr.WaitForResponse()
	astock := whr.ResponseText

	SArray := StrSplit(astock, "~")
	codes =
	Loop % SArray.MaxIndex()
	{
		String := SArray[a_index]
		var := SubStr(String, 1, 2)
		if var in 00,30
			codes .=  "sz" . SubStr(String, 1, 6) . ","
		else if var = 60
			codes .=  "sh" . SubStr(String, 1, 6) . ","
	}
	codes := RTrim(codes,  ",")

	;~ 用对象方式解决剔除重复的问题，排序函数 Sort 面对数量上几千的股票列表重复剔除不干净。
	oSubList := {}
	Loop, Parse, codes, CSV
		oSubList[A_LoopField] := 1
	codes =
	for k in oSubList
		codes .= k . ","
	codes := Trim(codes,  ",")
	return codes
}

