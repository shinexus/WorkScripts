/****  collate  collateitem  ****************************************************
*****  数据字典  *****************************************************************/
SELECT * FROM Collate@HDWMS;
SELECT * FROM Collateitem@HDWMS;

/**** TALCNTC WM_配货通知单 ****/
SELECT * FROM TALCNTC@HDWMS;

SELECT * FROM TALCNTC@HDWMS WHERE FSrcNum = 'P' || '1001PSYW201401280132';