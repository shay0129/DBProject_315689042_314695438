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

3. **Table with Foreign Key**:
   - **Action**: Create a "one to many" relationship.
   - **For us**: Create an entity in the ERD to reflect the addition of COUNSELOR_ID as a foreign key.
   - **One-Side**: **STUDENT** (a student can only be associated with one counselor).
   - **Many-Side**: **COUNSELOR** (one counselor can have many students).


2. **Part 2** - Integrated:


DSD after integration: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/DSD/DSD_integrated.png)

ERD: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/ERD/ERD_integrated.png)

### Integration Decisions

**1. Renaming Table:**
```sql
ALTER TABLE Student_
RENAME TO Student;
```
- **Reason**: This rename operation was performed to standardize and correct the naming convention of the table. The updated name `Student` aligns with conventional naming practices and improves consistency across the schema.

**2. Creating the `Kind` Connector Table:**
```sql
CREATE TABLE Kind (
    order_id INT,
    meal_id INTEGER,
    CONSTRAINT pk_kind PRIMARY KEY (order_id, meal_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES Orders (Order_ID),
    CONSTRAINT fk_meal FOREIGN KEY (meal_id) REFERENCES Meals (meal_id)
);
```
- **Reason for Addition**: 
  - The `Kind` table represents a many-to-many relationship between `Orders` and `Meals`. This relationship captures the association where each order can include multiple meals and each meal can be part of multiple orders.
  - **Columns**:
    - `order_id`: This foreign key references the `Order_ID` in the `Orders` table.
    - `meal_id`: This foreign key references the `meal_id` in the `Meals` table.
  - **Constraints**:
    - **Primary Key**: Composite primary key on `(order_id, meal_id)` ensures uniqueness of the combination of an order and a meal.
    - **Foreign Keys**: Ensures referential integrity by linking `order_id` to `Orders` and `meal_id` to `Meals`.

**3. Creating the `Learn` Connector Table:**
```sql
CREATE TABLE Learn (
    subject_name VARCHAR(30),
    student_id INTEGER,
    CONSTRAINT pk_learn PRIMARY KEY (subject_name, student_id),
    CONSTRAINT fk_subject FOREIGN KEY (subject_name) REFERENCES Subjects_Taught (Subject_Name),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Student (student_id)
);
```
- **Reason for Addition**: 
  - The `Learn` table represents a many-to-many relationship between `Subjects_Taught` and `Student`. This relationship captures the association where each student can be enrolled in multiple subjects, and each subject can have multiple students.
  - **Columns**:
    - `subject_name`: This foreign key references the `Subject_Name` in the `Subjects_Taught` table.
    - `student_id`: This foreign key references the `student_id` in the `Student` table.
  - **Constraints**:
    - **Primary Key**: Composite primary key on `(subject_name, student_id)` ensures uniqueness of the combination of a subject and a student.
    - **Foreign Keys**: Ensures referential integrity by linking `subject_name` to `Subjects_Taught` and `student_id` to `Student`.

### Summary

- **Renaming of `Student_` Table**: Improved naming convention for consistency.
- **`Kind` Connector Table**: Establishes a many-to-many relationship between `Orders` and `Meals`, enabling comprehensive tracking of meal orders.
- **`Learn` Connector Table**: Establishes a many-to-many relationship between `Subjects_Taught` and `Student`, allowing for tracking of student enrollments in subjects.

These changes are aimed at enhancing the relational database schema to capture and enforce the complex many-to-many relationships between the various entities involved.


3. **Views**

Here’s an explanation for each view and the corresponding queries that follow, including their purposes, the SQL code, and examples of what the results might look like.

### 1. View: `SubjectTeacherDetails`

**Description**: 
The `SubjectTeacherDetails` view provides detailed information about the subjects taught by each employee. It combines data from the `Subjects_Taught`, `Teach`, and `Employee` tables to provide a comprehensive view of the subject details along with the associated teacher's information.

**SQL Code**:
```sql
CREATE VIEW SubjectTeacherDetails AS
SELECT 
    s.Subject_Name,
    s.students_studying_number,
    s.Difficulty_level,
    t.Employee_ID,
    e.Employee_Name,
    e.Job_Title,
    e.Seniority
FROM 
    Subjects_Taught s
JOIN 
    Teach t ON s.Subject_Name = t.Subject_Name
JOIN 
    Employee e ON t.Employee_ID = e.Employee_ID;
```

