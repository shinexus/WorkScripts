/*结账日期修改*/
--收款机
--检查收款机结账日期
select * from tjkPosjzdate

--修改收款机结账日期
UPDATE tJkPosJzDate SET JzDate = '2012-04-05', LastJzDate = '2012-04-04'

--检查收款机流水
SELECT * FROM tSalSale WHERE JzDate = '2012-04-07'

--修改收款机流水
UPDATE tSalSale SET JzDate = '2012-04-06' WHERE JzDate='2012-04-07'

--收款机监控
--检查收款机流水
SELECT * FROM tSalSale WHERE PosNo='0009' AND JzDate = '2012-04-07'

--修改收款机流水
UPDATE tSalSale SET JzDate = '2012-04-06' WHERE PosNo = '0009' AND JzDate='2012-04-07'

--业务数据库
--检查收款机流水

--修改收款机流水

/*流水日期修改*/
--收款机
SELECT * FROM tSalSale
--2010-01-01;2012-04-11
UPDATE tSalSale SET XsDate = DATEADD (MONTH,27,XsDate)
UPDATE tSalSale SET XsDate = DATEADD (DAY,10,XsDate)
