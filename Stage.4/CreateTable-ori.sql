create table ACTIVITY
(
  activity_id      INTEGER not null,
  date_of_activity DATE not null,
  activity_name    VARCHAR2(100) not null,
  capacity         INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVITY
  add primary key (ACTIVITY_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVITY
  add constraint CHECK_CAPACITY
  check (capacity <= 100);
alter table ACTIVITY
  add constraint MAXIMUM_CAPACITY
  check (capacity <= 100);
alter table ACTIVITY
  add constraint MAX_CAPACITY
  check (capacity <= 100);

prompt Creating COUNSELOR...
create table COUNSELOR
(
  counselor_id    INTEGER not null,
  counselor_name  VARCHAR2(100) not null,
  degree_level    VARCHAR2(50) not null,
  counselor_age   INTEGER not null,
  counselor_email VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COUNSELOR
  add primary key (COUNSELOR_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating STUDENT_...
create table STUDENT_
(
  student_id   INTEGER not null,
  student_name VARCHAR2(100) not null,
  birth        DATE not null,
  grade        VARCHAR2(10) not null,
  adress       VARCHAR2(200) not null,
  counselor_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STUDENT_
  add primary key (STUDENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STUDENT_
  add foreign key (COUNSELOR_ID)
  references COUNSELOR (COUNSELOR_ID);

prompt Creating ACTIVE...
create table ACTIVE
(
  activity_id INTEGER not null,
  student_id  INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVE
  add primary key (ACTIVITY_ID, STUDENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVE
  add foreign key (ACTIVITY_ID)
  references ACTIVITY (ACTIVITY_ID);
alter table ACTIVE
  add foreign key (STUDENT_ID)
  references STUDENT_ (STUDENT_ID);

prompt Creating TRANSPORTATION...
create table TRANSPORTATION
(
  transportation_id INTEGER not null,
  departure_time    DATE not null,
  driver_name       VARCHAR2(100) not null,
  in_time           VARCHAR2(3) default 'No' not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TRANSPORTATION
  add primary key (TRANSPORTATION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ARRIVE...
create table ARRIVE
(
  transportation_id INTEGER not null,
  student_id        INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ARRIVE
  add primary key (TRANSPORTATION_ID, STUDENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ARRIVE
  add foreign key (TRANSPORTATION_ID)
  references TRANSPORTATION (TRANSPORTATION_ID);
alter table ARRIVE
  add foreign key (STUDENT_ID)
  references STUDENT_ (STUDENT_ID);

prompt Creating MEALS...
create table MEALS
(
  meal_id   INTEGER not null,
  type_meal VARCHAR2(100) not null,
  is_dairy  VARCHAR2(3) not null,
  meal_name VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEALS
  add primary key (MEAL_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEALS
  add constraint CHECK_IS_DAIRY
  check (Is_Dairy IN ('Yes', 'No'));

prompt Creating EATER...
create table EATER
(
  meal_id    INTEGER not null,
  student_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EATER
  add primary key (MEAL_ID, STUDENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EATER
  add foreign key (MEAL_ID)
  references MEALS (MEAL_ID);
alter table EATER
  add foreign key (STUDENT_ID)
  references STUDENT_ (STUDENT_ID);

prompt Creating TRIPS...
create table TRIPS
(
  locations       VARCHAR2(100) not null,
  grade           VARCHAR2(10) not null,
  trip_maneger_id INTEGER not null,
  trip_date       DATE not null,
  trip_topic      VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TRIPS
  add primary key (TRIP_MANEGER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TRIPS
  add constraint CHECK_GRADE
  check (Grade BETWEEN 1 AND 12);

prompt Creating GOING...
create table GOING
(
  student_id      INTEGER not null,
  trip_maneger_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GOING
  add primary key (STUDENT_ID, TRIP_MANEGER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GOING
  add foreign key (STUDENT_ID)
  references STUDENT_ (STUDENT_ID);
alter table GOING
  add foreign key (TRIP_MANEGER_ID)
  references TRIPS (TRIP_MANEGER_ID);