
--251_经代销商品成本
--701_经代销商品采购验收
--702_经代销商品采购退货
--901_易票联业务
--901_CB2易票联业务
--901_CB易票联业务
--913_含在途的总部配送
--913_非独立门店配送验收
--914_门店退货给总部
--914_总部配退

SELECT * FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document]
	WHERE Voucher_Id = '7252'
	
DELETE FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document]
	WHERE Voucher_Id = '901'
	
INSERT INTO [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document]
	SELECT * FROM [FinanceInterface].[dbo].[Cmp2Fnc_Document]	
	WHERE Voucher_Id = '901'
	
SELECT * FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	WHERE D_Name like '252%'
		
DELETE FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	WHERE D_Name like '901%'

INSERT INTO [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	SELECT * FROM [FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	--WHERE D_Name like '901%'
	WHERE D_Name = '901_易票联业务'
