SELECT Prize_Time, Prize_Code, Prize_TimeNo, Prize_term, Prize_Group, Prize_WinNo, Flag_Intranet, user_id, Post_Date 
FROM kmsprizenodg1 where kmsprizenodg1.Prize_WinNo = 1872263;

-- SELECT 
-- 	DATE_FORMAT(DATE_ADD(srd.release_date, INTERVAL 543 YEAR), '%m/%Y') as date, 
-- 	rr.ranking_reward_name,
-- 	srd.salak_number,
-- 	ktb1.Order_TurnOn
-- 
-- inner join salak_db.salak_rewards_detail srd on 
-- 	ktb1.Order_Time = DATE_FORMAT(DATE_ADD(srd.release_date, INTERVAL 543 YEAR), '%Y%m')
-- inner join salak_db.ranking_rewards rr on 
-- 	rr.ranking_reward_id  = srd.ranking_reward_id
-- inner join salak_db_old.ktbprizecode k on 
-- 	k.Prize_SeqNo  = rr.ranking_reward_code
-- inner join salak_db.salak_rewards sr on 
-- 	srd.salak_reward_id = sr.salak_reward_id and sr.salak_type_id = 2
-- group by DATE_FORMAT(DATE_ADD(srd.release_date, INTERVAL 543 YEAR), '%Y%m') , rr.ranking_reward_id
-- 	;

select 
ktb1.Order_PrizeCode
, rrt.ranking_reward_name
-- , srdg.salak_reward_id
-- , srdg.salak_reward_detail_id
, ktb1.Order_Time
, ktb1.Order_TurnOn
-- , srdg.release_month
-- , srdg.release_date
-- , srdg.ranking_reward_id
-- , srdg.Prize_code
-- , srdg.salak_number
FROM salak_db_old.ktbprizeorder2 ktb1
left join 
(
	select srd.salak_reward_id, srd.salak_reward_detail_id, DATE_FORMAT(DATE_ADD(srd.release_date, INTERVAL 543 YEAR), '%m/%Y') as release_month , 
		srd.release_date,
		rr.ranking_reward_id, 
		Prize_Code, 
		rr.ranking_reward_name, 
		srd.salak_number
	from salak_db_old.ktbprizecode k 
	inner join salak_db.ranking_rewards_temp rr 
	on 
		k.Prize_Code  = rr.ranking_reward_code
	inner join salak_db.salak_rewards_detail srd
	on
		srd.ranking_reward_id  = rr.ranking_reward_id 
	inner join salak_db.salak_rewards sr on 
		srd.salak_reward_id = sr.salak_reward_id
	where sr.salak_type_id = 3 
	order by srd.release_date
) srdg
on ktb1.Order_Time = DATE_FORMAT(DATE_ADD(srdg.release_date, INTERVAL 543 YEAR), '%Y%m') and ktb1.Order_PrizeCode = srdg.Prize_Code
inner join salak_db.ranking_rewards_temp rrt
on rrt.ranking_reward_code = ktb1.Order_PrizeCode
where salak_reward_id is null;

SELECT 
	*
FROM salak_db_old.ktbprizeorderdg1 ktb1  
inner join salak_db.salak_rewards_detail srd on 
	ktb1.Order_Time = DATE_FORMAT(DATE_ADD(srd.release_date, INTERVAL 543 YEAR), '%Y%m')
;	
	
SELECT *
FROM ktbprizeorder k ;

SELECT *
FROM salak_db.salak_rewards_detail;

select * from kmsprizeno2 k where Prize_Time  = "256502" ;


select * from ktbprizecode k ;

select * from salak_db.ranking_rewards rr ;

select * from salak_db_old.ktbprizeorderdg1 where Order_Time = "256604";

