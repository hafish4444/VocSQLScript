-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Schema salak_db
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Schema salak_db
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE SCHEMA IF NOT EXISTS `salak_db` DEFAULT CHARACTER SET utf8mb4 ;
USE `salak_db` ;

-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `roles`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NULL,
  `role_desc` varchar(255) NULL,
  `is_super_admin` TINYINT(1) NOT NULL DEFAULT 0,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `users`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `employee_id` varchar(255) NULL,
  `fullname_th` varchar(255) NULL,
  `fullname_en` varchar(255) NULL,
  `email` varchar(255) NULL,
  `position` varchar(255) NULL,
  `department` varchar(255) NULL,
  `username` varchar(255) NULL,
  `last_login_date` DATETIME NULL,
  `login_failed` INT NOT NULL DEFAULT 0,
  `is_locked` TINYINT(1) NOT NULL DEFAULT 0,
  `lock_date` DATETIME NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  INDEX `fk_users_roles_idx` (`role_id` ASC),
  CONSTRAINT `fk_users_roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `user_token`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE `user_token` (
  `user_id` INT(11) NOT NULL,
  `refresh_token` VARCHAR(100) NULL DEFAULT NULL,
  `refresh_token_expire` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_salak_user_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `modules`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `modules` (
  `module_id` INT NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) NULL,
  `module_component` varchar(255) NULL,
  `module_parent_id` INT NULL,
  `module_sort` INT NULL,
  `is_display` TINYINT(1) NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`module_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `actions`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `actions` (
  `action_id` INT NOT NULL AUTO_INCREMENT,
  `action_name` varchar(255) NULL,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `is_for_permission` TINYINT(1) NOT NULL DEFAULT 1,
  `is_display` TINYINT(1) NOT NULL DEFAULT 0,
  `ord` varchar(255) NULL,
  PRIMARY KEY (`action_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `permissions`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `permissions` (
  `permission_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `module_id` INT NOT NULL,
  `action_id` INT NOT NULL,
  INDEX `fk_roles_has_modules_modules1_idx` (`module_id` ASC),
  INDEX `fk_roles_has_modules_roles1_idx` (`role_id` ASC),
  PRIMARY KEY (`permission_id`),
  INDEX `fk_permissions_actions1_idx` (`action_id` ASC),
  CONSTRAINT `fk_roles_has_modules_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_modules_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `modules` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_actions1`
    FOREIGN KEY (`action_id`)
    REFERENCES `actions` (`action_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_types`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_types` (
  `salak_type_id` INT NOT NULL AUTO_INCREMENT,
  `salak_type_name` varchar(255) NULL,
  `salak_type_url` varchar(255) NULL,
  `salak_type_desc_reward` TEXT NULL,
  `salak_type_desc_check` TEXT NULL,
  `is_manual` TINYINT(1) NOT NULL DEFAULT 0,
  `is_digital` TINYINT(1) NOT NULL DEFAULT 0,
  `is_alphabet` TINYINT(1) NOT NULL DEFAULT 0,
  `last_release_date` DATETIME NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_type_id`),
  INDEX `fk_salak_types_created_idx` (`created_by` ASC),
  INDEX `fk_salak_types_modified_idx` (`modified_by` ASC),
  CONSTRAINT `fk_salak_types_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_types_modified`
    FOREIGN KEY (`modified_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_type_periods`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_type_periods` (
  `salak_type_periods_id` INT NOT NULL AUTO_INCREMENT,
  `salak_type_id` INT NOT NULL,
  `period_start` INT NOT NULL,
  `period_end` INT NOT NULL,
  PRIMARY KEY (`salak_type_periods_id`),
  INDEX `fk_salak_type_periods_salak_types1_idx` (`salak_type_id` ASC),
  CONSTRAINT `fk_salak_type_periods_salak_types1`
    FOREIGN KEY (`salak_type_id`)
    REFERENCES `salak_types` (`salak_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_prices`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_prices` (
  `salak_prices_id` INT NOT NULL AUTO_INCREMENT,
  `salak_type_id` INT NOT NULL,
  `ranking_reward_id` INT NOT NULL,
  `period_start` INT NULL,
  `period_end` INT NULL,
  `price` DOUBLE(18,2) NOT NULL DEFAULT 0,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  
  PRIMARY KEY (`salak_prices_id`),
  INDEX `fk_salak_prices_ranking_rewards1_idx` (`ranking_reward_id` ASC),
  INDEX `fk_salak_prices_salak_types1_idx` (`salak_type_id` ASC),
  CONSTRAINT `fk_salak_prices_salak_types1`
    FOREIGN KEY (`salak_type_id`)
    REFERENCES `salak_types` (`salak_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_prices_ranking_rewards1`
    FOREIGN KEY (`ranking_reward_id`)
    REFERENCES `ranking_rewards` (`ranking_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT="Use for default price when salak_reward dont't have a price";
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `ranking_rewards`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `ranking_rewards` (
  `ranking_reward_id` INT NOT NULL AUTO_INCREMENT,
  `ranking_reward_name` varchar(255) NULL,
  `ranking_reward_code` INT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ranking_reward_id`),
  INDEX `fk_ranking_rewards_created_idx` (`created_by` ASC),
  INDEX `fk_ranking_rewards_modified_idx` (`modified_by` ASC),
  CONSTRAINT `fk_ranking_rewards_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ranking_rewards_modified`
    FOREIGN KEY (`modified_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_statuses`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_statuses` (
  `salak_status_id` INT NOT NULL AUTO_INCREMENT,
  `salak_status_name` varchar(255) NULL,
  `color` varchar(255) NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_status_id`),
  INDEX `fk_salak_status_created_idx` (`created_by` ASC),
  CONSTRAINT `fk_salak_status_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_rewards_detail`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_rewards_detail` (
  `salak_reward_detail_id` INT NOT NULL AUTO_INCREMENT,
  `salak_reward_id` INT NOT NULL,
  `ranking_reward_id` INT NOT NULL,
  `salak_number` varchar(255) NULL,
  `amount_of_release` INT NOT NULL DEFAULT 0,
  `amount_of_win` INT NOT NULL DEFAULT 0,
  `release_date` DATETIME NOT NULL,
  `alphabet` varchar(255) NULL,
  `period_detail` INT NULL,
  `period_display` varchar(255) NULL DEFAULT NULL,
  `period_range_start` INT NULL,
  `period_range_end` INT NULL,
  `price` DOUBLE(18,2) NOT NULL DEFAULT 0,
  `account_type` INT NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_reward_detail_id`),
  INDEX `fk_salak_rewards_detail_salak_rewards_idx` (`salak_reward_id` ASC),
  INDEX `fk_salak_rewards_detail_ranking_rewards1_idx` (`ranking_reward_id` ASC),
  INDEX `fk_salak_rewards_detail_created_idx` (`created_by` ASC),
  INDEX `fk_salak_rewards_detail_modified_idx` (`modified_by` ASC),
  CONSTRAINT `fk_salak_rewards_detail_salak_rewards`
    FOREIGN KEY (`salak_reward_id`)
    REFERENCES `salak_rewards` (`salak_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_detail_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_detail_modified`
    FOREIGN KEY (`modified_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_detail_ranking_rewards1`
    FOREIGN KEY (`ranking_reward_id`)
    REFERENCES `ranking_rewards` (`ranking_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_rewards`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_rewards` (
  `salak_reward_id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT NOT NULL,
  `salak_type_id` INT NOT NULL,
  `month_of_release` DATETIME NOT NULL,
  `release_date` DATETIME NOT NULL,
  `file_range_ftp_path` VARCHAR(100) NULL,
  `file_detail_ftp_path` VARCHAR(100) NULL,
  `approved_date` DATETIME NULL,
  `approved_by` INT NULL,
  `rejected_date` DATETIME NULL,
  `rejected_by` INT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_reward_id`),
  INDEX `fk_salak_rewards_salak_status1_idx` (`status_id` ASC),
  INDEX `fk_salak_rewards_salak_types1_idx` (`salak_type_id` ASC),
  INDEX `fk_salak_rewards_created_idx` (`created_by` ASC),
  INDEX `fk_salak_rewards_modified_idx` (`modified_by` ASC),
  CONSTRAINT `fk_salak_rewards_salak_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `salak_statuses` (`salak_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_salak_types1`
    FOREIGN KEY (`salak_type_id`)
    REFERENCES `salak_types` (`salak_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_modified`
    FOREIGN KEY (`modified_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_approved`
    FOREIGN KEY (`approved_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_rewards_rejected`
    FOREIGN KEY (`rejected_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_reward_files`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_reward_files` (
  `salak_reward_file_id` INT NOT NULL AUTO_INCREMENT,
  `salak_reward_id` INT NOT NULL,
  `name` varchar(255) NULL,
  `name_old` varchar(255) NULL,
  `size` INT NOT NULL DEFAULT 0,
  `content_type` varchar(255) NULL,
  `is_range` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'is_range = 1 ไฟล์งวดรางวัลสลาก\nis_range = 0 ไฟล์ข้อมูลผลรางวัล',
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  PRIMARY KEY (`salak_reward_file_id`),
  INDEX `fk_salak_reward_files_salak_rewards1_idx` (`salak_reward_id` ASC),
  INDEX `fk_salak_rewards_detail_created_idx` (`created_by` ASC),
  INDEX `fk_salak_rewards_detail_modified_idx` (`modified_by` ASC),
  CONSTRAINT `fk_salak_reward_files_salak_rewards1`
    FOREIGN KEY (`salak_reward_id`)
    REFERENCES `salak_rewards` (`salak_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_reward_files_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_reward_files_modified`
    FOREIGN KEY (`modified_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_activities`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_activities` (
  `salak_activity_id` INT NOT NULL AUTO_INCREMENT,
  `salak_reward_id` INT NOT NULL,
  `salak_status_id` INT NOT NULL,
  `desc` varchar(255) NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_activity_id`),
  INDEX `fk_salak_activities_salak_status1_idx` (`salak_status_id` ASC),
  INDEX `fk_salak_activities_salak_rewards1_idx` (`salak_reward_id` ASC),
  INDEX `fk_salak_activities_created_idx` (`created_by` ASC),
  CONSTRAINT `fk_salak_activities_salak_status1`
    FOREIGN KEY (`salak_status_id`)
    REFERENCES `salak_statuses` (`salak_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_activities_salak_rewards1`
    FOREIGN KEY (`salak_reward_id`)
    REFERENCES `salak_rewards` (`salak_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_activity_created`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `activity_logs`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `activity_logs` (
  `activity_log_id` INT NOT NULL AUTO_INCREMENT,
  `module_id` INT NULL DEFAULT NULL,
  `action_id` INT NOT NULL,
  `desc` varchar(255) NULL,
  `email` varchar(255) NULL,
  `browser` varchar(255) NULL,
  `version_browser` VARCHAR(20) NULL DEFAULT NULL,
  `os` VARCHAR(20) NULL DEFAULT NULL,
  `ip` varchar(255) NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `created_by_name` varchar(255) NULL,
  `modified_date` DATETIME NULL,
  `modified_by` INT NULL,
  `ord` INT NOT NULL DEFAULT 1,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`activity_log_id`),
  INDEX `fk_activity_logs_actions1_idx` (`action_id` ASC),
  INDEX `fk_activity_logs_modules1_idx` (`module_id` ASC),
  CONSTRAINT `fk_activity_logs_actions1`
    FOREIGN KEY (`action_id`)
    REFERENCES `actions` (`action_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_logs_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `modules` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `table_settings`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `table_settings` (
  `table_setting_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `table_name` varchar(255) NULL,
  `columns` MEDIUMTEXT NULL,
  `saved_date` DATETIME NULL,
  PRIMARY KEY (`table_setting_id`),
  INDEX `fk_table_setting_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_table_setting_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_periods`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_periods` (
  `salak_period_id` INT NOT NULL AUTO_INCREMENT,
  `salak_reward_id` INT NOT NULL,
  `period_start` INT NOT NULL,
  `period_end` INT NOT NULL,
  PRIMARY KEY (`salak_period_id`),
  INDEX `fk_salak_period_salak_rewards1_idx` (`salak_reward_id` ASC),
  CONSTRAINT `fk_salak_period_salak_rewards1`
    FOREIGN KEY (`salak_reward_id`)
    REFERENCES `salak_rewards` (`salak_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `salak_reward_previews` (
  `salak_reward_preview_id` INT(11) NOT NULL AUTO_INCREMENT,
  `salak_type_id` INT(11) NULL DEFAULT NULL,
  `salak_type_name` VARCHAR(255) NULL DEFAULT NULL,
  `salak_type_url` VARCHAR(255) NULL DEFAULT NULL,
  `month` VARCHAR(100) NULL DEFAULT NULL,
  `release_date` DATETIME NULL DEFAULT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NULL,
  `is_temporary` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_reward_preview_id`),
  INDEX `salak_type_idx` (`salak_type_id` ASC),
  INDEX `salak_type_url_idx` (`salak_type_url` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `salak_reward_preview_ranks` (
  `salak_reward_preview_rank_id` INT(11) NOT NULL AUTO_INCREMENT,
  `salak_reward_preview_id` INT(11) NOT NULL,
  `ranking_reward_id` INT(11) NOT NULL,
  `reward_name` VARCHAR(100) NULL DEFAULT NULL,
  `amount_of_release` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`salak_reward_preview_rank_id`),
  INDEX `fk_salak_reward_preview_id_idx` (`salak_reward_preview_id` ASC),
  CONSTRAINT `fk_salak_reward_preview_id`
    FOREIGN KEY (`salak_reward_preview_id`)
    REFERENCES `salak_reward_previews` (`salak_reward_preview_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `salak_reward_preview_periods` (
  `salak_reward_preview_period_id` INT(11) NOT NULL AUTO_INCREMENT,
  `salak_reward_preview_rank_id` INT(11) NOT NULL,
  `period_name` VARCHAR(100) NULL DEFAULT NULL,
  `amount_of_win` VARCHAR(100) NULL DEFAULT NULL,
  `price` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`salak_reward_preview_period_id`),
  INDEX `salak_reward_preview_rank_id_idx` (`salak_reward_preview_rank_id` ASC),
  CONSTRAINT `salak_reward_preview_rank_id`
    FOREIGN KEY (`salak_reward_preview_rank_id`)
    REFERENCES `salak_reward_preview_ranks` (`salak_reward_preview_rank_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
    
CREATE TABLE `salak_reward_preview_numbers` (
  `salak_reward_preview_number_id` INT(11) NOT NULL AUTO_INCREMENT,
  `salak_reward_preview_rank_id` INT(11) NOT NULL,
  `salak_number` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`salak_reward_preview_number_id`),
  INDEX `fk_salak_reward_preview_rank_id_idx` (`salak_reward_preview_rank_id` ASC),
  CONSTRAINT `fk_salak_reward_preview_rank_id`
    FOREIGN KEY (`salak_reward_preview_rank_id`)
    REFERENCES `salak_reward_preview_ranks` (`salak_reward_preview_rank_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `apps` (
  app_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  api_key VARCHAR(36) NOT NULL,
  is_enabled TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (app_id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Table `salak_preview_versions`
-- -- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
CREATE TABLE IF NOT EXISTS `salak_reward_preview_versions` (
  `salak_reward_preview_version_id` INT NOT NULL AUTO_INCREMENT,
  `salak_reward_id` INT NOT NULL,
  `salak_reward_preview_id` INT NOT NULL,
  `version` INT NOT NULL,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`salak_reward_preview_version_id`),
  INDEX `fk_salak_reward_preview_version_salak_rewards1_idx` (`salak_reward_id` ASC),
  INDEX `fk_salak_reward_preview_version_salak_reward_previews1_idx` (`salak_reward_preview_id` ASC),
  CONSTRAINT `fk_salak_reward_preview_version_salak_rewards1`
    FOREIGN KEY (`salak_reward_id`)
    REFERENCES `salak_rewards` (`salak_reward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salak_reward_preview_version_salak_reward_previews1`
    FOREIGN KEY (`salak_reward_preview_id`)
    REFERENCES `salak_reward_previews` (`salak_reward_preview_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO apps (app_id,name,api_key,is_enabled) VALUES (1,'gsbsalak-frontend','b72b82c68cca44a1b0a80b434655de8f',1);
INSERT INTO apps (app_id,name,api_key,is_enabled) VALUES (2,'gsb-lottery-result','9d07442edd1f429d9d1d868f1b4d519a',1);

INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (1, 'เข้าถึง', 1, 1, 0, 3);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (2, 'สร้าง', 1, 1, 1, 4);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (3, 'แก้ไข', 1, 1, 1, 5);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (4, 'ลบ', 1, 1, 1, 6);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (5, 'นำออกรายงาน', 1, 1, 0, 11);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (6, 'ส่งตรวจสอบ', 1, 1, 1, 7);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (7, 'ผ่านการตรวจสอบ', 1, 1, 0, 8);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (8, 'ไม่ผ่านการตรวจสอบ', 1, 1, 0, 9);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (9, 'ยกเลิกการแสดงผล', 1, 1, 1, 10);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (10, 'เข้าสู่ระบบ', 1, 0, 1, 1);
INSERT INTO `actions` (`action_id`, `action_name`, `is_enabled`, `is_for_permission`, `is_display`, `ord`) VALUES (11, 'ออกจากระบบ', 1, 0, 1, 2);

INSERT INTO `modules` (`module_id`, `module_name`, `module_sort`, `is_display`, `is_enabled`) VALUES (1, 'ตั้งค่าข้อมูลตั้งต้น', '1', 1, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `module_sort`, `is_display`, `is_enabled`) VALUES (2, 'จัดการผู้ใช้งาน', '2', 1, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `module_component`, `module_parent_id`, `module_sort`, `is_display`, `is_enabled`) VALUES (3, 'ประเภทสลาก', 'setting-type', '1', '1', 1, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `module_component`, `module_parent_id`, `module_sort`, `is_display`, `is_enabled`) VALUES (4, 'อันดับรางวัล', 'setting-reward', '1', '2', 1, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `module_component`, `module_parent_id`, `module_sort`, `is_display`, `is_enabled`) VALUES (5, 'ผู้ใช้งาน', 'user', '2', '1', 1, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `module_component`, `module_parent_id`, `module_sort`, `is_display`, `is_enabled`) VALUES (6, 'ข้อมูลประวัติการใช้งาน', 'activity-log', '2', '2', 1, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `module_component`, `module_parent_id`, `module_sort`, `is_display`, `is_enabled`) VALUES (7, 'รวมประเภทสลาก', 'import-result', null, '3', 0, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `is_display`, `is_enabled`) VALUES (8, 'การอนุมัติข้อมูล', 0, 1);
INSERT INTO `modules` (`module_id`, `module_name`, `is_display`, `is_enabled`) VALUES (9, 'Preview', 0, 1);

-- - Role ผู้ดูแลระบบ -- -
INSERT INTO `roles` (`role_id`, `role_name`, `is_super_admin`, `is_enabled`) VALUES ('1', 'ผู้ดูแลระบบ (Super Admin)', 1, 1);
  -- จัดการประเภทสลาก --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 3, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 3, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 3, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 3, 4);

  -- อันดับรางวัล --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 4, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 4, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 4, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 4, 4);

  -- ผู้ใช้งาน --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 5, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 5, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 5, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 5, 4);

  -- ข้อมูลประวัติการใช้งาน --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 6, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 6, 5);

  -- จัดการข้อมูลผลสลาก --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 4);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 6);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 7);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 8);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (1, 7, 9);
  
-- - Role ผู้ตรวจสอบข้อมูล -- -
INSERT INTO `roles` (`role_id`, `role_name`, `is_enabled`) VALUES ('2', 'ผู้ตรวจสอบข้อมูล (Checker)', 1);
  -- จัดการประเภทสลาก --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 3, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 3, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 3, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 3, 4);

  -- อันดับรางวัล --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 4, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 4, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 4, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 4, 4);

  -- จัดการข้อมูลผลสลาก --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 4);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 6);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 7);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 8);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (2, 7, 9);
  
-- - Role ผู้สร้างข้อมูล -- -
INSERT INTO `roles` (`role_id`, `role_name`, `is_enabled`) VALUES ('3', 'ผู้สร้างข้อมูล (Maker)', 1);
  -- จัดการประเภทสลาก --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 3, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 3, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 3, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 3, 4);

  -- อันดับรางวัล --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 4, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 4, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 4, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 4, 4);

  -- จัดการข้อมูลผลสลาก --
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 7, 1);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 7, 2);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 7, 3);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 7, 4);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 7, 6);
  INSERT INTO `permissions` (`role_id`, `module_id`, `action_id`) VALUES (3, 7, 9);

