--销售交易重复流水异常数据表
select * FROM tSysRSaleERR;
--销售商品重复流水异常数据表
select * FROM tSysRSalePluERR;
--销售付款重复流水异常数据表
select * FROM tSysRSalePayERR;
--销售商品优惠重复流水异常数据表
select * FROM tSysRSalePluDscERR;
--收款机重复日志流水异常数据表
select * FROM tSysRPosLogERR;

SELECT * FROM tSysBillType
ORDER BY BillCode

SELECT * FROM tSysOverLog WHERE OrgCode = '3001' ORDER BY ItemCode

SELECT * FROM tSalSale WHERE JzDate = NULL