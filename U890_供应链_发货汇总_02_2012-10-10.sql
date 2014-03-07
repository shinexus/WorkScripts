SELECT 
DLs.cInvCode AS '存货编码', 
DLs.cInvName AS '存货名称',
Inv.cInvStd AS '规格型号',
CU.cComUnitName AS '单位' 
FROM 
DispatchLists DLs, 
DispatchList DL, 
Inventory Inv, 
ComputationUnit CU
WHERE 
DLS.DLID = DL.DLID
AND DLs.cInvCode = Inv.cInvCode
AND DL.dDate BETWEEN '2012-10-10' AND '2012-10-10'
