/** 商品销售数据，取自 tSalSalePluYYYYMM **/
SELECT * FROM tSalSalePlu201401;

/** 品类结构表，取自 tCatCategory **/
SELECT 
BC.ClsCode                AS B_ClsCode, 
MC.ClsCode                AS M_ClsCode, 
SubStr(SC.ClsCode, 3, 4)  AS S_ClsCode, 
SubStr(DC.ClsCode, 5, 6)  AS D_ClsCode 
FROM 
(SELECT ClsCode, ClsName FROM tCatCategory WHERE ClsCode LIKE '_'       ORDER BY ClsCode) BC,
(SELECT ClsCode, ClsName FROM tCatCategory WHERE ClsCode LIKE '__'      ORDER BY ClsCode) MC,
(SELECT ClsCode, ClsName FROM tCatCategory WHERE ClsCode LIKE '____'    ORDER BY ClsCode) SC,
(SELECT ClsCode, ClsName FROM tCatCategory WHERE ClsCode LIKE '______'  ORDER BY ClsCode) DC
WHERE 
SubStr(MC.ClsCode, 1, 1) = BC.ClsCode AND
SubStr(SC.ClsCode, 1, 2) = MC.ClsCode AND
SubStr(DC.ClsCode, 1, 4) = SC.ClsCode;