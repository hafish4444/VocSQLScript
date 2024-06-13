select * from salak_rewards srd;
select * from salak_rewards_detail srd;


select srd.salak_reward_detail_id, st.salak_type_id  , DATE_FORMAT(sr.release_date, "%Y%m") release_month, rr.ranking_reward_name, srd.price, sdw.amount_of_release, sdw.amount_of_win, sdw.rank_price  
from salak_db_test.salak_rewards sr 
inner join salak_db_test.salak_rewards_detail srd 
on sr.salak_reward_id  = srd.salak_reward_id
inner join salak_db_test.ranking_rewards rr
on rr.ranking_reward_id = srd.ranking_reward_id 
inner join salak_db_test.salak_types st
on st.salak_type_id  = sr.salak_type_id  
inner join salak_db.salak_data_web sdw
on sdw.salak_type_id = sr.salak_type_id and DATE_FORMAT(sdw.`date`, "%Y%m") = DATE_FORMAT(sr.release_date, "%Y%m") and sdw.ranking_id = srd.ranking_reward_id  and sdw.rank_price  = srd.price  
group by sdw.salak_type_id,  DATE_FORMAT(sr.release_date, "%Y%m"), sdw.ranking_id, sdw.rank_price, srd.salak_number, srd.account_type, srd.salak_reward_detail_id
order by 
srd.salak_reward_detail_id 
-- sr.salak_type_id, release_month, rr.ord, srd.salak_reward_detail_id 
;

CREATE INDEX idx_salak_data_web ON salak_db.salak_data_web(salak_type_id, date, ranking_id);

select *,
	sdw.ranking_name, 
	rr.ranking_reward_name 
from
	salak_db.salak_data_web sdw 
left join salak_db_test.ranking_rewards rr
on sdw.ranking_name = rr.ranking_reward_name 
-- group by sdw.ranking_name
where ranking_name = "เลขท้าย 4 ตัว"
order by salak_type, date, ranking_name
;

select * from salak_types st ;

select sdw.ranking_name
from 
salak_db.salak_data_web sdw 
group by ranking_name 
order by salak_type, date, ranking_name
;

select * from salak_db.salak_data_web sdw where ranking_name  = "รางวัลเพื่อการศึกษา" ;

select * from salak_db_test.ranking_rewards rr; 



select * from salak_db_test.salak_rewards_detail srd where srd.salak_reward_detail_id in ("35126", "35127", "35059");


UPDATE salak_db_test.salak_rewards_detail srd
INNER JOIN (
    SELECT 
        srd.salak_reward_detail_id, 
        sdw.period_display, 
        sdw.amount_of_win
    FROM salak_db_test.salak_rewards sr 
    INNER JOIN salak_db_test.salak_rewards_detail srd 
        ON sr.salak_reward_id = srd.salak_reward_id
    INNER JOIN salak_db_test.ranking_rewards rr
        ON rr.ranking_reward_id = srd.ranking_reward_id 
    INNER JOIN salak_db_test.salak_types st
        ON st.salak_type_id = sr.salak_type_id  
    INNER JOIN salak_db.salak_data_web sdw
        ON sdw.salak_type_id = sr.salak_type_id 
        AND DATE_FORMAT(sdw.`date`, "%Y%m%d") = DATE_FORMAT(sr.release_date, "%Y%m%d")
        AND sdw.ranking_id = srd.ranking_reward_id  
        AND sdw.rank_price = srd.price  
    GROUP BY 
        sdw.salak_type_id,  
        DATE_FORMAT(sr.release_date, "%Y%m%d"), 
        sdw.ranking_id, 
        sdw.rank_price, 
        srd.salak_number, 
        srd.account_type, 
        srd.salak_reward_detail_id
) subquery
ON srd.salak_reward_detail_id = subquery.salak_reward_detail_id
SET srd.period_display = subquery.period_display, 
    srd.amount_of_win = subquery.amount_of_win;
