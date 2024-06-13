

-- select * from salak_db.salak_types;
DROP PROCEDURE IF EXISTS UpdateAmountOfWin;
DELIMITER //

CREATE PROCEDURE UpdateAmountOfWin()
BEGIN
    DECLARE SalakTypeId INT;
    DECLARE PrizeOrderTable VARCHAR(255);
    DECLARE PrizeOrderCode VARCHAR(255);
    DECLARE idx INT DEFAULT 1;

    -- Declare cursor for table names and corresponding SalakTypeIds
    DECLARE cursor1 CURSOR FOR 
        SELECT 1 AS SalakTypeId, 'ktbprizeorderyouth' AS PrizeOrderTable, 'ktbprizecodeyouth' AS PrizeOrderCode
        UNION ALL
        SELECT 2, 'ktbprizeorderdg1', 'ktbprizecodedg1'
        UNION ALL
        SELECT 3, 'ktbprizeorder2', 'ktbprizecode2'
        UNION ALL
        SELECT 4, 'ktbprizeorder', 'ktbprizecode'
        UNION ALL
        SELECT 5, 'ktbprizeorder5', 'ktbprizecode5';

    -- Handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET idx = 0;

    OPEN cursor1;	
    
    read_loop: LOOP
        FETCH cursor1 INTO SalakTypeId, PrizeOrderTable, PrizeOrderCode;
        IF idx = 0 THEN
            LEAVE read_loop;
        END IF;

        -- Prepare and execute the dynamic SQL statement
        SET @sql = CONCAT(
            'UPDATE salak_db.salak_rewards_detail srd ',
            'INNER JOIN ( ',
            '    SELECT srdg.salak_reward_detail_id, ktb1.Order_TurnOn ',
            '    FROM salak_db_old.', PrizeOrderTable, ' ktb1 ',
            '    INNER JOIN ( ',
            '        SELECT srd.salak_reward_detail_id, ',
            '               DATE_FORMAT(DATE_ADD(sr.month_of_release, INTERVAL 543 YEAR), ''%m/%Y'') as release_month, ',
            '               sr.month_of_release, rr.ranking_reward_id, Prize_Code, rr.ranking_reward_name, srd.salak_number ',
            '        FROM salak_db_old.', PrizeOrderCode,' k ',
            '        INNER JOIN salak_db.ranking_rewards_temp rr ON k.Prize_Code = rr.ranking_reward_code ',
            '        INNER JOIN salak_db.salak_rewards_detail srd ON srd.ranking_reward_id = rr.ranking_reward_id ',
            '        INNER JOIN salak_db.salak_rewards sr ON srd.salak_reward_id = sr.salak_reward_id ',
            '        WHERE sr.salak_type_id = ', SalakTypeId, ' ',
            '        ORDER BY sr.month_of_release ',
            '    ) srdg ON ktb1.Order_Time = DATE_FORMAT(DATE_ADD(srdg.month_of_release, INTERVAL 543 YEAR), ''%Y%m'') ',
            '            AND ktb1.Order_PrizeCode = srdg.Prize_Code ',
            ') subquery ON srd.salak_reward_detail_id = subquery.salak_reward_detail_id ',
            'SET srd.amount_of_win = subquery.Order_TurnOn;'
        );
--         SELECT @sql AS generated_sql;

        -- Execute the dynamic SQL statement
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

    END LOOP;

    CLOSE cursor1;
END //

DELIMITER ;
CALL UpdateAmountOfWin();