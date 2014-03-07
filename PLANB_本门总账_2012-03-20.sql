create table bmzz_tmp
(month varchar2(4),
orgcode varchar2(10),
orgname varchar2(20),
bqqc number(20,2),
bqjh number(20,2),
bqcb number(20,2),
bqqm number(20,2)
)

select * from bmzz_tmp for update

create table bmzzsc_tmp
(month varchar2(4),
orgcode varchar2(10),
orgname varchar2(20),
bqqc number(20,2),
bqjh number(20,2),
bqcb number(20,2),
bqqm number(20,2)
)

select * from bmzzsc_tmp for update