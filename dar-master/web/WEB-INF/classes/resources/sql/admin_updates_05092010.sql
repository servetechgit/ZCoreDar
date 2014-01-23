update admin.form set super_class='org.rti.zcore.PatientRegistration' where id = 1;
update admin.rule_definition set rule_class = 'org.rti.zcore.rules.impl.ScriptRule' where rule_class = 'org.cidrz.webapp.dynasite.rules.impl.ScriptRule';
