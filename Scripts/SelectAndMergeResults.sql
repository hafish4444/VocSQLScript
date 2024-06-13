-- Change delimiter to //
-- Drop the existing procedure if it exists
DROP PROCEDURE IF EXISTS SelectAndMergeResults;
DELIMITER //


-- Create the new procedure
CREATE PROCEDURE SelectAndMergeResults()
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

    -- Create temporary table to store the merged results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_merged_results (
        SalakTypeId INT,
        salak_type_name VARCHAR(255),
        salak_type_url VARCHAR(255),
        Order_PrizeCode VARCHAR(255),
        Order_Time VARCHAR(255),
        Order_TurnOn INT,
        ranking_reward_name VARCHAR(255)
    );

    OPEN cursor1;
    
    read_loop: LOOP
        FETCH cursor1 INTO SalakTypeId, PrizeOrderTable, PrizeOrderCode;
        IF idx = 0 THEN
            LEAVE read_loop;
        END IF;

        -- Prepare the dynamic SQL statement
        SET @sql = CONCAT(
            'INSERT INTO temp_merged_results (SalakTypeId, salak_type_name, salak_type_url, Order_PrizeCode, Order_Time, Order_TurnOn, ranking_reward_name) ',
            'SELECT ', SalakTypeId, ', st.salak_type_name, st.salak_type_url, ktb1.Order_PrizeCode, ktb1.Order_Time, ktb1.Order_TurnOn, rrt.ranking_reward_name ',
            'FROM salak_db_old.', PrizeOrderTable, ' ktb1 ',
            'LEFT JOIN ( ',
            '    SELECT srd.salak_reward_id, srd.salak_reward_detail_id, ',
            '           DATE_FORMAT(DATE_ADD(sr.month_of_release, INTERVAL 543 YEAR), ''%m/%Y'') as release_month, ',
            '           sr.month_of_release, rr.ranking_reward_id, Prize_Code, rr.ranking_reward_name, srd.salak_number ',
            '    FROM salak_db_old.', PrizeOrderCode,' k  ',
            '    INNER JOIN salak_db.ranking_rewards_temp rr ON k.Prize_Code = rr.ranking_reward_code ',
            '    INNER JOIN salak_db.salak_rewards_detail srd ON srd.ranking_reward_id = rr.ranking_reward_id ',
            '    INNER JOIN salak_db.salak_rewards sr ON srd.salak_reward_id = sr.salak_reward_id ',
            '    WHERE sr.salak_type_id = ', SalakTypeId, ' ',
            '    ORDER BY sr.month_of_release ',
            ') srdg ON ktb1.Order_Time = DATE_FORMAT(DATE_ADD(srdg.month_of_release, INTERVAL 543 YEAR), ''%Y%m'') ',
            'AND ktb1.Order_PrizeCode = srdg.Prize_Code ',
            'INNER JOIN salak_db.ranking_rewards_temp rrt ON rrt.ranking_reward_code = ktb1.Order_PrizeCode ',
            'LEFT JOIN salak_db.salak_types st ON st.salak_type_id = ', SalakTypeId, ' ',
            'WHERE srdg.salak_reward_id IS NULL;'
        );

        -- Print the dynamic SQL statement for debugging
        -- SELECT @sql AS generated_sql;

        -- Execute the dynamic SQL statement
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

    END LOOP;

    CLOSE cursor1;

    -- Select the aggregated results from the temporary table
    SELECT tmr.salak_type_url, Order_Time, group_concat(distinct tmr.Order_PrizeCode), group_concat(distinct tmr.ranking_reward_name) 
    FROM temp_merged_results tmr 
   	where cast(Order_Time as int) >= 255801
   	group by tmr.SalakTypeId, Order_Time ;

    -- Drop the temporary table after selecting the results
    DROP TEMPORARY TABLE IF EXISTS temp_merged_results;
END //

-- Reset delimiter to ;
DELIMITER ;

CALL SelectAndMergeResults();
	