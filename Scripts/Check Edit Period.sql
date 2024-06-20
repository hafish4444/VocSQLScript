select srd.salak_reward_id, srd.release_date, rr.ranking_reward_name , srd.period_display sit, devsrd.period_display dev from salak_db_sit.salak_rewards_detail srd
inner join salak_db_dev_v2.salak_rewards_detail devsrd
on srd.salak_reward_id  = devsrd.salak_reward_id and  srd.ranking_reward_id = devsrd.ranking_reward_id and srd.price_detail  = devsrd.price_detail 
inner join salak_db_dev_v2.ranking_rewards rr 
on rr.ranking_reward_id = srd.ranking_reward_id 
where srd.period_display is not null and srd.period_display <> devsrd.period_display
group by srd.salak_reward_id, srd.ranking_reward_id, srd.price_detail
;

select * from salak_db_sit.salak_rewards_detail srd  where srd.salak_reward_id  = 26;
select * from salak_db_dev_v2.salak_rewards_detail srd  where srd.salak_reward_id  = 26;

select srd.salak_reward_id , srd.period_display, REPLACE(srd.period_display, 'และ ', 'และงวดที่ '), REPLACE(REPLACE(srd.period_display, 'และ ', 'และงวดที่ '), 'และงวดที่ ', 'และ ')
from salak_db_dev_v2.salak_rewards_detail srd 
where srd.period_display  <> "" and srd.period_display  is not null;

select srd.salak_reward_detail_id, REPLACE(srd.period_display, 'และ ', 'และงวดที่ ')
from salak_db_dev_v2.salak_rewards_detail srd 
where srd.period_display  <> "" and srd.period_display  is not null;

UPDATE salak_db_sit.salak_rewards_detail srd
SET srd.period_display = REPLACE(srd.period_display, 'และ ', 'และงวดที่ ')
WHERE srd.period_display <> '' AND srd.period_display IS NOT NULL;

UPDATE salak_db_sit.salak_reward_preview_periods  srd
SET srd.period_name = REPLACE(srd.period_name, 'และ ', 'และงวดที่ ')
WHERE srd.period_name <> '' AND srd.period_name IS NOT NULL;