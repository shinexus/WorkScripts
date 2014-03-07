-- DispatchList:	发货退货单主表
-- csvouchtype:		来源单据类型
-- cDLCode:			发货退货单号
-- dverifydate:		审核日期
-- dverifysystime:	审核时间
-- cVouchType:		单据类型编码
-- cCusCode:		客户编码
select * from DispatchList
WHERE cCusCode LIKE '030100%'
AND DLID = '38367'
ORDER BY dDate

-- DispatchLists:	发货退货单子表
-- DLID:			发货退货单主表标识
-- cInvCode:		存货编码
-- iQuantity:		数量
-- cMemo:			备注
-- cUnitID:			计量单位编码
SELECT * FROM DispatchLists
WHERE DLID = '38367'

-- Inventory:		存货档案
-- cInvStd:			规格型号
-- cComUnitCode:	主计量单位编码
-- cAssComUnitCode:	辅计量单位编码
SELECT * FROM Inventory

-- ComputationUnit:	计量单位
SELECT * FROM ComputationUnit