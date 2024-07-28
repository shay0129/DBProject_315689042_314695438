prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by ShayMordechai on Sunday, July 28, 2024
set feedback off
set define off

prompt Creating EMPLOYEE...
create table EMPLOYEE
(
  employee_id         NUMBER(4) not null,
  employee_name       VARCHAR2(30),
  seniority           NUMBER(5) default 0,
  contact_information VARCHAR2(50),
  job_title           VARCHAR2(30)
)
;
alter table EMPLOYEE
  add primary key (EMPLOYEE_ID);
alter table EMPLOYEE
  add constraint CHK_EMPLOYEE_JOBTITLE
  check (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'));
alter table EMPLOYEE
  add constraint JOB_TITLE
  check (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'));
alter table EMPLOYEE
  add check (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'));

prompt Creating BUDGET...
create table BUDGET
(
  budget_code      INTEGER,
  employee_id      NUMBER(4),
  expense_category VARCHAR2(50) not null,
  budget_amount    NUMBER(10,2),
  budget_year      NUMBER(4) not null
)
;
alter table BUDGET
  add primary key (EXPENSE_CATEGORY, BUDGET_YEAR);
alter table BUDGET
  add foreign key (EMPLOYEE_ID)
  references EMPLOYEE (EMPLOYEE_ID);

prompt Creating SUPPLIER...
create table SUPPLIER
(
  supplier_id         INTEGER not null,
  supplier_name       VARCHAR2(30),
  contact_information VARCHAR2(50),
  inventory           NUMBER(10,2)
)
;
alter table SUPPLIER
  add primary key (SUPPLIER_ID);

prompt Creating INVOICE...
create table INVOICE
(
  invoice_id   INTEGER not null,
  supplier_id  INTEGER,
  invoice_cost NUMBER(10,2),
  invoice_date DATE
)
;
alter table INVOICE
  add primary key (INVOICE_ID);
alter table INVOICE
  add foreign key (SUPPLIER_ID)
  references SUPPLIER (SUPPLIER_ID);

prompt Creating ORDERS...
create table ORDERS
(
  order_id    INTEGER not null,
  supplier_id INTEGER,
  employee_id INTEGER,
  invoice_id  INTEGER not null,
  quantity    INTEGER default 1
)
;
alter table ORDERS
  add primary key (ORDER_ID);
alter table ORDERS
  add foreign key (EMPLOYEE_ID)
  references EMPLOYEE (EMPLOYEE_ID);
alter table ORDERS
  add foreign key (SUPPLIER_ID)
  references SUPPLIER (SUPPLIER_ID);
alter table ORDERS
  add foreign key (INVOICE_ID)
  references INVOICE (INVOICE_ID);

prompt Creating PAYMENT...
create table PAYMENT
(
  payment_id      INTEGER not null,
  employee_id     INTEGER,
  amount          NUMBER(10,2),
  payment_purpose VARCHAR2(20),
  payment_date    DATE
)
;
alter table PAYMENT
  add primary key (PAYMENT_ID);
alter table PAYMENT
  add foreign key (EMPLOYEE_ID)
  references EMPLOYEE (EMPLOYEE_ID);
alter table PAYMENT
  add constraint CHK_PAYMENT_PAYMENTPURPOSE
  check (Payment_Purpose IN ('Salary', 'Bonus', 'Grant'));
alter table PAYMENT
  add constraint PAYMENT_PURPOSE
  check (Payment_Purpose IN ('Salary', 'Bonus', 'Grant'));
alter table PAYMENT
  add check (Payment_Purpose IN ('Salary', 'Bonus', 'Grant'));

prompt Creating SUBJECTS_TAUGHT...
create table SUBJECTS_TAUGHT
(
  subject_name             VARCHAR2(30) not null,
  class_number             INTEGER,
  students_studying_number INTEGER,
  difficulty_level         INTEGER
)
;
alter table SUBJECTS_TAUGHT
  add primary key (SUBJECT_NAME);

prompt Creating TEACH...
create table TEACH
(
  employee_id  NUMBER(4) not null,
  subject_name VARCHAR2(30) not null
)
;
alter table TEACH
  add primary key (EMPLOYEE_ID, SUBJECT_NAME);
alter table TEACH
  add foreign key (EMPLOYEE_ID)
  references EMPLOYEE (EMPLOYEE_ID);
alter table TEACH
  add foreign key (SUBJECT_NAME)
  references SUBJECTS_TAUGHT (SUBJECT_NAME);

prompt Disabling triggers for EMPLOYEE...
alter table EMPLOYEE disable all triggers;
prompt Disabling triggers for BUDGET...
alter table BUDGET disable all triggers;
prompt Disabling triggers for SUPPLIER...
alter table SUPPLIER disable all triggers;
prompt Disabling triggers for INVOICE...
alter table INVOICE disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for SUBJECTS_TAUGHT...
alter table SUBJECTS_TAUGHT disable all triggers;
prompt Disabling triggers for TEACH...
alter table TEACH disable all triggers;
prompt Disabling foreign key constraints for BUDGET...
alter table BUDGET disable constraint SYS_C008430;
prompt Disabling foreign key constraints for INVOICE...
alter table INVOICE disable constraint SYS_C008404;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C008408;
alter table ORDERS disable constraint SYS_C008409;
alter table ORDERS disable constraint SYS_C008410;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint SYS_C008413;
prompt Disabling foreign key constraints for TEACH...
alter table TEACH disable constraint SYS_C008425;
alter table TEACH disable constraint SYS_C008426;
prompt Deleting TEACH...
delete from TEACH;
commit;
prompt Deleting SUBJECTS_TAUGHT...
delete from SUBJECTS_TAUGHT;
commit;
prompt Deleting PAYMENT...
delete from PAYMENT;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting INVOICE...
delete from INVOICE;
commit;
prompt Deleting SUPPLIER...
delete from SUPPLIER;
commit;
prompt Deleting BUDGET...
delete from BUDGET;
commit;
prompt Deleting EMPLOYEE...
delete from EMPLOYEE;
commit;
prompt Loading EMPLOYEE...
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1500, 'Brandon' || chr(9) || 'Peake', 17, '555-555-613', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1501, 'Nicholas' || chr(9) || 'Jones', 12, 'NicholasJones@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1502, 'Brandon' || chr(9) || 'Skinner', 13, '555-555-469', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1503, 'Christian' || chr(9) || 'Ball', 13, 'ChristianBall@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1504, 'Joe' || chr(9) || 'Kerr', 7, 'JoeKerr@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1505, 'Brian' || chr(9) || 'Wallace', 5, 'BrianWallace@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1506, 'Megan' || chr(9) || 'Skinner', 19, '555-555-705', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1507, 'Lauren' || chr(9) || 'Harris', 10, 'LaurenHarris@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1508, 'Joe' || chr(9) || 'Peake', 2, 'JoePeake@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1509, 'Amanda' || chr(9) || 'Buckland', 9, 'AmandaBuckland@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1510, 'Lily' || chr(9) || 'Hart', 8, 'LilyHart@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1511, 'Dylan' || chr(9) || 'Clark', 16, 'DylanClark@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1512, 'Robert' || chr(9) || 'Carr', 13, 'RobertCarr@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1513, 'Natalie' || chr(9) || 'Greene', 2, 'NatalieGreene@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1514, 'Emily' || chr(9) || 'Welch', 10, 'EmilyWelch@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1515, 'Kevin' || chr(9) || 'Robertson', 14, '555-555-702', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1516, 'David' || chr(9) || 'Quinn', 12, 'DavidQuinn@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1517, 'Liam' || chr(9) || 'Cornish', 6, 'LiamCornish@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1518, 'Edward' || chr(9) || 'Underwood', 5, 'EdwardUnderwood@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1519, 'Julian' || chr(9) || 'Langdon', 17, 'JulianLangdon@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1520, 'Julian' || chr(9) || 'Churchill', 8, 'JulianChurchill@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1521, 'Leah' || chr(9) || 'Gill', 9, '555-555-433', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1522, 'Oliver' || chr(9) || 'McDonald', 20, 'OliverMcDonald@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1523, 'Jan' || chr(9) || 'Ross', 8, '555-555-274', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1524, 'Carolyn' || chr(9) || 'Kelly', 16, 'CarolynKelly@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1525, 'Connor' || chr(9) || 'Stewart', 2, '555-555-281', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1526, 'Tracey' || chr(9) || 'Clarkson', 5, 'TraceyClarkson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1527, 'Bella' || chr(9) || 'Blake', 13, 'BellaBlake@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1528, 'Sarah' || chr(9) || 'Vance', 9, '555-555-583', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1529, 'Liam' || chr(9) || 'Blake', 6, '555-555-318', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1530, 'Colin' || chr(9) || 'Arnold', 9, 'ColinArnold@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1531, 'Brian' || chr(9) || 'Coleman', 1, '555-555-156', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1532, 'Natalie' || chr(9) || 'Knox', 7, 'NatalieKnox@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1533, 'Blake' || chr(9) || 'Fraser', 13, 'BlakeFraser@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1534, 'Colin' || chr(9) || 'Parr', 13, 'ColinParr@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1535, 'Jacob' || chr(9) || 'Hughes', 12, '555-555-264', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1536, 'Emma' || chr(9) || 'Pullman', 7, '555-555-321', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1537, 'Michelle' || chr(9) || 'Metcalfe', 3, 'MichelleMetcalfe@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1538, 'Zoe' || chr(9) || 'Lawrence', 1, '555-555-707', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1539, 'Sally' || chr(9) || 'Rees', 6, '555-555-676', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1540, 'Katherine' || chr(9) || 'Bell', 9, 'KatherineBell@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1541, 'Connor' || chr(9) || 'Sutherland', 18, 'ConnorSutherland@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1542, 'Penelope' || chr(9) || 'Jones', 3, 'PenelopeJones@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1543, 'Joan' || chr(9) || 'Manning', 5, '555-555-693', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1544, 'Michelle' || chr(9) || 'Dickens', 13, 'MichelleDickens@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1545, 'Elizabeth' || chr(9) || 'Robertson', 12, '555-555-724', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1546, 'Megan' || chr(9) || 'Davies', 14, 'MeganDavies@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1547, 'Sebastian' || chr(9) || 'Sutherland', 6, 'SebastianSutherland@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1548, 'Bella' || chr(9) || 'Mills', 6, '555-555-191', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1549, 'Thomas' || chr(9) || 'Blake', 14, '555-555-308', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1550, 'Alexander' || chr(9) || 'Jackson', 13, '555-555-482', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1551, 'Lauren' || chr(9) || 'Turner', 15, 'LaurenTurner@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1552, 'Austin' || chr(9) || 'Rees', 13, '555-555-672', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1553, 'Wendy' || chr(9) || 'Harris', 13, 'WendyHarris@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1554, 'Michael' || chr(9) || 'Davies', 18, 'MichaelDavies@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1555, 'Peter' || chr(9) || 'Terry', 8, '555-555-939', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1556, 'Faith' || chr(9) || 'White', 1, 'FaithWhite@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1557, 'Gordon' || chr(9) || 'Paterson', 9, '555-555-750', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1558, 'Gordon' || chr(9) || 'Anderson', 8, '555-555-520', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1559, 'Melanie' || chr(9) || 'Piper', 9, 'MelaniePiper@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1560, 'Olivia' || chr(9) || 'Coleman', 9, '555-555-405', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1561, 'Sue' || chr(9) || 'Arnold', 12, 'SueArnold@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1562, 'Stewart' || chr(9) || 'Paterson', 6, 'StewartPaterson@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1563, 'Hannah' || chr(9) || 'Paige', 5, 'HannahPaige@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1564, 'Leah' || chr(9) || 'Cornish', 16, '555-555-410', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1565, 'Adrian' || chr(9) || 'Hemmings', 17, 'AdrianHemmings@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1566, 'Blake' || chr(9) || 'Ogden', 10, 'BlakeOgden@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1567, 'Virginia' || chr(9) || 'Hudson', 5, 'VirginiaHudson@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1568, 'Felicity' || chr(9) || 'Ball', 2, '555-555-625', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1569, 'Claire' || chr(9) || 'Grant', 7, 'ClaireGrant@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1570, 'Cameron' || chr(9) || 'Metcalfe', 10, '555-555-532', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1571, 'Leah' || chr(9) || 'Bond', 17, 'LeahBond@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1572, 'Nathan' || chr(9) || 'Rutherford', 6, 'NathanRutherford@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1573, 'Claire' || chr(9) || 'Burgess', 10, '555-555-766', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1574, 'Elizabeth' || chr(9) || 'Butler', 11, '555-555-535', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1575, 'Dylan' || chr(9) || 'Brown', 12, '555-555-370', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1576, 'Mary' || chr(9) || 'Gray', 2, 'MaryGray@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1577, 'Peter' || chr(9) || 'Peake', 18, 'PeterPeake@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1578, 'Lauren' || chr(9) || 'Wright', 5, '555-555-150', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1579, 'Luke' || chr(9) || 'McDonald', 4, 'LukeMcDonald@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1580, 'Christian' || chr(9) || 'Lee', 13, 'ChristianLee@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1581, 'Keith' || chr(9) || 'Welch', 13, '555-555-257', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1582, 'Andrew' || chr(9) || 'Duncan', 5, 'AndrewDuncan@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1583, 'Piers' || chr(9) || 'Howard', 1, '555-555-586', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1584, 'Theresa' || chr(9) || 'Paterson', 19, 'TheresaPaterson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1585, 'Irene' || chr(9) || 'Lambert', 6, '555-555-341', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1586, 'Carol' || chr(9) || 'Pullman', 8, 'CarolPullman@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1587, 'Sally' || chr(9) || 'MacDonald', 17, '555-555-771', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1588, 'Thomas' || chr(9) || 'Kerr', 18, '555-555-848', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1589, 'Lillian' || chr(9) || 'Dyer', 3, 'LillianDyer@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1590, 'Connor' || chr(9) || 'Churchill', 6, 'ConnorChurchill@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1591, 'Colin' || chr(9) || 'Johnston', 12, '555-555-100', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1592, 'Frank' || chr(9) || 'Glover', 17, '555-555-545', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1593, 'Leonard' || chr(9) || 'Underwood', 9, '555-555-730', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1594, 'Irene' || chr(9) || 'Short', 12, 'IreneShort@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1595, 'Ruth' || chr(9) || 'Skinner', 4, 'RuthSkinner@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1596, 'Jessica' || chr(9) || 'Wright', 8, '555-555-866', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1597, 'Amanda' || chr(9) || 'Campbell', 19, '555-555-804', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1598, 'Rachel' || chr(9) || 'Cameron', 19, 'RachelCameron@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1599, 'Lillian' || chr(9) || 'Quinn', 8, '555-555-913', 'Procurement Manager');
commit;
prompt 100 records committed...
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1600, 'Rachel' || chr(9) || 'Wright', 5, 'RachelWright@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1601, 'Sarah' || chr(9) || 'Berry', 4, '555-555-331', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1602, 'Madeleine' || chr(9) || 'Allan', 18, 'MadeleineAllan@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1603, 'Connor' || chr(9) || 'Martin', 9, 'ConnorMartin@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1604, 'Max' || chr(9) || 'Alsop', 3, '555-555-131', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1605, 'Leah' || chr(9) || 'Hamilton', 3, 'LeahHamilton@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1606, 'Claire' || chr(9) || 'Robertson', 15, 'ClaireRobertson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1607, 'Lauren' || chr(9) || 'Morrison', 1, '555-555-400', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1608, 'Tim' || chr(9) || 'Ball', 13, 'TimBall@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1609, 'Diana' || chr(9) || 'Bailey', 19, '555-555-645', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1610, 'Karen' || chr(9) || 'Davidson', 9, '555-555-386', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1611, 'Donna' || chr(9) || 'Bailey', 20, '555-555-777', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1612, 'Boris' || chr(9) || 'Lewis', 13, '555-555-638', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1613, 'Boris' || chr(9) || 'Graham', 2, 'BorisGraham@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1614, 'Faith' || chr(9) || 'Payne', 10, '555-555-656', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1615, 'Andrew' || chr(9) || 'McGrath', 20, 'AndrewMcGrath@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1616, 'Christopher' || chr(9) || 'Marshall', 4, 'ChristopherMarshall@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1617, 'William' || chr(9) || 'Murray', 1, '555-555-269', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1618, 'Natalie' || chr(9) || 'Allan', 2, '555-555-661', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1619, 'Vanessa' || chr(9) || 'Skinner', 8, '555-555-566', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1620, 'Oliver' || chr(9) || 'Vaughan', 13, '555-555-990', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1621, 'John' || chr(9) || 'Watson', 13, 'JohnWatson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1622, 'Jason' || chr(9) || 'Vance', 9, '555-555-147', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1623, 'Melanie' || chr(9) || 'Turner', 7, 'MelanieTurner@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1624, 'Simon' || chr(9) || 'Sharp', 4, '555-555-694', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1625, 'Sam' || chr(9) || 'Peters', 3, 'SamPeters@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1626, 'Charles' || chr(9) || 'Gray', 12, '555-555-672', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1627, 'Olivia' || chr(9) || 'Walker', 11, '555-555-927', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1628, 'Blake' || chr(9) || 'White', 19, 'BlakeWhite@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1629, 'Phil' || chr(9) || 'Buckland', 20, '555-555-691', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1630, 'Bella' || chr(9) || 'Knox', 10, '555-555-466', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1631, 'Carolyn' || chr(9) || 'Davies', 10, '555-555-144', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1632, 'Rose' || chr(9) || 'Campbell', 11, 'RoseCampbell@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1633, 'Luke' || chr(9) || 'Springer', 13, '555-555-167', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1634, 'Sonia' || chr(9) || 'Mitchell', 17, '555-555-152', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1635, 'Ava' || chr(9) || 'Hardacre', 10, 'AvaHardacre@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1636, 'Carolyn' || chr(9) || 'Rutherford', 3, '555-555-831', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1637, 'Una' || chr(9) || 'Walsh', 5, '555-555-435', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1638, 'Joanne' || chr(9) || 'Pullman', 5, 'JoannePullman@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1639, 'Brandon' || chr(9) || 'Reid', 14, '555-555-260', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1640, 'Piers' || chr(9) || 'Avery', 17, '555-555-383', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1641, 'Ruth' || chr(9) || 'Roberts', 1, '555-555-310', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1642, 'Wendy' || chr(9) || 'Nolan', 12, '555-555-902', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1643, 'Austin' || chr(9) || 'Mathis', 2, '555-555-701', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1644, 'Mary' || chr(9) || 'Peters', 3, 'MaryPeters@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1645, 'Carl' || chr(9) || 'Marshall', 9, '555-555-174', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1646, 'Samantha' || chr(9) || 'Cornish', 6, 'SamanthaCornish@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1647, 'Claire' || chr(9) || 'Duncan', 11, 'ClaireDuncan@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1648, 'Dan' || chr(9) || 'Terry', 1, 'DanTerry@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1649, 'Ruth' || chr(9) || 'Ross', 19, '555-555-584', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1650, 'Oliver' || chr(9) || 'Sutherland', 15, '555-555-312', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1651, 'Jane' || chr(9) || 'Campbell', 17, 'JaneCampbell@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1652, 'Jan' || chr(9) || 'Marshall', 6, 'JanMarshall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1653, 'Melanie' || chr(9) || 'Hemmings', 17, 'MelanieHemmings@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1654, 'Amanda' || chr(9) || 'Ogden', 18, 'AmandaOgden@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1655, 'Sarah' || chr(9) || 'Turner', 16, 'SarahTurner@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1656, 'Keith' || chr(9) || 'Hunter', 14, '555-555-860', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1657, 'Olivia' || chr(9) || 'Howard', 10, '555-555-297', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1658, 'Michelle' || chr(9) || 'Wallace', 3, 'MichelleWallace@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1659, 'Joseph' || chr(9) || 'Churchill', 16, '555-555-559', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1660, 'Chloe' || chr(9) || 'Dowd', 6, '555-555-729', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1661, 'Piers' || chr(9) || 'Quinn', 15, 'PiersQuinn@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1662, 'Deirdre' || chr(9) || 'Walsh', 16, 'DeirdreWalsh@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1663, 'Lisa' || chr(9) || 'Lawrence', 20, 'LisaLawrence@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1664, 'Mary' || chr(9) || 'Bower', 10, '555-555-561', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1665, 'Olivia' || chr(9) || 'North', 8, 'OliviaNorth@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1666, 'Elizabeth' || chr(9) || 'Davies', 14, 'ElizabethDavies@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1667, 'Lily' || chr(9) || 'Parr', 20, '555-555-167', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1668, 'Zoe' || chr(9) || 'Ferguson', 11, 'ZoeFerguson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1669, 'Samantha' || chr(9) || 'Langdon', 18, '555-555-994', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1670, 'Anna' || chr(9) || 'Hart', 11, '555-555-972', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1671, 'Sebastian' || chr(9) || 'Grant', 1, 'SebastianGrant@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1672, 'Ian' || chr(9) || 'Slater', 12, 'IanSlater@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1673, 'Katherine' || chr(9) || 'Springer', 12, '555-555-140', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1674, 'Hannah' || chr(9) || 'Cornish', 10, 'HannahCornish@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1675, 'Jane' || chr(9) || 'Graham', 13, 'JaneGraham@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1676, 'Joanne' || chr(9) || 'Ellison', 7, '555-555-488', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1677, 'Evan' || chr(9) || 'Clark', 17, 'EvanClark@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1678, 'Joanne' || chr(9) || 'Arnold', 19, '555-555-282', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1679, 'Blake' || chr(9) || 'Bailey', 15, '555-555-623', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1680, 'Diana' || chr(9) || 'Hart', 6, '555-555-128', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1681, 'Victoria' || chr(9) || 'Vaughan', 1, '555-555-658', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1682, 'Nicholas' || chr(9) || 'Clarkson', 6, 'NicholasClarkson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1683, 'Nathan' || chr(9) || 'Mitchell', 10, '555-555-501', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1684, 'Penelope' || chr(9) || 'Hart', 14, '555-555-273', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1685, 'Natalie' || chr(9) || 'Springer', 1, 'NatalieSpringer@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1686, 'Una' || chr(9) || 'Peake', 7, '555-555-893', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1687, 'Keith' || chr(9) || 'Campbell', 16, '555-555-725', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1688, 'Maria' || chr(9) || 'Mills', 18, 'MariaMills@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1689, 'Faith' || chr(9) || 'Sutherland', 2, 'FaithSutherland@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1690, 'Hannah' || chr(9) || 'Mitchell', 12, '555-555-808', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1691, 'Julia' || chr(9) || 'Poole', 5, 'JuliaPoole@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1692, 'John' || chr(9) || 'Rutherford', 20, 'JohnRutherford@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1693, 'Nicholas' || chr(9) || 'Lewis', 1, 'NicholasLewis@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1694, 'Yvonne' || chr(9) || 'Wilkins', 12, '555-555-862', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1695, 'Michelle' || chr(9) || 'Gibson', 18, '555-555-341', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1696, 'Justin' || chr(9) || 'Knox', 6, 'JustinKnox@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1697, 'Caroline' || chr(9) || 'Hughes', 17, 'CarolineHughes@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1698, 'Jane' || chr(9) || 'North', 11, 'JaneNorth@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1699, 'Yvonne' || chr(9) || 'Rutherford', 14, '555-555-624', 'Worker');
commit;
prompt 200 records committed...
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1700, 'Phil' || chr(9) || 'King', 12, 'PhilKing@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1701, 'Stephen' || chr(9) || 'Hemmings', 13, 'StephenHemmings@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1702, 'Warren' || chr(9) || 'Vance', 12, 'WarrenVance@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1703, 'Leah' || chr(9) || 'Tucker', 6, 'LeahTucker@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1704, 'Wendy' || chr(9) || 'Blake', 15, 'WendyBlake@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1705, 'Joshua' || chr(9) || 'Gill', 16, '555-555-111', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1706, 'Diane' || chr(9) || 'Paige', 6, '555-555-982', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1707, 'Max' || chr(9) || 'Lewis', 11, '555-555-887', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1708, 'Hannah' || chr(9) || 'Clarkson', 10, 'HannahClarkson@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1709, 'Bernadette' || chr(9) || 'Nolan', 12, '555-555-377', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1710, 'Emma' || chr(9) || 'McGrath', 9, 'EmmaMcGrath@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1711, 'Keith' || chr(9) || 'Randall', 3, '555-555-483', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1712, 'Grace' || chr(9) || 'Lyman', 11, 'GraceLyman@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1713, 'Joan' || chr(9) || 'Alsop', 11, 'JoanAlsop@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1714, 'Brandon' || chr(9) || 'Pullman', 19, 'BrandonPullman@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1715, 'Amanda' || chr(9) || 'King', 4, '555-555-677', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1716, 'Isaac' || chr(9) || 'Knox', 5, '555-555-265', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1717, 'Claire' || chr(9) || 'Wilkins', 19, '555-555-671', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1718, 'Amelia' || chr(9) || 'James', 6, '555-555-118', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1719, 'Olivia' || chr(9) || 'Greene', 12, '555-555-505', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1720, 'Dylan' || chr(9) || 'Allan', 9, '555-555-288', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1721, 'Pippa' || chr(9) || 'Davies', 10, 'PippaDavies@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1722, 'Phil' || chr(9) || 'Burgess', 13, 'PhilBurgess@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1723, 'Andrew' || chr(9) || 'Smith', 14, '555-555-330', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1724, 'Melanie' || chr(9) || 'Slater', 15, '555-555-186', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1725, 'Anne' || chr(9) || 'Sharp', 15, '555-555-317', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1726, 'Harry' || chr(9) || 'Sutherland', 16, 'HarrySutherland@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1727, 'David' || chr(9) || 'Hardacre', 14, 'DavidHardacre@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1728, 'Owen' || chr(9) || 'Russell', 13, 'OwenRussell@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1729, 'Anna' || chr(9) || 'Ball', 18, 'AnnaBall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1730, 'Pippa' || chr(9) || 'Ross', 1, 'PippaRoss@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1731, 'Maria' || chr(9) || 'Vaughan', 15, '555-555-886', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1732, 'Dan' || chr(9) || 'MacDonald', 18, 'DanMacDonald@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1733, 'Owen' || chr(9) || 'Ball', 10, 'OwenBall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1734, 'Audrey' || chr(9) || 'Skinner', 11, '555-555-610', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1735, 'Audrey' || chr(9) || 'Hamilton', 7, '555-555-379', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1736, 'Pippa' || chr(9) || 'Harris', 17, '555-555-603', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1737, 'Stephen' || chr(9) || 'Wright', 5, 'StephenWright@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1738, 'Adrian' || chr(9) || 'Vaughan', 4, 'AdrianVaughan@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1739, 'Blake' || chr(9) || 'Hodges', 9, 'BlakeHodges@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1740, 'Alan' || chr(9) || 'Morgan', 15, '555-555-226', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1741, 'Dorothy' || chr(9) || 'King', 14, '555-555-196', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1742, 'Dorothy' || chr(9) || 'Clark', 19, 'DorothyClark@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1743, 'Jason' || chr(9) || 'Black', 2, '555-555-884', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1744, 'Steven' || chr(9) || 'Walker', 16, '555-555-463', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1745, 'Julian' || chr(9) || 'Alsop', 7, 'JulianAlsop@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1746, 'Jasmine' || chr(9) || 'James', 15, 'JasmineJames@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1747, 'Samantha' || chr(9) || 'Thomson', 20, '555-555-918', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1748, 'Bella' || chr(9) || 'Welch', 8, 'BellaWelch@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1749, 'Rebecca' || chr(9) || 'Chapman', 8, 'RebeccaChapman@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1750, 'Jane' || chr(9) || 'Butler', 13, 'JaneButler@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1751, 'Brandon' || chr(9) || 'Chapman', 13, 'BrandonChapman@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1752, 'Peter' || chr(9) || 'Ferguson', 2, '555-555-759', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1753, 'Austin' || chr(9) || 'Graham', 5, 'AustinGraham@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1754, 'Edward' || chr(9) || 'Harris', 8, '555-555-915', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1755, 'Joanne' || chr(9) || 'Robertson', 6, '555-555-546', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1756, 'Jason' || chr(9) || 'Kerr', 16, '555-555-757', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1757, 'Lily' || chr(9) || 'Dowd', 5, '555-555-682', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1758, 'Grace' || chr(9) || 'Wilson', 11, 'GraceWilson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1759, 'Carl' || chr(9) || 'Hemmings', 3, '555-555-432', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1760, 'Heather' || chr(9) || 'Pullman', 6, 'HeatherPullman@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1761, 'Kevin' || chr(9) || 'Nash', 17, '555-555-276', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1762, 'Molly' || chr(9) || 'Lawrence', 1, '555-555-528', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1763, 'Sue' || chr(9) || 'Fraser', 5, 'SueFraser@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1764, 'Bernadette' || chr(9) || 'Lewis', 20, 'BernadetteLewis@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1765, 'Vanessa' || chr(9) || 'Bell', 14, '555-555-164', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1766, 'Joanne' || chr(9) || 'Kelly', 12, '555-555-530', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1767, 'Gavin' || chr(9) || 'Forsyth', 20, 'GavinForsyth@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1768, 'Wanda' || chr(9) || 'Davies', 12, 'WandaDavies@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1769, 'Nicholas' || chr(9) || 'Welch', 10, '555-555-775', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1770, 'Carol' || chr(9) || 'Scott', 16, '555-555-268', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1771, 'Brandon' || chr(9) || 'Cameron', 5, 'BrandonCameron@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1772, 'Cameron' || chr(9) || 'Nash', 13, 'CameronNash@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1773, 'Dorothy' || chr(9) || 'Bailey', 14, 'DorothyBailey@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1774, 'Eric' || chr(9) || 'Cameron', 15, 'EricCameron@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1775, 'Lucas' || chr(9) || 'Powell', 13, '555-555-933', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1776, 'Adrian' || chr(9) || 'Fraser', 5, '555-555-565', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1777, 'Deirdre' || chr(9) || 'Thomson', 8, 'DeirdreThomson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1778, 'Bella' || chr(9) || 'Ball', 7, 'BellaBall@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1779, 'Gabrielle' || chr(9) || 'Coleman', 15, 'GabrielleColeman@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1780, 'Megan' || chr(9) || 'Welch', 4, '555-555-478', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1781, 'Yvonne' || chr(9) || 'Springer', 16, '555-555-165', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1782, 'Alan' || chr(9) || 'Cornish', 19, '555-555-199', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1783, 'Luke' || chr(9) || 'Howard', 18, '555-555-615', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1784, 'Dan' || chr(9) || 'Taylor', 4, 'DanTaylor@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1785, 'Jacob' || chr(9) || 'Campbell', 2, '555-555-915', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1786, 'Jane' || chr(9) || 'Bower', 15, '555-555-343', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1787, 'Carl' || chr(9) || 'Peake', 7, 'CarlPeake@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1788, 'Audrey' || chr(9) || 'Welch', 4, '555-555-213', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1789, 'Megan' || chr(9) || 'Pullman', 10, 'MeganPullman@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1790, 'Amy' || chr(9) || 'Short', 7, '555-555-450', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1791, 'Sean' || chr(9) || 'May', 7, '555-555-477', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1792, 'Amy' || chr(9) || 'Wilson', 11, '555-555-382', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1793, 'Katherine' || chr(9) || 'Forsyth', 20, 'KatherineForsyth@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1794, 'Amanda' || chr(9) || 'Walsh', 11, 'AmandaWalsh@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1795, 'Joseph' || chr(9) || 'Peake', 13, '555-555-371', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1796, 'Sam' || chr(9) || 'Coleman', 19, 'SamColeman@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1797, 'Alexander' || chr(9) || 'Welch', 9, 'AlexanderWelch@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1798, 'Jake' || chr(9) || 'Dickens', 7, '555-555-592', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1799, 'David' || chr(9) || 'Paige', 5, '555-555-829', 'Procurement Manager');
commit;
prompt 300 records committed...
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1800, 'Carol' || chr(9) || 'Peake', 1, '555-555-985', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1801, 'Carl' || chr(9) || 'Mackenzie', 13, 'CarlMackenzie@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1802, 'Adrian' || chr(9) || 'Ellison', 7, '555-555-945', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1803, 'Frank' || chr(9) || 'Mackenzie', 9, '555-555-214', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1804, 'Steven' || chr(9) || 'Parr', 3, 'StevenParr@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1805, 'Sarah' || chr(9) || 'Thomson', 3, '555-555-751', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1806, 'Jacob' || chr(9) || 'Ince', 6, '555-555-721', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1807, 'Amy' || chr(9) || 'Morrison', 13, 'AmyMorrison@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1808, 'Madeleine' || chr(9) || 'Watson', 20, '555-555-290', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1809, 'Julia' || chr(9) || 'Walsh', 14, 'JuliaWalsh@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1810, 'Joanne' || chr(9) || 'Nolan', 8, '555-555-544', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1811, 'Julian' || chr(9) || 'Rampling', 17, 'JulianRampling@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1812, 'Leah' || chr(9) || 'Dickens', 13, 'LeahDickens@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1813, 'Tim' || chr(9) || 'Bell', 12, 'TimBell@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1814, 'Molly' || chr(9) || 'Peake', 15, 'MollyPeake@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1815, 'Joshua' || chr(9) || 'Lawrence', 19, 'JoshuaLawrence@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1816, 'Natalie' || chr(9) || 'Churchill', 18, '555-555-234', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1817, 'Diane' || chr(9) || 'Coleman', 1, '555-555-411', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1818, 'Sophie' || chr(9) || 'Marshall', 19, 'SophieMarshall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1819, 'Luke' || chr(9) || 'Powell', 9, '555-555-397', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1820, 'Amanda' || chr(9) || 'Davies', 17, 'AmandaDavies@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1821, 'Colin' || chr(9) || 'Allan', 7, '555-555-894', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1822, 'Carl' || chr(9) || 'Watson', 8, 'CarlWatson@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1823, 'Owen' || chr(9) || 'Peters', 13, 'OwenPeters@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1824, 'Evan' || chr(9) || 'Chapman', 14, 'EvanChapman@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1825, 'Samantha' || chr(9) || 'May', 1, 'SamanthaMay@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1826, 'James' || chr(9) || 'Morgan', 11, 'JamesMorgan@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1827, 'Emily' || chr(9) || 'Buckland', 11, 'EmilyBuckland@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1828, 'Rose' || chr(9) || 'Powell', 2, 'RosePowell@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1829, 'Benjamin' || chr(9) || 'Roberts', 17, '555-555-635', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1830, 'Michelle' || chr(9) || 'Duncan', 5, '555-555-991', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1831, 'Peter' || chr(9) || 'Lewis', 2, 'PeterLewis@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1832, 'Natalie' || chr(9) || 'Burgess', 19, '555-555-172', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1833, 'Irene' || chr(9) || 'Langdon', 14, 'IreneLangdon@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1834, 'John' || chr(9) || 'Ellison', 2, '555-555-155', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1835, 'Theresa' || chr(9) || 'Piper', 15, 'TheresaPiper@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1836, 'Joe' || chr(9) || 'Forsyth', 7, 'JoeForsyth@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1837, 'Madeleine' || chr(9) || 'May', 13, '555-555-902', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1838, 'Bella' || chr(9) || 'Bower', 18, '555-555-529', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1839, 'Diana' || chr(9) || 'Walker', 18, 'DianaWalker@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1840, 'Adrian' || chr(9) || 'Rees', 16, 'AdrianRees@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1841, 'Ruth' || chr(9) || 'Mackay', 10, 'RuthMackay@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1842, 'Max' || chr(9) || 'Cornish', 2, 'MaxCornish@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1843, 'Joanne' || chr(9) || 'Thomson', 11, '555-555-967', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1844, 'Nicola' || chr(9) || 'Poole', 13, 'NicolaPoole@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1845, 'Frank' || chr(9) || 'Simpson', 17, 'FrankSimpson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1846, 'Carolyn' || chr(9) || 'Rees', 18, '555-555-223', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1847, 'Joanne' || chr(9) || 'Wallace', 17, 'JoanneWallace@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1848, 'Jack' || chr(9) || 'Nolan', 10, '555-555-200', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1849, 'Lucas' || chr(9) || 'Kerr', 8, '555-555-129', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1850, 'Owen' || chr(9) || 'Johnston', 9, 'OwenJohnston@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1851, 'James' || chr(9) || 'James', 1, 'JamesJames@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1852, 'Nicola' || chr(9) || 'Avery', 14, '555-555-478', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1853, 'Jan' || chr(9) || 'James', 12, '555-555-348', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1854, 'Joshua' || chr(9) || 'Young', 4, '555-555-327', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1855, 'Evan' || chr(9) || 'Ince', 20, '555-555-234', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1856, 'Alison' || chr(9) || 'Cornish', 8, '555-555-512', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1857, 'Neil' || chr(9) || 'Randall', 14, '555-555-877', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1858, 'Lily' || chr(9) || 'Ball', 18, '555-555-486', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1859, 'Kimberly' || chr(9) || 'McGrath', 16, 'KimberlyMcGrath@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1860, 'Luke' || chr(9) || 'Peake', 20, '555-555-223', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1861, 'Kylie' || chr(9) || 'Jackson', 10, '555-555-854', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1862, 'Dan' || chr(9) || 'Hughes', 4, 'DanHughes@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1863, 'Sue' || chr(9) || 'Churchill', 1, 'SueChurchill@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1864, 'Kylie' || chr(9) || 'Ogden', 14, 'KylieOgden@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1865, 'Adrian' || chr(9) || 'Young', 9, '555-555-579', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1866, 'Leah' || chr(9) || 'Coleman', 9, '555-555-211', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1867, 'Jake' || chr(9) || 'Fraser', 20, '555-555-876', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1868, 'Sam' || chr(9) || 'Brown', 13, 'SamBrown@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1869, 'Joe' || chr(9) || 'Marshall', 4, '555-555-381', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1870, 'Jonathan' || chr(9) || 'Allan', 8, '555-555-951', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1871, 'Caroline' || chr(9) || 'Parr', 3, '555-555-599', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1872, 'Brian' || chr(9) || 'Stewart', 13, 'BrianStewart@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1873, 'Ryan' || chr(9) || 'Ince', 14, '555-555-505', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1874, 'Simon' || chr(9) || 'Duncan', 18, 'SimonDuncan@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1875, 'Jason' || chr(9) || 'Randall', 8, '555-555-334', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1876, 'Fiona' || chr(9) || 'Dowd', 18, '555-555-167', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1877, 'Max' || chr(9) || 'Black', 5, 'MaxBlack@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1878, 'Chloe' || chr(9) || 'Brown', 6, 'ChloeBrown@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1879, 'Andrea' || chr(9) || 'Paterson', 10, 'AndreaPaterson@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1880, 'Christian' || chr(9) || 'Butler', 17, '555-555-570', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1881, 'Charles' || chr(9) || 'Poole', 7, '555-555-512', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1882, 'Sarah' || chr(9) || 'King', 16, 'SarahKing@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1883, 'Brian' || chr(9) || 'MacDonald', 4, '555-555-821', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1884, 'Frank' || chr(9) || 'Duncan', 14, '555-555-682', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1885, 'William' || chr(9) || 'Ellison', 16, '555-555-989', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1886, 'Christian' || chr(9) || 'Knox', 6, 'ChristianKnox@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1887, 'Ruth' || chr(9) || 'Carr', 19, 'RuthCarr@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1888, 'Harry' || chr(9) || 'Randall', 20, 'HarryRandall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1889, 'Andrea' || chr(9) || 'Lawrence', 11, 'AndreaLawrence@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1890, 'Kevin' || chr(9) || 'Kelly', 1, '555-555-672', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1891, 'Vanessa' || chr(9) || 'Nash', 3, '555-555-493', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1892, 'Eric' || chr(9) || 'Nash', 8, '555-555-863', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1893, 'Jason' || chr(9) || 'Sutherland', 8, 'JasonSutherland@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1894, 'Tracey' || chr(9) || 'Lawrence', 12, 'TraceyLawrence@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1895, 'Oliver' || chr(9) || 'Marshall', 7, 'OliverMarshall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1896, 'Nicola' || chr(9) || 'Dyer', 2, 'NicolaDyer@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1897, 'Pippa' || chr(9) || 'Paterson', 8, '555-555-196', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1898, 'Zoe' || chr(9) || 'Vaughan', 10, 'ZoeVaughan@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1899, 'Elizabeth' || chr(9) || 'Forsyth', 1, '555-555-890', 'Worker');
commit;
prompt 400 records committed...
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1900, 'Lily' || chr(9) || 'Morrison', 2, '555-555-939', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1901, 'Anna' || chr(9) || 'Nash', 4, 'AnnaNash@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1902, 'Tracey' || chr(9) || 'Lambert', 6, 'TraceyLambert@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1903, 'Oliver' || chr(9) || 'Walker', 13, '555-555-388', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1904, 'Irene' || chr(9) || 'Dyer', 18, 'IreneDyer@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1905, 'Peter' || chr(9) || 'Walsh', 5, '555-555-547', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1906, 'Jennifer' || chr(9) || 'Sanderson', 16, 'JenniferSanderson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1907, 'Heather' || chr(9) || 'Russell', 3, 'HeatherRussell@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1908, 'Grace' || chr(9) || 'Ball', 10, '555-555-153', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1909, 'Joanne' || chr(9) || 'Avery', 12, '555-555-985', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1910, 'Robert' || chr(9) || 'Lawrence', 11, 'RobertLawrence@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1911, 'Sam' || chr(9) || 'Rutherford', 5, '555-555-911', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1912, 'Jan' || chr(9) || 'Slater', 5, 'JanSlater@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1913, 'Rose' || chr(9) || 'Piper', 16, 'RosePiper@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1914, 'Brian' || chr(9) || 'White', 8, '555-555-857', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1915, 'William' || chr(9) || 'Russell', 19, 'WilliamRussell@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1916, 'Samantha' || chr(9) || 'Vance', 9, 'SamanthaVance@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1917, 'Joan' || chr(9) || 'Paige', 17, 'JoanPaige@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1918, 'Sam' || chr(9) || 'Powell', 11, '555-555-478', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1919, 'Sebastian' || chr(9) || 'Metcalfe', 13, '555-555-771', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1920, 'Adam' || chr(9) || 'Davidson', 10, 'AdamDavidson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1921, 'Kylie' || chr(9) || 'Dyer', 4, '555-555-397', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1922, 'Wendy' || chr(9) || 'Glover', 6, '555-555-486', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1923, 'Jake' || chr(9) || 'Greene', 4, 'JakeGreene@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1924, 'Natalie' || chr(9) || 'Langdon', 10, 'NatalieLangdon@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1925, 'Ava' || chr(9) || 'Harris', 18, '555-555-238', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1926, 'Amy' || chr(9) || 'Payne', 16, 'AmyPayne@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1927, 'Theresa' || chr(9) || 'Black', 2, 'TheresaBlack@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1928, 'Dylan' || chr(9) || 'Arnold', 7, 'DylanArnold@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1929, 'Robert' || chr(9) || 'Randall', 16, 'RobertRandall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1930, 'Amy' || chr(9) || 'Davies', 18, 'AmyDavies@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1931, 'Victoria' || chr(9) || 'Robertson', 12, 'VictoriaRobertson@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1932, 'Jack' || chr(9) || 'Hughes', 3, 'JackHughes@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1933, 'Chloe' || chr(9) || 'Morrison', 11, 'ChloeMorrison@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1934, 'Lillian' || chr(9) || 'Clark', 11, 'LillianClark@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1935, 'Leah' || chr(9) || 'Edmunds', 10, '555-555-352', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1936, 'Robert' || chr(9) || 'Hill', 10, 'RobertHill@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1937, 'Nicola' || chr(9) || 'Berry', 1, 'NicolaBerry@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1938, 'Harry' || chr(9) || 'Edmunds', 13, '555-555-548', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1939, 'Warren' || chr(9) || 'Manning', 12, 'WarrenManning@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1940, 'Joanne' || chr(9) || 'Hart', 15, '555-555-708', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1941, 'Luke' || chr(9) || 'Hill', 18, 'LukeHill@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1942, 'Amanda' || chr(9) || 'Reid', 17, 'AmandaReid@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1943, 'Max' || chr(9) || 'Newman', 2, '555-555-357', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1944, 'Adam' || chr(9) || 'Springer', 12, '555-555-781', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1945, 'Ian' || chr(9) || 'White', 13, '555-555-175', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1946, 'Austin' || chr(9) || 'Lyman', 19, 'AustinLyman@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1947, 'Thomas' || chr(9) || 'Fraser', 11, 'ThomasFraser@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1948, 'Anne' || chr(9) || 'Johnston', 4, '555-555-645', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1949, 'Blake' || chr(9) || 'Coleman', 5, '555-555-673', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1950, 'Amy' || chr(9) || 'Lambert', 17, 'AmyLambert@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1951, 'Joe' || chr(9) || 'Abraham', 6, '555-555-369', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1952, 'Megan' || chr(9) || 'Knox', 6, 'MeganKnox@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1953, 'Jan' || chr(9) || 'Randall', 5, '555-555-364', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1954, 'Bella' || chr(9) || 'Clark', 4, '555-555-307', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1955, 'Jake' || chr(9) || 'Morrison', 1, '555-555-908', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1956, 'Liam' || chr(9) || 'Payne', 13, '555-555-299', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1957, 'Joan' || chr(9) || 'Watson', 20, '555-555-259', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1958, 'Piers' || chr(9) || 'Anderson', 17, '555-555-257', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1959, 'Jacob' || chr(9) || 'Peters', 2, '555-555-507', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1960, 'Joe' || chr(9) || 'Piper', 19, 'JoePiper@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1961, 'Emma' || chr(9) || 'Randall', 5, 'EmmaRandall@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1962, 'Rose' || chr(9) || 'Abraham', 14, '555-555-185', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1963, 'Alan' || chr(9) || 'McLean', 12, '555-555-530', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1964, 'Vanessa' || chr(9) || 'Parsons', 13, 'VanessaParsons@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1965, 'Evan' || chr(9) || 'Hart', 4, 'EvanHart@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1966, 'Isaac' || chr(9) || 'McLean', 12, 'IsaacMcLean@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1967, 'Joe' || chr(9) || 'Fraser', 12, '555-555-337', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1968, 'Keith' || chr(9) || 'Knox', 12, 'KeithKnox@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1969, 'Austin' || chr(9) || 'Sanderson', 16, 'AustinSanderson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1970, 'Warren' || chr(9) || 'Skinner', 17, 'WarrenSkinner@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1971, 'Joshua' || chr(9) || 'Alsop', 16, 'JoshuaAlsop@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1972, 'Carl' || chr(9) || 'Slater', 9, '555-555-971', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1973, 'Heather' || chr(9) || 'Dyer', 20, 'HeatherDyer@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1974, 'Kevin' || chr(9) || 'Avery', 11, 'KevinAvery@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1975, 'Nathan' || chr(9) || 'Sanderson', 19, 'NathanSanderson@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1976, 'Una' || chr(9) || 'Cornish', 7, 'UnaCornish@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1977, 'Luke' || chr(9) || 'Reid', 16, '555-555-552', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1978, 'Abigail' || chr(9) || 'Brown', 5, 'AbigailBrown@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1979, 'Leonard' || chr(9) || 'Ellison', 6, 'LeonardEllison@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1980, 'Austin' || chr(9) || 'Brown', 15, 'AustinBrown@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1981, 'Carolyn' || chr(9) || 'Graham', 6, '555-555-450', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1982, 'Alan' || chr(9) || 'Paterson', 15, 'AlanPaterson@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1983, 'Neil' || chr(9) || 'Nolan', 12, 'NeilNolan@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1984, 'Sue' || chr(9) || 'Mitchell', 1, '555-555-146', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1985, 'Gabrielle' || chr(9) || 'Allan', 14, '555-555-443', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1986, 'Stephanie' || chr(9) || 'Gill', 19, 'StephanieGill@example.com', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1987, 'Chloe' || chr(9) || 'James', 1, '555-555-415', 'Procurement Manager');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1988, 'Justin' || chr(9) || 'Hardacre', 17, '555-555-837', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1989, 'Gordon' || chr(9) || 'Lyman', 9, '555-555-898', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1990, 'Trevor' || chr(9) || 'Nash', 15, '555-555-692', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1991, 'Claire' || chr(9) || 'Parr', 8, 'ClaireParr@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1992, 'Penelope' || chr(9) || 'Butler', 15, 'PenelopeButler@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1993, 'Madeleine' || chr(9) || 'Underwood', 8, 'MadeleineUnderwood@example.com', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1994, 'Sophie' || chr(9) || 'Kerr', 18, '555-555-176', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1995, 'Caroline' || chr(9) || 'Bower', 13, '555-555-398', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1996, 'Anna' || chr(9) || 'Skinner', 9, '555-555-441', 'Budget Committee');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1997, 'Emily' || chr(9) || 'MacLeod', 13, 'EmilyMacLeod@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1998, 'Leah' || chr(9) || 'Gibson', 4, 'LeahGibson@example.com', 'Worker');
insert into EMPLOYEE (employee_id, employee_name, seniority, contact_information, job_title)
values (1999, 'Katherine' || chr(9) || 'Young', 14, 'KatherineYoung@example.com', 'Procurement Manager');
commit;
prompt 500 records loaded
prompt Loading BUDGET...
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (1, 1500, 'Rent or Lease Payments', 15000, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (2, 1501, 'Special Education', 6240.9, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (3, 1502, 'Food Services', 6831.72, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (4, 1503, 'Employee Recruitment and Retention', 5794.23, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (5, 1504, 'Security', 4298.56, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (6, 1505, 'Legal Fees', 7207.49, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (7, 1506, 'Rent or Lease Payments', 8562.9, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (244, 1743, 'Travel', 7490.58, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (286, 1785, 'Travel', 7054.07, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (464, 1963, 'Textbooks and Instructional Software', 3981.04, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (11, 1510, 'Counseling and Guidance', 1166, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (85, 1584, 'Classroom Supplies', 7919.94, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (13, 1512, 'PC Services', 5783.82, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (324, 1823, 'Substitute Teachers', 5386.1, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (15, 1514, 'PC Services', 2020.73, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (16, 1515, 'Special Education', 7905.2, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (346, 1845, 'Professional Development', 1216.47, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (384, 1883, 'Debt Service (loans)', 5230.36, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (106, 1605, 'Technology Support', 1279.36, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (20, 1519, 'PC Services', 3424.43, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (21, 1520, 'Employee Recruitment and Retention', 1723.87, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (22, 1521, 'Student Activities', 1115.19, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (23, 1522, 'Guest Speakers', 3928.68, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (431, 1930, 'Legal Fees', 9536.93, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (482, 1981, 'Administrative Costs', 1630.15, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (308, 1807, 'Transportation', 9911.41, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (27, 1526, 'Substitute Teachers', 6320.83, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (28, 1527, 'Marketing and Communication', 9313.55, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (29, 1528, 'Insurance', 6821.11, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (205, 1704, 'Curriculum Materials and Resources', 1889.75, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (31, 1530, 'Field Trips', 8486.23, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (32, 1531, 'Salaries and Benefits', 6020.02, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (33, 1532, 'Salaries and Benefits', 2972.75, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (484, 1983, 'Health Services', 9048.07, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (156, 1655, 'Counseling and Guidance', 4339.91, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (59, 1558, 'Curriculum Materials and Resources', 1730.42, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (37, 1536, 'Administrative Costs', 9754.47, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (38, 1537, 'Professional Development for Teachers', 9518.43, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (194, 1693, 'Administrative Costs', 1985.86, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (334, 1833, 'Student Activities', 1033.01, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (93, 1592, 'Special Education', 5113.79, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (427, 1926, 'Temporary Staff', 2839.95, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (44, 1543, 'Professional Development for Teachers', 9397.66, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (45, 1544, 'Technology Infrastructure', 5927.18, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (46, 1545, 'Technology Infrastructure', 2672.67, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (47, 1546, 'Capital Expenditures', 3028.85, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (313, 1812, 'Guest Speakers', 9741.67, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (49, 1548, 'Technology Infrastructure', 4971.8, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (213, 1712, 'Special Education', 7883.21, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (51, 1550, 'Insurance', 2510.09, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (52, 1551, 'Special Education', 3895.04, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (461, 1960, 'Marketing and Communication', 7978.18, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (54, 1553, 'Employee Recruitment and Retention', 1818.59, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (100, 1599, 'Technology Infrastructure', 6519.79, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (56, 1555, 'PC Services', 2480.5, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (57, 1556, 'Curriculum Materials and Resources', 8524.65, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (58, 1557, 'Food Services', 3042.45, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (475, 1974, 'Transportation', 6375.79, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (61, 1560, 'Library Resources', 2903.69, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (62, 1561, 'Educational Technology', 2093.88, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (63, 1562, 'Maintenance and Repair', 4877.36, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (64, 1563, 'Special Education', 4973.03, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (486, 1985, 'Administrative Costs', 5727.84, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (490, 1989, 'Rent or Lease Payments', 9501.33, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (374, 1873, 'Legal Fees', 4004.8, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (236, 1735, 'Insurance', 2602.49, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (69, 1568, 'Utilities', 5898, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (266, 1765, 'Travel', 6853.02, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (349, 1848, 'After-School Programs', 8730.09, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (72, 1571, 'Arts and Humanities', 5945.69, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (319, 1818, 'Insurance', 1117.1, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (74, 1573, 'Educational Technology', 3840.88, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (75, 1574, 'Temporary Staff', 6627.88, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (76, 1575, 'Academic Competitions', 2109.03, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (339, 1838, 'Substitute Teachers', 8317.57, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (78, 1577, 'Food Services', 5472.51, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (79, 1578, 'Maintenance and Repair', 4126.41, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (80, 1579, 'Salaries and Benefits', 4410.3, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (81, 1580, 'Administrative Costs', 7051.22, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (82, 1581, 'Health Services', 4771.26, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (83, 1582, 'Professional Development', 5654.44, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (84, 1583, 'Legal Fees', 4305.98, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (86, 1585, 'Technology Infrastructure', 2015.95, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (350, 1849, 'Guest Speakers', 5972.91, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (88, 1587, 'Technology Infrastructure', 6875.44, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (89, 1588, 'Professional Audits', 4901.18, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (278, 1777, 'Academic Competitions', 8700.15, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (413, 1912, 'Temporary Staff', 7161.34, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (92, 1591, 'Utilities', 6105.85, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (94, 1593, 'Travel', 4917.05, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (95, 1594, 'Technology Infrastructure', 9253.55, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (96, 1595, 'Substitute Teachers', 2926.83, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (97, 1596, 'Professional Audits', 6082.26, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (354, 1853, 'Curriculum Materials and Resources', 3407.82, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (99, 1598, 'Temporary Staff', 6110.95, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (382, 1881, 'Technology Support', 9115.42, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (102, 1601, 'After-School Programs', 7686.75, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (104, 1603, 'Professional Audits', 9189.3, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (408, 1907, 'Textbooks and Instructional Software', 1842.61, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (107, 1606, 'Professional Development for Teachers', 1831.83, 2011);
commit;
prompt 100 records committed...
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (108, 1607, 'Utilities', 2599.61, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (109, 1608, 'Library Resources', 5396.95, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (123, 1622, 'Printing and Copying', 6676.45, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (111, 1610, 'Legal Fees', 5299.22, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (112, 1611, 'Health Services', 9091.5, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (411, 1910, 'Security', 6840.98, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (115, 1614, 'Classroom Supplies', 9644.78, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (116, 1615, 'Language Programs', 9293.88, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (375, 1874, 'Extracurricular Activities', 7139.97, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (118, 1617, 'Special Education', 8511.58, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (119, 1618, 'Textbooks and Instructional Software', 1706.55, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (120, 1619, 'Student Activities', 7091.97, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (121, 1620, 'Library Resources', 3941.01, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (122, 1621, 'Textbooks and Instructional Software', 4901.56, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (124, 1623, 'Technology Support', 9681.95, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (125, 1624, 'Insurance', 6716.24, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (126, 1625, 'Insurance', 3441.35, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (127, 1626, 'Temporary Staff', 3892.75, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (128, 1627, 'Printing and Copying', 2725.05, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (360, 1859, 'Library Resources', 6511.29, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (130, 1629, 'Health Services', 9653.35, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (131, 1630, 'Field Trips', 1985.87, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (132, 1631, 'Printing and Copying', 1662.35, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (134, 1633, 'Printing and Copying', 9700.82, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (135, 1634, 'Professional Audits', 6738.09, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (136, 1635, 'Administrative Costs', 5523.82, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (137, 1636, 'Salaries and Benefits', 4670.45, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (138, 1637, 'Professional Audits', 8545.41, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (139, 1638, 'Professional Development', 5254.25, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (140, 1639, 'Field Trips', 9180.95, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (145, 1644, 'Athletics', 3270.52, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (142, 1641, 'Legal Fees', 7055.8, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (143, 1642, 'Insurance', 6418.83, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (144, 1643, 'After-School Programs', 3053.97, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (146, 1645, 'Insurance', 6952.96, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (147, 1646, 'Substitute Teachers', 6720.01, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (148, 1647, 'Professional Development', 9193.86, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (149, 1648, 'Guest Speakers', 8492.52, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (351, 1850, 'Curriculum Materials and Resources', 8170.52, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (151, 1650, 'Travel', 4187.69, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (238, 1737, 'Language Programs', 1747.15, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (153, 1652, 'Academic Competitions', 9442.5, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (154, 1653, 'Debt Service (loans)', 7893.66, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (155, 1654, 'Insurance', 3448.81, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (157, 1656, 'Debt Service (loans)', 3907.14, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (158, 1657, 'Rent or Lease Payments', 8057.85, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (159, 1658, 'Transportation', 9670.72, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (457, 1956, 'Extracurricular Activities', 6273.19, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (161, 1660, 'Temporary Staff', 7856.76, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (162, 1661, 'Maintenance and Repair', 1074.98, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (237, 1736, 'Legal Fees', 4845.56, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (164, 1663, 'Arts and Humanities', 2948.08, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (165, 1664, 'Extracurricular Activities', 5087.18, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (166, 1665, 'Legal Fees', 2202.8, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (167, 1666, 'Field Trips', 6072.76, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (169, 1668, 'Academic Competitions', 5949.4, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (170, 1669, 'Extracurricular Activities', 6542.64, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (171, 1670, 'Health Services', 8536.82, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (363, 1862, 'Administrative Costs', 7751.15, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (173, 1672, 'After-School Programs', 5365.12, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (174, 1673, 'Temporary Staff', 9027.76, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (426, 1925, 'PC Services', 8835.22, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (176, 1675, 'Utilities', 6220.89, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (177, 1676, 'Language Programs', 9633.61, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (178, 1677, 'Textbooks and Instructional Software', 8623.6, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (453, 1952, 'Textbooks and Instructional Software', 5296.26, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (180, 1679, 'Legal Fees', 3410.17, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (182, 1681, 'After-School Programs', 1152.77, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (183, 1682, 'Guest Speakers', 2665.18, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (264, 1763, 'After-School Programs', 8930.83, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (242, 1741, 'Special Education', 7584.05, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (186, 1685, 'Professional Audits', 8847.11, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (187, 1686, 'Professional Development for Teachers', 7161.55, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (373, 1872, 'Educational Technology', 1283.85, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (189, 1688, 'Field Trips', 4730.15, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (190, 1689, 'Athletics', 7021.3, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (191, 1690, 'Language Programs', 5112.22, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (192, 1691, 'Counseling and Guidance', 9499.99, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (193, 1692, 'Special Education', 9815.47, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (195, 1694, 'Academic Competitions', 2451.54, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (291, 1790, 'Transportation', 4553.04, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (212, 1711, 'Counseling and Guidance', 4479.1, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (198, 1697, 'Academic Competitions', 7965.56, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (199, 1698, 'Administrative Costs', 6422.27, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (200, 1699, 'Library Resources', 5545.08, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (221, 1720, 'Rent or Lease Payments', 6633.15, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (430, 1929, 'Maintenance and Repair', 8046.29, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (206, 1705, 'Professional Audits', 4577.73, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (207, 1706, 'Salaries and Benefits', 3778.7, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (208, 1707, 'Security', 1111.45, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (209, 1708, 'Professional Development for Teachers', 6067.61, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (352, 1851, 'Employee Recruitment and Retention', 4978.53, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (214, 1713, 'Food Services', 3159.07, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (215, 1714, 'Academic Competitions', 2514.4, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (217, 1716, 'Extracurricular Activities', 1324.62, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (218, 1717, 'Counseling and Guidance', 2601.6, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (219, 1718, 'Transportation', 3106.03, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (220, 1719, 'Technology Support', 2536.98, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (222, 1721, 'Professional Audits', 4197.34, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (223, 1722, 'Health Services', 5771.75, 2020);
commit;
prompt 200 records committed...
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (271, 1770, 'After-School Programs', 1690.19, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (225, 1724, 'Student Activities', 4340.68, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (403, 1902, 'Special Education', 6051.77, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (227, 1726, 'Arts and Humanities', 3224.28, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (229, 1728, 'Health Services', 6481.26, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (230, 1729, 'PC Services', 1605.2, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (231, 1730, 'Language Programs', 8045.21, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (232, 1731, 'Technology Support', 3703.97, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (233, 1732, 'Curriculum Materials and Resources', 6012.56, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (234, 1733, 'Salaries and Benefits', 5702, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (235, 1734, 'Legal Fees', 7677.28, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (239, 1738, 'Technology Support', 8202.24, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (240, 1739, 'Student Activities', 2972.18, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (241, 1740, 'Salaries and Benefits', 6508.62, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (245, 1744, 'Marketing and Communication', 4979.84, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (246, 1745, 'Temporary Staff', 4152.67, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (248, 1747, 'Academic Competitions', 6530.96, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (344, 1843, 'Debt Service (loans)', 9139.91, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (250, 1749, 'Library Resources', 5070.09, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (251, 1750, 'Special Education', 3346.98, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (252, 1751, 'Marketing and Communication', 5070.33, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (253, 1752, 'Counseling and Guidance', 4040.74, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (254, 1753, 'Special Education', 3694.84, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (256, 1755, 'Food Services', 4486.5, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (257, 1756, 'Printing and Copying', 8491.53, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (258, 1757, 'Classroom Supplies', 7626.01, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (259, 1758, 'Textbooks and Instructional Software', 6798.33, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (260, 1759, 'Substitute Teachers', 1648.96, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (261, 1760, 'Maintenance and Repair', 2859.19, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (409, 1908, 'Curriculum Materials and Resources', 5914.55, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (268, 1767, 'Food Services', 8951.95, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (269, 1768, 'Health Services', 6199.28, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (270, 1769, 'Food Services', 3074.54, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (272, 1771, 'Employee Recruitment and Retention', 2695.93, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (273, 1772, 'Professional Audits', 4379.91, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (274, 1773, 'Classroom Supplies', 9257.25, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (332, 1831, 'Transportation', 9188.53, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (279, 1778, 'Textbooks and Instructional Software', 3852.49, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (280, 1779, 'Professional Development', 8272.9, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (281, 1780, 'Substitute Teachers', 5084.87, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (460, 1959, 'Professional Audits', 4246.96, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (283, 1782, 'Health Services', 1480.2, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (285, 1784, 'Athletics', 2911.71, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (287, 1786, 'Professional Development', 7546.45, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (289, 1788, 'Technology Support', 2724.8, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (485, 1984, 'Arts and Humanities', 6961.27, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (292, 1791, 'Educational Technology', 2195.71, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (293, 1792, 'Library Resources', 8328.64, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (294, 1793, 'Professional Development for Teachers', 9948.4, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (295, 1794, 'PC Services', 1731.77, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (296, 1795, 'Field Trips', 8716.17, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (297, 1796, 'Language Programs', 7173.64, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (299, 1798, 'Extracurricular Activities', 8533.48, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (300, 1799, 'Professional Development for Teachers', 2166.18, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (301, 1800, 'Technology Infrastructure', 9745.98, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (302, 1801, 'After-School Programs', 3742.02, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (338, 1837, 'Marketing and Communication', 7538.83, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (305, 1804, 'Curriculum Materials and Resources', 4266.63, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (306, 1805, 'Counseling and Guidance', 5929.57, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (307, 1806, 'Field Trips', 3029.12, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (310, 1809, 'Food Services', 7697.68, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (311, 1810, 'Security', 5353.65, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (312, 1811, 'Temporary Staff', 9906.04, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (348, 1847, 'Legal Fees', 7705.11, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (315, 1814, 'After-School Programs', 7052.65, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (316, 1815, 'Security', 5206.4, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (317, 1816, 'Library Resources', 7927.19, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (488, 1987, 'Marketing and Communication', 4470.21, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (320, 1819, 'Travel', 7310.63, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (321, 1820, 'Language Programs', 4608.9, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (322, 1821, 'PC Services', 8662.9, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (495, 1994, 'Technology Support', 8667.29, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (325, 1824, 'Field Trips', 1127.17, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (327, 1826, 'Language Programs', 8815.82, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (328, 1827, 'Temporary Staff', 1995.65, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (329, 1828, 'Security', 9389.48, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (331, 1830, 'Arts and Humanities', 8033.21, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (333, 1832, 'Security', 6634.88, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (335, 1834, 'Printing and Copying', 3531.66, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (455, 1954, 'Guest Speakers', 3735.14, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (337, 1836, 'Printing and Copying', 1842.2, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (340, 1839, 'Salaries and Benefits', 1432.28, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (341, 1840, 'Field Trips', 4865.36, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (342, 1841, 'PC Services', 5327.66, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (345, 1844, 'Insurance', 2139.05, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (347, 1846, 'Classroom Supplies', 8313.02, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (353, 1852, 'Debt Service (loans)', 4899.3, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (355, 1854, 'Legal Fees', 3753.59, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (356, 1855, 'Extracurricular Activities', 5253.96, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (357, 1856, 'Administrative Costs', 9574.1, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (358, 1857, 'Classroom Supplies', 7440.18, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (359, 1858, 'PC Services', 9815.73, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (361, 1860, 'Debt Service (loans)', 2842.34, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (362, 1861, 'Academic Competitions', 7970.77, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (365, 1864, 'PC Services', 4428.85, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (366, 1865, 'Professional Development', 9604.55, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (367, 1866, 'Extracurricular Activities', 3512.31, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (368, 1867, 'Curriculum Materials and Resources', 2029.12, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (369, 1868, 'Insurance', 4689.92, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (370, 1869, 'Security', 7619.11, 2015);
commit;
prompt 300 records committed...
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (418, 1917, 'Transportation', 1690.6, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (372, 1871, 'Transportation', 1489.51, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (376, 1875, 'Salaries and Benefits', 2171.69, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (396, 1895, 'Debt Service (loans)', 3873.31, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (378, 1877, 'Technology Infrastructure', 1913.81, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (379, 1878, 'Professional Audits', 8440.81, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (412, 1911, 'Travel', 6205.38, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (381, 1880, 'Administrative Costs', 8647.92, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (383, 1882, 'Marketing and Communication', 5203.74, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (481, 1980, 'Athletics', 3419.39, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (386, 1885, 'Employee Recruitment and Retention', 7636.56, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (387, 1886, 'Debt Service (loans)', 9085.02, 2024);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (388, 1887, 'Transportation', 3790.1, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (390, 1889, 'Athletics', 6353.71, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (391, 1890, 'Student Activities', 7725.83, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (480, 1979, 'Rent or Lease Payments', 2941.09, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (393, 1892, 'Professional Development', 6823.1, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (394, 1893, 'Marketing and Communication', 8381.17, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (395, 1894, 'Arts and Humanities', 5330.82, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (397, 1896, 'Transportation', 7141.89, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (417, 1916, 'Educational Technology', 3748, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (399, 1898, 'PC Services', 6980.85, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (400, 1899, 'Classroom Supplies', 7791.14, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (456, 1955, 'After-School Programs', 9144.4, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (402, 1901, 'Security', 7453.65, 2019);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (404, 1903, 'Field Trips', 2068.41, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (405, 1904, 'Maintenance and Repair', 3821.52, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (406, 1905, 'Transportation', 8898.15, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (407, 1906, 'Educational Technology', 4003.87, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (410, 1909, 'Guest Speakers', 9390.47, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (414, 1913, 'Library Resources', 5724.92, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (415, 1914, 'Travel', 6331.49, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (416, 1915, 'Extracurricular Activities', 8680.95, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (419, 1918, 'Salaries and Benefits', 9710.53, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (420, 1919, 'Guest Speakers', 4108.1, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (421, 1920, 'PC Services', 3098.23, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (422, 1921, 'Travel', 4569.22, 2025);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (423, 1922, 'Food Services', 2949.71, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (424, 1923, 'Technology Support', 1911, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (425, 1924, 'Health Services', 1762.13, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (428, 1927, 'Food Services', 2344.19, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (429, 1928, 'Substitute Teachers', 8577.39, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (432, 1931, 'Field Trips', 3774.38, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (433, 1932, 'PC Services', 1154.96, 2016);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (434, 1933, 'Maintenance and Repair', 7615.32, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (435, 1934, 'After-School Programs', 2709.01, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (437, 1936, 'Classroom Supplies', 8212.45, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (438, 1937, 'Maintenance and Repair', 9687.9, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (439, 1938, 'Special Education', 3540.79, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (440, 1939, 'Extracurricular Activities', 6359.9, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (441, 1940, 'Athletics', 2656.75, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (442, 1941, 'Library Resources', 6109.29, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (443, 1942, 'Textbooks and Instructional Software', 9364.11, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (445, 1944, 'Library Resources', 3372.8, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (446, 1945, 'Printing and Copying', 6237.24, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (447, 1946, 'Professional Development', 7730.91, 2008);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (448, 1947, 'Counseling and Guidance', 1561.09, 2003);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (450, 1949, 'Employee Recruitment and Retention', 9700.39, 2021);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (451, 1950, 'Professional Development for Teachers', 6136.39, 2023);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (452, 1951, 'Technology Infrastructure', 6355.38, 2000);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (454, 1953, 'Classroom Supplies', 9645.32, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (458, 1957, 'Textbooks and Instructional Software', 4024.77, 2007);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (459, 1958, 'Marketing and Communication', 7186.28, 2001);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (462, 1961, 'Counseling and Guidance', 2519.7, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (463, 1962, 'Travel', 5432.72, 2017);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (466, 1965, 'After-School Programs', 7388.45, 2004);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (467, 1966, 'Debt Service (loans)', 9172.45, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (468, 1967, 'Administrative Costs', 9817.62, 2010);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (469, 1968, 'Technology Support', 2211.02, 2020);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (470, 1969, 'Athletics', 9719.67, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (471, 1970, 'Technology Support', 4633.37, 2015);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (472, 1971, 'Field Trips', 4348, 2018);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (473, 1972, 'Special Education', 4587.3, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (474, 1973, 'Temporary Staff', 2740.41, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (476, 1975, 'After-School Programs', 1669.6, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (477, 1976, 'Language Programs', 3940.43, 2014);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (478, 1977, 'Travel', 4263.63, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (479, 1978, 'Academic Competitions', 5901.46, 2009);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (483, 1982, 'Substitute Teachers', 1895.07, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (487, 1986, 'Extracurricular Activities', 3588.86, 2002);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (489, 1988, 'Substitute Teachers', 5288.15, 2022);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (491, 1990, 'Food Services', 4311.26, 2012);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (493, 1992, 'Marketing and Communication', 9029.93, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (496, 1995, 'Arts and Humanities', 9559.34, 2006);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (497, 1996, 'Printing and Copying', 5464.72, 2011);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (498, 1997, 'Marketing and Communication', 9190.05, 2013);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (499, 1998, 'Arts and Humanities', 7085.52, 2005);
insert into BUDGET (budget_code, employee_id, expense_category, budget_amount, budget_year)
values (500, 1999, 'Substitute Teachers', 6383.17, 2000);
commit;
prompt 388 records loaded
prompt Loading SUPPLIER...
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3000, 'Brainwave Basics Boutique', 'harris.scheider@stonebrewing.is', -49.53);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3001, 'Brainwave Basics Boutique', 'harris.mccann@medsource.it', 89.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3002, 'School Savvy Storefront', 'jackson.ruiz@marlabs.de', -29.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3003, 'School Savvy Solutions', 'kurtwoodm@providentbancorp.br', 63.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3004, 'Brainy Basics Boutique', 'anita.zappacosta@palmbeachtan.de', 46.45);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3005, 'School Savvy Solutions', 'jwoodard@cocacola.mx', 1.15);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3006, 'Genius Gear Emporium', 'benjamin.b@smartronix.nl', 28.17);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3007, 'Brainy Basics Bazaar', 'k.myers@ceb.com', 25.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3008, 'Notebook Nook', 'jim.fierstein@timberlanewoodcrafters.uk', -77.88);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3009, 'EduEssentials Storefront', 'lucinda.wong@prosperitybancshares.jp', -1.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3010, 'Scholarly Solutions Storefront', 'john.f@technica.com', 13.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3011, 'Brainy Basics Emporium', 'johnette.holmes@zoneperfectnutrition.au', 4.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3012, 'Genius Gear Galore', 'lee.tomei@albertsons.de', 63.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3013, 'Scholarly Supplies Shack', 'tom.oszajca@questarcapital.br', 5.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3014, 'Scholarly Solutions Stop', 'sheryl.schiavelli@scooterstore.at', -100.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3015, 'Brainwave Basics Boutique', 'rita.baldwin@infinity.com', 81.48);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3016, 'IntelliTools Emporium', 'brenda@clorox.pt', 17.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3017, 'Brainy Basics Bazaar', 'a.johnson@totalentertainment.de', 57.75);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3018, 'Scholastic Solutions Storefron', 'jessica.benet@printingforlesscom.com', -99.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3019, 'Brainwave Basics Boutique', 'beth.p@bowman.br', 41.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3020, 'EduEssentials Emporium', 'mintk@datawarehouse.com', -135.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3021, 'Brainwave Basics Boutique', 'jarvis.theron@team.pl', 7.33);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3022, 'Educated Catalog', 'ellen.shaye@dynacqinternational.uk', 13.99);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3023, 'Genius Gear Emporium', 'pete.w@career.com', 5.57);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3024, 'Brain Boost Emporium', 'nickel.liu@gsat.com', 61.34);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3025, 'IntelliSupplies Station', 'sonny.s@curagroup.de', 16.38);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3026, 'Genius Gear Emporium', 'gavin.twilley@outsourcegroup.br', 1.71);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3027, 'School Supply Hub', 'p.crosby@americanhealthways.com', 37.15);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3028, 'Genius Gear Emporium', 'radneyr@glmt.com', -12.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3029, 'Brain Boost Emporium', 'htillis@3tsystems.de', -139.24);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3030, 'MentalMath Supplies', 'chad.englund@smg.de', 8.73);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3031, 'Smart Study Solutions', 'dan.tyler@epamsystems.de', 64.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3032, 'IntelliTools Emporium', 'brothers.c@adeasolutions.com', 11.15);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3033, 'School Savvy Solutions', 'sheena.vannelli@epiqsystems.com', -.17);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3034, 'Study Smart Spot', 'v.cleese@manhattanassociates.ca', 32.33);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3035, 'Scholastic Solutions Storefron', 'daryle.b@advancedneuromodulation.com', -45.25);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3036, 'Genius Gear Emporium', 'franz.sylvian@gsat.ht', 74.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3037, 'School Success Supply Co.', 'mel.ponty@computersource.com', 31.78);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3038, 'Intellect Depot', 'wayman.hingle@ptg.ch', -14.31);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3039, 'Genius Junction', 'm.vaughan@diageo.za', -81.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3040, 'Study Smart Stop', 'nilem@millersystems.no', 52.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3041, 'Brainy Bookstore', 'rod.mattea@captechventures.ch', 49.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3042, 'Smart Study Solutions', 'sonab@connected.com', 41.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3043, 'Scholarly Supply Station', 'benjamin.larter@execuscribe.com', -40.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3044, 'Smart Study Solutions', 'i.portman@kramontrealty.at', 82.04);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3045, 'Scholastic Solutions Station', 'france.stowe@cooktek.br', 34.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3046, 'Genius Goods Galore', 'minnie.sylvian@mse.fr', 92.86);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3047, 'Wisdom Works Warehouse', 'catherine.burrows@qssgroup.com', -38.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3048, 'Brainwave Basics', 'lloyd.s@meridiangold.com', 46.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3049, 'Study Smart Solutions', 'ahmadc@paisley.uk', 5.43);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3050, 'IntelliSupplies Shack', 'jann.burmester@noodles.com', 4.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3051, 'Brainy Basics Bazaar', 'curtiss@uem.com', 22.42);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3052, 'EduEssentials Emporium', 'nastassja.rawls@vesta.ch', -49.46);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3053, 'IntelliTools Shack', 'jeanne.sample@medsource.de', 52.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3054, 'Genius Goods Galore', 'will@ghrsystems.com', -38.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3055, 'Genius Gear Galore', 'b.magnuson@montpelierplastics.ca', 42.16);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3056, 'Scholastic Solutions Storefron', 'willem.dukakis@usphysicaltherapy.uk', 5.88);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3057, 'Genius Goods Emporium', 'larry.r@gra.com', 75.01);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3058, 'Smart Study Solutions', 's.paxton@scjohnson.tw', 57.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3059, 'Brainwave Basics Boutique', 'pam.c@infopros.com', 86.89);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3060, 'Academic Advantage Co.', 'isaiah.cromwell@electricalsolutions.it', 10.81);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3061, 'The Learning Store', 'carole.black@mindiq.com', -82.55);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3062, 'Brainwave Bazaar', 'milla.secada@servicesource.com', -62.94);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3063, 'Scholarly Supplies Stop', 'taryn.dunaway@yumbrands.ch', 22.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3064, 'Brain Boost Emporium', 'rhett.rebhorn@heritagemicrofilm.de', 44.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3065, 'EduEssentials Storefront', 'arnold@volkswagen.com', 83.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3066, 'Brain Boost Boutique', 'ivonsydow@commworks.com', 22.12);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3067, 'Scholarly Supply Station', 'gerald@exinomtechnologies.se', -12.11);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3068, 'IntelliTools Emporium', 'kevn.s@axis.com', 86.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3069, 'Study Smart Stop', 'mia.t@mosaic.at', -17.72);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3070, 'Genius Goods Galore', 'davy.garr@bigdoughcom.fr', -.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3071, 'Brainy Basics Emporium', 'juniora@comglobalsystems.de', -119.05);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3072, 'Brain Boost Bazaar', 'arnold.borgnine@nsd.com', -15.69);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3073, 'Scholarly Solutions Storefront', 'greiner@questarcapital.ca', -7.63);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3074, 'Brainy Basics Emporium', 'ann.pepper@connected.se', 27.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3075, 'Scholastic Solutions Storefron', 'lou.n@hiltonhotels.br', -36.66);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3076, 'Study Savvy Station', 'roscoe.ribisi@fmt.ca', 90.25);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3077, 'Study Smart Shack', 'freddie.hurley@coldstonecreamery.de', 54.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3078, 'Brain Boost Boutique', 'kay.marx@yumbrands.br', 76.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3079, 'Scholarly Supply Station', 'dom.d@boldtechsystems.au', -57.55);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3080, 'Genius Goods Galore', 'collective.hutton@invisioncom.de', -161.12);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3081, 'EduEssentials Storefront', 'l.sheen@hondamotor.com', 56.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3082, 'A+ School Solutions', 'haroldg@connected.jp', 86.66);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3083, 'Scholastic Solutions Station', 'm.kapanka@balchem.it', 65.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3084, 'Enlightened Essentials', 'm.diggs@sfb.com', 56.1);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3085, 'Brainy Basics Bazaar', 'alice@bluffcitysteel.cl', 24.98);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3086, 'Scholastic Solutions Station', 'patti.guilfoyle@computersource.es', 49.3);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3087, 'IntelliSupplies Emporium', 'dennis.laurie@profitline.com', 63.02);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3088, 'EduEssentials Storefront', 'rtennison@shot.com', 63.45);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3089, 'Brainy Basics Bazaar', 'andrea.underwood@qestrel.com', -17.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3090, 'Scholastic Warehouse', 'janeane.weller@fam.in', -64.35);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3091, 'Smart Study Stop', 'colin.c@tropicaloasis.ch', -3.11);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3092, 'Study Smart Stop', 'jeanlucg@universalsolutions.br', 93.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3093, 'Scholastic Solutions Station', 'jamie.c@linersdirect.com', 3.31);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3094, 'IntelliTools Inc.', 'oded.winslet@mre.com', 67.96);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3095, 'Brainy Basics Bazaar', 'n.oakenfold@fra.cl', -15.05);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3096, 'Brainpower Basics', 'rarnold@integramedamerica.tw', 24.69);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3097, 'Educational Essentials Co.', 'collin@vspan.uk', 66.77);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3098, 'Brainy Basics Boutique', 'bo44@visionarysystems.uk', 89.45);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3099, 'Essential & Brilliant', 'rodney.moreno@electricalsolutions.uk', 91.61);
commit;
prompt 100 records committed...
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3100, 'Brainy Bookstore', 'kevn.kinnear@gdi.com', 8.2);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3101, 'Scholastic Solutions Storefron', 'albertina.malone@cocacola.com', 16.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3102, 'Smart Study Solutions', 'o.dutton@doraldentalusa.ge', 49.42);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3103, 'Genius Goods Boutique', 'rhys.bening@actechnologies.com', 42.75);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3104, 'Brain Boost Bazaar', 'johnny.renfro@accurateautobody.com', 23.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3105, 'Brainy Bookstore', 'clarence@pinnaclestaffing.de', -21.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3106, 'Genius Gear Emporium', 'cloris.gibson@colgatepalmolive.com', 39.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3107, 'Genius Goods Boutique', 'taryn.feliciano@innovativelighting.com', -44.61);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3108, 'Brainwave Basics Boutique', 'omclachlan@mai.uk', 71.43);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3109, 'Genius Gear Galore', 'r.vincent@sony.com', 17.03);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3110, 'Educational Emporium', 'r.cage@lynksystems.dk', 50.22);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3111, 'Brain Boost Emporium', 'jesse.stills@insurmark.ch', -.66);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3112, 'EduEssentials Emporium', 'busta@proclarity.com', -38);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3113, 'School Savvy Solutions', 'gilberto.beals@bat.com', 60.2);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3114, 'Genius Goods Boutique', 'csossamon@marketfirst.com', 5.44);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3115, 'Study Tools Galore', 'michelle.s@tilia.ca', 27.6);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3116, 'Clever Equipped', 'mika.foster@idas.uk', -12.05);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3117, 'MentalMath Supplies', 'nancym@esteelauder.com', 15.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3118, 'Smart Scholars Supply Store', 'clive.goodman@harrison.za', -26.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3119, 'Study Smart Station', 'wayne.colman@royalgold.com', -6.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3120, 'IntelliGear Emporium', 'm.owen@hatworld.br', 54.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3121, 'Brain Boost Emporium', 'nrankin@supplycorecom.it', -31.79);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3122, 'Brain Boost Bazaar', 'hikaru.skerritt@spenser.ch', 10.64);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3123, 'Brainy Basics Boutique', 'j.quinones@usphysicaltherapy.com', 30.56);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3124, 'Smart Study Spot', 'christina.mcanally@atg.pt', -3.41);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3125, 'IntelliSupplies Station', 'mel@allstar.se', 92.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3126, 'Genius Gear Emporium', 'nik.hannah@wyeth.com', 75.9);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3127, 'EduEssentials Storefront', 'humberto.vanshelton@carteretmortgage.ch', 91.35);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3128, 'IntelliSupplies Emporium', 'c.bentley@diversitech.uk', -13.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3129, 'Scholarly Supplies Shack', 'delroy.i@trafficmanagement.uk', 41.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3130, 'Brain Boost Bazaar', 'aengland@monarchcasino.ch', -36.24);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3131, 'EduEssentials Emporium', 'arturo@tripwire.de', 8.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3132, 'Scholastic Solutions Storefron', 'saul@its.uk', 29.81);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3133, 'Scholarly Supply Stop', 'steven.schneider@stonebrewing.de', -65.76);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3134, 'Brainwave Basics Boutique', 'toddn@qssgroup.br', -33.26);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3135, 'Study Smart Spot', 'illeana.lillard@cynergydata.jp', 24.49);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3136, 'Smart Study Solutions', 'charlize.jay@gcd.com', 1.81);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3137, 'IntelliTools Storefront', 'mdealmeida@stm.il', -40.77);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3138, 'Smart Scholars Supply Store', 'terence@base.com', 41.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3139, 'Scholarly Supply Station', 'moe.linney@vms.it', -39.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3140, 'EduEssentials Emporium', 'jcreek@colgatepalmolive.ie', 91.75);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3141, 'IntelliSupplies Station', 'markin@ciwservices.it', -73.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3142, 'Scholastic Solutions Station', 'joshua@qssgroup.com', 2.14);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3143, 'IntelliTools Emporium', 'derek@gulfmarkoffshore.com', 30.66);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3144, 'Smart Study Stop', 'mpleasure@newtoninteractive.au', -84.08);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3145, 'Essential School Store', 'd.landau@prahs.com', -37.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3146, 'Scholastic Solutions Emporium', 'katie.cromwell@ccb.com', 16.8);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3147, 'Genius Goods Boutique', 'ned.midler@mathis.br', 17.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3148, 'Study Smart Spot', 'george.gallagher@gcd.fr', 23.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3149, 'Scholarly Solutions Storefront', 'helen.warwick@dis.com', 10.44);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3150, 'Study Savvy Stop', 'qwoods@fordmotor.de', 10.96);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3151, 'IntelliTools Storefront', 'carrie@wellsfinancial.dk', 14.68);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3152, 'Genius Gear Galore', 'goran.b@qssgroup.uk', 93.9);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3153, '''Pens & Pencils', 'keithm@tmaresources.com', 17.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3154, 'Back to School Warehouse', 'freddiec@digitalmotorworks.jp', -36.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3155, 'Brainwave Basics Boutique', 'annm@nbs.uk', 7.18);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3156, 'Genius Goods Galore', 'sheena.g@isd.es', -47.98);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3157, 'Genius Goods Galore', 'sona.harper@capital.de', -37.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3158, 'EduEssentials Emporium', 'gordieb@harrison.de', 3.58);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3159, 'Smart Study Solutions', 'vguzman@gentrasystems.com', 11.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3160, 'Classroom Couture', 'armin.geldof@nsd.se', -100.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3161, 'Office & School Supplies Co.', 'rob.urban@merck.ar', 43.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3162, 'Genius Gear Galore', 'hcohn@allegiantbancorp.com', -28.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3163, 'Study Smart Station', 'javon.lightfoot@nike.ch', -53.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3164, 'IntelliSupplies Emporium', 'oliver.hubbard@ssci.it', -30.52);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3165, 'Brain Boost Emporium', 'olga.s@bat.it', 3.54);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3166, 'Brainwave Bodega', 'edgar.brandt@mercantilebank.at', 53.99);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3167, 'IntelliGear Emporium', 'natalie.mason@topicsentertainment.com', 20.71);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3168, 'Smart Study Supplies', 'fisher.eastwood@smg.se', 69.84);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3169, 'IntelliSupplies Store', 'elle@gha.com', -10.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3170, 'School Savvy Solutions', 'dwight.sweeney@generalmotors.fr', -13.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3171, 'Scholarly Solutions Storefront', 'firstb@saralee.ca', 59.78);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3172, 'Brainy Basics Boutique', 'teri.pastore@jlphor.uk', -33.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3173, 'Brain Boost Bazaar', 'mickeye@pharmafab.ca', 60.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3174, 'EduEssentials Emporium', 'bcagle@quakercitybancorp.com', 86.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3175, 'School Supply Hub', 'kurtwood.hoffman@consultants.com', -122.94);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3176, 'Study Smart Solutions', 'dar.f@ibm.com', -139.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3177, 'Brainwave Basics Boutique', 'neve@shot.com', 42.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3178, 'Brainwave Bazaar', 'cfehr@providenceservice.jp', 95.47);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3179, 'Study Smart Spot', 'fats.pantoliano@topicsentertainment.com', -45.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3180, 'Scholarly Supply Shack', 'busta.m@ositissoftware.com', 17.94);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3181, 'EduEssentials Emporium', 'salma.posey@mse.fi', -8.56);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3182, 'Genius Gear Emporium', 'miko.hirsch@newmedia.com', 35.24);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3183, 'Study Smart Stop', 'heather.gambon@carteretmortgage.fr', -124.88);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3184, 'Study Smart Solutions', 'stephanie.d@target.my', -72.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3185, 'The Birds of Minerva', 'nick.douglas@usainstruments.com', -22.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3186, 'Bookbag Parade', 'olympia.humphrey@safeway.uk', 16.08);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3187, 'IntelliTools Co.', 'timothy.vega@maverick.com', 23.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3188, 'Brainwave Basics Boutique', 'lhayek@gapinc.ch', 5.12);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3189, 'Genius Goods Emporium', 'liquid.wahlberg@totalentertainment.com', 76.18);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3190, 'EduEssentials Emporium', 'ronnie.olyphant@americanland.com', -30.5);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3191, 'Brainwave Basics Boutique', 'kim@generalelectric.com', 4.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3192, 'Brainwave Bazaar', 'cmould@benecongroup.uk', 25.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3193, 'School Savvy Storehouse', 'liv.stanton@dancor.uk', 87.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3194, 'Scholarly Supplies Shack', 'jmiles@berkshirehathaway.com', -.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3195, 'Study Smart Solutions', 'angie@isd.gr', 6.19);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3196, 'Scholarly Supply Storefront', 'mingna.shatner@efcbancorp.fr', -118.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3197, 'Brainy Basics Emporium', 'g.purefoy@bristolmyers.com', 10.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3198, 'Learning Depot', 'morgan.coburn@cooktek.nl', 41.63);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3199, 'Genius Gear Emporium', 'lisa.kier@palmbeachtan.com', 44.27);
commit;
prompt 200 records committed...
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3200, 'Genius Goods Station', 'emm.maxwell@linksys.br', 91.65);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3201, 'Smart Study Solutions', 'rauls@dbprofessionals.com', 5.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3202, 'Brainwave Basics Boutique', 'roba@formatech.com', 91.01);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3203, 'IntelliSupplies Emporium', 'adam.boothe@capitalautomotive.com', 41.24);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3204, 'Scholarly Supply Storefront', 'gwyneth.r@limitedbrands.com', 11.84);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3205, 'Artistic Academy', 'matth@accessus.at', -66.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3206, 'Wisdom Works Warehouse', 'rik.arnold@esoftsolutions.es', -3.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3207, 'Scholastic Solutions Station', 'terence.fisher@mitsubishimotors.ch', -60.8);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3208, 'Genius Goods Boutique', 'candice@sds.com', 23.33);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3209, 'Genius Goods Station', 'sheena.conley@drinkmorewater.ca', 97.16);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3210, 'School Success Supply Co.', 'phoebe.i@mwh.ch', 37.66);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3211, 'EduEssentials Storefront', 'bhudson@mainstreetbanks.it', 74.32);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3212, 'IntelliSupplies Emporium', 'fionnula.b@neogen.com', -40.21);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3213, 'Scholastic Solutions Storefron', 'colin.g@msdw.com', 3.6);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3214, 'EduEssentials Emporium', 'bruce@floorgraphics.br', -.08);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3215, 'School Savvy Storehouse', 'lynette.shatner@ach.com', 24.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3216, 'The Learning Store', 'ediet@ach.com', 17.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3217, 'Brainy Basics Emporium', 'jcarr@telesynthesis.nl', 6.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3218, 'Genius Goods Station', 'jpalminteri@usphysicaltherapy.za', -88.94);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3219, 'Genius Gear Galore', 'whiatt@americanexpress.au', 22.41);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3220, 'EduEssentials Emporium', 'martha.hornsby@sensortechnologies.com', 63.48);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3221, 'Genius Gear Galore', 'gilj@grayhawksystems.com', -138.39);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3222, 'Genius Goods Boutique', 'fionnula@freedommedical.com', 24.19);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3223, 'School Savvy Solutions', 'chuck.perry@usdairyproducers.pl', -13.32);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3224, 'Brain Boost Emporium', 'ving@tilia.hu', -119.75);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3225, 'Study Smart Spot', 'boz.tucker@mainstreetbanks.de', -60.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3226, 'EduEssentials Storefront', 'miko.warren@nobrainerblindscom.uk', 66.63);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3227, 'School Savvy Storefront', 'clea.lennox@securitycheck.de', 47.81);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3228, 'Scholarly Supplies Shack', 'maura.pride@summitenergy.com', 97.03);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3229, 'Scholarly Solutions Stop', 'hbosco@pharmafab.uk', 10.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3230, 'Study Smart Solutions', 'machine.speaks@advertisingventures.com', -61.05);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3231, 'Scholarly Solutions Stop', 'rickie.abraham@sfgo.com', -51.81);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3232, 'Brain Boost Bazaar', 'salma.schiff@cns.uk', 80.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3233, 'Learning Supply Store', 'ashton@studiobproductions.de', 86.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3234, 'Scholarly Supply Shack', 'c.may@marriottinternational.com', -11.05);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3235, 'Genius Gearhouse', 'wang.singletary@woronocobancorp.dk', 19.39);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3236, '''Pens & Pencils', 'marie.amos@jewettcameron.uk', 3.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3237, 'Study Smart Station', 'gina.gatlin@webgroup.com', -214.3);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3238, 'The Birds of Minerva', 'astamp@gdi.fr', 50.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3239, 'Brain Boost Emporium', 'dylan@bashen.jp', -2.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3240, 'Brainwave Bodega', 'aburstyn@hps.jp', 22.89);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3241, 'Brainwave Basics Boutique', 'rogerd@supplycorecom.com', -23.02);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3242, 'IntelliTools Emporium', 'nicole@yumbrands.com', 8.86);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3243, 'School Savvy Solutions', 'debi@ivorysystems.de', -56.03);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3244, 'LearnWell Supplies', 'lou.cara@qls.au', 1.21);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3245, 'Scholarly Supply Shack', 'whoopi.visnjic@hiltonhotels.dk', -39.89);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3246, 'IntelliTools Co.', 'lucy.cusack@primussoftware.de', 70.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3247, 'Brainwave Basics Boutique', 'william.mclachlan@mls.in', 54.02);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3248, 'Scholastic Solutions Storefron', 'ecarradine@aop.com', 23.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3249, 'School Essentials Warehouse', 'jedmunds@tropicaloasis.com', 32.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3250, 'EduEssentials Depot', 'edie.b@cns.com', 80.21);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3251, 'Scholarly Supplies Shack', 'tim.d@ivorysystems.at', 54.1);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3252, 'Smart Solutions Store', 'o.mitra@yumbrands.pt', 1.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3253, 'IntelliTools Co.', 'mena.e@eagleone.com', 81.78);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3254, 'IntelliSupplies Emporium', 'irene.wen@pharmafab.com', 36.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3255, 'School Savvy Solutions', 'blaw@bluffcitysteel.ht', -17.01);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3256, 'Brainy Basics Boutique', 'joshua.emmett@deutschetelekom.il', 57.45);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3257, 'EduEssentials Depot', 'renee.atkinson@totalentertainment.com', 94);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3258, 'Scholarly Solutions Storefront', 'coley.paltrow@cascadebancorp.uk', 94.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3259, 'Study Smart Station', 'alex.loring@qestrel.de', 8.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3260, 'Scholastic Solutions Emporium', 'jamie.orton@homedepot.com', 79.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3261, 'IntelliSupplies Station', 'geoff.stewart@mre.com', 43.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3262, 'School Supply Solutions', 'mark.adams@hersheyfoods.ca', 3.49);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3263, 'EduEssentials Storefront', 's.matheson@sms.uk', -53.97);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3264, 'Scholarly Solutions Shack', 'nigel.degraw@merck.com', 53.54);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3265, 'Notebook Nation', 'anjelica@tama.au', -5.18);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3266, 'Clever Equipped', 'k.leguizamo@gcd.com', 14.71);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3267, 'Study Smart Stop', 'dclarkson@hersheyfoods.tr', 39.48);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3268, 'Scholarly Supply Station', 'patricia.condition@nobrainerblindscom.uk', 91.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3269, 'EduEssentials Emporium', 'howard.k@mcdonalds.com', 43.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3270, 'Essential & Brilliant', 'adownie@philipmorris.de', -70.2);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3271, 'Genius Goods Station', 'gena.white@usdairyproducers.ch', 24.9);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3272, 'IntelliSupplies Emporium', 'kylie@ivorysystems.com', 54.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3273, 'EduEssentials Storefront', 'marley.t@techbooks.com', 69.71);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3274, 'EduEssentials Emporium', 'joan.tobolowsky@qssgroup.com', 68.9);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3275, 'Scholarly Supply Shack', 'miko@americanmegacom.com', 25.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3276, 'Genius Gear Gallery', 'fred.rydell@providenceservice.com', -51.81);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3277, 'IntelliSupplies Emporium', 'fmolina@marketfirst.at', 70.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3278, 'IntelliSupplies Emporium', 's.klein@spenser.jp', -46.44);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3279, 'Smart Study Spot', 'w.fender@usdairyproducers.com', 99.9);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3280, 'Scholarly Supply Station', 'busta.bacon@trafficmanagement.com', 77.21);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3281, 'Study Smart Solutions', 'owen.domino@multimedialive.com', -58.89);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3282, 'Study Savvy Solutions', 'frank.s@cowlitzbancorp.com', 24.99);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3283, 'Brainpower Basics', 'jonny@newmedia.cn', 87.88);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3284, 'Smart Study Solutions', 'gabriel@woronocobancorp.de', 36.98);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3285, 'School Savvy Solutions', 'russell.platt@nobrainerblindscom.com', 71.43);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3286, 'Genius Goods Station', 'penelope.phillips@hencie.nc', 98.04);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3287, 'Study Smart Spot', 'luis.finney@allstar.com', 12.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3288, 'Study Smart Spot', 'selma.wayans@pharmafab.ca', 87.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3289, 'Brainy Bookstore', 'albertina.mccain@conagra.tw', -81.42);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3290, 'Scholarly Supplies Shack', 'lucinda.h@accurateautobody.com', -15.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3291, 'Bright Minds Emporium', 'yaphet.strathairn@jcpenney.uk', 40.73);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3292, 'Brainwave Basics Bazaar', 'breckint@pioneermortgage.com', -40.88);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3293, 'School Savvy Storefront', 'cece.bonneville@mai.com', 29.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3294, 'Scholastic Solutions Station', 'powers.stuermer@visionarysystems.com', 23.94);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3295, 'Brainy Basics Emporium', 'kniven@afs.it', -41.26);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3296, 'Smart Study Stop', 'yaphet.williams@techrx.com', -69.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3297, 'Genius Goods Emporium', 'nshepherd@wendysinternational.com', -23.3);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3298, 'EduGear Emporium', 'lynn.bosco@shot.com', 14.66);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3299, 'EduEssentials Depot', 'grant.w@nissanmotor.be', -61.45);
commit;
prompt 300 records committed...
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3300, 'IntelliTech Tools Co.', 'barry.p@max.cy', -9.54);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3301, 'IntelliTools Emporium', 'karon.deejay@jsa.it', 83.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3302, '''Pens & Pencils', 'val.t@aquascapedesigns.com', 37.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3303, 'Study Smart Station', 'lily.mcconaughey@at.jp', -56.02);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3304, 'Smart Study Stop', 'vin.l@captechventures.com', 48.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3305, 'School Savvy Solutions', 'judi.heslov@keith.com', 80.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3306, 'Brainy Basics Boutique', 'domb@canterburypark.it', -22);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3307, 'Genius Goods Station', 'marty.holliday@ivorysystems.br', -13.49);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3308, 'School Source', 'walter.kershaw@progressivedesigns.com', 37.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3309, 'IntelliTools Inc.', 'lily.santana@accessus.de', 5.34);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3310, 'Scholarly Supplies Shack', 'taye.v@mavericktechnologies.com', 18.22);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3311, 'IntelliTools Co.', 'rita.emmett@noodles.ve', -15.19);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3312, 'School Support Systems', 'victor.kier@sears.com', 39.1);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3313, 'Wisdom Warehouse', 'vendetta.rossellini@priorityleasing.com', 2.86);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3314, 'School Savvy Storefront', 'b.bandy@staffforce.it', 6.49);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3315, 'Genius Gear Galore', 'yolanda.pride@dvdt.it', 24.99);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3316, 'Scholarly Solutions Storefront', 'nperrineau@comnetinternational.au', 35.32);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3317, 'Genius Gear Emporium', 'w.dreyfuss@interfacesoftware.com', 12.02);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3318, 'Smart Study Supplies', 'latin.martin@marathonheater.de', 43.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3319, 'Study Tools Galore', 'merle.l@valleyoaksystems.uk', -18.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3320, 'Genius Gear Emporium', 'hector.ford@ataservices.com', -34.04);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3321, 'Scholarly Supply Shack', 'mlizzy@waltdisney.com', 25);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3322, 'EduEssentials Emporium', 'molly.rossellini@officedepot.com', -36.16);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3323, 'Study Savvy Solutions', 'samantha.lightfoot@sony.de', 12.59);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3324, 'Genius Goods Gallery', 'samuel.may@telwares.com', 98.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3325, 'Genius Gear Galore', 'richard.danes@prp.in', 49.87);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3326, 'Scholastic Solutions Emporium', 'liquid.chapman@knightsbridge.uk', -97.96);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3327, 'IntelliSupplies Station', 'andre@emt.com', 53.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3328, 'Study Smart Spot', 'jrudd@profitline.com', -25.12);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3329, 'IntelliTools Storefront', 'sanderf@intel.br', -16.97);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3330, 'Genius Gear Emporium', 'mae.h@johnkeeler.nl', -18.34);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3331, 'Smart Study Spot', 'leelee.bentley@sm.com', 1.03);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3332, 'Scholarly Supply Station', 'liquid.snider@cooktek.uk', 23.84);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3333, 'Scholarly Supplies Stop', 'm.klein@pepsico.com', 63);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3334, 'IntelliSupplies Emporium', 'gary@uem.ar', 26.76);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3335, 'Scholarly Supply Shack', 'jkapanka@hps.com', 7.55);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3336, 'Scholastic Supplies Source', 'davis.elwes@smg.com', 87.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3337, 'Brain Boost Emporium', 'petula.l@pds.com', 88.1);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3338, 'Study Smart Stop', 'penelope@infovision.com', -102.47);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3339, 'Genius Goods Boutique', 'scottv@oriservices.com', -45.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3340, 'Scholarly Solutions Storefront', 'noah.alda@hudsonriverbancorp.com', 14.65);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3341, 'Brain Boost Emporium', 'p.roberts@credopetroleum.br', 12.89);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3342, 'Brainwave Bodega', 'patrick.vanian@hps.com', 34.65);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3343, 'Brainwave Basics Bazaar', 'george.reubens@gagwear.com', 47.07);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3344, 'Academic Advantage Co.', 'brad@mre.com', 87.84);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3345, 'Study Smart Solutions', 'night.osbourne@qssgroup.it', 29.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3346, 'Genius Goods Galore', 'edward.ratzenberger@ptg.uk', 2.38);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3347, 'Study Smart Station', 'kathyt@floorgraphics.com', 21.02);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3348, 'Mindful Materials Co.', 'cdushku@granitesystems.jp', 29.72);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3349, 'Scholastic Supplies Source', 'lesley.dern@gillani.com', -40.49);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3350, 'Genius Goods Galore', 'mykelti.burton@fmb.com', 93.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3351, 'Intellect Innovations', 'x.larter@toyotamotor.ch', 25.25);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3352, 'IntelliSupplies Station', 'orlando.w@scjohnson.com', 67.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3353, 'Genius Goods Gallery', 'keith@oriservices.uk', 55.77);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3354, 'Enlightened Educators Emporium', 'crispin@accucode.no', 22.21);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3355, 'Scholarly Supplies Stop', 'tcheky.smurfit@fflcbancorp.com', -7.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3356, 'IntelliTools Storefront', 'uma.arthur@dcgroup.dk', -15.86);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3357, 'Genius Goods Galore', 'trini.s@cyberthink.com', 55.69);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3358, 'Brainwave Basics Boutique', 'miriamv@conquestsystems.com', -61.16);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3359, 'Wisdom Works Warehouse', 'neneh.boone@cendant.at', 62.62);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3360, 'School Savvy Storefront', 'tony.ponty@greenmountain.ee', -85.32);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3361, 'Scholarly Solutions Shack', 'shawn@bashen.com', 46.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3362, 'Genius Goods Boutique', 'c.barkin@marathonheater.it', 32.48);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3363, 'School Supplies Depot', 'sfreeman@saralee.com', -71.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3364, 'IntelliTools Emporium', 'tony.b@fordmotor.ca', -36.56);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3365, 'Study Smart Stop', 'harold.lemmon@elitemedical.com', 97.3);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3366, 'Scholastic Solutions Storefron', 'christmas@gentrasystems.br', 24.55);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3367, 'Brainy Basics Bazaar', 'cevin.kinney@gdatechnologies.com', -73);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3368, 'Brainwave Bazaar', 'steve.l@afs.au', -64.45);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3369, 'Smart Solutions Store', 'swoosie.holiday@gra.hk', -38.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3370, 'Office & School Supplies Co.', 'rodney.mantegna@travizon.com', 43.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3371, 'Smart Study Stop', 'bret.barry@ufs.it', 52.77);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3372, 'IntelliSupplies Station', 'richie.n@codykramerimports.com', 61.39);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3373, 'School Savvy Storefront', 'juices@codykramerimports.it', -20.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3374, 'Scholastic Solutions Storefron', 'jake.crystal@oriservices.fi', 34.34);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3375, 'Scholarly Supply Shack', 'jean.k@conquest.nl', -9.98);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3376, 'Smart Study Supplies', 'cloris.feuerstein@bestever.uk', -57.8);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3377, 'Brain Boost Bazaar', 'juan@fpf.com', 35.55);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3378, 'IntelliGear Inc.', 'fiona.orton@trafficmanagement.it', 2.87);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3379, 'Scholastic Solutions Storefron', 'vienna@target.com', 52.44);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3380, 'Study Smart Station', 'austin.sevenfold@typhoon.at', 29.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3381, 'Brainpower Boutique', 'annette.vaughn@qls.it', 38.76);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3382, 'IntelliSupplies Shack', 'drobbins@caliber.com', 29.16);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3383, 'Genius Gear Emporium', 'janices@parker.uk', 47.25);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3384, 'Scholarly Supplies Shack', 'molly.jeffreys@novartis.com', -27.75);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3385, 'Scholarly Solutions Stop', 'azucar.kelly@sms.com', -50.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3386, 'Genius Goods Station', 'f.sisto@ogi.br', -85.16);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3387, 'EduEssentials Storefront', 'hwitherspoon@meritagetechnologies.com', 35.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3388, 'Scholarly Supplies Shack', 'leelee@qestrel.de', -63.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3389, 'Genius Goods Station', 'b.raye@spenser.com', -26.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3390, 'Smart Study Solutions', 'gerald@afs.uk', -11.92);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3391, 'School Savvy Solutions', 'noraw@kroger.mx', 77.21);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3392, 'Scholarly Solutions Depot', 'rutger.mantegna@procurementcentre.com', -11.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3393, 'IntelliTools Emporium', 'jonatha@credopetroleum.com', -25.14);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3394, 'IntelliSupplies Shack', 'maggieg@stonebrewing.dk', 52.26);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3395, 'Knowledge Kingdom', 'jmann@hencie.com', 35.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3396, 'Study Smart Station', 'jared.a@cimalabs.ec', 39.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3397, 'Genius Gear Emporium', 't.woodard@pib.nz', 96.83);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3398, 'Classroom Essentials', 'annes@integratelecom.com', 28.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3399, 'Scholastic Solutions Storefron', 'h.brown@younginnovations.si', -44.31);
commit;
prompt 400 records committed...
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3400, 'Notebook Nook', 'saffronl@mre.ch', 16.12);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3401, 'Academic Alcove', 'petula.kapanka@shar.com', 90.65);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3402, 'Brain Boost Bazaar', 'loreena.houston@labradanutrition.jp', 58.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3403, 'School Supply Superstore', 'sally.westerberg@yashtechnologies.pt', 53.96);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3404, 'Study Smart Station', 'bonnie@fab.com', 28.33);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3405, 'IntelliTools Emporium', 'g.herrmann@stmaryland.de', -69.75);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3406, 'Scholastic Warehouse', 'frances@esteelauder.ca', 38.49);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3407, 'IntelliSupplies Shack', 'greg.begley@chhc.uk', -19.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3408, 'IntelliTools Emporium', 'ipesci@tama.com', 59.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3409, 'Scholarly Solutions Storefront', 'liquid@cascadebancorp.com', 24.78);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3410, 'IntelliSupplies Emporium', 'halle.oneal@signalperfection.uk', 27.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3411, 'Wisdom Works Warehouse', 'vern.gleeson@keymark.ca', -24.05);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3412, 'Scholarly Supplies Shack', 'candice@trusecure.de', -122.64);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3413, 'Brainy Basics Boutique', 'denny.b@generalmotors.com', -68.38);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3414, 'School Stuff Inc.', 'oded.lauper@inzone.jp', 76.76);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3415, 'Scholarly Supply Station', 'kdevita@businessplus.br', -19.34);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3416, 'Scholarly Supplies Stop', 'lynn@hatworld.mo', 51.31);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3417, 'Genius Goods Station', 'emerson.m@north.com', 34.99);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3418, 'IntelliSupplies Emporium', 'rob.sayer@wlt.de', -24.29);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3419, 'IntelliSupplies Emporium', 'vienna@dancor.com', -37.34);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3420, 'Knowledge Mart', 'ashley.h@qas.de', -152.8);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3421, 'IntelliSupplies Shack', 'wade.robbins@terrafirma.dk', 76.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3422, 'Scholarly Supply Shack', 'stellan.borden@mms.it', 83.76);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3423, 'IntelliSupplies Emporium', 'maxine.nivola@fflcbancorp.ch', -3.17);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3424, 'Scholastic Solutions Station', 'wprowse@businessplus.ca', 46.82);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3425, 'EduEssentials Storefront', 'charlie@trekequipment.jp', -124.85);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3426, 'Study Smart Spot', 'rita.shawn@eastmankodak.it', 25.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3427, 'Brainy Basics Emporium', 'clive.bean@unicru.com', 3.17);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3428, 'Brain Boost Emporium', 'lisa.holden@faef.il', 39.79);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3429, 'Scholarly Solutions Stop', 'pam@aventis.com', 87.4);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3430, 'SchoolSmart Solutions', 'bernie.christie@bayer.com', -.01);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3431, 'Scholarly Supplies Shack', 'boz.shalhoub@visainternational.com', -42.35);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3432, 'Smart Supplies Inc.', 'mitchell.r@capitalautomotive.uk', 46.64);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3433, 'Brainwave Basics Boutique', 'rene.w@diamondtechnologies.com', 14.5);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3434, 'Learn & Lead Supplies', 'udo.scott@ssci.uk', 74.84);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3435, 'Scholastic Solutions Storefron', 'freda.g@bat.com', 56.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3436, 'Brainy Basics Emporium', 'kurtwoodg@hudsonriverbancorp.com', -63.04);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3437, 'Smart Study Solutions', 's.channing@prahs.at', -20.06);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3438, 'Study Smart Spot', 't.ingram@marketfirst.com', 32.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3439, 'Brainy Basics Boutique', 'danni.cummings@manhattanassociates.br', 16.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3440, 'Brainwave Basics Boutique', 'o.marin@ultimus.com', -88.24);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3441, 'Genius Goods Boutique', 'solomon.zahn@invisioncom.de', 97.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3442, 'School Savvy Storefront', 'g.khan@novartis.com', -26.98);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3443, 'The Learning Store', 'ethan.dreyfuss@mai.es', 43.73);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3444, 'Brainy Basics Bazaar', 'uma.m@execuscribe.com', 14.26);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3445, 'Scholastic Solutions Shack', 'robin.dourif@nexxtworks.com', -2.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3446, 'Scholarly Solutions Storefront', 'vivica.devita@faef.ch', 36.2);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3447, 'Essential & Brilliant', 'harris.richardson@qestrel.ch', -120.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3448, 'IntelliSupplies Emporium', 'cgary@trinityhomecare.com', -59.71);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3449, 'School Supply Hub', 'clewin@vspan.uk', -16.46);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3450, 'Study Smart Station', 'tommy@atxforms.de', -34.09);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3451, 'Genius Gear Galore', 'rdavies@totalentertainment.ch', 47.18);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3452, 'Scholarly Supplies', 'v.moraz@hitechpharmacal.de', 29.53);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3453, 'School Savvy Storefront', 'roddy.shorter@cima.hu', 89.1);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3454, 'Genius Gear Emporium', 'm.driver@comnetinternational.in', 53.13);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3455, 'Brain Boost Emporium', 'anna@telesynthesis.za', 56.78);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3456, 'EduEssentials Emporium', 'livj@clorox.jp', -61.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3457, 'IntelliTools Inc.', 'rhett.burmester@accuship.br', -66.79);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3458, 'Genius Gear Emporium', 'rob.m@fordmotor.com', 96.53);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3459, 'Genius Goods Emporium', 'lupe.f@pharmafab.se', 98.42);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3460, 'Brainpower Supplies', 'georgeh@inspirationsoftware.com', 14.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3461, 'IntelliTools Storefront', 'ani@esoftsolutions.com', -3.73);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3462, 'Brain Boost Emporium', 'will.blige@hondamotor.nl', 39);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3463, 'Genius Goods Boutique', 'acolman@yumbrands.com', -84.57);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3464, 'Academic Essentials', 'sonny.orbit@avr.com', 42.97);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3465, 'EduEssentials Depot', 'carolyn.capshaw@viacom.com', -90.93);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3466, 'Genius Goods Galore', 'toni.koteas@hewlettpackard.ch', -71.95);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3467, 'Genius Goods Gallery', 'collective.fiennes@seiaarons.com', 65.98);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3468, 'IntelliSupplies Emporium', 'simon.p@evinco.de', .45);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3469, 'Genius Gear Emporium', 'abrickell@bristolmyers.de', 10.1);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3470, 'School Supply Shoppe', 'ashepard@shirtfactory.com', 41.8);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3471, 'EduEssentials Storefront', 'nikka@grayhawksystems.fr', -8.54);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3472, 'Essential & Brilliant', 'sonny.miller@morganresearch.com', 64.27);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3473, 'EduEssentials Emporium', 'alex.sharp@unitedasset.com', -8.04);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3474, 'Brainwave Basics Boutique', 'ksevigny@softworld.dk', 4.22);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3475, 'Genius Goods Boutique', 'gordon.johansson@wyeth.com', 32.7);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3476, 'Smart Study Stop', 'daniel.emmerich@loreal.com', -127.58);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3477, 'IntelliTools Inc.', 'domingo.li@ams.com', 56.28);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3478, 'Scholarly Solutions Storefront', 'kirsten.pollack@bashen.com', 41.78);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3479, 'School Savvy Storefront', 'crawls@captechventures.com', 87.61);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3480, 'Scholarly Supply Shack', 'gordo@alohanysystems.com', 96.33);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3481, 'Study Smart Stop', 'andrae@fflcbancorp.com', 85.91);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3482, 'Scholastic Solutions Storefron', 'dar.li@activeservices.com', -34.86);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3483, 'Study Smart Stop', 'anne.richards@medamicus.com', -49.15);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3484, 'Scholarly Solutions Stop', 'kathleen.neuwirth@talx.fr', 15.88);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3485, 'Scholarly Solutions Stop', 'l.haslam@mitsubishimotors.de', 8.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3486, 'IntelliGear Emporium', 'dermot.gayle@greene.au', 22.04);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3487, 'Classroom Essentials', 'forest.coleman@angieslist.com', -86.25);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3488, 'Brainy Bookstore', 'lois.richardson@homedepot.uk', 37.61);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3489, 'IntelliSupplies Shack', 'andrew.cockburn@americanhealthways.com', -20.23);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3490, 'Scholarly Solutions Storefront', 'julia@ipsadvisory.com', 19.95);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3491, 'Scholarly Solutions Shack', 'olga.winger@cascadebancorp.nl', 58.46);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3492, 'Classroom Couture', 'val.donofrio@techbooks.de', 45.95);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3493, 'Scholarly Solutions Storefront', 'clive@httprint.com', 11.67);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3494, 'EduGear Emporium', 'leo.spector@mls.com', -50.86);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3495, 'Brainy Basics Emporium', 'pdef@scooterstore.com', 18.36);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3496, 'School Savvy Solutions', 'rachel.mantegna@socketinternet.dk', 76.37);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3497, 'Genius Goods Station', 'elizabeth.h@servicelink.fr', 62.74);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3498, 'IntelliTools Emporium', 'shirley.lillard@johnson.com', 49.55);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (3499, 'Brain Boost Bazaar', 'alex.ammons@keymark.ch', 56.57);
commit;
prompt 500 records committed...
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (1234, 'Test Supplier', '123 Test St', 5000);
insert into SUPPLIER (supplier_id, supplier_name, contact_information, inventory)
values (5678, 'Test Supplier', '123 Test St', 1000);
commit;
prompt 502 records loaded
prompt Loading INVOICE...
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2500, 3019, 146.53, to_date('23-02-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2501, 3262, 238.19, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2502, 3423, 424.91, to_date('04-07-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2503, 3372, 118.04, to_date('01-09-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2504, 3329, 53.41, to_date('18-11-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2505, 3409, 25.36, to_date('05-06-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2506, 3477, 366.45, to_date('03-11-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2507, 3032, 274.59, to_date('13-12-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2508, 3053, 231.6, to_date('09-11-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2509, 3362, 102.79, to_date('03-12-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2510, 3495, 446.8, to_date('25-04-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2511, 3371, 59.94, to_date('12-09-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2512, 3165, 462.55, to_date('06-05-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2513, 3484, 495.59, to_date('20-04-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2514, 3085, 456.69, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2515, 3457, 173.22, to_date('25-04-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2516, 3466, 277.92, to_date('17-03-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2517, 3162, 268.02, to_date('04-07-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2518, 3347, 15.44, to_date('05-03-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2519, 3435, 434.57, to_date('12-11-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2520, 3164, 307.83, to_date('30-07-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2521, 3329, 208.85, to_date('03-10-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2522, 3120, 266.87, to_date('22-06-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2523, 3050, 408.86, to_date('08-11-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2524, 3421, 166.81, to_date('05-06-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2525, 3011, 96.73, to_date('29-03-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2526, 3109, 431.04, to_date('06-05-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2527, 3121, 474.58, to_date('27-02-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2528, 3120, 40.7, to_date('05-08-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2529, 3086, 76.65, to_date('14-10-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2530, 3059, 152.45, to_date('15-02-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2531, 3329, 91.95, to_date('28-12-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2532, 3081, 32.55, to_date('13-03-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2533, 3167, 320.81, to_date('17-12-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2534, 3083, 227.85, to_date('09-08-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2535, 3083, 286.81, to_date('04-10-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2536, 3341, 327.9, to_date('15-10-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2537, 3125, 19.78, to_date('09-11-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2538, 3099, 423.18, to_date('15-04-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2539, 3349, 249.52, to_date('05-03-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2540, 3348, 173.11, to_date('14-12-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2541, 3296, 289.32, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2542, 3454, 109.77, to_date('09-03-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2543, 3198, 273.95, to_date('16-02-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2544, 3142, 71.02, to_date('15-10-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2545, 3125, 20.69, to_date('29-06-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2546, 3355, 134.46, to_date('04-10-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2547, 3385, 225.47, to_date('06-09-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2548, 3242, 18.28, to_date('05-10-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2549, 3208, 153.88, to_date('01-11-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2550, 3326, 115.91, to_date('18-11-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2551, 3200, 209.46, to_date('18-09-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2552, 3203, 171, to_date('14-05-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2553, 3071, 146.74, to_date('06-07-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2554, 3250, 124.59, to_date('27-08-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2555, 3428, 491.81, to_date('06-10-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2556, 3209, 342.41, to_date('17-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2557, 3241, 272.26, to_date('08-02-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2558, 3148, 27.71, to_date('31-07-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2559, 3060, 68.1, to_date('15-10-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2560, 3014, 415.57, to_date('17-06-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2561, 3412, 358.57, to_date('01-04-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2562, 3464, 451.38, to_date('18-01-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2563, 3498, 268.41, to_date('07-09-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2564, 3179, 234.7, to_date('11-07-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2565, 3417, 493.33, to_date('25-05-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2566, 3315, 457.52, to_date('08-07-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2567, 3475, 285.62, to_date('20-02-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2568, 3044, 452.08, to_date('28-02-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2569, 3228, 34.02, to_date('10-08-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2570, 3272, 351.34, to_date('03-05-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2571, 3023, 291.41, to_date('12-04-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2572, 3356, 245.9, to_date('14-02-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2573, 3320, 439.44, to_date('17-04-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2574, 3242, 15.97, to_date('10-10-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2575, 3035, 287.44, to_date('28-07-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2576, 3008, 375.1, to_date('12-08-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2577, 3482, 91.35, to_date('10-09-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2578, 3044, 75.7, to_date('26-05-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2579, 3235, 18.68, to_date('16-09-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2580, 3115, 470.45, to_date('23-04-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2581, 3200, 353.21, to_date('03-12-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2582, 3089, 237.43, to_date('22-05-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2583, 3322, 145.17, to_date('11-07-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2584, 3059, 407.71, to_date('27-11-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2585, 3402, 41.08, to_date('10-01-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2586, 3309, 327.28, to_date('26-09-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2587, 3237, 258.24, to_date('10-06-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2588, 3115, 63.55, to_date('09-07-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2589, 3281, 1.37, to_date('05-08-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2590, 3128, 199.87, to_date('29-07-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2591, 3060, 84.88, to_date('22-06-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2592, 3188, 198.88, to_date('20-01-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2593, 3422, 319.41, to_date('20-09-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2594, 3279, 497.28, to_date('24-01-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2595, 3197, 143.07, to_date('26-01-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2596, 3311, 307.39, to_date('03-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2597, 3217, 124.69, to_date('17-01-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2598, 3358, 9.8, to_date('08-07-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2599, 3092, 409.13, to_date('16-10-2002', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2600, 3197, 335.05, to_date('25-07-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2601, 3164, 174.15, to_date('29-10-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2602, 3245, 312.13, to_date('03-03-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2603, 3227, 181.83, to_date('29-03-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2604, 3280, 138.47, to_date('10-01-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2605, 3400, 212.91, to_date('04-04-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2606, 3489, 152.85, to_date('11-04-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2607, 3318, 390.01, to_date('01-01-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2608, 3133, 384.4, to_date('21-06-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2609, 3435, 55.35, to_date('09-12-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2610, 3377, 109.95, to_date('13-02-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2611, 3219, 454.34, to_date('30-11-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2612, 3249, 151.2, to_date('08-10-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2613, 3238, 455.68, to_date('08-01-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2614, 3070, 378.03, to_date('29-04-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2615, 3380, 187.53, to_date('14-12-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2616, 3362, 74.96, to_date('10-06-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2617, 3491, 7.59, to_date('29-04-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2618, 3400, 333.3, to_date('24-09-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2619, 3123, 228.51, to_date('26-02-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2620, 3237, 498.67, to_date('29-10-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2621, 3369, 8.72, to_date('25-08-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2622, 3199, 251.74, to_date('04-12-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2623, 3256, 452.19, to_date('02-12-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2624, 3268, 184.19, to_date('25-02-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2625, 3226, 60.96, to_date('01-05-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2626, 3207, 391.45, to_date('14-12-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2627, 3342, 346.24, to_date('29-09-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2628, 3300, 214.26, to_date('24-08-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2629, 3312, 301.82, to_date('07-03-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2630, 3072, 255.16, to_date('31-05-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2631, 3454, 203.17, to_date('21-03-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2632, 3408, 7.88, to_date('10-05-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2633, 3228, 239.28, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2634, 3492, 330.81, to_date('14-07-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2635, 3381, 464.3, to_date('22-09-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2636, 3117, 41.66, to_date('24-10-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2637, 3169, 409.97, to_date('21-06-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2638, 3201, 110.58, to_date('08-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2639, 3188, 307.58, to_date('28-12-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2640, 3447, 96.45, to_date('18-09-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2641, 3259, 188.02, to_date('18-10-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2642, 3122, 339.85, to_date('14-09-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2643, 3482, 189.88, to_date('13-11-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2644, 3179, 297.1, to_date('09-12-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2645, 3175, 46.35, to_date('11-08-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2646, 3179, 260.25, to_date('21-07-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2647, 3399, 314.22, to_date('08-10-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2648, 3452, 134.67, to_date('02-01-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2649, 3448, 39.5, to_date('24-03-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2650, 3498, 269.57, to_date('09-01-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2651, 3345, 265.46, to_date('24-03-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2652, 3423, 307.71, to_date('14-07-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2653, 3053, 419.26, to_date('30-08-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2654, 3257, 390.41, to_date('06-05-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2655, 3210, 301.51, to_date('09-08-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2656, 3026, 126.6, to_date('23-09-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2657, 3380, 90.29, to_date('18-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2658, 3451, 421.68, to_date('23-01-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2659, 3178, 205.77, to_date('08-06-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2660, 3269, 297.18, to_date('12-06-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2661, 3410, 303.24, to_date('19-02-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2662, 3130, 268.92, to_date('10-03-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2663, 3323, 244.87, to_date('09-04-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2664, 3457, 472.87, to_date('27-07-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2665, 3050, 339.16, to_date('09-06-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2666, 3052, 487.4, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2667, 3227, 380.22, to_date('21-04-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2668, 3086, 327.35, to_date('20-04-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2669, 3269, 140.01, to_date('01-09-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2670, 3082, 314.53, to_date('10-05-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2671, 3404, 285.2, to_date('08-11-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2672, 3162, 414.18, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2673, 3218, 263.88, to_date('30-11-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2674, 3135, 66.04, to_date('16-07-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2675, 3488, 27.3, to_date('24-10-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2676, 3372, 200.48, to_date('10-04-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2677, 3376, 191.24, to_date('29-10-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2678, 3248, 243.86, to_date('23-09-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2679, 3132, 325.55, to_date('09-07-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2680, 3407, 198.99, to_date('03-03-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2681, 3335, 54.76, to_date('06-06-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2682, 3029, 299.98, to_date('25-03-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2683, 3099, 283.08, to_date('19-02-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2684, 3468, 87.66, to_date('03-02-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2685, 3153, 111.82, to_date('09-09-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2686, 3079, 156.57, to_date('21-03-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2687, 3479, 241.51, to_date('14-04-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2688, 3422, 483.86, to_date('10-03-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2689, 3303, 434, to_date('10-05-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2690, 3152, 192.45, to_date('20-04-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2691, 3404, 188.17, to_date('28-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2692, 3116, 424.76, to_date('31-07-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2693, 3280, 57.78, to_date('18-11-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2694, 3316, 29.58, to_date('28-03-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2695, 3405, 126.61, to_date('14-06-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2696, 3133, 22, to_date('05-03-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2697, 3228, 311.22, to_date('23-12-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2698, 3367, 333.46, to_date('09-09-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2699, 3296, 475.4, to_date('22-10-2019', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2700, 3385, 101.46, to_date('14-02-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2701, 3286, 348.67, to_date('09-07-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2702, 3429, 299.2, to_date('09-08-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2703, 3291, 415.96, to_date('05-12-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2704, 3150, 387.64, to_date('02-08-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2705, 3282, 149.71, to_date('13-11-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2706, 3317, 382.31, to_date('20-07-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2707, 3359, 340.42, to_date('22-12-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2708, 3079, 16.39, to_date('03-03-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2709, 3440, 481.85, to_date('17-03-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2710, 3269, 384.2, to_date('14-03-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2711, 3362, 22.52, to_date('14-04-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2712, 3096, 194.32, to_date('20-07-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2713, 3129, 355.57, to_date('29-10-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2714, 3396, 244.42, to_date('02-06-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2715, 3351, 35.43, to_date('23-09-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2716, 3188, 228.26, to_date('29-12-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2717, 3235, 38.75, to_date('03-10-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2718, 3051, 378.17, to_date('07-06-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2719, 3380, 40.82, to_date('02-03-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2720, 3318, 416.55, to_date('22-02-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2721, 3401, 463.54, to_date('11-02-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2722, 3036, 203.22, to_date('25-06-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2723, 3220, 50.35, to_date('23-12-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2724, 3108, 395.06, to_date('18-12-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2725, 3077, 95.26, to_date('17-05-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2726, 3397, 154.04, to_date('09-05-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2727, 3165, 14.82, to_date('24-06-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2728, 3315, 34.39, to_date('26-08-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2729, 3071, 246.23, to_date('25-07-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2730, 3322, 316.07, to_date('30-01-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2731, 3057, 470.04, to_date('30-10-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2732, 3211, 444.98, to_date('04-03-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2733, 3366, 108.81, to_date('23-10-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2734, 3248, 466.01, to_date('08-10-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2735, 3333, 401.79, to_date('26-06-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2736, 3352, 297.68, to_date('26-07-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2737, 3476, 226.42, to_date('05-02-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2738, 3045, 268.66, to_date('04-09-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2739, 3183, 180.29, to_date('22-11-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2740, 3236, 176.19, to_date('25-02-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2741, 3489, 208.3, to_date('11-02-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2742, 3128, 114.4, to_date('27-08-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2743, 3018, 420.61, to_date('19-06-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2744, 3250, 72.21, to_date('07-10-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2745, 3226, 280.85, to_date('11-05-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2746, 3476, 486.5, to_date('20-07-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2747, 3330, 155.38, to_date('06-12-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2748, 3249, 161.2, to_date('29-09-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2749, 3357, 373.56, to_date('28-12-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2750, 3083, 221.46, to_date('30-04-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2751, 3281, 321.22, to_date('30-01-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2752, 3197, 428.38, to_date('19-03-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2753, 3268, 405.67, to_date('11-12-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2754, 3241, 126.33, to_date('22-12-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2755, 3113, 228, to_date('19-12-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2756, 3019, 447.66, to_date('23-06-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2757, 3219, 357.42, to_date('10-03-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2758, 3348, 66.65, to_date('28-11-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2759, 3360, 71.68, to_date('13-08-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2760, 3323, 104.69, to_date('30-05-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2761, 3298, 96.32, to_date('16-05-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2762, 3494, 435.28, to_date('09-04-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2763, 3221, 319.78, to_date('23-06-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2764, 3431, 4.45, to_date('13-08-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2765, 3004, 277.44, to_date('03-02-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2766, 3378, 244.27, to_date('08-11-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2767, 3456, 90.9, to_date('12-02-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2768, 3421, 271.63, to_date('26-12-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2769, 3297, 72.79, to_date('09-04-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2770, 3171, 315.04, to_date('14-03-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2771, 3486, 90.15, to_date('06-02-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2772, 3160, 174.21, to_date('27-10-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2773, 3328, 414.23, to_date('04-02-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2774, 3309, 459.8, to_date('23-09-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2775, 3427, 119.47, to_date('02-02-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2776, 3197, 445.24, to_date('12-05-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2777, 3265, 76.02, to_date('20-01-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2778, 3246, 418.58, to_date('06-09-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2779, 3149, 109.28, to_date('06-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2780, 3248, 457.98, to_date('08-10-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2781, 3395, 468.08, to_date('10-03-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2782, 3065, 263.97, to_date('20-03-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2783, 3025, 213.39, to_date('29-06-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2784, 3162, 397.66, to_date('21-08-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2785, 3212, 200.18, to_date('02-10-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2786, 3419, 89.75, to_date('12-10-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2787, 3277, 120.48, to_date('25-03-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2788, 3279, 280.04, to_date('02-03-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2789, 3039, 3.91, to_date('31-01-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2790, 3492, 472.92, to_date('19-06-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2791, 3345, 39.61, to_date('28-08-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2792, 3158, 58.82, to_date('08-05-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2793, 3373, 343.48, to_date('09-03-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2794, 3398, 389, to_date('25-05-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2795, 3465, 423.95, to_date('08-06-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2796, 3471, 156.13, to_date('19-02-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2797, 3279, 38.59, to_date('01-08-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2798, 3382, 143.46, to_date('03-10-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2799, 3381, 102.8, to_date('20-12-2003', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2800, 3346, 205.28, to_date('31-05-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2801, 3404, 167.26, to_date('02-07-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2802, 3417, 370.06, to_date('03-07-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2803, 3263, 332.85, to_date('12-07-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2804, 3090, 32.2, to_date('07-01-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2805, 3279, 247.93, to_date('13-10-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2806, 3085, 416.51, to_date('14-01-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2807, 3243, 208.93, to_date('14-06-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2808, 3302, 340.76, to_date('20-07-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2809, 3091, 71.1, to_date('19-09-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2810, 3001, 325.6, to_date('29-01-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2811, 3189, 349.47, to_date('22-04-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2812, 3030, 476.92, to_date('05-01-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2813, 3134, 390.88, to_date('21-11-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2814, 3322, 69.07, to_date('04-04-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2815, 3361, 366.93, to_date('30-12-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2816, 3103, 67.52, to_date('15-12-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2817, 3109, 110.67, to_date('17-02-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2818, 3087, 114.42, to_date('26-06-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2819, 3005, 211.63, to_date('15-08-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2820, 3190, 123.6, to_date('10-10-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2821, 3431, 496.73, to_date('18-01-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2822, 3333, 56.8, to_date('23-11-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2823, 3496, 443.52, to_date('27-04-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2824, 3266, 360.82, to_date('01-01-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2825, 3180, 375.71, to_date('17-10-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2826, 3456, 275.42, to_date('06-08-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2827, 3116, 365.77, to_date('24-07-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2828, 3092, 252.23, to_date('08-07-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2829, 3228, 214.36, to_date('02-08-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2830, 3131, 103.66, to_date('15-03-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2831, 3288, 339.95, to_date('26-06-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2832, 3217, 459.57, to_date('19-11-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2833, 3388, 97.21, to_date('04-01-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2834, 3055, 456.81, to_date('29-09-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2835, 3414, 327.35, to_date('26-03-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2836, 3240, 391.36, to_date('26-01-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2837, 3216, 84.12, to_date('03-07-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2838, 3317, 356.94, to_date('29-08-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2839, 3068, 220.39, to_date('25-10-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2840, 3475, 279.39, to_date('16-12-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2841, 3167, 476.75, to_date('05-12-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2842, 3237, 39.4, to_date('14-02-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2843, 3467, 290.8, to_date('27-06-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2844, 3015, 440.42, to_date('15-04-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2845, 3013, 116, to_date('12-07-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2846, 3176, 304.86, to_date('30-12-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2847, 3144, 144.28, to_date('25-06-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2848, 3296, 290.98, to_date('14-08-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2849, 3113, 36.81, to_date('09-01-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2850, 3084, 278.79, to_date('22-08-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2851, 3379, 449.16, to_date('30-10-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2852, 3208, 180.29, to_date('03-12-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2853, 3400, 275.42, to_date('05-12-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2854, 3294, 238.75, to_date('19-03-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2855, 3182, 45.05, to_date('20-06-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2856, 3402, 297.39, to_date('14-11-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2857, 3410, 365.06, to_date('13-03-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2858, 3391, 166.26, to_date('22-05-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2859, 3089, 254.67, to_date('13-03-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2860, 3351, 285.04, to_date('13-06-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2861, 3453, 384.99, to_date('19-06-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2862, 3003, 368.57, to_date('31-03-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2863, 3001, 206.62, to_date('04-04-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2864, 3024, 356.03, to_date('07-04-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2865, 3281, 66.61, to_date('25-02-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2866, 3162, 301.09, to_date('04-02-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2867, 3169, 298.96, to_date('26-07-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2868, 3316, 230.18, to_date('05-08-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2869, 3386, 307.14, to_date('12-03-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2870, 3401, 286.92, to_date('02-03-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2871, 3191, 362.08, to_date('14-02-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2872, 3042, 78.69, to_date('08-12-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2873, 3096, 467.85, to_date('30-08-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2874, 3056, 278.53, to_date('07-07-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2875, 3463, 433.99, to_date('04-04-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2876, 3401, 379.87, to_date('20-03-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2877, 3472, 466.85, to_date('01-03-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2878, 3102, 120.47, to_date('16-01-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2879, 3461, 56.47, to_date('24-11-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2880, 3274, 317.61, to_date('12-10-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2881, 3055, 131.92, to_date('02-05-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2882, 3003, 174.18, to_date('01-04-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2883, 3142, 483.43, to_date('19-02-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2884, 3353, 207.36, to_date('21-09-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2885, 3143, 48.8, to_date('30-09-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2886, 3073, 481.87, to_date('16-10-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2887, 3095, 25.75, to_date('15-01-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2888, 3293, 240.43, to_date('13-09-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2889, 3298, 384.5, to_date('16-04-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2890, 3300, 452.63, to_date('14-06-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2891, 3071, 407.67, to_date('21-08-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2892, 3179, 72.88, to_date('06-09-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2893, 3432, 353.34, to_date('06-05-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2894, 3301, 96.96, to_date('08-05-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2895, 3418, 45.81, to_date('30-04-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2896, 3414, 22.9, to_date('05-04-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2897, 3239, 303.84, to_date('23-09-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2898, 3416, 420.69, to_date('20-12-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2899, 3135, 358.02, to_date('18-03-2009', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2900, 3400, 442.57, to_date('15-11-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2901, 3055, 164.92, to_date('24-04-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2902, 3240, 314.75, to_date('13-10-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2903, 3341, 398.99, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2904, 3436, 475.32, to_date('14-03-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2905, 3190, 235.17, to_date('08-11-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2906, 3001, 305.7, to_date('10-04-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2907, 3242, 215.08, to_date('29-07-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2908, 3407, 395.14, to_date('30-11-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2909, 3020, 294.94, to_date('23-12-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2910, 3043, 430.2, to_date('02-02-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2911, 3047, 468.15, to_date('14-03-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2912, 3037, 357.25, to_date('31-08-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2913, 3417, 431.08, to_date('20-03-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2914, 3217, 217.16, to_date('31-05-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2915, 3341, 474.75, to_date('19-11-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2916, 3278, 288.98, to_date('22-08-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2917, 3009, 171.82, to_date('22-06-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2918, 3495, 320.69, to_date('18-02-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2919, 3497, 302.56, to_date('22-07-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2920, 3203, 173.35, to_date('05-09-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2921, 3383, 219.99, to_date('25-05-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2922, 3182, 56.1, to_date('03-01-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2923, 3430, 236.31, to_date('02-06-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2924, 3477, 265.75, to_date('31-08-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2925, 3083, 168.07, to_date('12-06-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2926, 3164, 252.65, to_date('14-10-2016', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2927, 3171, 43.8, to_date('27-07-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2928, 3478, 286.06, to_date('10-02-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2929, 3493, 224.18, to_date('11-03-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2930, 3326, 109.26, to_date('03-05-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2931, 3316, 89.21, to_date('16-05-2019', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2932, 3290, 237.78, to_date('24-04-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2933, 3150, 411.04, to_date('16-07-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2934, 3327, 87.2, to_date('22-10-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2935, 3156, 292.83, to_date('30-11-2013', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2936, 3315, 380.38, to_date('24-08-2004', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2937, 3032, 439.87, to_date('02-07-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2938, 3191, 185.83, to_date('22-05-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2939, 3047, 337.13, to_date('31-03-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2940, 3127, 210.38, to_date('23-06-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2941, 3479, 112.19, to_date('13-11-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2942, 3129, 220.39, to_date('04-07-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2943, 3267, 97.41, to_date('04-10-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2944, 3135, 494.31, to_date('29-05-2000', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2945, 3388, 49.47, to_date('16-01-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2946, 3468, 471.47, to_date('13-06-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2947, 3455, 55.22, to_date('25-08-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2948, 3273, 110.29, to_date('24-11-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2949, 3036, 405.95, to_date('19-01-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2950, 3028, 155.91, to_date('09-06-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2951, 3490, 117.26, to_date('21-07-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2952, 3053, 384.97, to_date('02-04-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2953, 3075, 55.58, to_date('09-11-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2954, 3090, 232.92, to_date('29-04-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2955, 3078, 204.84, to_date('12-04-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2956, 3280, 282.23, to_date('30-03-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2957, 3215, 19.18, to_date('21-12-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2958, 3175, 420.83, to_date('18-01-2020', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2959, 3141, 188.35, to_date('17-03-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2960, 3496, 13.1, to_date('03-09-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2961, 3086, 328.87, to_date('14-11-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2962, 3389, 94.44, to_date('09-04-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2963, 3176, 333.45, to_date('25-07-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2964, 3429, 363.44, to_date('22-01-2007', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2965, 3052, 179.2, to_date('12-09-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2966, 3460, 27.18, to_date('28-04-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2967, 3128, 454.37, to_date('12-07-2022', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2968, 3461, 123.9, to_date('23-09-2014', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2969, 3145, 147.47, to_date('18-12-2009', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2970, 3381, 167.16, to_date('09-08-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2971, 3024, 344.56, to_date('08-03-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2972, 3064, 429.92, to_date('30-03-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2973, 3436, 81.07, to_date('03-06-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2974, 3491, 401.87, to_date('14-04-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2975, 3492, 351.41, to_date('18-04-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2976, 3296, 478.27, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2977, 3488, 378.95, to_date('12-01-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2978, 3285, 371.9, to_date('21-03-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2979, 3197, 382.46, to_date('02-04-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2980, 3240, 128.45, to_date('09-07-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2981, 3289, 274.08, to_date('20-10-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2982, 3307, 475.09, to_date('14-05-2008', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2983, 3487, 34.11, to_date('18-08-2021', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2984, 3072, 152.55, to_date('11-09-2012', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2985, 3405, 366.03, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2986, 3232, 412.3, to_date('28-03-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2987, 3447, 439.27, to_date('27-09-2003', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2988, 3195, 288.42, to_date('05-01-2011', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2989, 3214, 246.83, to_date('23-05-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2990, 3149, 220.23, to_date('24-05-2005', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2991, 3401, 211.66, to_date('05-02-2002', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2992, 3012, 423.22, to_date('26-12-2018', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2993, 3278, 83.93, to_date('02-07-2006', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2994, 3132, 344.69, to_date('06-10-2017', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2995, 3259, 447.43, to_date('03-09-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2996, 3233, 92.54, to_date('13-03-2001', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2997, 3272, 159.41, to_date('21-12-2015', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2998, 3281, 352.87, to_date('11-07-2010', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (2999, 3240, 126.66, to_date('23-10-2014', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (1001, 1234, 500, to_date('01-01-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (1002, 1234, 1500, to_date('01-02-2024', 'dd-mm-yyyy'));
insert into INVOICE (invoice_id, supplier_id, invoice_cost, invoice_date)
values (1003, 1234, 2000, to_date('01-03-2024', 'dd-mm-yyyy'));
commit;
prompt 503 records loaded
prompt Loading ORDERS...
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4000, 3411, 1884, 2560, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4001, 3349, 1629, 2763, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4002, 3196, 1883, 2857, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4003, 3297, 1932, 2721, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4004, 3456, 1604, 2720, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4005, 3028, 1776, 2964, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4006, 3489, 1656, 2700, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4007, 3300, 1653, 2793, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4008, 3184, 1678, 2619, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4009, 3476, 1830, 2735, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4010, 3264, 1791, 2589, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4011, 3107, 1757, 2676, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4012, 3107, 1662, 2928, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4013, 3310, 1683, 2632, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4014, 3212, 1708, 2769, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4015, 3476, 1530, 2922, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4016, 3491, 1977, 2984, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4017, 3221, 1713, 2831, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4018, 3134, 1973, 2938, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4019, 3465, 1842, 2674, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4020, 3440, 1773, 2669, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4021, 3426, 1706, 2902, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4022, 3128, 1581, 2501, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4023, 3369, 1925, 2696, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4024, 3306, 1941, 2847, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4025, 3361, 1533, 2870, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4026, 3338, 1662, 2689, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4027, 3409, 1801, 2836, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4028, 3116, 1799, 2635, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4029, 3028, 1774, 2879, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4030, 3302, 1930, 2515, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4031, 3014, 1580, 2969, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4032, 3317, 1901, 2655, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4033, 3457, 1623, 2934, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4034, 3287, 1532, 2791, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4035, 3396, 1807, 2513, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4036, 3335, 1619, 2535, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4037, 3494, 1812, 2762, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4038, 3322, 1795, 2655, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4039, 3405, 1833, 2592, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4040, 3000, 1971, 2827, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4041, 3297, 1626, 2800, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4042, 3080, 1536, 2809, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4043, 3435, 1944, 2543, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4044, 3328, 1696, 2886, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4045, 3164, 1831, 2657, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4046, 3417, 1956, 2820, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4047, 3002, 1965, 2765, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4048, 3060, 1834, 2554, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4049, 3289, 1514, 2553, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4050, 3020, 1678, 2680, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4051, 3077, 1881, 2559, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4052, 3066, 1842, 2580, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4053, 3355, 1609, 2827, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4054, 3341, 1934, 2710, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4055, 3263, 1655, 2924, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4056, 3393, 1565, 2859, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4057, 3055, 1795, 2969, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4058, 3412, 1929, 2532, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4059, 3433, 1617, 2747, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4060, 3306, 1627, 2693, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4061, 3170, 1926, 2815, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4062, 3410, 1959, 2622, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4063, 3000, 1637, 2738, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4064, 3198, 1848, 2513, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4065, 3319, 1698, 2654, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4066, 3133, 1884, 2870, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4067, 3062, 1502, 2697, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4068, 3123, 1967, 2834, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4069, 3136, 1838, 2983, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4070, 3347, 1716, 2621, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4071, 3214, 1971, 2988, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4072, 3240, 1882, 2755, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4073, 3307, 1785, 2506, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4074, 3369, 1673, 2800, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4075, 3303, 1541, 2894, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4076, 3183, 1975, 2517, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4077, 3385, 1596, 2911, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4078, 3237, 1967, 2902, 30);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4079, 3058, 1895, 2778, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4080, 3389, 1764, 2503, 22);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4081, 3105, 1582, 2815, 30);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4082, 3388, 1725, 2927, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4083, 3470, 1972, 2829, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4084, 3425, 1864, 2751, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4085, 3098, 1628, 2990, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4086, 3364, 1954, 2581, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4087, 3285, 1897, 2826, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4088, 3244, 1801, 2916, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4089, 3478, 1814, 2884, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4090, 3298, 1987, 2722, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4091, 3038, 1586, 2886, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4092, 3392, 1583, 2813, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4093, 3144, 1520, 2529, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4094, 3131, 1724, 2742, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4095, 3407, 1880, 2609, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4096, 3221, 1541, 2812, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4097, 3210, 1563, 2599, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4098, 3281, 1548, 2503, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4099, 3196, 1838, 2818, 36);
commit;
prompt 100 records committed...
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4100, 3388, 1622, 2580, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4101, 3185, 1965, 2689, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4102, 3008, 1931, 2585, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4103, 3181, 1997, 2865, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4104, 3116, 1980, 2765, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4105, 3206, 1639, 2878, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4106, 3465, 1590, 2500, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4107, 3289, 1643, 2531, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4108, 3436, 1642, 2991, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4109, 3043, 1700, 2708, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4110, 3016, 1860, 2663, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4111, 3468, 1855, 2543, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4112, 3263, 1847, 2763, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4113, 3440, 1553, 2836, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4114, 3183, 1995, 2674, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4115, 3160, 1757, 2706, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4116, 3310, 1635, 2704, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4117, 3119, 1880, 2622, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4118, 3231, 1945, 2644, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4119, 3237, 1971, 2559, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4120, 3215, 1561, 2932, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4121, 3172, 1870, 2589, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4122, 3246, 1950, 2634, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4123, 3162, 1981, 2527, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4124, 3457, 1656, 2893, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4125, 3461, 1978, 2603, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4126, 3029, 1599, 2545, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4127, 3271, 1665, 2945, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4128, 3363, 1925, 2897, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4129, 3205, 1878, 2825, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4130, 3033, 1960, 2923, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4131, 3335, 1569, 2544, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4132, 3388, 1768, 2674, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4133, 3272, 1990, 2811, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4134, 3241, 1714, 2774, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4135, 3476, 1677, 2939, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4136, 3483, 1872, 2604, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4137, 3071, 1530, 2968, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4138, 3039, 1511, 2932, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4139, 3176, 1900, 2953, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4140, 3139, 1587, 2777, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4141, 3067, 1787, 2812, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4142, 3405, 1871, 2824, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4143, 3294, 1927, 2668, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4144, 3180, 1845, 2885, 22);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4145, 3433, 1530, 2806, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4146, 3212, 1571, 2721, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4147, 3010, 1762, 2918, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4148, 3360, 1542, 2949, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4149, 3100, 1539, 2952, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4150, 3399, 1552, 2903, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4151, 3049, 1567, 2584, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4152, 3465, 1925, 2826, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4153, 3066, 1809, 2651, 30);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4154, 3221, 1740, 2613, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4155, 3072, 1984, 2598, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4156, 3218, 1888, 2765, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4157, 3039, 1936, 2837, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4158, 3382, 1746, 2783, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4159, 3073, 1658, 2552, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4160, 3230, 1576, 2914, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4161, 3342, 1661, 2717, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4162, 3346, 1998, 2888, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4163, 3165, 1849, 2895, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4164, 3396, 1572, 2853, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4165, 3281, 1610, 2769, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4166, 3212, 1550, 2599, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4167, 3285, 1883, 2645, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4168, 3243, 1849, 2504, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4169, 3090, 1979, 2740, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4170, 3010, 1618, 2907, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4171, 3299, 1674, 2856, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4172, 3276, 1814, 2926, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4173, 3473, 1540, 2754, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4174, 3386, 1701, 2713, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4175, 3038, 1754, 2847, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4176, 3172, 1662, 2990, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4177, 3409, 1764, 2827, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4178, 3373, 1977, 2887, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4179, 3478, 1524, 2862, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4180, 3437, 1932, 2782, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4181, 3260, 1737, 2606, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4182, 3196, 1564, 2632, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4183, 3385, 1802, 2544, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4184, 3250, 1724, 2877, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4185, 3075, 1767, 2651, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4186, 3224, 1737, 2538, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4187, 3108, 1575, 2726, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4188, 3160, 1903, 2990, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4189, 3463, 1754, 2944, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4190, 3134, 1737, 2964, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4191, 3237, 1662, 2811, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4192, 3276, 1598, 2815, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4193, 3431, 1859, 2694, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4194, 3332, 1806, 2999, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4195, 3081, 1578, 2556, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4196, 3056, 1618, 2762, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4197, 3358, 1858, 2880, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4198, 3266, 1994, 2731, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4199, 3356, 1883, 2977, 16);
commit;
prompt 200 records committed...
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4200, 3376, 1537, 2844, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4201, 3282, 1719, 2679, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4202, 3423, 1701, 2600, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4203, 3292, 1612, 2530, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4204, 3063, 1895, 2838, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4205, 3489, 1578, 2871, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4206, 3089, 1971, 2623, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4207, 3482, 1846, 2986, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4208, 3130, 1727, 2911, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4209, 3175, 1521, 2549, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4210, 3121, 1572, 2739, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4211, 3197, 1638, 2697, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4212, 3449, 1807, 2562, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4213, 3245, 1809, 2645, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4214, 3384, 1577, 2798, 22);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4215, 3199, 1890, 2723, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4216, 3255, 1821, 2579, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4217, 3065, 1555, 2784, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4218, 3487, 1878, 2771, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4219, 3072, 1504, 2756, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4220, 3308, 1870, 2671, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4221, 3090, 1863, 2948, 22);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4222, 3169, 1519, 2650, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4223, 3378, 1752, 2753, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4224, 3347, 1838, 2672, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4225, 3263, 1560, 2670, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4227, 3360, 1839, 2958, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4228, 3006, 1796, 2781, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4229, 3126, 1903, 2610, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4230, 3299, 1846, 2899, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4231, 3034, 1934, 2885, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4232, 3307, 1842, 2689, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4233, 3419, 1648, 2578, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4234, 3360, 1956, 2945, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4235, 3176, 1502, 2527, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4236, 3237, 1610, 2660, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4237, 3163, 1562, 2619, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4238, 3008, 1966, 2891, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4239, 3469, 1862, 2824, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4240, 3417, 1927, 2986, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4241, 3413, 1660, 2961, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4242, 3262, 1550, 2618, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4243, 3265, 1917, 2599, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4244, 3223, 1612, 2930, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4245, 3386, 1870, 2857, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4246, 3061, 1719, 2848, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4247, 3363, 1702, 2885, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4248, 3416, 1501, 2743, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4249, 3176, 1502, 2674, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4250, 3419, 1541, 2873, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4251, 3383, 1711, 2550, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4252, 3175, 1788, 2843, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4253, 3420, 1685, 2776, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4254, 3320, 1712, 2952, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4255, 3145, 1976, 2652, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4256, 3101, 1807, 2713, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4257, 3341, 1501, 2648, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4258, 3412, 1960, 2675, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4259, 3447, 1565, 2857, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4260, 3104, 1661, 2650, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4261, 3009, 1510, 2921, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4263, 3107, 1986, 2780, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4264, 3054, 1909, 2888, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4265, 3005, 1709, 2807, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4266, 3296, 1759, 2990, 30);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4267, 3139, 1963, 2712, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4268, 3190, 1619, 2551, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4269, 3219, 1902, 2954, 22);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4270, 3408, 1542, 2562, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4271, 3348, 1973, 2893, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4272, 3083, 1688, 2507, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4273, 3020, 1527, 2905, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4274, 3340, 1527, 2945, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4275, 3069, 1811, 2555, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4276, 3221, 1775, 2612, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4277, 3078, 1701, 2836, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4278, 3326, 1515, 2534, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4279, 3118, 1820, 2690, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4280, 3132, 1632, 2566, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4281, 3420, 1810, 2943, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4282, 3252, 1594, 2784, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4283, 3033, 1846, 2685, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4284, 3377, 1509, 2866, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4285, 3239, 1851, 2869, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4286, 3058, 1599, 2617, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4287, 3466, 1720, 2662, 30);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4288, 3431, 1619, 2902, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4289, 3079, 1609, 2852, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4290, 3329, 1709, 2799, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4291, 3418, 1628, 2625, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4292, 3144, 1686, 2788, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4293, 3371, 1655, 2924, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4294, 3425, 1695, 2636, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4295, 3070, 1905, 2814, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4296, 3388, 1840, 2781, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4297, 3450, 1898, 2636, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4298, 3295, 1586, 2769, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4299, 3328, 1917, 2538, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4300, 3194, 1603, 2706, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4301, 3184, 1686, 2668, 24);
commit;
prompt 300 records committed...
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4302, 3040, 1745, 2844, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4303, 3394, 1718, 2746, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4304, 3447, 1821, 2622, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4305, 3314, 1904, 2848, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4306, 3179, 1589, 2908, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4307, 3207, 1779, 2729, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4308, 3145, 1902, 2826, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4309, 3311, 1597, 2884, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4310, 3035, 1518, 2819, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4311, 3156, 1643, 2551, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4312, 3205, 1530, 2696, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4313, 3138, 1875, 2912, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4314, 3300, 1604, 2635, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4315, 3007, 1702, 2697, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4316, 3137, 1588, 2511, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4317, 3002, 1528, 2681, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4318, 3020, 1896, 2815, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4319, 3355, 1541, 2979, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4320, 3205, 1954, 2657, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4321, 3338, 1773, 2922, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4322, 3234, 1840, 2586, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4323, 3236, 1516, 2891, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4324, 3130, 1722, 2883, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4325, 3487, 1787, 2502, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4326, 3456, 1817, 2615, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4327, 3183, 1722, 2785, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4328, 3175, 1955, 2927, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4329, 3032, 1802, 2774, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4330, 3472, 1611, 2645, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4331, 3366, 1863, 2637, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4332, 3234, 1976, 2540, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4333, 3484, 1821, 2966, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4334, 3154, 1807, 2949, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4335, 3373, 1820, 2645, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4336, 3018, 1630, 2685, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4337, 3386, 1868, 2547, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4338, 3425, 1904, 2990, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4339, 3432, 1996, 2622, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4340, 3490, 1707, 2698, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4341, 3259, 1690, 2865, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4342, 3018, 1900, 2619, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4343, 3468, 1979, 2846, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4344, 3450, 1539, 2721, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4345, 3079, 1659, 2666, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4346, 3256, 1950, 2884, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4347, 3121, 1784, 2697, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4348, 3224, 1657, 2908, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4349, 3061, 1695, 2722, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4350, 3124, 1665, 2749, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4351, 3303, 1544, 2561, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4352, 3198, 1862, 2959, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4353, 3179, 1760, 2867, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4354, 3495, 1600, 2558, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4355, 3172, 1967, 2550, 8);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4356, 3309, 1944, 2948, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4357, 3420, 1649, 2794, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4358, 3318, 1947, 2803, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4359, 3314, 1873, 2811, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4360, 3415, 1814, 2987, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4361, 3218, 1648, 2543, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4362, 3095, 1711, 2998, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4363, 3119, 1854, 2643, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4364, 3019, 1509, 2534, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4365, 3183, 1790, 2522, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4366, 3263, 1687, 2885, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4368, 3412, 1606, 2534, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4369, 3023, 1707, 2971, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4370, 3296, 1955, 2591, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4371, 3463, 1838, 2837, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4372, 3095, 1588, 2548, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4373, 3407, 1522, 2547, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4374, 3147, 1954, 2547, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4375, 3024, 1651, 2715, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4376, 3080, 1833, 2769, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4377, 3109, 1671, 2833, 18);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4378, 3290, 1555, 2899, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4379, 3373, 1765, 2986, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4380, 3014, 1595, 2539, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4381, 3170, 1513, 2954, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4382, 3185, 1911, 2674, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4383, 3080, 1542, 2630, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4384, 3087, 1891, 2831, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4385, 3012, 1952, 2587, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4386, 3311, 1963, 2653, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4387, 3048, 1603, 2634, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4388, 3190, 1656, 2857, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4389, 3430, 1913, 2793, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4390, 3029, 1890, 2965, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4391, 3109, 1970, 2841, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4392, 3091, 1927, 2624, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4393, 3492, 1531, 2879, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4394, 3483, 1919, 2724, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4395, 3436, 1777, 2503, 37);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4396, 3085, 1745, 2856, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4397, 3349, 1921, 2846, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4398, 3430, 1951, 2718, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4399, 3009, 1826, 2680, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4400, 3237, 1811, 2942, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4401, 3112, 1865, 2719, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4402, 3320, 1551, 2558, 39);
commit;
prompt 400 records committed...
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4403, 3282, 1512, 2750, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4404, 3186, 1559, 2789, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4405, 3139, 1525, 2677, 35);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4406, 3423, 1563, 2551, 31);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4407, 3019, 1530, 2808, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4408, 3018, 1577, 2750, 23);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4409, 3116, 1654, 2777, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4410, 3411, 1598, 2541, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4411, 3210, 1919, 2967, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4412, 3164, 1658, 2914, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4413, 3174, 1741, 2731, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4414, 3146, 1513, 2932, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4415, 3372, 1991, 2517, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4416, 3091, 1803, 2788, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4417, 3330, 1936, 2844, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4418, 3439, 1896, 2510, 7);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4419, 3052, 1783, 2787, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4420, 3270, 1720, 2501, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4421, 3157, 1613, 2633, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4422, 3495, 1748, 2873, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4423, 3326, 1511, 2972, 38);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4424, 3252, 1886, 2885, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4425, 3110, 1823, 2898, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4426, 3061, 1751, 2726, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4427, 3338, 1648, 2989, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4428, 3399, 1509, 2681, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4429, 3118, 1867, 2806, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4430, 3359, 1848, 2534, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4431, 3185, 1778, 2532, 5);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4432, 3141, 1954, 2935, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4433, 3389, 1885, 2875, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4434, 3180, 1994, 2704, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4435, 3351, 1730, 2809, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4436, 3473, 1650, 2519, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4437, 3317, 1594, 2655, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4438, 3047, 1577, 2645, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4439, 3071, 1521, 2687, 39);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4440, 3025, 1606, 2991, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4441, 3471, 1514, 2891, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4442, 3225, 1602, 2642, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4443, 3317, 1640, 2801, 10);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4444, 3291, 1607, 2855, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4445, 3045, 1947, 2580, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4446, 3111, 1651, 2527, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4447, 3303, 1766, 2665, 24);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4448, 3186, 1824, 2662, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4449, 3242, 1973, 2520, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4450, 3315, 1868, 2967, 17);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4451, 3450, 1565, 2574, 34);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4452, 3287, 1526, 2500, 20);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4453, 3073, 1712, 2837, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4454, 3278, 1944, 2701, 40);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4455, 3130, 1746, 2730, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4456, 3133, 1619, 2803, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4457, 3476, 1976, 2809, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4458, 3014, 1890, 2545, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4459, 3339, 1633, 2878, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4460, 3205, 1685, 2853, 12);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4461, 3375, 1683, 2898, 22);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4462, 3466, 1927, 2829, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4463, 3497, 1700, 2522, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4464, 3087, 1640, 2843, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4465, 3454, 1601, 2601, 1);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4466, 3112, 1925, 2888, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4467, 3436, 1527, 2863, 4);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4468, 3050, 1767, 2841, 21);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4469, 3320, 1909, 2973, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4470, 3449, 1591, 2950, 33);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4471, 3447, 1802, 2738, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4472, 3368, 1597, 2739, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4473, 3440, 1579, 2950, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4474, 3309, 1982, 2617, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4475, 3236, 1865, 2971, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4476, 3367, 1580, 2728, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4477, 3118, 1969, 2747, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4478, 3300, 1581, 2994, 16);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4479, 3218, 1517, 2559, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4480, 3367, 1508, 2602, 36);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4481, 3137, 1675, 2906, 25);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4482, 3403, 1813, 2756, 2);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4483, 3111, 1514, 2663, 11);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4484, 3090, 1733, 2558, 27);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4485, 3297, 1507, 2668, 9);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4486, 3342, 1660, 2569, 6);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4487, 3023, 1532, 2725, 29);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4488, 3281, 1728, 2709, 15);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4489, 3390, 1798, 2547, 26);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4490, 3144, 1672, 2807, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4491, 3278, 1899, 2931, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4492, 3445, 1869, 2757, 3);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4493, 3181, 1612, 2688, 28);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4494, 3442, 1914, 2585, 30);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4495, 3085, 1854, 2934, 14);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4496, 3448, 1970, 2746, 32);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4497, 3483, 1758, 2904, 19);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4498, 3180, 1689, 2991, 13);
insert into ORDERS (order_id, supplier_id, employee_id, invoice_id, quantity)
values (4499, 3362, 1629, 2881, 17);
commit;
prompt 497 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6000, 1630, 4639.46, 'Grant', to_date('22-07-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6001, 1761, 6309.34, 'Salary', to_date('18-11-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6002, 1600, 4002.49, 'Grant', to_date('05-01-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6003, 1516, 6965.9, 'Bonus', to_date('02-03-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6004, 1861, 6653.62, 'Bonus', to_date('26-08-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6005, 1909, 9019.17, 'Salary', to_date('12-06-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6006, 1847, 6706.64, 'Salary', to_date('01-03-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6007, 1878, 5228.56, 'Grant', to_date('17-09-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6008, 1752, 3397.36, 'Bonus', to_date('17-04-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6009, 1637, 8637.19, 'Salary', to_date('21-10-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6010, 1526, 2507.39, 'Grant', to_date('14-03-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6011, 1681, 8196.98, 'Salary', to_date('09-08-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6012, 1500, 2327.49, 'Bonus', to_date('13-01-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6013, 1699, 7298.05, 'Salary', to_date('09-07-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6014, 1807, 4386.72, 'Salary', to_date('24-07-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6015, 1828, 3739.71, 'Grant', to_date('28-03-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6016, 1782, 3144.32, 'Grant', to_date('01-09-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6017, 1864, 7816.39, 'Salary', to_date('07-12-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6018, 1900, 5176.85, 'Grant', to_date('17-10-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6019, 1769, 5186.62, 'Grant', to_date('04-04-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6020, 1810, 9870.02, 'Salary', to_date('29-06-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6021, 1913, 9284.84, 'Bonus', to_date('03-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6022, 1627, 5475.12, 'Grant', to_date('01-12-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6023, 1622, 8591.32, 'Grant', to_date('29-12-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6024, 1914, 3372.97, 'Salary', to_date('13-02-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6025, 1786, 9807.81, 'Bonus', to_date('10-09-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6026, 1930, 1951.91, 'Bonus', to_date('29-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6027, 1921, 3467.37, 'Bonus', to_date('28-12-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6028, 1584, 1089.69, 'Salary', to_date('28-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6029, 1624, 2149.77, 'Bonus', to_date('04-03-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6030, 1666, 3610.77, 'Bonus', to_date('26-09-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6031, 1831, 2457.9, 'Grant', to_date('13-08-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6032, 1653, 3481.43, 'Salary', to_date('14-09-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6033, 1635, 8281.36, 'Grant', to_date('27-03-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6034, 1684, 2372.36, 'Bonus', to_date('19-06-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6035, 1620, 1951.14, 'Bonus', to_date('22-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6036, 1762, 8542.96, 'Salary', to_date('06-12-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6037, 1998, 4711.76, 'Bonus', to_date('29-06-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6038, 1917, 9487.97, 'Grant', to_date('13-08-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6039, 1975, 1512.83, 'Bonus', to_date('03-04-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6040, 1729, 1417.04, 'Grant', to_date('17-01-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6041, 1935, 4978.06, 'Salary', to_date('25-01-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6042, 1842, 4884.75, 'Bonus', to_date('16-05-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6043, 1968, 4819.92, 'Salary', to_date('26-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6044, 1685, 4612.45, 'Grant', to_date('19-07-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6045, 1862, 9604.76, 'Grant', to_date('27-11-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6046, 1637, 2687.43, 'Grant', to_date('20-06-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6047, 1811, 8165.92, 'Salary', to_date('18-12-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6048, 1952, 4609.85, 'Grant', to_date('15-10-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6049, 1785, 9182.55, 'Grant', to_date('21-12-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6050, 1798, 7917.34, 'Grant', to_date('26-06-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6051, 1775, 4905.69, 'Grant', to_date('04-06-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6052, 1784, 1225.14, 'Grant', to_date('17-02-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6053, 1541, 2807.04, 'Bonus', to_date('02-08-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6054, 1712, 4614.23, 'Grant', to_date('18-12-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6055, 1902, 2193.37, 'Salary', to_date('21-12-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6056, 1723, 6059.76, 'Bonus', to_date('11-02-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6057, 1652, 2760.8, 'Grant', to_date('24-10-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6058, 1508, 9818.01, 'Grant', to_date('14-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6059, 1869, 9021.42, 'Grant', to_date('27-10-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6060, 1907, 4429.09, 'Bonus', to_date('06-09-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6061, 1963, 1103.26, 'Salary', to_date('08-04-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6062, 1836, 6317.42, 'Bonus', to_date('01-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6063, 1527, 5035.39, 'Bonus', to_date('13-11-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6064, 1987, 5243.6, 'Salary', to_date('01-12-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6065, 1917, 5357.9, 'Salary', to_date('12-07-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6066, 1684, 2728.87, 'Bonus', to_date('23-01-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6067, 1797, 3888.07, 'Salary', to_date('15-10-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6068, 1842, 4831.97, 'Salary', to_date('12-11-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6069, 1894, 6923.79, 'Bonus', to_date('03-06-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6070, 1835, 2690.77, 'Salary', to_date('07-05-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6071, 1861, 3885.67, 'Bonus', to_date('21-10-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6072, 1752, 7603.61, 'Bonus', to_date('26-09-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6073, 1856, 5852.94, 'Grant', to_date('14-05-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6074, 1840, 8860.29, 'Grant', to_date('14-03-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6075, 1676, 2303.27, 'Salary', to_date('29-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6076, 1919, 4172.17, 'Bonus', to_date('20-01-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6077, 1685, 6173.46, 'Bonus', to_date('12-04-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6078, 1932, 6632.1, 'Bonus', to_date('26-03-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6079, 1819, 4068.47, 'Salary', to_date('14-08-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6080, 1941, 4115.8, 'Grant', to_date('10-08-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6081, 1770, 6299.24, 'Salary', to_date('22-10-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6082, 1991, 3847.32, 'Grant', to_date('03-08-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6083, 1690, 6397.69, 'Bonus', to_date('28-06-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6084, 1965, 4109.75, 'Grant', to_date('29-06-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6085, 1735, 5785.92, 'Grant', to_date('01-04-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6086, 1823, 5761.21, 'Salary', to_date('08-05-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6087, 1993, 3554.61, 'Salary', to_date('16-01-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6088, 1912, 4101.35, 'Salary', to_date('04-06-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6089, 1969, 1053.11, 'Bonus', to_date('03-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6090, 1589, 9691.51, 'Salary', to_date('17-05-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6091, 1606, 4616.15, 'Grant', to_date('12-04-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6092, 1754, 3316.99, 'Grant', to_date('02-01-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6093, 1937, 5754.45, 'Grant', to_date('01-09-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6094, 1555, 2936.41, 'Salary', to_date('28-07-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6095, 1973, 1672.83, 'Salary', to_date('20-10-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6096, 1560, 3073.35, 'Grant', to_date('01-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6097, 1932, 9436.24, 'Salary', to_date('26-10-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6098, 1517, 6403.97, 'Bonus', to_date('01-07-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6099, 1572, 3789.42, 'Bonus', to_date('07-08-2002', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6100, 1808, 6482.6, 'Grant', to_date('03-01-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6101, 1510, 6111.71, 'Grant', to_date('09-06-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6102, 1788, 4678.45, 'Salary', to_date('27-09-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6103, 1742, 9007.24, 'Salary', to_date('04-10-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6104, 1705, 3168.76, 'Salary', to_date('15-12-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6105, 1711, 4176.58, 'Salary', to_date('05-04-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6106, 1709, 3320.78, 'Salary', to_date('29-08-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6107, 1929, 7855.65, 'Salary', to_date('27-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6108, 1877, 6830.26, 'Bonus', to_date('11-10-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6109, 1630, 5643.14, 'Salary', to_date('10-10-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6110, 1739, 9440.25, 'Bonus', to_date('23-11-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6111, 1869, 8515.28, 'Salary', to_date('18-06-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6112, 1587, 5527.62, 'Grant', to_date('21-04-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6113, 1806, 9155.71, 'Grant', to_date('05-06-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6114, 1886, 7379.39, 'Salary', to_date('19-08-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6115, 1879, 8903.13, 'Salary', to_date('02-09-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6116, 1694, 4751.19, 'Bonus', to_date('07-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6117, 1658, 4896.4, 'Grant', to_date('17-03-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6118, 1767, 3967.59, 'Bonus', to_date('22-02-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6119, 1916, 2632.13, 'Salary', to_date('11-07-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6120, 1779, 9612.13, 'Grant', to_date('28-03-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6121, 1625, 3019.62, 'Bonus', to_date('11-06-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6122, 1937, 6051.87, 'Grant', to_date('06-09-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6123, 1772, 3331.15, 'Bonus', to_date('22-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6124, 1554, 4630.13, 'Bonus', to_date('28-10-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6125, 1629, 4931.99, 'Bonus', to_date('29-07-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6126, 1820, 5117.36, 'Salary', to_date('16-12-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6127, 1816, 2488.63, 'Bonus', to_date('13-05-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6128, 1511, 4502.03, 'Bonus', to_date('17-09-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6129, 1667, 1321.12, 'Salary', to_date('18-08-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6130, 1737, 7702.05, 'Salary', to_date('22-07-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6131, 1676, 3463.96, 'Salary', to_date('01-11-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6132, 1824, 1162.88, 'Grant', to_date('14-07-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6133, 1831, 4609.18, 'Bonus', to_date('08-10-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6134, 1623, 7021.13, 'Grant', to_date('26-03-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6135, 1796, 7182.96, 'Bonus', to_date('01-05-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6136, 1762, 5262.61, 'Salary', to_date('21-03-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6137, 1603, 2539.19, 'Bonus', to_date('01-05-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6138, 1841, 3340.08, 'Grant', to_date('06-08-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6139, 1980, 3584.27, 'Salary', to_date('12-03-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6140, 1906, 4608.4, 'Salary', to_date('14-03-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6141, 1677, 8704.24, 'Grant', to_date('01-06-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6142, 1792, 3582.27, 'Bonus', to_date('26-01-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6143, 1918, 1263.89, 'Grant', to_date('28-11-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6144, 1990, 2593.45, 'Bonus', to_date('06-08-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6145, 1617, 3750.05, 'Salary', to_date('08-09-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6146, 1547, 7455.88, 'Bonus', to_date('29-10-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6147, 1641, 7095.62, 'Grant', to_date('16-10-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6148, 1843, 7808.7, 'Salary', to_date('27-04-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6149, 1675, 3190.8, 'Salary', to_date('18-09-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6150, 1700, 6645.56, 'Bonus', to_date('28-02-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6151, 1739, 2902.14, 'Bonus', to_date('11-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6152, 1639, 8099.78, 'Bonus', to_date('14-01-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6153, 1772, 7021.11, 'Grant', to_date('07-12-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6154, 1942, 9835.17, 'Grant', to_date('08-08-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6155, 1980, 9487.55, 'Bonus', to_date('28-10-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6156, 1832, 9537.88, 'Grant', to_date('11-04-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6157, 1902, 5492.86, 'Salary', to_date('23-05-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6158, 1687, 5006.42, 'Grant', to_date('24-02-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6159, 1727, 7294.72, 'Bonus', to_date('05-11-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6160, 1928, 9465.59, 'Bonus', to_date('03-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6161, 1925, 2655.18, 'Salary', to_date('29-04-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6162, 1778, 8653.9, 'Salary', to_date('10-04-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6163, 1782, 2415.75, 'Salary', to_date('29-12-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6164, 1726, 1771.16, 'Bonus', to_date('08-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6165, 1508, 5572.22, 'Salary', to_date('03-10-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6166, 1794, 9073.82, 'Bonus', to_date('22-02-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6167, 1584, 9301.93, 'Bonus', to_date('27-08-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6168, 1561, 7982.99, 'Bonus', to_date('01-08-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6169, 1925, 1597.96, 'Bonus', to_date('20-06-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6170, 1506, 7428.24, 'Salary', to_date('21-06-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6171, 1842, 8500.18, 'Bonus', to_date('22-03-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6172, 1533, 1957.71, 'Bonus', to_date('27-11-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6173, 1925, 6025.9, 'Grant', to_date('27-10-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6174, 1813, 8777.16, 'Bonus', to_date('15-07-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6175, 1823, 6122.05, 'Bonus', to_date('23-11-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6176, 1668, 8270.91, 'Bonus', to_date('03-11-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6177, 1625, 4091.4, 'Salary', to_date('28-09-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6178, 1846, 6564.33, 'Grant', to_date('12-06-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6179, 1661, 9608.42, 'Bonus', to_date('27-02-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6180, 1768, 5205.78, 'Salary', to_date('14-03-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6181, 1958, 5598.84, 'Salary', to_date('06-06-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6182, 1569, 2933.98, 'Salary', to_date('22-05-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6183, 1724, 2758.61, 'Grant', to_date('01-10-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6184, 1739, 7418.84, 'Bonus', to_date('11-04-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6185, 1700, 2218.16, 'Bonus', to_date('18-04-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6186, 1948, 1001.02, 'Grant', to_date('05-11-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6187, 1881, 5030.02, 'Salary', to_date('24-01-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6188, 1741, 6871.91, 'Bonus', to_date('22-07-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6189, 1530, 2158.11, 'Grant', to_date('08-05-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6190, 1885, 4091.07, 'Bonus', to_date('20-12-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6191, 1786, 7929.44, 'Bonus', to_date('09-02-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6192, 1552, 1748.57, 'Grant', to_date('26-08-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6193, 1713, 9949.1, 'Salary', to_date('21-10-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6194, 1638, 4140.73, 'Grant', to_date('25-12-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6195, 1534, 5431.81, 'Salary', to_date('13-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6196, 1788, 6892.61, 'Grant', to_date('29-07-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6197, 1733, 1862.19, 'Salary', to_date('09-10-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6198, 1932, 2542.08, 'Grant', to_date('09-05-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6199, 1922, 3979.22, 'Bonus', to_date('16-01-2017', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6200, 1811, 6841.83, 'Salary', to_date('25-01-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6201, 1513, 9865.77, 'Grant', to_date('01-09-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6202, 1882, 2458.28, 'Bonus', to_date('07-06-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6203, 1884, 9353.54, 'Grant', to_date('24-04-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6204, 1653, 6054.62, 'Salary', to_date('06-11-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6205, 1915, 2093.57, 'Bonus', to_date('16-06-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6206, 1558, 8055.04, 'Grant', to_date('28-04-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6207, 1808, 2029.35, 'Salary', to_date('03-06-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6208, 1809, 7231.78, 'Grant', to_date('04-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6209, 1962, 8871.98, 'Salary', to_date('06-06-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6210, 1714, 8230.86, 'Bonus', to_date('24-11-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6211, 1877, 6052.01, 'Salary', to_date('19-10-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6212, 1630, 9506.61, 'Grant', to_date('19-11-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6213, 1574, 1480.9, 'Bonus', to_date('01-08-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6214, 1711, 9547.01, 'Bonus', to_date('14-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6215, 1755, 7803.98, 'Salary', to_date('23-08-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6216, 1505, 5988.11, 'Bonus', to_date('10-08-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6217, 1657, 5697.72, 'Salary', to_date('17-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6218, 1742, 8700.72, 'Salary', to_date('28-10-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6219, 1631, 7950.72, 'Grant', to_date('15-12-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6220, 1584, 3166.17, 'Bonus', to_date('08-10-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6221, 1687, 1343.46, 'Salary', to_date('01-05-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6222, 1603, 6695.21, 'Salary', to_date('16-10-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6223, 1718, 6494.7, 'Salary', to_date('19-09-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6224, 1974, 9045.18, 'Bonus', to_date('09-10-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6226, 1850, 2251.57, 'Salary', to_date('02-12-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6227, 1601, 3166.82, 'Salary', to_date('01-11-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6228, 1889, 2646.05, 'Grant', to_date('12-03-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6229, 1787, 5899.41, 'Salary', to_date('11-08-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6230, 1732, 8947.55, 'Grant', to_date('23-09-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6231, 1828, 3640.93, 'Salary', to_date('18-06-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6232, 1794, 2019.76, 'Grant', to_date('05-05-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6233, 1876, 3302.4, 'Grant', to_date('25-11-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6234, 1527, 6580.74, 'Bonus', to_date('06-07-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6235, 1824, 9955.96, 'Bonus', to_date('28-01-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6236, 1625, 9457.02, 'Bonus', to_date('11-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6237, 1839, 4517.79, 'Bonus', to_date('07-08-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6238, 1562, 2717.53, 'Bonus', to_date('02-05-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6239, 1948, 6973.71, 'Salary', to_date('24-03-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6240, 1801, 1976.8, 'Salary', to_date('27-10-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6241, 1843, 5732.35, 'Grant', to_date('22-06-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6242, 1873, 5874.61, 'Salary', to_date('12-02-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6243, 1746, 1344.46, 'Grant', to_date('06-08-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6244, 1974, 2485.1, 'Grant', to_date('05-01-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6245, 1932, 9595.76, 'Salary', to_date('18-01-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6246, 1670, 6707.91, 'Grant', to_date('07-05-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6247, 1858, 6022.19, 'Bonus', to_date('02-11-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6248, 1681, 4374.85, 'Salary', to_date('11-03-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6249, 1557, 5533.41, 'Salary', to_date('13-10-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6250, 1838, 3142.14, 'Bonus', to_date('21-03-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6251, 1933, 9031.38, 'Bonus', to_date('29-09-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6252, 1855, 7037.85, 'Grant', to_date('29-07-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6253, 1705, 7038.81, 'Grant', to_date('09-07-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6254, 1696, 8225.07, 'Salary', to_date('26-05-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6255, 1975, 1245.7, 'Salary', to_date('05-04-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6256, 1683, 1153.15, 'Grant', to_date('22-11-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6257, 1563, 5057, 'Salary', to_date('26-02-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6258, 1701, 2973.23, 'Bonus', to_date('23-05-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6259, 1689, 9686.85, 'Salary', to_date('24-04-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6260, 1718, 9013.95, 'Salary', to_date('25-03-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6261, 1598, 8769.72, 'Grant', to_date('05-09-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6262, 1516, 8480.27, 'Bonus', to_date('05-12-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6263, 1894, 9485.21, 'Bonus', to_date('18-03-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6264, 1825, 8309.88, 'Grant', to_date('29-10-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6265, 1539, 9095.72, 'Salary', to_date('04-08-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6266, 1870, 4083.58, 'Salary', to_date('28-09-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6267, 1715, 6550.69, 'Salary', to_date('04-07-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6268, 1683, 9893.06, 'Bonus', to_date('27-01-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6269, 1889, 7555.75, 'Salary', to_date('12-08-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6270, 1585, 2033.49, 'Grant', to_date('17-11-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6271, 1654, 8487.58, 'Bonus', to_date('02-02-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6272, 1907, 6900.58, 'Bonus', to_date('23-12-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6273, 1654, 5574.98, 'Salary', to_date('11-05-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6274, 1965, 3824.21, 'Salary', to_date('13-02-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6275, 1778, 8423.58, 'Salary', to_date('22-09-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6276, 1937, 8623.06, 'Grant', to_date('07-05-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6277, 1793, 3149.56, 'Bonus', to_date('01-11-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6278, 1666, 3486.08, 'Bonus', to_date('09-10-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6279, 1553, 8013.33, 'Salary', to_date('06-11-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6280, 1858, 6609.59, 'Grant', to_date('09-04-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6281, 1920, 3122.17, 'Grant', to_date('11-06-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6282, 1538, 2133.4, 'Bonus', to_date('13-04-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6283, 1710, 1769.08, 'Grant', to_date('19-12-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6284, 1941, 5457.97, 'Bonus', to_date('20-09-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6285, 1520, 2266.81, 'Grant', to_date('28-05-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6286, 1853, 4523.26, 'Salary', to_date('24-09-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6287, 1958, 2920.55, 'Salary', to_date('22-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6288, 1841, 8722.7, 'Bonus', to_date('01-06-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6289, 1566, 6730.79, 'Grant', to_date('05-03-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6290, 1526, 7771.34, 'Salary', to_date('07-02-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6291, 1782, 1640.08, 'Bonus', to_date('26-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6292, 1748, 3926.28, 'Salary', to_date('01-08-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6293, 1854, 4473, 'Bonus', to_date('14-05-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6294, 1824, 3792.36, 'Grant', to_date('04-08-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6295, 1657, 4940.54, 'Grant', to_date('26-11-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6296, 1793, 7385.04, 'Salary', to_date('17-10-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6297, 1994, 8814.95, 'Grant', to_date('22-07-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6298, 1618, 4990.17, 'Grant', to_date('21-01-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6299, 1566, 4810.91, 'Bonus', to_date('04-09-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6300, 1729, 5424.63, 'Grant', to_date('13-02-2014', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6301, 1765, 2423.45, 'Salary', to_date('21-03-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6302, 1509, 4717.67, 'Bonus', to_date('22-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6303, 1832, 8042.55, 'Bonus', to_date('19-05-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6304, 1542, 8680.83, 'Salary', to_date('21-12-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6305, 1946, 4554.37, 'Salary', to_date('03-06-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6306, 1966, 4385.82, 'Salary', to_date('17-07-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6307, 1864, 4086.91, 'Grant', to_date('09-11-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6308, 1526, 9096.83, 'Salary', to_date('22-02-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6309, 1757, 4031.67, 'Grant', to_date('26-09-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6310, 1686, 4614.79, 'Grant', to_date('29-06-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6311, 1512, 7749.38, 'Salary', to_date('23-10-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6312, 1852, 2689.52, 'Salary', to_date('28-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6313, 1780, 2254.87, 'Salary', to_date('17-07-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6314, 1923, 7886.58, 'Grant', to_date('28-08-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6315, 1699, 8836.74, 'Salary', to_date('03-12-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6316, 1962, 7760.25, 'Grant', to_date('17-05-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6317, 1557, 6521.31, 'Grant', to_date('04-10-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6318, 1994, 3124.92, 'Bonus', to_date('28-02-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6319, 1980, 5835.63, 'Salary', to_date('07-05-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6320, 1550, 9263.36, 'Bonus', to_date('29-04-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6321, 1632, 7487.98, 'Grant', to_date('13-10-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6322, 1605, 4075.14, 'Grant', to_date('20-05-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6323, 1630, 4440.24, 'Bonus', to_date('15-02-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6324, 1626, 2592.72, 'Bonus', to_date('06-03-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6325, 1634, 5247.07, 'Bonus', to_date('02-10-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6326, 1725, 6295.3, 'Grant', to_date('22-07-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6327, 1672, 2532.92, 'Bonus', to_date('11-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6328, 1598, 7793.73, 'Bonus', to_date('28-08-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6329, 1772, 3261.87, 'Bonus', to_date('25-08-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6330, 1804, 2707.52, 'Salary', to_date('22-02-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6331, 1566, 7183.93, 'Bonus', to_date('03-07-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6332, 1593, 7701.37, 'Salary', to_date('02-05-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6333, 1886, 2506.75, 'Salary', to_date('26-06-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6334, 1897, 6089.69, 'Grant', to_date('09-08-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6335, 1742, 4000.89, 'Grant', to_date('26-07-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6336, 1893, 6057.36, 'Bonus', to_date('06-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6337, 1787, 6481.97, 'Bonus', to_date('26-12-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6338, 1555, 6153.8, 'Salary', to_date('05-11-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6339, 1884, 1464.31, 'Salary', to_date('13-09-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6340, 1640, 3616.05, 'Salary', to_date('12-03-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6341, 1546, 2296.5, 'Grant', to_date('15-10-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6342, 1834, 9688.5, 'Grant', to_date('16-05-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6343, 1616, 8788.25, 'Grant', to_date('26-12-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6344, 1597, 6424.33, 'Salary', to_date('20-04-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6345, 1974, 8005.99, 'Grant', to_date('09-06-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6346, 1670, 6106.07, 'Salary', to_date('17-06-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6347, 1717, 1582.67, 'Grant', to_date('08-07-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6348, 1632, 7546.86, 'Bonus', to_date('14-02-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6349, 1696, 2029.46, 'Salary', to_date('26-07-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6350, 1858, 1365.32, 'Bonus', to_date('27-07-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6351, 1716, 6970.25, 'Salary', to_date('19-11-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6352, 1719, 7865.44, 'Salary', to_date('18-02-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6353, 1626, 6820.52, 'Grant', to_date('05-09-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6354, 1973, 2069.25, 'Salary', to_date('13-05-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6355, 1718, 2495.83, 'Grant', to_date('28-02-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6356, 1792, 6691.3, 'Bonus', to_date('25-10-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6357, 1912, 9539.04, 'Bonus', to_date('22-06-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6358, 1923, 7248.79, 'Bonus', to_date('18-11-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6359, 1629, 3642.93, 'Bonus', to_date('08-03-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6360, 1722, 3477.18, 'Bonus', to_date('24-02-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6361, 1790, 6074.96, 'Salary', to_date('20-11-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6362, 1876, 7887.44, 'Salary', to_date('27-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6363, 1674, 5115.2, 'Grant', to_date('13-08-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6364, 1886, 1169.9, 'Grant', to_date('22-03-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6365, 1833, 6263.85, 'Bonus', to_date('11-02-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6366, 1968, 9401.66, 'Grant', to_date('01-11-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6367, 1599, 2476.34, 'Grant', to_date('01-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6368, 1811, 6676.17, 'Grant', to_date('05-12-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6369, 1794, 2325.9, 'Bonus', to_date('20-04-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6370, 1866, 8085.29, 'Grant', to_date('03-06-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6371, 1523, 4109.7, 'Grant', to_date('20-05-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6372, 1746, 8685.35, 'Salary', to_date('26-09-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6373, 1999, 7238.01, 'Salary', to_date('22-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6374, 1808, 1281.25, 'Grant', to_date('13-01-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6375, 1646, 8184.77, 'Salary', to_date('01-10-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6376, 1713, 7121.71, 'Grant', to_date('13-02-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6377, 1812, 5872.87, 'Bonus', to_date('07-08-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6378, 1863, 3479.51, 'Bonus', to_date('18-01-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6379, 1671, 1879.13, 'Bonus', to_date('24-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6380, 1543, 7971.52, 'Grant', to_date('23-06-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6381, 1621, 2815.74, 'Grant', to_date('12-11-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6382, 1787, 8162.23, 'Salary', to_date('24-02-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6383, 1806, 8694.36, 'Grant', to_date('25-03-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6384, 1658, 4492.09, 'Salary', to_date('03-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6385, 1859, 9680.44, 'Bonus', to_date('16-01-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6386, 1957, 5249.14, 'Bonus', to_date('15-01-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6387, 1528, 9603.39, 'Bonus', to_date('11-01-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6388, 1631, 1072.28, 'Grant', to_date('16-03-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6389, 1721, 4417.5, 'Salary', to_date('03-07-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6390, 1843, 8085.18, 'Salary', to_date('22-06-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6391, 1960, 3868.06, 'Salary', to_date('08-06-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6392, 1740, 3717.03, 'Salary', to_date('23-03-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6393, 1538, 4218.84, 'Grant', to_date('07-09-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6394, 1587, 6891.4, 'Bonus', to_date('04-04-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6395, 1806, 1616.68, 'Salary', to_date('15-03-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6396, 1878, 5133.42, 'Grant', to_date('07-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6397, 1686, 8376.97, 'Grant', to_date('26-09-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6398, 1932, 1216.15, 'Bonus', to_date('20-10-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6399, 1616, 5309.47, 'Salary', to_date('21-04-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6400, 1620, 9180.11, 'Grant', to_date('26-09-2023', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6401, 1527, 4456.06, 'Salary', to_date('13-10-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6402, 1782, 5702.37, 'Grant', to_date('13-07-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6403, 1905, 3293.31, 'Bonus', to_date('17-11-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6404, 1833, 5604.99, 'Grant', to_date('20-11-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6405, 1512, 6400.55, 'Grant', to_date('11-06-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6406, 1731, 2643.49, 'Salary', to_date('08-11-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6407, 1910, 1701.45, 'Grant', to_date('29-04-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6408, 1511, 1844.52, 'Bonus', to_date('29-08-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6409, 1735, 3968.19, 'Salary', to_date('26-07-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6410, 1974, 7075.07, 'Salary', to_date('14-12-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6411, 1877, 4477.58, 'Grant', to_date('18-05-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6412, 1887, 2882.43, 'Bonus', to_date('21-02-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6413, 1509, 2931.64, 'Grant', to_date('14-05-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6414, 1801, 4553.18, 'Bonus', to_date('07-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6415, 1819, 2214.23, 'Bonus', to_date('21-01-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6416, 1723, 2986.51, 'Bonus', to_date('05-05-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6417, 1830, 8112.5, 'Bonus', to_date('24-07-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6418, 1572, 5377.18, 'Grant', to_date('07-01-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6419, 1845, 8271.52, 'Grant', to_date('25-07-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6420, 1509, 1693.97, 'Grant', to_date('10-11-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6421, 1772, 1121.49, 'Grant', to_date('13-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6422, 1781, 1622.66, 'Grant', to_date('08-02-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6423, 1726, 5064.4, 'Salary', to_date('08-12-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6424, 1943, 4490.58, 'Bonus', to_date('03-12-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6425, 1612, 4119.78, 'Grant', to_date('08-07-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6426, 1739, 6781.93, 'Salary', to_date('20-02-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6427, 1814, 6102.59, 'Grant', to_date('19-02-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6428, 1590, 4135.38, 'Salary', to_date('02-05-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6429, 1696, 5126.62, 'Bonus', to_date('10-11-2013', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6430, 1987, 2725.27, 'Grant', to_date('05-05-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6431, 1610, 3537.49, 'Bonus', to_date('16-02-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6432, 1727, 9819.77, 'Grant', to_date('01-06-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6433, 1942, 5319.49, 'Grant', to_date('11-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6434, 1934, 2019.88, 'Grant', to_date('08-07-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6435, 1519, 4431.55, 'Bonus', to_date('16-08-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6436, 1896, 8320.56, 'Bonus', to_date('10-03-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6437, 1844, 4936.05, 'Grant', to_date('19-11-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6438, 1865, 6649.43, 'Grant', to_date('26-12-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6439, 1818, 3291.22, 'Salary', to_date('07-12-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6440, 1780, 8614.55, 'Salary', to_date('25-07-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6441, 1700, 5820.23, 'Bonus', to_date('12-01-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6442, 1929, 1227.33, 'Grant', to_date('09-12-2000', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6443, 1877, 8802.49, 'Salary', to_date('18-11-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6444, 1720, 3092.75, 'Salary', to_date('09-12-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6445, 1762, 8798.92, 'Grant', to_date('04-09-2020', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6446, 1948, 4465.89, 'Bonus', to_date('03-02-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6447, 1721, 4509.12, 'Grant', to_date('19-04-2001', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6448, 1877, 5902.49, 'Salary', to_date('13-05-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6449, 1683, 7390.66, 'Grant', to_date('21-04-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6450, 1995, 4635.28, 'Salary', to_date('08-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6451, 1975, 1051.66, 'Salary', to_date('24-05-2021', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6452, 1888, 2210.67, 'Bonus', to_date('08-09-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6453, 1913, 4178.7, 'Grant', to_date('13-06-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6454, 1621, 2379.8, 'Grant', to_date('20-09-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6455, 1995, 2462.98, 'Bonus', to_date('04-06-2015', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6456, 1697, 9550.01, 'Salary', to_date('09-11-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6457, 1521, 2228.55, 'Bonus', to_date('27-05-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6458, 1811, 4658.91, 'Salary', to_date('15-06-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6459, 1670, 1573.66, 'Grant', to_date('14-12-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6460, 1760, 2849.35, 'Bonus', to_date('09-11-2003', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6461, 1794, 3765.67, 'Bonus', to_date('20-02-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6462, 1643, 3561.1, 'Salary', to_date('06-07-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6463, 1806, 9664.86, 'Salary', to_date('26-07-2014', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6464, 1594, 4249.69, 'Grant', to_date('04-09-2011', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6465, 1616, 4637.13, 'Grant', to_date('28-11-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6466, 1612, 8079.07, 'Bonus', to_date('15-05-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6467, 1940, 2126.6, 'Salary', to_date('24-04-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6468, 1554, 8068.74, 'Grant', to_date('01-11-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6469, 1571, 3772.68, 'Bonus', to_date('16-09-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6470, 1628, 9394.18, 'Salary', to_date('27-01-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6471, 1707, 4913.51, 'Grant', to_date('26-02-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6472, 1949, 8715.92, 'Salary', to_date('22-09-2018', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6473, 1731, 7868.07, 'Grant', to_date('16-07-2005', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6474, 1872, 8594.89, 'Bonus', to_date('14-12-2010', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6475, 1842, 5439.85, 'Salary', to_date('14-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6476, 1595, 9824.66, 'Salary', to_date('23-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6477, 1711, 4323.02, 'Salary', to_date('15-06-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6478, 1798, 4221.98, 'Grant', to_date('12-07-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6479, 1996, 8649.59, 'Salary', to_date('09-06-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6480, 1889, 2839.1, 'Bonus', to_date('29-06-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6481, 1970, 5254.13, 'Grant', to_date('27-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6482, 1840, 9951.65, 'Salary', to_date('13-05-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6483, 1761, 2966.09, 'Bonus', to_date('18-10-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6484, 1700, 2724.84, 'Grant', to_date('13-10-2016', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6485, 1708, 3749.89, 'Bonus', to_date('28-05-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6486, 1706, 8861.16, 'Bonus', to_date('19-02-2019', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6487, 1719, 6780.17, 'Grant', to_date('10-05-2007', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6488, 1877, 8309.82, 'Bonus', to_date('25-10-2017', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6489, 1810, 1231.75, 'Bonus', to_date('14-11-2004', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6490, 1839, 1665.21, 'Bonus', to_date('17-08-2024', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6491, 1644, 8654.44, 'Bonus', to_date('29-01-2009', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6492, 1605, 6910.66, 'Grant', to_date('28-11-2012', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6493, 1717, 1961.57, 'Bonus', to_date('25-02-2008', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6494, 1800, 8610.03, 'Grant', to_date('21-07-2002', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6495, 1961, 1683.66, 'Grant', to_date('21-09-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6496, 1547, 7322.02, 'Grant', to_date('06-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6497, 1887, 6964.48, 'Salary', to_date('19-05-2025', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6498, 1920, 5926.73, 'Salary', to_date('01-05-2006', 'dd-mm-yyyy'));
insert into PAYMENT (payment_id, employee_id, amount, payment_purpose, payment_date)
values (6499, 1513, 3930.69, 'Grant', to_date('19-12-2005', 'dd-mm-yyyy'));
commit;
prompt 499 records loaded
prompt Loading SUBJECTS_TAUGHT...
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('VAlgebra I', 54, 42, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Algebra II', 79, 32, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('American History', 99, 22, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Anatomy', 36, 23, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Ancient Civilizations', 35, 22, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Anthropology', 88, 37, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Biology', 48, 20, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Calculus AB', 39, 33, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Calculus BC', 83, 23, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Chemistry', 53, 50, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP English Language', 9, 32, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP English Literature', 45, 27, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Environmental Science', 60, 49, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP European History', 50, 48, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP French', 38, 33, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Government', 8, 42, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Human Geography', 4, 34, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Macroeconomics', 89, 11, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Microeconomics', 13, 44, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Physics 1', 29, 46, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Physics 2', 54, 49, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Physics C', 85, 28, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Psychology', 92, 41, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Spanish', 37, 20, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Statistics', 64, 16, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP Studio Art', 30, 45, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP US Government', 86, 10, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP US History', 79, 41, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('AP World History', 70, 19, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Archaeology', 6, 42, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Architecture', 19, 14, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Art History', 47, 42, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Astronomy', 62, 16, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Band', 9, 18, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Biochemistry', 44, 35, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Biology', 75, 11, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Biotechnology', 69, 40, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Botany', 6, 39, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Business Studies', 92, 35, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Calculus', 60, 18, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Chemistry', 29, 44, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Choir', 16, 26, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Civics', 50, 35, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Computer Programming', 66, 31, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Computer Science', 66, 47, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Creative Writing', 97, 13, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Criminal Justice', 60, 41, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Culinary Arts', 28, 30, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Dance', 61, 11, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Debate', 63, 41, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Digital Art', 80, 25, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Drama', 68, 48, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Earth Science', 41, 36, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Economics', 25, 46, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Engineering', 75, 16, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('English Composition', 35, 49, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('English Literature', 67, 41, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Environmental Science', 53, 41, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('European History', 88, 15, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Film Studies', 92, 36, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Finance', 51, 40, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Forensic Science', 75, 15, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('French I', 38, 39, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('French II', 89, 14, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('French III', 57, 34, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('French IV', 19, 35, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Geography', 98, 37, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Geology', 21, 16, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Geometry', 35, 34, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('German I', 28, 15, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('German II', 49, 49, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('German III', 62, 34, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('German IV', 95, 40, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Graphic Design', 44, 29, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Health', 100, 37, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('History of Art', 77, 29, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Human Anatomy', 73, 16, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Information Technology', 63, 21, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Japanese I', 35, 28, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Japanese II', 82, 24, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Japanese III', 41, 34, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Japanese IV', 96, 11, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Journalism', 83, 17, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Latin I', 34, 35, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Latin II', 28, 20, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Latin III', 3, 22, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Latin IV', 94, 34, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Law', 79, 13, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Literature', 13, 45, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marine Biology', 53, 11, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marketing', 31, 32, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Mathematics', 26, 21, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Mechanical Engineering', 46, 46, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Media Studies', 26, 39, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Meteorology', 70, 37, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Microbiology', 36, 33, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music Appreciation', 98, 47, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music Theory', 35, 41, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Nutrition', 38, 43, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Oceanography', 7, 16, 5);
commit;
prompt 100 records committed...
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Orchestra', 84, 41, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Organic Chemistry', 7, 28, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Philosophy', 88, 48, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Photography', 6, 49, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physical Education', 9, 31, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physical Science', 97, 39, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physics', 45, 50, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physiology', 97, 23, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Political Science', 50, 43, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Pre-Algebra', 77, 26, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Pre-Calculus', 20, 34, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Psychology', 23, 42, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Public Speaking', 10, 25, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Robotics', 11, 40, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Russian I', 78, 14, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Russian II', 15, 40, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Russian III', 53, 29, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Russian IV', 58, 45, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sociology', 72, 32, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Spanish I', 34, 16, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Spanish II', 15, 10, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Spanish III', 39, 40, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Spanish IV', 75, 22, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Statistics', 23, 23, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Studio Art', 46, 12, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Theater', 29, 17, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Trigonometry', 76, 13, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('US Government', 73, 23, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('US History', 28, 19, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Web Design', 79, 16, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('World Geography', 26, 12, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('World History', 14, 35, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('World Literature', 84, 16, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Writing', 57, 10, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Zoology', 12, 28, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Accounting', 45, 47, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Advertising', 43, 22, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Aerospace Engineering', 71, 20, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Agriculture', 13, 19, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Algebra III', 3, 18, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Ancient History', 81, 42, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Animal Science', 15, 28, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Arabic I', 89, 24, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Arabic II', 27, 37, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Arabic III', 92, 49, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Arabic IV', 93, 29, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Art', 86, 28, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Asian History', 55, 34, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Banking', 96, 30, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Business', 98, 45, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Calculus I', 32, 27, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Calculus II', 81, 19, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Calculus III', 71, 24, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Career Development', 63, 22, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Chemistry I', 77, 10, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Chemistry II', 53, 31, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Chemistry III', 3, 13, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Child Development', 95, 49, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Classical Studies', 71, 40, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Coding', 96, 33, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Communications', 68, 12, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Comparative Government', 51, 13, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Computer Graphics', 88, 29, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Computer Networking', 23, 21, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Computer Repair', 6, 36, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Construction', 31, 24, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Cosmetology', 6, 37, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Creative Arts', 80, 23, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Criminal Law', 61, 44, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Culinary Skills', 55, 50, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Cybersecurity', 52, 12, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Dance I', 18, 45, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Dance II', 22, 16, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Dance III', 38, 37, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Dance IV', 57, 11, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Database Management', 31, 44, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Design', 2, 47, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Digital Media', 85, 14, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Drama I', 2, 11, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Drama II', 77, 48, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Drama III', 63, 32, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Drama IV', 37, 23, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Earth and Space Science', 31, 12, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Economics I', 65, 13, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Economics II', 87, 37, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Electrical Engineering', 42, 45, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Electronics', 63, 22, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Elementary Algebra', 77, 26, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Emergency Management', 83, 49, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Engineering Design', 40, 33, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('English I', 64, 48, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('English II', 39, 33, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('English III', 18, 45, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('English IV', 52, 10, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Environmental Engineering', 87, 38, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Ethics', 12, 18, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('European Literature', 65, 19, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Fashion Design', 62, 27, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Film Making', 83, 37, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Finance I', 75, 35, 1);
commit;
prompt 200 records committed...
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Finance II', 54, 23, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Financial Accounting', 60, 47, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Fine Arts', 62, 38, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Fire Science', 6, 48, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Fitness', 51, 31, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Food Science', 82, 49, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Forensic Psychology', 43, 47, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('French Literature', 16, 27, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Game Design', 8, 29, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Gender Studies', 43, 42, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('General Science', 37, 18, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Genetics', 78, 20, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Geometry I', 38, 48, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Geometry II', 33, 46, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Government', 41, 41, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Graphic Arts', 10, 48, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Greek I', 84, 34, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Greek II', 81, 33, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Greek III', 34, 39, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Greek IV', 20, 50, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Health Education', 84, 42, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Horticulture', 55, 22, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Hospitality', 77, 39, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Human Geography', 1, 28, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Human Services', 1, 13, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Humanities', 31, 17, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Industrial Design', 53, 20, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Information Systems', 2, 42, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Interior Design', 67, 44, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('International Business', 63, 41, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('International Relations', 42, 31, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('International Studies', 84, 36, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Journalism I', 3, 50, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Journalism II', 40, 44, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Journalism III', 87, 34, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Journalism IV', 79, 42, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Kinesiology', 73, 18, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Law Enforcement', 4, 22, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Legal Studies', 86, 15, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Linguistics', 9, 24, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Logic', 7, 24, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Macroeconomics', 41, 40, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Management', 29, 11, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Manufacturing', 66, 14, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marine Science', 44, 39, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marketing I', 99, 28, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marketing II', 5, 38, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marketing III', 20, 27, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Marketing IV', 80, 31, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Mass Communication', 60, 41, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Materials Science', 75, 33, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Mechanical Design', 60, 11, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Media Production', 83, 43, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Medieval History', 81, 45, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Meteorology I', 32, 32, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Meteorology II', 45, 22, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Microeconomics', 96, 37, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Molecular Biology', 91, 44, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music History', 88, 29, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music I', 70, 41, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music II', 2, 17, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music III', 94, 38, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Music IV', 56, 45, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Nanotechnology', 66, 22, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Natural Resources', 55, 35, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Naval Science', 68, 47, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Networking', 69, 43, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Nutrition I', 70, 33, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Nutrition II', 71, 38, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Nutrition III', 70, 26, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Nutrition IV', 98, 19, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Occupational Therapy', 77, 35, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Ocean Science', 45, 42, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Organizational Behavior', 56, 28, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Painting', 7, 31, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Paralegal Studies', 9, 21, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Personal Finance', 47, 43, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Pharmacology', 28, 20, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Philosophy I', 89, 28, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Philosophy II', 64, 33, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Philosophy III', 18, 13, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Philosophy IV', 70, 32, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Photography I', 20, 41, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Photography II', 3, 10, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Photography III', 56, 36, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Photography IV', 29, 28, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physical Education I', 100, 44, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physical Education II', 76, 20, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physical Education III', 48, 25, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physical Education IV', 6, 15, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physics I', 9, 33, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physics II', 82, 22, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physics III', 7, 50, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Physics IV', 26, 38, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Political Science I', 5, 38, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Political Science II', 69, 50, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Political Science III', 4, 29, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Political Science IV', 20, 18, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Programming', 58, 19, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Project Management', 83, 38, 5);
commit;
prompt 300 records committed...
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Psychology I', 36, 22, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Psychology II', 72, 42, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Psychology III', 81, 50, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Psychology IV', 75, 19, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Public Health', 7, 30, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Public Relations', 22, 25, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Publishing', 40, 43, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Real Estate', 86, 43, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Robotics I', 74, 28, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Robotics II', 4, 35, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Robotics III', 15, 48, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Robotics IV', 5, 44, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sociology I', 41, 45, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sociology II', 85, 27, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sociology III', 96, 28, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sociology IV', 93, 26, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Software Engineering', 48, 42, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Spanish Literature', 95, 30, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Special Education', 92, 37, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Speech', 49, 38, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sports Medicine', 11, 25, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Statistics I', 42, 47, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Statistics II', 68, 39, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Statistics III', 54, 19, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Statistics IV', 1, 29, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Strategic Management', 16, 32, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Studio Design', 35, 29, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Supply Chain Management', 56, 22, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Surveying', 55, 30, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Sustainable Energy', 63, 24, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Teaching', 87, 43, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Technical Writing', 17, 13, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Telecommunications', 83, 31, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Theater Arts', 77, 19, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Tourism', 1, 15, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Transportation', 95, 19, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Urban Planning', 59, 18, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Veterinary Science', 97, 10, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Visual Arts', 54, 22, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Welding', 44, 36, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Wildlife Management', 38, 29, 2);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Women''s Studies', 60, 31, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('World Cultures', 52, 44, 4);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('World Religions', 23, 20, 3);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Youth Studies', 13, 28, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Zoology I', 77, 32, 5);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Zoology II', 57, 47, 1);
insert into SUBJECTS_TAUGHT (subject_name, class_number, students_studying_number, difficulty_level)
values ('Zoology III', 8, 12, 3);
commit;
prompt 348 records loaded
prompt Loading TEACH...
insert into TEACH (employee_id, subject_name)
values (1500, 'American History');
insert into TEACH (employee_id, subject_name)
values (1504, 'Biotechnology');
insert into TEACH (employee_id, subject_name)
values (1505, 'English IV');
insert into TEACH (employee_id, subject_name)
values (1507, 'World Literature');
insert into TEACH (employee_id, subject_name)
values (1518, 'Forensic Science');
insert into TEACH (employee_id, subject_name)
values (1524, 'Astronomy');
insert into TEACH (employee_id, subject_name)
values (1525, 'Band');
insert into TEACH (employee_id, subject_name)
values (1527, 'Business');
insert into TEACH (employee_id, subject_name)
values (1529, 'Career Development');
insert into TEACH (employee_id, subject_name)
values (1532, 'Dance');
insert into TEACH (employee_id, subject_name)
values (1535, 'AP Microeconomics');
insert into TEACH (employee_id, subject_name)
values (1537, 'AP English Literature');
insert into TEACH (employee_id, subject_name)
values (1538, 'Japanese IV');
insert into TEACH (employee_id, subject_name)
values (1546, 'Physical Education');
insert into TEACH (employee_id, subject_name)
values (1549, 'Russian IV');
insert into TEACH (employee_id, subject_name)
values (1550, 'Civics');
insert into TEACH (employee_id, subject_name)
values (1552, 'Photography');
insert into TEACH (employee_id, subject_name)
values (1559, 'AP World History');
insert into TEACH (employee_id, subject_name)
values (1559, 'Finance');
insert into TEACH (employee_id, subject_name)
values (1561, 'Arabic III');
insert into TEACH (employee_id, subject_name)
values (1561, 'Computer Science');
insert into TEACH (employee_id, subject_name)
values (1561, 'Robotics');
insert into TEACH (employee_id, subject_name)
values (1563, 'Microbiology');
insert into TEACH (employee_id, subject_name)
values (1565, 'Economics I');
insert into TEACH (employee_id, subject_name)
values (1569, 'AP Environmental Science');
insert into TEACH (employee_id, subject_name)
values (1571, 'Physical Science');
insert into TEACH (employee_id, subject_name)
values (1577, 'Dance I');
insert into TEACH (employee_id, subject_name)
values (1577, 'Digital Art');
insert into TEACH (employee_id, subject_name)
values (1577, 'Web Design');
insert into TEACH (employee_id, subject_name)
values (1578, 'Literature');
insert into TEACH (employee_id, subject_name)
values (1580, 'Computer Graphics');
insert into TEACH (employee_id, subject_name)
values (1581, 'Writing');
insert into TEACH (employee_id, subject_name)
values (1582, 'Japanese II');
insert into TEACH (employee_id, subject_name)
values (1583, 'Botany');
insert into TEACH (employee_id, subject_name)
values (1588, 'Calculus II');
insert into TEACH (employee_id, subject_name)
values (1591, 'Chemistry II');
insert into TEACH (employee_id, subject_name)
values (1601, 'Zoology');
insert into TEACH (employee_id, subject_name)
values (1605, 'Botany');
insert into TEACH (employee_id, subject_name)
values (1606, 'Art');
insert into TEACH (employee_id, subject_name)
values (1609, 'Architecture');
insert into TEACH (employee_id, subject_name)
values (1610, 'Aerospace Engineering');
insert into TEACH (employee_id, subject_name)
values (1613, 'Geology');
insert into TEACH (employee_id, subject_name)
values (1614, 'Physiology');
insert into TEACH (employee_id, subject_name)
values (1616, 'Database Management');
insert into TEACH (employee_id, subject_name)
values (1621, 'Mathematics');
insert into TEACH (employee_id, subject_name)
values (1623, 'Banking');
insert into TEACH (employee_id, subject_name)
values (1623, 'Drama IV');
insert into TEACH (employee_id, subject_name)
values (1623, 'Latin I');
insert into TEACH (employee_id, subject_name)
values (1623, 'World Geography');
insert into TEACH (employee_id, subject_name)
values (1627, 'Latin II');
insert into TEACH (employee_id, subject_name)
values (1634, 'AP Physics 2');
insert into TEACH (employee_id, subject_name)
values (1642, 'Information Technology');
insert into TEACH (employee_id, subject_name)
values (1647, 'AP Studio Art');
insert into TEACH (employee_id, subject_name)
values (1648, 'Drama I');
insert into TEACH (employee_id, subject_name)
values (1651, 'Environmental Science');
insert into TEACH (employee_id, subject_name)
values (1652, 'AP Government');
insert into TEACH (employee_id, subject_name)
values (1652, 'Ancient History');
insert into TEACH (employee_id, subject_name)
values (1652, 'Astronomy');
insert into TEACH (employee_id, subject_name)
values (1652, 'Psychology');
insert into TEACH (employee_id, subject_name)
values (1660, 'Statistics');
insert into TEACH (employee_id, subject_name)
values (1669, 'Dance III');
insert into TEACH (employee_id, subject_name)
values (1671, 'Geometry');
insert into TEACH (employee_id, subject_name)
values (1671, 'Latin III');
insert into TEACH (employee_id, subject_name)
values (1672, 'Comparative Government');
insert into TEACH (employee_id, subject_name)
values (1673, 'Classical Studies');
insert into TEACH (employee_id, subject_name)
values (1673, 'Russian III');
insert into TEACH (employee_id, subject_name)
values (1674, 'Oceanography');
insert into TEACH (employee_id, subject_name)
values (1682, 'Cybersecurity');
insert into TEACH (employee_id, subject_name)
values (1683, 'AP Macroeconomics');
insert into TEACH (employee_id, subject_name)
values (1685, 'Communications');
insert into TEACH (employee_id, subject_name)
values (1687, 'Computer Repair');
insert into TEACH (employee_id, subject_name)
values (1690, 'Chemistry');
insert into TEACH (employee_id, subject_name)
values (1691, 'Algebra III');
insert into TEACH (employee_id, subject_name)
values (1691, 'English III');
insert into TEACH (employee_id, subject_name)
values (1692, 'Philosophy');
insert into TEACH (employee_id, subject_name)
values (1695, 'French I');
insert into TEACH (employee_id, subject_name)
values (1697, 'Meteorology');
insert into TEACH (employee_id, subject_name)
values (1698, 'Theater');
insert into TEACH (employee_id, subject_name)
values (1702, 'AP Calculus BC');
insert into TEACH (employee_id, subject_name)
values (1707, 'Chemistry I');
insert into TEACH (employee_id, subject_name)
values (1710, 'Business Studies');
insert into TEACH (employee_id, subject_name)
values (1710, 'Spanish II');
insert into TEACH (employee_id, subject_name)
values (1715, 'Anatomy');
insert into TEACH (employee_id, subject_name)
values (1717, 'Choir');
insert into TEACH (employee_id, subject_name)
values (1717, 'Criminal Justice');
insert into TEACH (employee_id, subject_name)
values (1718, 'AP English Language');
insert into TEACH (employee_id, subject_name)
values (1718, 'Algebra II');
insert into TEACH (employee_id, subject_name)
values (1719, 'Dance IV');
insert into TEACH (employee_id, subject_name)
values (1719, 'Trigonometry');
insert into TEACH (employee_id, subject_name)
values (1720, 'Art History');
insert into TEACH (employee_id, subject_name)
values (1721, 'German IV');
insert into TEACH (employee_id, subject_name)
values (1722, 'Creative Arts');
insert into TEACH (employee_id, subject_name)
values (1722, 'Culinary Arts');
insert into TEACH (employee_id, subject_name)
values (1722, 'Public Speaking');
insert into TEACH (employee_id, subject_name)
values (1724, 'Cosmetology');
insert into TEACH (employee_id, subject_name)
values (1724, 'French IV');
insert into TEACH (employee_id, subject_name)
values (1725, 'Arabic IV');
insert into TEACH (employee_id, subject_name)
values (1725, 'Sociology');
insert into TEACH (employee_id, subject_name)
values (1729, 'Construction');
insert into TEACH (employee_id, subject_name)
values (1729, 'Spanish I');
commit;
prompt 100 records committed...
insert into TEACH (employee_id, subject_name)
values (1730, 'AP French');
insert into TEACH (employee_id, subject_name)
values (1731, 'Law');
insert into TEACH (employee_id, subject_name)
values (1737, 'Drama');
insert into TEACH (employee_id, subject_name)
values (1738, 'Music Theory');
insert into TEACH (employee_id, subject_name)
values (1739, 'AP Human Geography');
insert into TEACH (employee_id, subject_name)
values (1739, 'Pre-Calculus');
insert into TEACH (employee_id, subject_name)
values (1740, 'Engineering');
insert into TEACH (employee_id, subject_name)
values (1741, 'Anthropology');
insert into TEACH (employee_id, subject_name)
values (1743, 'US Government');
insert into TEACH (employee_id, subject_name)
values (1752, 'AP Spanish');
insert into TEACH (employee_id, subject_name)
values (1752, 'Archaeology');
insert into TEACH (employee_id, subject_name)
values (1753, 'US History');
insert into TEACH (employee_id, subject_name)
values (1755, 'Japanese I');
insert into TEACH (employee_id, subject_name)
values (1755, 'Political Science');
insert into TEACH (employee_id, subject_name)
values (1757, 'AP Statistics');
insert into TEACH (employee_id, subject_name)
values (1762, 'History of Art');
insert into TEACH (employee_id, subject_name)
values (1762, 'Nutrition');
insert into TEACH (employee_id, subject_name)
values (1764, 'Elementary Algebra');
insert into TEACH (employee_id, subject_name)
values (1765, 'Calculus III');
insert into TEACH (employee_id, subject_name)
values (1765, 'Chemistry III');
insert into TEACH (employee_id, subject_name)
values (1767, 'Design');
insert into TEACH (employee_id, subject_name)
values (1768, 'Child Development');
insert into TEACH (employee_id, subject_name)
values (1776, 'Economics II');
insert into TEACH (employee_id, subject_name)
values (1777, 'AP Biology');
insert into TEACH (employee_id, subject_name)
values (1777, 'Animal Science');
insert into TEACH (employee_id, subject_name)
values (1780, 'English Composition');
insert into TEACH (employee_id, subject_name)
values (1780, 'World History');
insert into TEACH (employee_id, subject_name)
values (1781, 'Archaeology');
insert into TEACH (employee_id, subject_name)
values (1786, 'Agriculture');
insert into TEACH (employee_id, subject_name)
values (1794, 'AP US History');
insert into TEACH (employee_id, subject_name)
values (1794, 'Earth Science');
insert into TEACH (employee_id, subject_name)
values (1798, 'Creative Writing');
insert into TEACH (employee_id, subject_name)
values (1799, 'AP Chemistry');
insert into TEACH (employee_id, subject_name)
values (1801, 'Human Anatomy');
insert into TEACH (employee_id, subject_name)
values (1804, 'French II');
insert into TEACH (employee_id, subject_name)
values (1805, 'Dance II');
insert into TEACH (employee_id, subject_name)
values (1810, 'Latin IV');
insert into TEACH (employee_id, subject_name)
values (1810, 'Russian II');
insert into TEACH (employee_id, subject_name)
values (1812, 'Arabic I');
insert into TEACH (employee_id, subject_name)
values (1820, 'AP Physics C');
insert into TEACH (employee_id, subject_name)
values (1827, 'Music Appreciation');
insert into TEACH (employee_id, subject_name)
values (1830, 'Electrical Engineering');
insert into TEACH (employee_id, subject_name)
values (1833, 'English Literature');
insert into TEACH (employee_id, subject_name)
values (1833, 'Film Studies');
insert into TEACH (employee_id, subject_name)
values (1836, 'French III');
insert into TEACH (employee_id, subject_name)
values (1837, 'Biology');
insert into TEACH (employee_id, subject_name)
values (1839, 'Journalism');
insert into TEACH (employee_id, subject_name)
values (1841, 'Spanish III');
insert into TEACH (employee_id, subject_name)
values (1844, 'Ancient Civilizations');
insert into TEACH (employee_id, subject_name)
values (1845, 'English I');
insert into TEACH (employee_id, subject_name)
values (1855, 'Asian History');
insert into TEACH (employee_id, subject_name)
values (1857, 'Engineering Design');
insert into TEACH (employee_id, subject_name)
values (1862, 'AP European History');
insert into TEACH (employee_id, subject_name)
values (1862, 'Debate');
insert into TEACH (employee_id, subject_name)
values (1863, 'Health');
insert into TEACH (employee_id, subject_name)
values (1864, 'Coding');
insert into TEACH (employee_id, subject_name)
values (1867, 'Electronics');
insert into TEACH (employee_id, subject_name)
values (1868, 'Culinary Skills');
insert into TEACH (employee_id, subject_name)
values (1868, 'Earth and Space Science');
insert into TEACH (employee_id, subject_name)
values (1873, 'Drama II');
insert into TEACH (employee_id, subject_name)
values (1874, 'Mechanical Engineering');
insert into TEACH (employee_id, subject_name)
values (1874, 'Organic Chemistry');
insert into TEACH (employee_id, subject_name)
values (1876, 'AP Physics 1');
insert into TEACH (employee_id, subject_name)
values (1877, 'German I');
insert into TEACH (employee_id, subject_name)
values (1885, 'AP Psychology');
insert into TEACH (employee_id, subject_name)
values (1887, 'Computer Programming');
insert into TEACH (employee_id, subject_name)
values (1889, 'English II');
insert into TEACH (employee_id, subject_name)
values (1889, 'Graphic Design');
insert into TEACH (employee_id, subject_name)
values (1893, 'Orchestra');
insert into TEACH (employee_id, subject_name)
values (1896, 'Marine Biology');
insert into TEACH (employee_id, subject_name)
values (1900, 'Architecture');
insert into TEACH (employee_id, subject_name)
values (1902, 'Accounting');
insert into TEACH (employee_id, subject_name)
values (1907, 'Calculus I');
insert into TEACH (employee_id, subject_name)
values (1910, 'Environmental Engineering');
insert into TEACH (employee_id, subject_name)
values (1915, 'AP Calculus AB');
insert into TEACH (employee_id, subject_name)
values (1929, 'Pre-Algebra');
insert into TEACH (employee_id, subject_name)
values (1929, 'Studio Art');
insert into TEACH (employee_id, subject_name)
values (1934, 'Computer Networking');
insert into TEACH (employee_id, subject_name)
values (1942, 'Japanese III');
insert into TEACH (employee_id, subject_name)
values (1944, 'Russian I');
insert into TEACH (employee_id, subject_name)
values (1947, 'Marketing');
insert into TEACH (employee_id, subject_name)
values (1950, 'Physics');
insert into TEACH (employee_id, subject_name)
values (1952, 'Calculus');
insert into TEACH (employee_id, subject_name)
values (1959, 'Geography');
insert into TEACH (employee_id, subject_name)
values (1961, 'Advertising');
insert into TEACH (employee_id, subject_name)
values (1962, 'Emergency Management');
insert into TEACH (employee_id, subject_name)
values (1969, 'Criminal Law');
insert into TEACH (employee_id, subject_name)
values (1971, 'AP US Government');
insert into TEACH (employee_id, subject_name)
values (1971, 'Biochemistry');
insert into TEACH (employee_id, subject_name)
values (1971, 'European History');
insert into TEACH (employee_id, subject_name)
values (1972, 'Spanish IV');
insert into TEACH (employee_id, subject_name)
values (1975, 'German II');
insert into TEACH (employee_id, subject_name)
values (1980, 'Anthropology');
insert into TEACH (employee_id, subject_name)
values (1980, 'Economics');
insert into TEACH (employee_id, subject_name)
values (1983, 'Digital Media');
insert into TEACH (employee_id, subject_name)
values (1985, 'Drama III');
insert into TEACH (employee_id, subject_name)
values (1988, 'Arabic II');
insert into TEACH (employee_id, subject_name)
values (1991, 'German III');
insert into TEACH (employee_id, subject_name)
values (1998, 'Media Studies');
commit;
prompt 199 records loaded
prompt Enabling foreign key constraints for BUDGET...
alter table BUDGET enable constraint SYS_C008430;
prompt Enabling foreign key constraints for INVOICE...
alter table INVOICE enable constraint SYS_C008404;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C008408;
alter table ORDERS enable constraint SYS_C008409;
alter table ORDERS enable constraint SYS_C008410;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint SYS_C008413;
prompt Enabling foreign key constraints for TEACH...
alter table TEACH enable constraint SYS_C008425;
alter table TEACH enable constraint SYS_C008426;
prompt Enabling triggers for EMPLOYEE...
alter table EMPLOYEE enable all triggers;
prompt Enabling triggers for BUDGET...
alter table BUDGET enable all triggers;
prompt Enabling triggers for SUPPLIER...
alter table SUPPLIER enable all triggers;
prompt Enabling triggers for INVOICE...
alter table INVOICE enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for SUBJECTS_TAUGHT...
alter table SUBJECTS_TAUGHT enable all triggers;
prompt Enabling triggers for TEACH...
alter table TEACH enable all triggers;

set feedback on
set define on
prompt Done
