SELECT 
DLs.cInvCode AS '�������', 
DLs.cInvName AS '�������',
Inv.cInvStd AS '����ͺ�',
CU.cComUnitName AS '��λ' 
FROM 
DispatchLists DLs, 
DispatchList DL, 
Inventory Inv, 
ComputationUnit CU
WHERE 
DLS.DLID = DL.DLID
AND DLs.cInvCode = Inv.cInvCode
AND DL.dDate BETWEEN '2012-10-10' AND '2012-10-10'
