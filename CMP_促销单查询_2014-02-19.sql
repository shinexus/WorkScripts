/**** sSys_HsCmp_PromotionForJob? ��������Ч�������� ****/
/**** sPro_Cx_Upd_Hy_Plu Line:261 ****/

/**** �������ʹ�������� ****/
SELECT * FROM tProBillHead ORDER BY BillNo DESC;

/**** �������ʹ�����ϸ�� ****/
SELECT * FROM tprobillBody ORDER BY BillNo DESC;

/**** ����������ȯ��Ϣ�� ****/
SELECT * FROM tProCertiInfo;

/**** ���ͼ��������� ****/
SELECT * FROM tProZsFullToSubResult;

/**** ����������ŵ�� ****/
SELECT * FROM tProGroupShop ORDER BY BillNo DESC;

/**** ������Ʒ��Χ���� ****/
SELECT * FROM tProPluAreaHead; 

/**** ������Ʒ��Χ��ϸ�� ****/
SELECT * FROM tProPluAreaBody; 

/**** ���������� ****/
SELECT * FROM tprocxbillhead WHERE JzDate >= '2014-02-24' ORDER BY BillNo DESC;

/**** ������֯�� ****/
SELECT * FROM tProCxOrg ORDER BY BillNo DESC;

/**** ������Ա�����ͱ� ****/
SELECT * FROM tProCxCardLx;

/**** ��Ա������Ʒ�� ****/
SELECT * FROM tProCxHyPlu;

/**** ��������� ****/
SELECT * FROM tProCxJob ORDER BY BillNo DESC;

/**** ���� ****/
SELECT * FROM vProCxPlu ORDER BY BillNo DESC;
SELECT * FROM TprocxHyplu;
SELECT * FROM SysTemp_tProOriCxPlu;

/**** ���[����������]��Ʒ������ʾΪС���Ĵ��� ****/
UPDATE tsysclasspropdict SET refPropId ='14' WHERE classid = '12202' AND fieldname ='BarCode';