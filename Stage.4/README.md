1/7/24

•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System

## Stage 4:

We chose to integrate with the student services department

1. **Part 1** - Reverse Engineering:

DSD before integration: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/DSD/DSD_from_backup.png)

ERD: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/ERD/ERD_from_backup.png)

---

At this stage, we used an automatic PL/SQL tool to create a Data Structure (DS) Diagram from the backup of the table creation scripts. The algorithm we used for generating the ERD is described below:

---

1. **Create Table (`create_table`)**:
   - **Action**: Create an entity in the ERD.
   - **Explanation**: When a table is created, it represents a new entity in the diagram.

2. **Alter Table (`alter_table`)**:
   - **Action**: Create a connector in the ERD.
   - **Explanation**: When a table is altered, it typically means an existing entity's structure is modified, which might affect the relationships or constraints of the entity.

3. **Alter Table with Foreign Key (`alter table` with `add foreign key`)**:
   - **Action**: Create a "one to many" relationship.
   - **Explanation**: Adding a foreign key establishes a relationship between two entities:
     - **One-Side**: The entity that includes the foreign key.
     - **Many-Side**: The entity being referenced by the foreign key.
   - **Additional Action**: If a table (entity) referenced by the foreign key does not already exist in the ERD, it should be added.

Example Explained
```sql
alter table STUDENT_
  add foreign key (COUNSELOR_ID)
  references COUNSELOR (COUNSELOR_ID);
```

- **STUDENT_** is the table being altered, and it includes a foreign key `COUNSELOR_ID`.
- **COUNSELOR** is the table being referenced.

**Actions**:
- **STUDENT_**: Create or modify an existing entity in the ERD to reflect the addition of `COUNSELOR_ID` as a foreign key.
- **COUNSELOR**: Ensure this entity exists in the ERD as it is being referenced.
- **Relationship**: Establish a "one to many" relationship where:
  - **One-Side**: **COUNSELOR** (one counselor can be associated with many students).
  - **Many-Side**: **STUDENT_** (many students can have one counselor).

2. **Part 2** - Integrated:


DSD after integration: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/DSD/DSD_integrated.png)

ERD: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/ERD/ERD_integrated.png)


integration decisions:

* 

פקודות sql לביצוע האינטגרציה:

אם המפתח נמצא בטבלה אחרת, אני מבין שזה יחיד לרבים חץ עגול. אם יש ישות חלשה זה הופך להיות מפתח, לא קורה פה. היחיד זה הסטודנט והיועץ רבים, לפי זה שיש מפתח זר של יועץ בתוך סטודנט.


הסבר מילולי של התהליך והפקודות

* .....
```

```


3. **Views**
·         לכל מבט: תיאור מילולי של המבט ושליפת נתונים ממנו עם select * (מספיק 10 רשומות).


1. name_of_view:

explain:

code:

output:

2. name_of_view:

explain:

code:

output:
