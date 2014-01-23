# SQL Manager 2007 Lite for MySQL 4.2.0.2
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : derbytest


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS derbytest;

CREATE DATABASE derbytest
    CHARACTER SET 'latin1'
    COLLATE 'latin1_swedish_ci';

USE derbytest;

#
# Structure for the item_group table : 
#

CREATE TABLE item_group (
  id int(11) NOT NULL auto_increment,
  name varchar(200) default NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

#
# Structure for the item table : 
#

CREATE TABLE item (
  id int(11) NOT NULL auto_increment,
  code varchar(125) default NULL,
  name varchar(160) default NULL,
  item_group_id int(11) NOT NULL,
  unit varchar(20) default NULL,
  PRIMARY KEY  (id),
  KEY item_group_fk (item_group_id),
  CONSTRAINT item_group_fk FOREIGN KEY (item_group_id) REFERENCES item_group (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=latin1;

#
# Structure for the regimen_group table : 
#

CREATE TABLE regimen_group (
  id int(11) NOT NULL auto_increment,
  name varchar(200) default NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 AVG_ROW_LENGTH=8192 COMMENT='InnoDB free: 3072 kB';

#
# Structure for the regimen table : 
#

CREATE TABLE regimen (
  id int(11) NOT NULL auto_increment,
  code varchar(10) NOT NULL,
  name varchar(150) NOT NULL,
  desc varchar(200) NOT NULL,
  ARV_option int(11) default NULL,
  regimen_group_id int(11) default NULL,
  PRIMARY KEY  (id),
  KEY regimen_code_ind (code),
  KEY regimen_group_id (regimen_group_id),
  CONSTRAINT regimen_fk FOREIGN KEY (regimen_group_id) REFERENCES regimen_group (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

#
# Structure for the regimen_group_new table : 
#

CREATE TABLE regimen_group_new (
  id int(11) NOT NULL auto_increment,
  name varchar(200) default NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for the item_group table  (LIMIT 0,500)
#

INSERT INTO item_group (id, name) VALUES 
  (1,'Fixed Dose Combination drugs (FDCs)'),
  (2,'Single drugs'),
  (3,'Paediatric Single drugs'),
  (4,'Anti Fungals'),
  (5,'Anti Bacterials'),
  (6,'Anti Protozoal Drugs'),
  (7,'Anti Virals '),
  (8,'Others'),
  (9,'1a) Essential Medicines (EM) for Dispensary Level'),
  (11,'1b) Additional Essential Medicines for HC Level'),
  (12,'2. Reproductive Health Supplies (for all levels)'),
  (13,'3a) Essential Medical Supplies (EMS) for Dispensary Level'),
  (14,'3b) Additional EMS for HC Level');

COMMIT;

#
# Data for the item table  (LIMIT 0,500)
#

INSERT INTO item (id, code, name, item_group_id, unit) VALUES 
  (1,NULL,'Stavudine/Lamivudine (d4T/3TC) FDC (30/150mg)',1,'Tablet'),
  (2,NULL,'Stavudine/Lamivudine (d4T/3TC) FDC (40/150mg)',1,'Tablet'),
  (3,NULL,'Stavudine/Lamivudine/Nevirapine (d4T/3TC/NVP) FDC (30/150/200mg) ',1,'Tablet'),
  (4,NULL,'Stavudine/Lamivudine/Nevirapine (d4T/3TC/NVP) FDC (40/150/200mg)',1,'Tablet'),
  (5,NULL,'Zidovudine/Lamivudine (AZT/3TC) FDC (300/150mg)',1,'Tablet'),
  (6,NULL,'Zidovudine/Lamivudine/Nevirapine (AZT/3TC/NVP) FDC (300/150/200mg)',1,'Tablet'),
  (7,NULL,'Abacavir (ABC) 300mg',2,'Tablet'),
  (8,NULL,'Didanosine (ddI) 100mg',2,'Tablet'),
  (9,NULL,'Didanosine (ddI) 200mg',2,'Tablet'),
  (10,NULL,'Didanosine (ddI) 50mg',2,'Tablet'),
  (11,NULL,'Efavirenz (EFV) 200mg',2,'Capsule'),
  (12,NULL,'Efavirenz (EFV) 600mg',2,'Tablet'),
  (13,NULL,'Lamivudine (3TC) 150mg',2,'Tablet'),
  (14,NULL,'Lopinavir/ritonavir (LPV/r) 133.3/33.3mg',2,'Capsule'),
  (15,NULL,'Nelfinavir (NFV) 250mg',2,'Tablet'),
  (16,NULL,'Nevirapine (NVP) 200mg',2,'Tablet'),
  (17,NULL,'Stavudine (d4T) 30mg ',2,'Tab/Cap'),
  (18,NULL,'Stavudine (d4T) 40mg',2,'Tab/Cap'),
  (19,NULL,'Tenofovir (TDF) 300mg',2,'Tablet'),
  (20,NULL,'Zidovudine (AZT, ZDV) 300mg',2,'Tablet'),
  (21,NULL,'Abacavir (ABC) liquid 20mg/ml',3,'Bottle'),
  (22,NULL,'Didanosine (ddI) 25mg',3,'Tablet'),
  (23,NULL,'Didanosine (ddI) liquid 10mg/ml',3,'Bottle'),
  (24,NULL,'Efavirenz (EFV) 50mg',3,'Capsule'),
  (25,NULL,'Efavirenz (EFV) liquid 30mg/ml',3,'Bottle'),
  (26,NULL,'Lamivudine liquid (3TC) 10mg/ml',3,'Bottle'),
  (27,NULL,'Lopinavir/ritonavir (LPV/r) liquid 80/20mg/ml',3,'Bottle'),
  (28,NULL,'Nelfinavir (NFV) powder 50mg/1.25ml',3,'Bottle'),
  (29,NULL,'Nevirapine (NVP) susp 10mg/ml',3,'Bottle'),
  (30,NULL,'Stavudine (d4T) 15mg',3,'Capsule'),
  (31,NULL,'Stavudine (d4T) 20mg',3,'Capsule'),
  (32,NULL,'Stavudine liquid (d4T) 1mg/ml',3,'Bottle'),
  (33,NULL,'Zidovudine (AZT, ZDV) 100mg',3,'Capsule'),
  (34,NULL,'Zidovudine liquid (AZT, ZDV) 10mg/ml',3,'Bottle'),
  (35,NULL,'Diflucan 200mg',4,'Tablet'),
  (36,NULL,'Diflucan suspension',4,'Bottle'),
  (37,NULL,'Diflucan Infusion',4,'Bottle'),
  (38,NULL,'Fluconazole 200mg',4,'Tab/Cap'),
  (39,NULL,'Fluconazole 150mg',4,'Tab/Cap'),
  (40,NULL,'Fluconazole 50mg',4,'Tab/Cap'),
  (41,NULL,'Ketaconazole 200mg',4,'Tablet'),
  (42,NULL,'Miconazole Nitrate 2% Oral Gel',4,'Tube'),
  (43,NULL,'Nystatin Oral Suspension 100,000 Units',4,NULL),
  (44,NULL,'Amphotericin B Injection',4,'Vial'),
  (45,NULL,'Cotrimoxazole susp 240mg/5ml',5,'Bottle'),
  (46,NULL,'Cotrimoxazole DS 960mg',5,'Tablet'),
  (47,NULL,'Ciprofloxacin Tabs 500mg',5,'Tab/Cap'),
  (48,NULL,'Ceftriaxone Inj. 250mg IM',5,'Vial'),
  (49,NULL,'Aminosidine Sulphate liquid',6,'Bottle'),
  (50,NULL,'Aminosidine Sulphate',6,'Tablet'),
  (51,NULL,'Acyclovir 200mg',7,'Tablet'),
  (52,NULL,'Acyclovir IV Infusion',7,'Vial'),
  (53,NULL,'Pyridoxine 25mg',8,'Tab/Cap'),
  (54,'PHA0002','Adrenaline (epinephrine) inj 1mg/1mL amp',9,NULL),
  (55,'PHA0385','AL tabs 20/120 mg',9,NULL),
  (56,'PHA0386','AL tabs 20/120 mg',9,NULL),
  (57,'PHA0387','AL tabs 20/120 mg',9,NULL),
  (58,'PHA0388','AL tabs 20/120 mg',9,NULL),
  (59,'PHA0003','Albendazole tab 400mg',9,NULL),
  (60,'PHA0004','Aminophylline inj 25mg/mL, 10mL amp',9,NULL),
  (61,'PHA0011','Amoxicillin oral susp 125mg/5mL',9,NULL),
  (62,'PHA0009','Amoxicillin cap 250mg',9,NULL),
  (63,'PHA0001','Aspirin tab 300mg',9,NULL),
  (64,'PHA0019','Benzathine penicillin inj 2.4 MU vial pfr',9,NULL),
  (65,'PHA0235','Benzyl benzoate application 25%',9,NULL),
  (66,'PHA0025','Benzylpenicillin inj 1MU vial pfr',9,NULL),
  (67,'PHA0280','Calamine lotion 15%',9,NULL),
  (68,'PHA0028','Ceftriaxone inj 250mg vial pfr',9,NULL),
  (69,'PHA0032','Chloramphenicol inj 1g vial pfr',9,NULL),
  (70,'PHA0034','Chlorhexidine gluconate soln 5%',9,NULL),
  (71,'PHA0035','Chlorpheniramine inj 10mg/1mL amp',9,NULL),
  (72,'PHA0036','Chlorpheniramine tab 4mg',9,NULL),
  (73,'PHA0432','Ciprofloxacin tab 250mg',9,NULL),
  (74,'PHA0044','Clotrimazole cream 1%',9,NULL),
  (75,'PHA0435','Clotrimazole pessary 200mg',9,NULL),
  (76,'PHA0046','Cotrimoxazole susp 240mg/5mL',9,NULL),
  (77,'PHA0048','Cotrimoxazole tab 480mg',9,NULL),
  (78,'PHA0054','Diazepam inj 5mg/mL, 2mL amp',9,NULL),
  (79,'PHA0070','Doxycycline cap 100mg',9,NULL),
  (80,'PHA0073','Erythromycin tab 250mg',9,NULL),
  (81,'PHA0078','Ferrous sulphate tab f/c 200mg',9,NULL),
  (82,'PHA0083','Folic acid tab 5mg',9,NULL),
  (83,'PHA0087','Gentamicin inj 10mg/mL, 2mL amp',9,NULL),
  (84,'PHA0088','Gentamicin inj 40mg/mL, 2mL amp',9,NULL),
  (85,'PHA0052','Glucose (dextrose) IV infusion 5%, 500mL',9,NULL),
  (86,'PHA0421','Glucose (dextrose) IV inf. 10%, 500mL',9,NULL),
  (87,'PHA0124','Hydrocortisone inj 100mg vial',9,NULL),
  (88,'PHA0284','Hydrocortisone ointment 1%',9,NULL),
  (89,'PHA0130','Ibuprofen tab f/c 200mg (scored)',9,NULL),
  (90,'PHA0331','Ketoconazole tab 200mg',9,NULL),
  (91,'PHA0145','Lidocaine (lignocaine) inj 2%, 30mL vial',9,NULL),
  (92,'PHA0287','Magnesium sulphate inj 50%, 10mL amp',9,NULL),
  (93,'PHA0148','Magnesium trisilicate co tab',9,NULL),
  (94,'PHA0288','Methylergometrine inj 200mcg/1mL amp',9,NULL),
  (95,'PHA0357','Metoclopramide inj 5mg/mL, 2mL amp',9,NULL),
  (96,'PHA0373','Metoclopramide tabs 10mg',9,NULL),
  (97,'PHA0158','Metronidazole susp 200mg/5mL',9,NULL),
  (98,'PHA0159','Metronidazole tab 200mg',9,NULL),
  (99,'PHA0284','Multivitamin syrup',9,NULL),
  (100,'PHA0160','Multivitamin tab',9,NULL),
  (101,'PHA0170','Nystatin oral susp 100,000 IU/mL',9,NULL),
  (102,'PHA0173','ORS sachet (for 500mL)',9,NULL),
  (103,'PHA0177','Paracetamol syrup 120mg/5mL',9,NULL),
  (104,'PHA0332','Paracetamol tab 100mg',9,NULL),
  (105,'PHA0178','Paracetamol tab 500mg',9,NULL),
  (106,'PHA0182','Phenobarbitone tab 30mg',9,NULL),
  (107,'PHA0289','Phytomenadione (Vit K) inj 2mg/0.2mL amp',9,NULL),
  (108,'PHA0186','Povidone iodine solution 10%',9,NULL),
  (109,'PHA0192','Quinine dihydr. inj 300mg/mL, 2mL amp',9,NULL),
  (110,'PHA0291','Quinine sulphate tab 300mg f/c scored',9,NULL),
  (111,'PHA0200','Salbutamol syrup 2mg/5mL',9,NULL),
  (112,'PHA0202','Salbutamol tab 4mg (scored)',9,NULL),
  (113,'PHA0169','Sodium chloride IV infusion 0.9%, 500mL',9,NULL),
  (114,'PHA0094','Sodium lactate co IV infusion, 500mL ',9,NULL),
  (115,'PHA0214','Sulfadoxine/pyrimethamine tab 500/25mg',9,NULL),
  (116,'PHA0223','Tetracycline eye ointment 1%',9,NULL),
  (117,'PHA0229','Water for injection 10mL vial',9,NULL),
  (118,'PHA0470','Zinc sulphate tab 20mg (elem. zinc)',9,NULL),
  (119,'PHA0005','Amitriptyline tab 25mg',11,NULL),
  (120,'PHA0286','Amoxicillin/clavulanic acid tab 500/125mg',11,NULL),
  (121,'PHA0038','Chlorpromazine inj 25mg/mL, 2mL amp',11,NULL),
  (122,'PHA0458','Phenobarbitone inj 200mg/mL',11,NULL),
  (123,'NPH0021','Condom, female',12,NULL),
  (124,'NPH0022','Condom, male',12,NULL),
  (125,'KIT0007','DMPA kit [100 vials 150mg inj + syringes/ needles, swabs, gloves, patient info leaflets',12,NULL),
  (126,'PHA0255','Levonorgestrel implant 75mg',12,NULL),
  (127,'PHA0408','Etonogestrel Implant 68mg',12,NULL),
  (128,'PHA0252','Implant insertion kit',12,NULL),
  (129,'PHA0250','IUD Copper T',12,NULL),
  (130,'PHA0251','IUD insertion/removal kit',12,NULL),
  (131,'PHA0241','Levonorgestrel/ethinylestradiol tab ',12,NULL),
  (132,'PHA0346','Levonorgestrel tab 30mcg  ',12,NULL),
  (133,'PHA0263','Levonorgestrel tab 750mcg ',12,NULL),
  (134,'PHA0345','Medroxyprogesterone inj 150mg/1mL vial ',12,NULL),
  (135,'NPH0139','Autoclave tape 19mm x 50m',13,NULL),
  (136,'NPH0031','Cotton crepe bandage 7.5cm x 5m',13,NULL),
  (137,'NPH0064','Cotton gauze bandage 5cm x 5m',13,NULL),
  (138,'NPH0154','Cotton gauze plain 36\" x 100yds, 1,500g',13,NULL),
  (139,'NPH0152','Cotton wool, absorbent, 400g',13,NULL),
  (140,'NPH0270','Dispensing bottle, plastic 60mL',13,NULL),
  (141,'PHA0069','Dispensing envelope plastic resealable',13,NULL),
  (142,'NPH0271','Dispensing label, self-adhesive x 200',13,NULL),
  (143,'PHA0445','Ethanol denatured soln 70%',13,NULL),
  (144,'NPH0057','IV cannula 18G',13,NULL),
  (145,'NPH0058','IV cannula 20G',13,NULL),
  (146,'NPH0060','IV cannula 22G',13,NULL),
  (147,'PHA0137','IV infusion giving set with air inlet',13,NULL),
  (148,'NPH0050','Gloves, latex examination, large',13,NULL),
  (149,'NPH0050','Gloves, latex examination, medium',13,NULL),
  (150,'NPH0050','Gloves, latex examination, small',13,NULL),
  (151,'NPH0052','Gloves, surgical 7.5 (sterile)',13,NULL),
  (152,'NPH0052','Gloves, surgical 7 (sterile)',13,NULL),
  (153,'NPH0140','Maternity pad (pack of 10)',13,NULL),
  (154,'NPH0072','Paraffin gauze dressing 10x10cm',13,NULL),
  (155,'NPH0101','Scalpel blade #15 with handle',13,NULL),
  (156,'NPH0010','Suture, chromic catgut 2/0 75cm ',13,NULL),
  (157,'NPH0068','Suture, nylon 2/0 75cm with ',13,NULL),
  (158,'NPH0109','Syringe 2mL + needle 23G x 1\"',13,NULL),
  (159,'NPH0111','Syringe 5mL + needle 21G x 1.5\"',13,NULL),
  (160,'NPH0110','Syringe 10mL + needle 21G x 1.5\"',13,NULL),
  (161,'NPH0082','Sharps safe disposal box',13,NULL),
  (162,'PHA0205','Sodium hypochlorite solution 4-6%',13,NULL),
  (163,'NPH0180','Tongue depressor wooden',13,NULL),
  (164,'NPH0186','Umbilical cord clamp',13,NULL),
  (165,'NPH0188','Zinc oxide strapping 7.5cm x 5m',13,NULL),
  (166,'NPH0146','Foley''s catheter 16FG 30mL 2-way',14,NULL),
  (167,'NPH0147','Foley''s catheter 18FG 30mL 2-way',14,NULL),
  (168,'NPH0182','Nasogastric/feeding tube, size 6 (for pre-term)',14,NULL),
  (169,'NPH0048','Nasogastric/feeding tube, size 8 (for term) ',14,NULL),
  (170,'NPH0184','Nasogastric/feeding tube, size 12',14,NULL),
  (171,'NPH0046','Nasogastric/feeding tube, size 16',14,NULL),
  (172,'NPH0045','Nasogastric/feeding tube, size 18',14,NULL),
  (173,'NPH0212','Urine bag 200mL graduated with inlet/outlet',14,NULL);

COMMIT;

#
# Data for the regimen_group table  (LIMIT 0,500)
#

INSERT INTO regimen_group (id, name) VALUES 
  (1,'Adult First-Line Regimens'),
  (2,'Adult Second-Line Regimens'),
  (3,'Other Adult ART Regimens'),
  (4,'Post Exposure Prophylaxis (PEP)'),
  (5,'PMTCT Regimens'),
  (6,'Paediatric First Line Regimens (Child is <14 years)'),
  (7,'Paediatric Second-Line Regimens'),
  (8,'Other Paediatric Regimens  (List any other regimens in these extra lines)');

COMMIT;

#
# Data for the regimen table  (LIMIT 0,500)
#

INSERT INTO regimen (id, code, name, desc, ARV_option, regimen_group_id) VALUES 
  (1,'1A','d4T 30mg + 3TC 150mg + NVP 200mg  [< 60Kg]','Stavudine 30mg + Lamivudine 150mg + Nevirapine 200mg for pat',NULL,1),
  (2,'1B','d4T 40mg + 3TC 150mg + NVP 200mg [> 60Kg]','Stavudine 40mg + Lamivudine 150mg + Nevirapine 200mg for pat',NULL,1),
  (3,'2A','d4T 30mg + 3TC 150mg + EFV 600mg  [< 60Kg]','Stavudine 30mg + Lamivudine 150mg + Efavirenz 600mg for pati',NULL,1),
  (4,'2B','d4T 40mg + 3TC 150mg + EFV 600mg  [> 60Kg]','Stavudine 40mg + Lamivudine 150mg + Efavirenz 600mg for pati',NULL,1),
  (5,'3A','AZT/ZDV 300mg + 3TC 150mg + EFV 600mg','Zidovudine 300mg + Lamivudine 150mg + Efavirenz 600mg',NULL,1),
  (6,'3B','AZT/ZDV 300mg + 3TC 150mg + NVP 200mg','Zidovudine 300mg + Lamivudine 150mg + Nevirapine 200mg',NULL,1),
  (7,'4A','AZT 300mg + ddI 125mg + LPV/r 400/100mg [< 60 Kg ]','Zidovudine 300mg + Didanosine 125mg + Lopinavir/Ritonavir 13',1,2),
  (8,'4B','AZT 300mg + ddI 200mg + LPV/r 400/100mg [> 60 Kg ]','Zidovudine 300mg + Didanosine 200mg + Lopinavir/Ritonavir 13',1,2),
  (9,'5A','AZT 300mg + ddI 125mg + NFV 1250mg [< 60 Kg ]','Zidovudine 300mg + Didanosine 125mg + Nelfinavir 250mg for p',2,2),
  (10,'5B','AZT 300mg + ddI 200mg + NFV 1250mg [> 60 Kg ]','Zidovudine 300mg + Didanosine 200mg + Nelfinavir 250mg for p',2,2),
  (11,'6A','ABC 300mg + ddI 125mg + LPV/r 400/100mg [< 60 Kg ]','Abacavir 300mg + Didanosine 125mg + Lopinavir/Ritonavir 133.',3,2),
  (12,'6B','ABC 300mg + ddI 200mg + LPV/r 400/100mg  [> 60 Kg ]','Abacavir 300mg + Didanosine 125mg + Lopinavir/Ritonavir 133.',3,2),
  (13,'7A','ABC 300mg + ddI 125mg + NFV 1250mg [< 60 Kg ]','Abacavir 300mg + Didanosine 125mg + Nelfinavir 250mg for pat',4,2),
  (14,'7B','ABC 300mg + ddI 200mg + NFV 1250mg  [> 60 Kg ]','Abacavir 300mg + Didanosine 200mg + Nelfinavir 250mg for pat',4,2),
  (15,'8','AZT 300mg + 3TC 150mg + LPV/r 133.3mg/33.3mg  ','Zidovudine 300mg + Lamivudine 150mg + Lopinavir/Ritonavir 13',NULL,3),
  (16,'9','AZT 300mg + 3TC 150mg + IDV 400mg + RTV 100mg  ','Zidovudine 300mg + Lamivudine 150mg + Indinavir 400mg + Rito',NULL,3),
  (17,'10A','AZT 300mg + ddI 125mg + IDV 400mg + RTV 100mg [< 60 Kg ]','Zidovudine 300mg + Didanosine 125mg + Indinavir 400mg + Rito',NULL,3),
  (18,'10B','AZT 300mg + ddI 200mg + IDV 400mg + RTV 100mg [> 60 Kg ]','Zidovudine 300mg + Didanosine 125mg + Indinavir 400mg + Rito',NULL,3),
  (19,'11A','TDF 300mg + ABC 300mg + LPV/r 133.3mg/33.3mg  ','Tenofovir 300mg + Abacavir 300mg + Lopinavir/ritonavir 133.3',NULL,3),
  (20,'11B','TDF 300mg + AZT 300mg + LPV/r 133.3mg/33.3mg','Tenofovir 300mg + Zidovudine 300mg + Lopinavir/ritonavir 133',NULL,3),
  (21,'PEP1','AZT 300mg + 3TC 150mg ','Zidovudine 300mg + Lamivudine 150mg',NULL,4),
  (22,'PEP2A','d4T 30mg + 3TC 150mg  [< 60Kg]','Stavudine 30mg + Lamivudine 150mg for patients less than 60 ',NULL,4),
  (23,'PEP2B','d4T 40mg + 3TC 150mg  [> 60Kg]','Stavudine 40mg + Lamivudine 150mg for patients greater than ',NULL,4),
  (24,'PEP3','AZT 300mg + 3TC 150mg + LPV/r 133.3/33.3mg  ','Zidovudine 300mg + Lamivudine 150mg + Lopinavir/Ritonavir 13',NULL,4),
  (25,'PEP4','AZT 300mg + 3TC 150mg + IDV 400mg + RTV 100mg','Zidovudine 300mg + Lamivudine 150mg + Indinavir 400mg + Rito',NULL,4),
  (26,'PEP5','AZT 300mg + 3TC 150mg + NFV 250mg ','Zidovudine 300mg + Lamivudine 150mg + Nelfinavir 250mg',NULL,4),
  (27,'PEP6A','Paed: AZT + 3TC','Paediatric PEP: Zidovudine + Lamivudine',NULL,4),
  (28,'PEP6C','Paed: AZT + 3TC + NFV','Paediatric PEP: Zidovudine + Lamivudine + Nelfinavir',NULL,4),
  (29,'PEP6B','Paed: AZT + 3TC + LPV/r','Paediatric PEP: Zidovudine + Lamivudine + Lopinavir/Ritonavi',NULL,4),
  (30,'PEP7A','Paed: d4T + 3TC','Paediatric PEP: Stavudine + Lamivudine',NULL,4),
  (31,'PEP7B','Paed: d4T + 3TC + LPV/r','Paediatric PEP: Stavudine + Lamivudine + Lopinavir/Ritonavir',NULL,4),
  (32,'PMTCT 1M','Nevirapine (NVP) 200mg stat','PMTCT for the mother: Nevirapine tablets 200mg stat',NULL,5),
  (33,'PMTCT 2M','AZT 300mg bd (from week 28-40) + AZT 600mg stat + NVP 200mg stat','PMTCT for the mother: Zidovudine tablets 300mg bd (from week 28 to 40 of the pregnancy) plus Zidovudine 600mg stat and Nevirapine tablets 200mg stat at birth',NULL,5),
  (34,'PMTCT 1C','Nevirapine (NVP) 2 mg/kg stat','PMTCT for the baby: Nevirapine syrup 2mg/kg stat',NULL,5),
  (35,'PMTCT 2C','NVP 2 mg/kg stat + AZT 4mg/kg bd for 1 week','PMTCT for the baby: Nevirapine syrup 2mg/kg stat at birth plus Zidovudine syrup 4mg/kg bd for 1 week. [Neonatal/Infant dose for AZT (age <6 weeks): Oral: 2 mg per kg of body weight every six hours.]',NULL,5),
  (36,'C1A','d4T + 3TC + NVP [0 - <10 kg]','Stavudine + Lamivudine + Nevirapine for patients weighing less than 10 kg',NULL,6),
  (37,'C1B','d4T + 3TC + NVP [10 - <20 kg]','Stavudine + Lamivudine + Nevirapine for patients weighing 10 to 20 kg',NULL,6),
  (38,'C1C','d4T + 3TC + NVP [20 - <30 kg]','Stavudine + Lamivudine + Nevirapine for patients weighing 20 to 30 kg',NULL,6),
  (39,'C1D','d4T + 3TC + NVP [30 - <40 kg]','Stavudine + Lamivudine + Nevirapine for patients weighing 30 to 40 kg',NULL,6),
  (40,'C2A','d4T + 3TC + EFV [0 - <10 kg]','Stavudine + Lamivudine + Efavirenz for patients weighing less than 10 kg',NULL,6),
  (41,'C2B','d4T + 3TC + EFV [10 - <20 kg]','Stavudine + Lamivudine + Efavirenz for patients weighing 10 to 20 kg',NULL,6),
  (42,'C2C','d4T + 3TC + EFV [20 - <30 kg]','Stavudine + Lamivudine + Efavirenz for patients weighing 20 to 30 kg',NULL,6),
  (43,'C2D','d4T + 3TC + EFV [30 - <40 kg]','Stavudine + Lamivudine + Efavirenz for patients weighing 30 to 40 kg',NULL,6),
  (44,'C3A','AZT + 3TC + EFV [0 - <10 kg]','Zidovudine + Lamivudine + Efavirenz for patients weighing less than 10 kg',NULL,6),
  (45,'C3B','AZT + 3TC + EFV [10 - <20 kg]','Zidovudine + Lamivudine + Efavirenz for patients weighing 10 to 20 kg',NULL,6),
  (46,'C3C','AZT + 3TC + EFV [20 - <30 kg]','Zidovudine + Lamivudine + Efavirenz for patients weighing 20 to 30 kg',NULL,6),
  (47,'C3D','AZT + 3TC + EFV [30 - <40 kg]','Zidovudine + Lamivudine + Efavirenz for patients weighing 30 to 40 kg',NULL,6),
  (48,'C4A','AZT + 3TC + NVP [0 - <10 kg]','Zidovudine + Lamivudine + Nevirapine for patients weighing less than 10 kg',NULL,6),
  (49,'C4B','AZT + 3TC + NVP [10 - <20 kg]','Zidovudine + Lamivudine + Nevirapine for patients weighing 10 to 20 kg',NULL,6),
  (50,'C4C','AZT + 3TC + NVP [20 - <30 kg]','Zidovudine + Lamivudine + Nevirapine for patients weighing 20 to 30 kg',NULL,6),
  (51,'C4D','AZT + 3TC + NVP [30 - <40 kg]','Zidovudine + Lamivudine + Nevirapine for patients weighing 30 to 40 kg',NULL,6),
  (52,'C5A','d4T + ABC + LPV/r','Stavudine + Abacavir + Lopinavir/Ritonavir',NULL,7),
  (53,'C5B','d4T + ABC + NFV','Stavudine + Abacavir + Nelfinavir',NULL,7),
  (54,'C6A','AZT + ABC + LPV/r','Zidovudine + Abacavir + Lopinavir/Ritonavir',NULL,7),
  (55,'C6B','AZT + ABC + NFV','Zidovudine + Abacavir + Nelfinavir',NULL,7),
  (56,'C7A','ABC + ddI + LPV/r','Abacavir + Didanosine + Lopinavir/Ritonavir',NULL,7),
  (57,'C7B','ABC + ddI + NFV','Abacavir + Didanosine + Nelfinavir',NULL,7),
  (58,'C8','AZT + 3TC + LPV/r','Zidovudine + Lamivudine + Lopinavir/Ritonavir (especially for child exposed to single dose NVP (failed prophylaxis))',NULL,7);

COMMIT;

