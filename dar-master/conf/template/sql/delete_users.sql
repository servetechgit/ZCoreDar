SET FOREIGN_KEY_CHECKS = 0;
USE zeprs;
DELETE FROM user_group_membership;

INSERT INTO zeprs.user_group_membership SET id='zepadmin', group_id=1;
INSERT INTO zeprs.user_group_membership SET id='luser', group_id=16;
INSERT INTO zeprs.user_group_membership SET id='reports', group_id=15;
INSERT INTO zeprs.user_group_membership SET id='clinic', group_id=5;
INSERT INTO zeprs.user_group_membership SET id='viewall', group_id=16;
INSERT INTO zeprs.user_group_membership SET id='useradmin', group_id=9;
INSERT INTO zeprs.user_group_membership SET id='clerk', group_id=16;
SET FOREIGN_KEY_CHECKS = 1;