INSERT INTO `users` (`role_id`, `employee_id`, `fullname_th`, `email`, `position`, `department`, `username`, `is_active`, `is_enabled`) VALUES ('1', '5100754', 'วีระณัฐ ชูพึ่งอาตม์', 'weeranutc@gsb.or.th', 'ผู้จัดการสาขา', 'ธนาคารสาขา0335', 'weeranutc', 1, 1);
INSERT INTO `users` (`role_id`, `employee_id`, `fullname_th`, `email`, `position`, `department`, `username`, `is_active`, `is_enabled`) VALUES ('2', '5100755', 'นาวี นา', 'navee@gsb.or.th', 'ผู้จัดการสาขา 2', 'ธนาคารสาขา0336', 'navee', 1, 1);
INSERT INTO `users` (`role_id`, `employee_id`, `fullname_th`, `email`, `position`, `department`, `username`, `is_active`, `is_enabled`) VALUES ('3', '4302610', 'ชนิตา อุชชิน', 'chanitau@gsb.or.th', 'ผู้จัดการสาขา 3', 'ธนาคารสาขา0337', 'chanitau', 1, 1);

INSERT INTO `salak_db`.`salak_types` (`salak_type_name`, `salak_type_url`, `salak_type_desc_reward`, `salak_type_desc_check`, `is_manual`, `is_digital`, `is_alphabet`, `created_by`, `ord`, `is_active`, `is_enabled`) VALUES ('สลากออมสินพิเศษ 1 ปี Youth Salak', 'salak-1year-youth', 'ตามที่ธนาคารออมสินได้เปิดรับฝากสลากออมสินพิเศษ ซึ่งเป็นผลิตภัณฑ์เงินฝากที่มีการกำหนด ระยะเวลาในการรับฝาก โดยได้แจ้งวันที่มีสิทธิ์ถอนครบอายุไว้ที่ด้านหลังสลากทุกฉบับ  เพื่อเป็น การรักษาผลประโยชน์ของผู้ฝาก  ธนาคารจึงขอแจ้งให้ท่านตรวจสอบสลากออมสินพิเศษของท่าน  หากพบว่ามีสลากออมสินพิเศษฉบับใดครบกำหนดระยะเวลาการฝากแล้ว ธนาคารขอเรียนเชิญ ท่านนำสลากดังกล่าวติดต่อถอนเงินครบอายุได้ที่ธนาคารออมสินทุกสาขา ธนาคารออมสินขอขอบ พระคุณเป็นอย่างยิ่งที่ท่านได้วางใจใช้บริการธนาคารออมสินเสมอมา', 'การตรวจรางวัลสลากออมสินพิเศษ 5 ปี กรุณาระบุงวดเป็นตัวเลข 1 ตัว เช่น สลากฯ ของท่านงวดที่ 1 ให้ระบุเป็น 501 ถ้าสลากฯ ของท่านเป็นงวดที่ 1 ให้ระบุเป็น 501 ฯลฯ', 0, 1, 0, 1, 3, 1, 1);
INSERT INTO `salak_db`.`salak_types` (`salak_type_name`, `salak_type_url`, `salak_type_desc_reward`, `salak_type_desc_check`, `is_manual`, `is_digital`, `is_alphabet`, `created_by`, `ord`, `is_active`, `is_enabled`) VALUES ('สลากออมสินพิเศษ 1 ปี และสลากออมสินดิจิทัล 1 ปี', 'salak-1year', 'ตามที่ธนาคารออมสินได้เปิดรับฝากสลากออมสินพิเศษ ซึ่งเป็นผลิตภัณฑ์เงินฝากที่มีการกำหนด ระยะเวลาในการรับฝาก โดยได้แจ้งวันที่มีสิทธิ์ถอนครบอายุไว้ที่ด้านหลังสลากทุกฉบับ  เพื่อเป็น การรักษาผลประโยชน์ของผู้ฝาก  ธนาคารจึงขอแจ้งให้ท่านตรวจสอบสลากออมสินพิเศษของท่าน  หากพบว่ามีสลากออมสินพิเศษฉบับใดครบกำหนดระยะเวลาการฝากแล้ว ธนาคารขอเรียนเชิญ ท่านนำสลากดังกล่าวติดต่อถอนเงินครบอายุได้ที่ธนาคารออมสินทุกสาขา ธนาคารออมสินขอขอบ พระคุณเป็นอย่างยิ่งที่ท่านได้วางใจใช้บริการธนาคารออมสินเสมอมา', 'การตรวจรางวัลสลากออมสินพิเศษ 5 ปี กรุณาระบุงวดเป็นตัวเลข 1 ตัว เช่น สลากฯ ของท่านงวดที่ 1 ให้ระบุเป็น 501 ถ้าสลากฯ ของท่านเป็นงวดที่ 1 ให้ระบุเป็น 501 ฯลฯ', 0, 1, 0, 1, 3, 1, 1);
INSERT INTO `salak_db`.`salak_types` (`salak_type_name`, `salak_type_url`, `salak_type_desc_reward`, `salak_type_desc_check`, `is_manual`, `is_digital`, `is_alphabet`, `created_by`, `ord`, `is_active`, `is_enabled`) VALUES ('สลากออมสินพิเศษ 2 ปี และสลากออมสินดิจิทัล 2 ปี', 'salak-2year', 'ตามที่ธนาคารออมสินได้เปิดรับฝากสลากออมสินพิเศษ ซึ่งเป็นผลิตภัณฑ์เงินฝากที่มีการกำหนด ระยะเวลาในการรับฝาก โดยได้แจ้งวันที่มีสิทธิ์ถอนครบอายุไว้ที่ด้านหลังสลากทุกฉบับ  เพื่อเป็น การรักษาผลประโยชน์ของผู้ฝาก  ธนาคารจึงขอแจ้งให้ท่านตรวจสอบสลากออมสินพิเศษของท่าน  หากพบว่ามีสลากออมสินพิเศษฉบับใดครบกำหนดระยะเวลาการฝากแล้ว ธนาคารขอเรียนเชิญ ท่านนำสลากดังกล่าวติดต่อถอนเงินครบอายุได้ที่ธนาคารออมสินทุกสาขา ธนาคารออมสินขอขอบ พระคุณเป็นอย่างยิ่งที่ท่านได้วางใจใช้บริการธนาคารออมสินเสมอมา', 'การตรวจรางวัลสลากออมสินพิเศษ 5 ปี กรุณาระบุงวดเป็นตัวเลข 2 ตัว เช่น สลากฯ ของท่านงวดที่ 1 ให้ระบุเป็น 501 ถ้าสลากฯ ของท่านเป็นงวดที่ 2 ให้ระบุเป็น 502 ฯลฯ', 0, 1, 0, 0, 2, 1, 1);
INSERT INTO `salak_db`.`salak_types` (`salak_type_name`, `salak_type_url`, `salak_type_desc_reward`, `salak_type_desc_check`, `is_manual`, `is_digital`, `is_alphabet`, `created_by`, `ord`, `is_active`, `is_enabled`) VALUES ('สลากออมสินพิเศษ 3 ปี และสลากออมสินดิจิทัล 3 ปี', 'salak-3year', 'ตามที่ธนาคารออมสินได้เปิดรับฝากสลากออมสินพิเศษ ซึ่งเป็นผลิตภัณฑ์เงินฝากที่มีการกำหนด ระยะเวลาในการรับฝาก โดยได้แจ้งวันที่มีสิทธิ์ถอนครบอายุไว้ที่ด้านหลังสลากทุกฉบับ  เพื่อเป็น การรักษาผลประโยชน์ของผู้ฝาก  ธนาคารจึงขอแจ้งให้ท่านตรวจสอบสลากออมสินพิเศษของท่าน  หากพบว่ามีสลากออมสินพิเศษฉบับใดครบกำหนดระยะเวลาการฝากแล้ว ธนาคารขอเรียนเชิญ ท่านนำสลากดังกล่าวติดต่อถอนเงินครบอายุได้ที่ธนาคารออมสินทุกสาขา ธนาคารออมสินขอขอบ พระคุณเป็นอย่างยิ่งที่ท่านได้วางใจใช้บริการธนาคารออมสินเสมอมา', 'การตรวจรางวัลสลากออมสินพิเศษ 5 ปี กรุณาระบุงวดเป็นตัวเลข 3 ตัว เช่น สลากฯ ของท่านงวดที่ 1 ให้ระบุเป็น 501 ถ้าสลากฯ ของท่านเป็นงวดที่ 2 ให้ระบุเป็น 502 ฯลฯ', 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `salak_db`.`salak_types` (`salak_type_name`, `salak_type_url`, `salak_type_desc_reward`, `salak_type_desc_check`, `last_release_date`, `is_manual`, `is_digital`, `is_alphabet`, `created_by`, `ord`, `is_active`, `is_enabled`) VALUES ('สลากออมสินพิเศษ 5 ปี ', 'salak-5year', 'ตามที่ธนาคารออมสินได้เปิดรับฝากสลากออมสินพิเศษ ซึ่งเป็นผลิตภัณฑ์เงินฝากที่มีการกำหนด ระยะเวลาในการรับฝาก โดยได้แจ้งวันที่มีสิทธิ์ถอนครบอายุไว้ที่ด้านหลังสลากทุกฉบับ  เพื่อเป็น การรักษาผลประโยชน์ของผู้ฝาก  ธนาคารจึงขอแจ้งให้ท่านตรวจสอบสลากออมสินพิเศษของท่าน  หากพบว่ามีสลากออมสินพิเศษฉบับใดครบกำหนดระยะเวลาการฝากแล้ว ธนาคารขอเรียนเชิญ ท่านนำสลากดังกล่าวติดต่อถอนเงินครบอายุได้ที่ธนาคารออมสินทุกสาขา ธนาคารออมสินขอขอบ พระคุณเป็นอย่างยิ่งที่ท่านได้วางใจใช้บริการธนาคารออมสินเสมอมา', 'การตรวจรางวัลสลากออมสินพิเศษ 5 ปี กรุณาระบุงวดเป็นตัวเลข 1 ตัว เช่น สลากฯ ของท่านงวดที่ 1 ให้ระบุเป็น 501 ถ้าสลากฯ ของท่านเป็นงวดที่ 1 ให้ระบุเป็น 501 ฯลฯ', '2024-02-14 17:37:34', 1, 0, 1, 1, 4, 1, 1);

INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (1,603,603);
INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (2,601,602);
INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (2,11,20);
INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (3,201,246);
INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (4,129,130);
INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (5,5,10);
INSERT INTO `salak_db`.`salak_type_periods` (`salak_type_id`, `period_start`, `period_end`) VALUES
	 (5,510,510);

INSERT INTO `salak_statuses` (`salak_status_id`, `salak_status_name`, `color`, `is_enabled`, `ord`) VALUES (1, 'แบบร่าง', '#7C818D', 1, 1);
INSERT INTO `salak_statuses` (`salak_status_id`, `salak_status_name`, `color`, `is_enabled`, `ord`) VALUES (2, 'รอตรวจสอบ', '#E1BD00', 1, 2);
INSERT INTO `salak_statuses` (`salak_status_id`, `salak_status_name`, `color`, `is_enabled`, `ord`) VALUES (3, 'ผ่านการตรวจสอบ', '#26B465', 1, 3);
INSERT INTO `salak_statuses` (`salak_status_id`, `salak_status_name`, `color`, `is_enabled`, `ord`) VALUES (4, 'ไม่ผ่านการตรวจสอบ', '#FF4A4A', 1, 4);
INSERT INTO `salak_statuses` (`salak_status_id`, `salak_status_name`, `color`, `is_enabled`, `ord`) VALUES (5, 'ยกเลิกการแสดงผล', '#7C818D', 1, 5);
INSERT INTO `salak_statuses` (`salak_status_id`, `salak_status_name`, `color`, `is_enabled`, `ord`) VALUES (6, 'มีการเปลี่ยนแปลงข้อมูล', '#4A52FF', 1, 6);

INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("อันดับ 1", "1", current_timestamp(), 1, NULL, NULL, 1, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("อันดับ 2", "2", current_timestamp(), 1, NULL, NULL, 2, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("อันดับ 3", "3", current_timestamp(), 1, NULL, NULL, 3, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("อันดับ 4", "4", current_timestamp(), 1, NULL, NULL, 4, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("อันดับ 5", "5", current_timestamp(), 1, NULL, NULL, 5, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("เลขท้าย 6 ตัว", "6", current_timestamp(), 1, NULL, NULL, 6, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("เลขท้าย 5 ตัว", "7", current_timestamp(), 1, NULL, NULL, 7, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("เลขท้าย 4 ตัว", "8", current_timestamp(), 1, NULL, NULL, 8, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("เลขสลากตรงกับอันดับ 1", "9", current_timestamp(), 1, NULL, NULL, 9, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("อันดับพิเศษ", "10", current_timestamp(), 1, NULL, NULL, 10, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("รางวัลเพิ่มโชค", "11", current_timestamp(), 1, NULL, NULL, 11, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("รางวัลสมนาคุณเพิ่มโชค", "12", current_timestamp(), 1, NULL, NULL, 12, 1, 1);
INSERT INTO `ranking_rewards` (`ranking_reward_name`, `ranking_reward_code`, `created_date`, `created_by`, `modified_date`, `modified_by`, `ord`, `is_active`, `is_enabled`)
VALUES("เลขท้าย 3 ตัว", "13", current_timestamp(), 1, NULL, NULL, 13, 1, 1);

-- INSERT INTO salak_db.salak_rewards (status_id,salak_type_id,month_of_release,release_date,file_range_ftp_path,file_detail_ftp_path,approved_date,approved_by,rejected_date,rejected_by,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,2,'2024-03-27 00:00:00','2024-03-27 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'2024-03-27 17:32:36',1,NULL,NULL,1,1);

-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,1,'6534844',1,1,'2024-03-16 00:00:00','P',19,19,3000000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,1,1),
-- 	 (1,2,'1820861',1,1,'2024-03-16 00:00:00','ฐ',17,17,100000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,2,1),
-- 	 (1,3,'7051877',5,1,'2024-03-16 00:00:00','',602,602,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,3,1),
-- 	 (1,3,'7736457',5,1,'2024-03-16 00:00:00','',602,602,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,4,1),
-- 	 (1,3,'2826563',5,1,'2024-03-16 00:00:00','',602,602,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,5,1),
-- 	 (1,3,'9288529',5,1,'2024-03-16 00:00:00','',602,602,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,6,1),
-- 	 (1,3,'4934103',5,1,'2024-03-16 00:00:00','',602,602,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,7,1),
-- 	 (1,4,'6471478',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,8,1),
-- 	 (1,4,'0465639',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,9,1),
-- 	 (1,4,'8329822',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,10,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,4,'6848432',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,11,1),
-- 	 (1,4,'5973148',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,12,1),
-- 	 (1,4,'1396071',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,13,1),
-- 	 (1,4,'5027912',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,14,1),
-- 	 (1,4,'9232421',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,15,1),
-- 	 (1,4,'8275775',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,16,1),
-- 	 (1,4,'9776785',10,1,'2024-03-16 00:00:00','',602,602,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,17,1),
-- 	 (1,5,'7230178',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,18,1),
-- 	 (1,5,'3410689',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,19,1),
-- 	 (1,5,'4787881',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,20,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,5,'2937697',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,21,1),
-- 	 (1,5,'5263999',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,22,1),
-- 	 (1,5,'8518128',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,23,1),
-- 	 (1,5,'3667523',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,24,1),
-- 	 (1,5,'8503829',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,25,1),
-- 	 (1,5,'2329621',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,26,1),
-- 	 (1,5,'4446218',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,27,1),
-- 	 (1,5,'8788606',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,28,1),
-- 	 (1,5,'0137937',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,29,1),
-- 	 (1,5,'5355871',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,30,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,5,'4784929',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,31,1),
-- 	 (1,5,'2720914',15,1,'2024-03-16 00:00:00','',602,602,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,32,1),
-- 	 (1,8,'1629',2,50,'2024-03-16 00:00:00','',602,602,25.0,0,'2024-03-27 17:32:36',1,NULL,NULL,33,1),
-- 	 (1,8,'9445',2,50,'2024-03-16 00:00:00','',602,602,25.0,0,'2024-03-27 17:32:36',1,NULL,NULL,34,1),
-- 	 (1,1,'6534844',1,1,'2024-03-16 00:00:00','P',19,19,3000000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,35,1),
-- 	 (1,2,'1820861',1,1,'2024-03-16 00:00:00','ฐ',17,17,100000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,36,1),
-- 	 (1,3,'7051877',5,1,'2024-03-16 00:00:00','',16,16,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,37,1),
-- 	 (1,3,'7736457',5,1,'2024-03-16 00:00:00','',16,16,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,38,1),
-- 	 (1,3,'2826563',5,1,'2024-03-16 00:00:00','',16,16,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,39,1),
-- 	 (1,3,'9288529',5,1,'2024-03-16 00:00:00','',16,16,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,40,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,3,'4934103',5,1,'2024-03-16 00:00:00','',16,16,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,41,1),
-- 	 (1,4,'6471478',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,42,1),
-- 	 (1,4,'0465639',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,43,1),
-- 	 (1,4,'8329822',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,44,1),
-- 	 (1,4,'6848432',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,45,1),
-- 	 (1,4,'5973148',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,46,1),
-- 	 (1,4,'1396071',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,47,1),
-- 	 (1,4,'5027912',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,48,1),
-- 	 (1,4,'9232421',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,49,1),
-- 	 (1,4,'8275775',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,50,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,4,'9776785',10,1,'2024-03-16 00:00:00','',16,16,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,51,1),
-- 	 (1,5,'7230178',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,52,1),
-- 	 (1,5,'3410689',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,53,1),
-- 	 (1,5,'4787881',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,54,1),
-- 	 (1,5,'2937697',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,55,1),
-- 	 (1,5,'5263999',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,56,1),
-- 	 (1,5,'8518128',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,57,1),
-- 	 (1,5,'3667523',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,58,1),
-- 	 (1,5,'8503829',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,59,1),
-- 	 (1,5,'2329621',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,60,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,5,'4446218',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,61,1),
-- 	 (1,5,'8788606',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,62,1),
-- 	 (1,5,'0137937',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,63,1),
-- 	 (1,5,'5355871',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,64,1),
-- 	 (1,5,'4784929',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,65,1),
-- 	 (1,5,'2720914',15,1,'2024-03-16 00:00:00','',16,16,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,66,1),
-- 	 (1,8,'1629',2,50,'2024-03-16 00:00:00','',16,16,25.0,0,'2024-03-27 17:32:36',1,NULL,NULL,67,1),
-- 	 (1,8,'9445',2,50,'2024-03-16 00:00:00','',16,16,25.0,0,'2024-03-27 17:32:36',1,NULL,NULL,68,1),
-- 	 (1,1,'6534844',1,1,'2024-03-16 00:00:00','P',19,19,3000000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,69,1),
-- 	 (1,2,'1820861',1,1,'2024-03-16 00:00:00','ฐ',17,17,100000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,70,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,3,'7051877',5,1,'2024-03-16 00:00:00','',17,19,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,71,1),
-- 	 (1,3,'7736457',5,1,'2024-03-16 00:00:00','',17,19,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,72,1),
-- 	 (1,3,'2826563',5,1,'2024-03-16 00:00:00','',17,19,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,73,1),
-- 	 (1,3,'9288529',5,1,'2024-03-16 00:00:00','',17,19,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,74,1),
-- 	 (1,3,'4934103',5,1,'2024-03-16 00:00:00','',17,19,2000.0,0,'2024-03-27 17:32:36',1,NULL,NULL,75,1),
-- 	 (1,4,'6471478',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,76,1),
-- 	 (1,4,'0465639',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,77,1),
-- 	 (1,4,'8329822',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,78,1),
-- 	 (1,4,'6848432',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,79,1),
-- 	 (1,4,'5973148',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,80,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,4,'1396071',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,81,1),
-- 	 (1,4,'5027912',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,82,1),
-- 	 (1,4,'9232421',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,83,1),
-- 	 (1,4,'8275775',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,84,1),
-- 	 (1,4,'9776785',10,1,'2024-03-16 00:00:00','',17,19,800.0,0,'2024-03-27 17:32:36',1,NULL,NULL,85,1),
-- 	 (1,5,'7230178',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,86,1),
-- 	 (1,5,'3410689',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,87,1),
-- 	 (1,5,'4787881',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,88,1),
-- 	 (1,5,'2937697',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,89,1),
-- 	 (1,5,'5263999',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,90,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,5,'8518128',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,91,1),
-- 	 (1,5,'3667523',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,92,1),
-- 	 (1,5,'8503829',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,93,1),
-- 	 (1,5,'2329621',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,94,1),
-- 	 (1,5,'4446218',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,95,1),
-- 	 (1,5,'8788606',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,96,1),
-- 	 (1,5,'0137937',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,97,1),
-- 	 (1,5,'5355871',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,98,1),
-- 	 (1,5,'4784929',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,99,1),
-- 	 (1,5,'2720914',15,1,'2024-03-16 00:00:00','',17,19,200.0,0,'2024-03-27 17:32:36',1,NULL,NULL,100,1);
-- INSERT INTO salak_db.salak_rewards_detail (salak_reward_id,ranking_reward_id,salak_number,amount_of_release,amount_of_win,release_date,alphabet,period_range_start,period_range_end,price,account_type,created_date,created_by,modified_date,modified_by,ord,is_enabled) VALUES
-- 	 (1,8,'1629',2,100,'2024-03-16 00:00:00','',17,19,40.0,0,'2024-03-27 17:32:36',1,NULL,NULL,101,1),
-- 	 (1,8,'9445',2,100,'2024-03-16 00:00:00','',17,19,40.0,0,'2024-03-27 17:32:36',1,NULL,NULL,102,1);

-- INSERT INTO salak_db.salak_reward_files (salak_reward_id,name,name_old,`size`,content_type,is_range,created_date,created_by,modified_date,modified_by) VALUES
-- 	 (1,'20240327173236-range.txt','PSC_PRZRANGE20240316.txt',310,'text/plain',1,'2024-03-27 17:32:36',1,NULL,NULL),
-- 	 (1,'20240327173236-detail.txt','PSC_PRZDETAIL20240316.txt',3488,'text/plain',0,'2024-03-27 17:32:36',1,NULL,NULL);

-- INSERT INTO salak_db.salak_periods (salak_reward_id,period_start,period_end) VALUES
-- 	 (1,601,602),
-- 	 (1,11,20);

-- INSERT INTO salak_db.salak_activities (salak_reward_id,salak_status_id,`desc`,created_date,created_by,ord,is_enabled) VALUES
-- 	 (1,2,'รางวัลสลากออมสิน','2024-03-21 10:41:29',1,1,1);


-- INSERT INTO salak_db.salak_reward_previews (salak_type_id,salak_type_name,salak_type_url,`month`,release_date,created_date,created_by,is_temporary) VALUES
-- 	 (2,'สลากออมสินพิเศษ 1 ปี และสลากออมสินดิจิทัล 1 ปี','salak-1year','03/2567','2024-03-27 00:00:00','2024-03-27 17:29:58',1,1);

-- INSERT INTO salak_db.salak_reward_preview_ranks (salak_reward_preview_id,ranking_reward_id,reward_name,amount_of_release) VALUES
-- 	 (1,1,'อันดับ 1','1'),
-- 	 (1,2,'อันดับ 2','1'),
-- 	 (1,3,'อันดับ 3','5'),
-- 	 (1,4,'อันดับ 4','10'),
-- 	 (1,5,'อันดับ 5','15'),
-- 	 (1,8,'เลขท้าย 4 ตัว','2');
-- INSERT INTO salak_db.salak_reward_preview_numbers (salak_reward_preview_rank_id,salak_number) VALUES
-- 	 (1,'งวดที่ 19 P 6534844'),
-- 	 (2,'งวดที่ 17 ฐ 1820861'),
-- 	 (3,'7051877'),
-- 	 (3,'7736457'),
-- 	 (3,'2826563'),
-- 	 (3,'9288529'),
-- 	 (3,'4934103'),
-- 	 (4,'6471478'),
-- 	 (4,'0465639'),
-- 	 (4,'8329822');
-- INSERT INTO salak_db.salak_reward_preview_numbers (salak_reward_preview_rank_id,salak_number) VALUES
-- 	 (4,'6848432'),
-- 	 (4,'5973148'),
-- 	 (4,'1396071'),
-- 	 (4,'5027912'),
-- 	 (4,'9232421'),
-- 	 (4,'8275775'),
-- 	 (4,'9776785'),
-- 	 (5,'7230178'),
-- 	 (5,'3410689'),
-- 	 (5,'4787881');
-- INSERT INTO salak_db.salak_reward_preview_numbers (salak_reward_preview_rank_id,salak_number) VALUES
-- 	 (5,'2937697'),
-- 	 (5,'5263999'),
-- 	 (5,'8518128'),
-- 	 (5,'3667523'),
-- 	 (5,'8503829'),
-- 	 (5,'2329621'),
-- 	 (5,'4446218'),
-- 	 (5,'8788606'),
-- 	 (5,'0137937'),
-- 	 (5,'5355871');
-- INSERT INTO salak_db.salak_reward_preview_numbers (salak_reward_preview_rank_id,salak_number) VALUES
-- 	 (5,'4784929'),
-- 	 (5,'2720914'),
-- 	 (6,'1629'),
-- 	 (6,'9445');
-- INSERT INTO salak_db.salak_reward_preview_periods (salak_reward_preview_rank_id,period_name,amount_of_win,price) VALUES
-- 	 (1,'งวดที่ 19','1','3,000,000'),
-- 	 (2,'งวดที่ 17','1','100,000'),
-- 	 (3,'งวดที่ 16-19 และ 602','1','2,000'),
-- 	 (4,'งวดที่ 16-19 และ 602','1','800'),
-- 	 (5,'งวดที่ 16-19 และ 602','1','200'),
-- 	 (6,'งวดที่ 16 และ 602','50','25'),
-- 	 (6,'งวดที่ 17-19','100','40');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
