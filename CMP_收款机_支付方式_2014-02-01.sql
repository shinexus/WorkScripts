SELECT *
  FROM [pos_pos].[dbo].[tJkPosKeyValue] WHERE FuncCap = '会员积分消费'
GO

INSERT INTO [Pos_Pos].[dbo].[tJkPosKeyValue] 
([FuncType],[FuncValue],[FuncCap],[DispIndex],[CanUse]) VALUES
('2','221','会员积分消费','95','1')
GO