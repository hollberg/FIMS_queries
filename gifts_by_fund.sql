SELECT FundDetailHistory_0.fundid
	,FundDetailHistory_0."tran-date"
	,FundDetailHistory_0.refno
	,FundDetailHistory_0."tran-amt"
	,Gifthistory_0.GiftAmt
	,Gifthistory_0."non-giftamt"
	,FundDetailHistory_0.trantype
	,FundDetailHistory_0.dateposted
	,FundDetailHistory_0."Adj-Date"
	,FundDetailHistory_0."Adj-Num"
	,FundDetailHistory_0."Adj-Type"
	,FundDetailHistory_0."Adj-User"
	,FundDetailHistory_0."pro-idcode"
	,FundDetailHistory_0."don-idcode"
	,Profile_0.ASF
	,Profile_0.AnnualName
	,Gifthistory_0."Ack-Name"
	,Gifthistory_0.GiftComment
	,Gifthistory_0.GiftTypeCode
	,Gifthistory_0."Inter-Fund"
	,now() AS 'GiftDataAsOf'
FROM FOUND.PUB.Fund Fund_0
	,FOUND.PUB.FundDetailHistory FundDetailHistory_0
	,FOUND.PUB.Gifthistory Gifthistory_0
	,FOUND.PUB.PROFILE Profile_0
WHERE FundDetailHistory_0.fundid = Fund_0.fundid
	AND FundDetailHistory_0."don-idcode" = Profile_0.IDCode
	AND FundDetailHistory_0.refno = Gifthistory_0.GiftNum
	AND (
		(
			FundDetailHistory_0."tran-date" >= ?
			AND FundDetailHistory_0."tran-date" <= ?
			)
		AND (FundDetailHistory_0.trantype = 'gi')
		AND (
			Fund_0."Fund-class" >= '21'
			AND Fund_0."Fund-class" <= '65'
			AND Fund_0."Fund-class" NOT IN (
				'36'
				,'60'
				)
			)
		)
ORDER BY FundDetailHistory_0.fundid
	,FundDetailHistory_0."tran-date"
	,FundDetailHistory_0.refno
