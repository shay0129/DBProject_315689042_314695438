ALTER TABLE Student_
RENAME TO Student;

CREATE TABLE Kind (
    order_id INT,
    meal_id INTEGER,
    CONSTRAINT pk_kind PRIMARY KEY (order_id, meal_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES Orders (Order_ID),
    CONSTRAINT fk_meal FOREIGN KEY (meal_id) REFERENCES Meals (meal_id)
);

CREATE TABLE Learn (
    subject_name VARCHAR(30),
    student_id INTEGER,
    CONSTRAINT pk_learn PRIMARY KEY (subject_name, student_id),
    CONSTRAINT fk_subject FOREIGN KEY (subject_name) REFERENCES Subjects_Taught (Subject_Name),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Student (student_id)
);