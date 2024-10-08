CREATE DATABASE dbbank_loan_data;
USE dbbank_loan_data;

select count(*) from finance_1_dataset;
select count(*) from finance_2_dataset;


-- KPI 1
select year(issue_d) as year_of_issue_d, concat(round(sum(loan_amnt)/1000000,1),"M") as total_loan_amnt FROM finance_1_dataset 
group by year_of_issue_d order by year_of_issue_d ;



-- KPI 2
select grade, sub_grade, concat(round(sum(revol_bal)/1000000,1),"M") as total_revol_bal 
from finance_1_dataset inner join finance_2_dataset on finance_1_dataset.id=finance_2_dataset.id 
group by  grade, sub_grade order by  grade, sub_grade ;




-- KPI 3

set sql_safe_updates=0;
update finance_1_dataset set verification_status= "verified" where verification_status="source verified";

select verification_status , concat(round(sum(total_pymnt)/1000000,1),"M") as total_pymnt 
from finance_1_dataset inner join finance_2_dataset on finance_1_dataset.id=finance_2_dataset.id 
group by verification_status;



-- KPI 4
select addr_state, month(last_pymnt_d) as month_wise_pymnt, loan_status, sum(last_credit_pull_d) as total_loan_status
from finance_1_dataset inner join finance_2_dataset on finance_1_dataset.id=finance_2_dataset.id 
group by addr_state, loan_status, month_wise_pymnt order by addr_state, month_wise_pymnt;



-- KPI 5
select home_ownership, year(last_pymnt_d) as pymnt_d, concat(round(sum(last_pymnt_amnt)/1000,1),"K") as pymnt_amnt
from finance_1_dataset inner join finance_2_dataset on finance_1_dataset.id=finance_2_dataset.id 
group by home_ownership, last_pymnt_d 
order by home_ownership, last_pymnt_d ;
