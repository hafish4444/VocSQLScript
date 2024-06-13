select srpv.*, srp.is_temporary, srp.created_by  
from salak_db.salak_reward_preview_versions srpv
inner join salak_db.salak_reward_previews srp
on srpv.salak_reward_preview_id  = srp.salak_reward_preview_id 
where srpv.salak_reward_id = 49 ;

