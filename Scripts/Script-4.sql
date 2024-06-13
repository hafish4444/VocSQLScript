
(
    SELECT t0.ranking_reward_id, t0.price, t0.c, t0.c0, t0.c1, t2.period, t0.c2
    FROM
    (
        SELECT s1.ranking_reward_id, s1.price, (
            SELECT TOP(1) s2.period
            FROM salak_rewards_detail AS s2
            INNER JOIN ranking_rewards AS r0 ON s2.ranking_reward_id == r0.ranking_reward_id
            WHERE (t.salak_reward_id == s2.salak_reward_id) && ((s1.ranking_reward_id == s2.ranking_reward_id) && (s1.price == s2.price))) AS c, (
            SELECT TOP(1) s3.alphabet
            FROM salak_rewards_detail AS s3
            INNER JOIN ranking_rewards AS r1 ON s3.ranking_reward_id == r1.ranking_reward_id
            WHERE (t.salak_reward_id == s3.salak_reward_id) && ((s1.ranking_reward_id == s3.ranking_reward_id) && (s1.price == s3.price))) AS c0, (
            SELECT TOP(1) s4.release_date
            FROM salak_rewards_detail AS s4
            INNER JOIN ranking_rewards AS r2 ON s4.ranking_reward_id == r2.ranking_reward_id
            WHERE (t.salak_reward_id == s4.salak_reward_id) && ((s1.ranking_reward_id == s4.ranking_reward_id) && (s1.price == s4.price))) AS c1, COUNT(*) AS c2
        FROM salak_rewards_detail AS s1
        INNER JOIN ranking_rewards AS r ON s1.ranking_reward_id == r.ranking_reward_id
        WHERE t.salak_reward_id == s1.salak_reward_id
        GROUP BY s1.ranking_reward_id, s1.price
    ) AS t0
    OUTER APPLY
    (
        SELECT DISTINCT s5.period
        FROM salak_rewards_detail AS s5
        INNER JOIN ranking_rewards AS r3 ON s5.ranking_reward_id == r3.ranking_reward_id
        WHERE (t.salak_reward_id == s5.salak_reward_id) && ((t0.ranking_reward_id == s5.ranking_reward_id) && (t0.price == s5.price))
    ) AS t2
) AS t1