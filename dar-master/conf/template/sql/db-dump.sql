// dump the admin tables
mysqldump -u root -p36avaU68 zeprs form form_type form_field field_enumeration  encounter_record flow info_outcome outcome page_item encounter_outcome referral_outcome rule_definition rule_definition_param > zeprs-wide.sql
mysqldump -u root -p36avaU68 zeprs user_group user_group_membership user_group_role > zeprs-user.sql
mysqldump -u root -p36avaU68 zeprs site > zeprs-site.sql
mysqldump -u root -p36avaU68 zeprs drugs district > zeprs-drugsdist.sql
mysqldump -u root -p36avaU68 zeprs immunization > zeprs-immunization.sql

mysqldump -u root -p36avaU68 -tc zeprs form display_hint form_field_bridge form_field field_enumeration patient encounter_record encounter_value menu_item report_spec rule_definition rule_definition_param flow flow_bridge outcome referral_outcome encounter_outcome> zeprs-wide.sql

mysqldump -u root -p36avaU68 -te zeprs>zeprs.sql