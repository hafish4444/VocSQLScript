ALTER TABLE salak_reward_previews ADD remark varchar(255) null DEFAULT NULL AFTER release_date;
ALTER TABLE salak_rewards ADD remark varchar(255) null DEFAULT null after file_detail_ftp_path;