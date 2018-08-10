SELECT FundDetailHistory_0.fundid
	,FundDetailHistory_0."tran-date"
	,FundDetailHistory_0.refno
	,FundDetailHistory_0."tran-amt"
	,FundDetailHistory_0.trantype
	,FundDetailHistory_0.dateposted
	,FundDetailHistory_0."Adj-Date"
	,FundDetailHistory_0."Adj-Num"
	,FundDetailHistory_0."Adj-Type"
	,FundDetailHistory_0."Adj-User"
	,FundDetailHistory_0."pro-idcode"
	,Profile_0.AnnualName
	,Grants_0.ProgCode1
	,Grants_0.progname
	,Grants_0.ProjectCode
	,Grants_0."Inter-Fund"
	,now() AS 'GrantDataAsOf'
FROM FOUND.PUB.Fund Fund_0
	,FOUND.PUB.FundDetailHistory FundDetailHistory_0
	,FOUND.PUB.Grants Grants_0
	,FOUND.PUB.PROFILE Profile_0
WHERE FundDetailHistory_0.fundid = Fund_0.fundid
	AND FundDetailHistory_0."pro-idcode" = Profile_0.IDCode
	AND FundDetailHistory_0.refno = Grants_0.GrantNum
	AND (
		(
			FundDetailHistory_0."tran-date" >= ?
			AND FundDetailHistory_0."tran-date" <= ?
			)
		AND (FundDetailHistory_0.trantype = 'gr')
		AND (
			Fund_0."Fund-class" >= '21'
			AND Fund_0."Fund-class" <= '65'
			AND Fund_0."Fund-class" NOT IN (
				36
				,60
				)
			)
		AND (Grants_0."Inter-Fund" = 0)
		)
ORDER BY FundDetailHistory_0.refno
