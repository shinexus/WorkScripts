select t.dept_name,a.template_name,r.item_name,r.val_y budget,v.val_y exec,r.val_y-v.val_y chayi from bm_budgeteering_table_rec r 
left join bm_sys.spsys_department t
on r.dept_id=t.dept_id left join bm_budget_template a on r.template_id=a.template_id
left join (
select * from bm_budget_rec_exec c where c.col_header='本年预算' and c.measure_inner_name='CURR_AMOUNT'
) v on v.dept_id=r.dept_id and v.template_id=r.template_id and v.item_id =r.item_id
where r.col_header='本年预算' and r.measure_inner_name='CURR_AMOUNT' 
order by r.dept_id