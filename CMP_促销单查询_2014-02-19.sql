/**** sSys_HsCmp_PromotionForJob? 促销单生效作废任务 ****/
/**** sPro_Cx_Upd_Hy_Plu Line:261 ****/

/**** 满减满送促销活动主表 ****/
SELECT * FROM tProBillHead ORDER BY BillNo DESC;

/**** 满减满送促销明细表 ****/
SELECT * FROM tprobillBody ORDER BY BillNo DESC;

/**** 满减满送赠券信息表 ****/
SELECT * FROM tProCertiInfo;

/**** 满就减计算结果表 ****/
SELECT * FROM tProZsFullToSubResult;

/**** 促销活动参与门店表 ****/
SELECT * FROM tProGroupShop ORDER BY BillNo DESC;

/**** 促销商品范围主表 ****/
SELECT * FROM tProPluAreaHead; 

/**** 促销商品范围明细表 ****/
SELECT * FROM tProPluAreaBody; 

/**** 促销单主表 ****/
SELECT * FROM tprocxbillhead WHERE JzDate >= '2014-02-24' ORDER BY BillNo DESC;

/**** 促销组织表 ****/
SELECT * FROM tProCxOrg ORDER BY BillNo DESC;

/**** 促销会员卡类型表 ****/
SELECT * FROM tProCxCardLx;

/**** 会员促销商品表 ****/
SELECT * FROM tProCxHyPlu;

/**** 促销任务表 ****/
SELECT * FROM tProCxJob ORDER BY BillNo DESC;

/**** 调试 ****/
SELECT * FROM vProCxPlu ORDER BY BillNo DESC;
SELECT * FROM TprocxHyplu;
SELECT * FROM SysTemp_tProOriCxPlu;

/**** 解决[制作促销单]商品条码显示为小数的错误 ****/
UPDATE tsysclasspropdict SET refPropId ='14' WHERE classid = '12202' AND fieldname ='BarCode';