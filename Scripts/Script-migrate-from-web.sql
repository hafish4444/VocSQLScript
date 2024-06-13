
UPDATE salak_db_dev.salak_rewards_detail srd
INNER JOIN (
    SELECT 
        srd.salak_reward_detail_id, 
        sdw.period_display, 
        sdw.amount_of_win
    FROM salak_db_dev.salak_rewards sr 
    INNER JOIN salak_db_dev.salak_rewards_detail srd 
        ON sr.salak_reward_id = srd.salak_reward_id
    INNER JOIN salak_db_dev.ranking_rewards rr
        ON rr.ranking_reward_id = srd.ranking_reward_id 
    INNER JOIN salak_db_dev.salak_types st
        ON st.salak_type_id = sr.salak_type_id  
    INNER JOIN salak_db.salak_data_web sdw
        ON sdw.salak_type_id = sr.salak_type_id 
        AND DATE_FORMAT(sdw.`date`, "%Y%m%d") = DATE_FORMAT(sr.release_date, "%Y%m%d")
        AND sdw.ranking_id = srd.ranking_reward_id  
        AND sdw.rank_price = srd.price  
    where sr.salak_type_id <> 1 and sr.salak_type_id <> 2
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
SET srd.amount_of_win = subquery.amount_of_win;