**Queries on `SubjectTeacherDetails` View**:

1. **Query 1: Total Students and Average Difficulty by Employee**

   **Description**: Retrieves each employee's total number of students and the average difficulty level of the subjects they teach.

   **SQL Code**:
   ```sql
   SELECT 
       Employee_ID,
       Employee_Name,
       Job_Title,
       Seniority,
       SUM(students_studying_number) AS Total_Students,
       AVG(Difficulty_level) AS Average_Difficulty
   FROM 
       SubjectTeacherDetails
   GROUP BY 
       Employee_ID, Employee_Name, Job_Title, Seniority;
   ```

   **Sample Output**:
   ```
   EMPLOYEE_ID | EMPLOYEE_NAME | JOB_TITLE | SENIORITY | TOTAL_STUDENTS | AVERAGE_DIFFICULTY
   ----------------------------------------------------------------------------------------------
   101         | John Doe      | Professor | Senior    | 150            | 4.5
   102         | Jane Smith    | Lecturer   | Junior    | 120            | 3.8
   ```

2. **Query 2: Employees Teaching More Than 2 Subjects with Difficulty Level > 4**

   **Description**: Lists employees who teach more than two subjects with an average difficulty level greater than 4.

   **SQL Code**:
   ```sql
   SELECT 
       Employee_ID,
       Employee_Name,
       COUNT(Subject_Name) AS Number_of_Subjects
   FROM 
       SubjectTeacherDetails
   WHERE 
       Difficulty_level > 4
   GROUP BY 
       Employee_ID, Employee_Name
   HAVING 
       COUNT(Subject_Name) > 2;
   ```

   **Sample Output**:
   ```
   EMPLOYEE_ID | EMPLOYEE_NAME | NUMBER_OF_SUBJECTS
   ---------------------------------------------------
   101         | John Doe      | 3
   ```
   ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/SQL/View1_output.png)

### 2. View: `StudentActivityDetails`

**Description**: 
The `StudentActivityDetails` view provides information about activities and students participating in those activities. It merges data from the `Activity`, `Active`, and `Student` tables to offer a detailed overview of student involvement in activities.

**SQL Code**:
```sql
CREATE VIEW StudentActivityDetails AS
SELECT 
    a.activity_id,
    a.date_of_activity,
    a.activity_name,
    a.capacity,
    st.student_id,
    st.student_name,
    st.grade,
    st.counselor_id
FROM 
    Activity a
JOIN 
    Active ac ON a.activity_id = ac.activity_id
JOIN 
    Student st ON ac.student_id = st.student_id;
```

**Queries on `StudentActivityDetails` View**:

1. **Query 1: Total Students and Average Grade by Activity**

   **Description**: Retrieves the total number of students and average grade for each activity.

   **SQL Code**:
   ```sql
   SELECT 
       activity_id,
       activity_name,
       COUNT(student_id) AS Total_Students,
       AVG(grade) AS Average_Grade
   FROM 
       StudentActivityDetails
   GROUP BY 
       activity_id, activity_name;
   ```

   **Sample Output**:
   ```
   ACTIVITY_ID | ACTIVITY_NAME | TOTAL_STUDENTS | AVERAGE_GRADE
   ---------------------------------------------------------------
   201         | Soccer         | 25             | 8.2
   202         | Chess           | 18             | 7.9
   ```

2. **Query 2: Activities with More Than 20 Students and Average Grade > 8**

   **Description**: Lists activities where the number of students is greater than 20 and the average grade of participants is above 8.

   **SQL Code**:
   ```sql
   SELECT 
       activity_id,
       activity_name,
       COUNT(student_id) AS Number_of_Students,
       AVG(grade) AS Average_Grade
   FROM 
       StudentActivityDetails
   GROUP BY 
       activity_id, activity_name
   HAVING 
       COUNT(student_id) > 20 AND AVG(grade) > 8;
   ```

   **Sample Output**:
   ```
   ACTIVITY_ID | ACTIVITY_NAME | NUMBER_OF_STUDENTS | AVERAGE_GRADE
   --------------------------------------------------------------
   201         | Soccer         | 25                 | 8.2
   ```
![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/SQL/View2_output.png)
