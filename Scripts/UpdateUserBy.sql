
DROP PROCEDURE IF EXISTS UpdateUserBy;
DELIMITER //

CREATE PROCEDURE UpdateUserBy()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    
    START TRANSACTION;
    
    UPDATE users SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_types SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE ranking_rewards SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_statuses SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_rewards_detail SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_rewards SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_rewards SET approved_by = 1 WHERE approved_by IS NOT NULL;
    UPDATE salak_reward_files SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_reward_previews SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE salak_activities SET created_by = 1 WHERE created_by IS NOT NULL;
    UPDATE activity_logs SET created_by = 1 WHERE created_by IS NOT NULL;

	UPDATE users SET modified_by=1 WHERE modified_by is not null;
	UPDATE salak_types SET modified_by=1 WHERE modified_by is not null;
	UPDATE ranking_rewards SET modified_by=1 WHERE modified_by is not null;
	UPDATE salak_rewards_detail SET modified_by=1 WHERE modified_by is not null;
	UPDATE salak_rewards SET modified_by=1 WHERE modified_by is not null;
	UPDATE salak_reward_files SET modified_by=1 WHERE modified_by is not null;
	UPDATE activity_logs SET modified_by=1 WHERE modified_by is not null;

	UPDATE activity_logs SET created_by_name="ผู้ดูแลระบบ" WHERE created_by_name is not null;
	UPDATE activity_logs SET email="adminsalak@gsbvoc.local" WHERE email is not null;


    COMMIT;
END//

DELIMITER ;

CALL UpdateUserBy();