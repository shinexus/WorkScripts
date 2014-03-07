SELECT
  OrgJh.BillNo    AS "���յ��ݺ�",
  OrgJh.refbillno AS "�������͵��ݺ�",
  OrgJh.horgcode  AS "������֯����",
  OrgJh.horgname  AS "������֯����",
  OrgJh.plucode   AS "������Ʒ����",
  OrgJh.PsShCount AS "�����ջ�����",
  DtsPs.BillNo    AS "���͵��ݺ�",
  DtsPs.ShOrgCode AS "�ջ���֯����",
  DtsPs.ShOrgName AS "�ջ���֯����",
  DtsPs.PluCode   AS "������Ʒ����",
  DtsPs.PsCount   AS "��������"
FROM
  (
    SELECT
      JH.billno ,
      JH.refbillno ,
      JH.horgcode ,
      jh.horgname ,
      JB.plucode ,
      SUM(PsShCount) PsShCount
    FROM
      tOrdJhHead JH ,
      tOrdJhBody JB
    WHERE
      JH.RefBillType = '2003'
    AND JH.billno    =JB.billno
    GROUP BY
      JH.billno,
      JH.refbillno,
      JH.horgcode,
      JH.horgname,
      JB.pluid,
      JB.plucode
  )
  OrgJh,
  (
    SELECT
      PH.billno,
      PH.shorgcode,
      PH.shorgname,
      --PB.pluid,
      PB.plucode ,
      SUM(PB.pscount) pscount
    FROM
      tDstPsHead PH,
      tDstPsBody PB
    WHERE
      PH.billno   =PB.billno
    AND PH.pstype =0
    AND PH.jzdate>='2013-11-27'
    GROUP BY
      PH.billno,
      PH.shorgcode,
      PH.shorgname,
      --PB.pluid,
      PB.plucode
  )
  DtsPs
WHERE
  OrgJh.refbillno   =DtsPs.billno
AND OrgJh.PsShCount<>DtsPs.pscount
AND OrgJh.pluCode   =DtsPs.plucode