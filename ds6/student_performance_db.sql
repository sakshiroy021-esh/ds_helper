CREATE DATABASE IF NOT EXISTS student_performance_db;
USE student_performance_db;

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female'),
    department VARCHAR(50)
);

CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    total_classes INT,
    attended_classes INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    marks_obtained FLOAT,
    max_marks FLOAT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


INSERT INTO Students (first_name, last_name, gender, department) VALUES
('Aarav', 'Sharma', 'Male', 'Computer Science'),
('Isha', 'Patel', 'Female', 'Information Technology'),
('Rohan', 'Verma', 'Male', 'Electronics'),
('Simran', 'Kaur', 'Female', 'Mechanical'),
('Arjun', 'Singh', 'Male', 'Civil'),
('Neha', 'Gupta', 'Female', 'Computer Science'),
('Dev', 'Mehta', 'Male', 'Electrical'),
('Priya', 'Reddy', 'Female', 'Information Technology'),
('Kabir', 'Joshi', 'Male', 'Computer Science'),
('Ananya', 'Iyer', 'Female', 'Electronics');

INSERT INTO Attendance (student_id, total_classes, attended_classes) VALUES
(1, 40, 36),
(2, 40, 30),
(3, 40, 28),
(4, 40, 25),
(5, 40, 35),
(6, 40, 39),
(7, 40, 32),
(8, 40, 34),
(9, 40, 20),
(10, 40, 38);

INSERT INTO Grades (student_id, subject, marks_obtained, max_marks) VALUES
(1, 'Math', 85, 100),
(2, 'Math', 72, 100),
(3, 'Math', 68, 100),
(4, 'Math', 55, 100),
(5, 'Math', 80, 100),
(6, 'Math', 92, 100),
(7, 'Math', 70, 100),
(8, 'Math', 75, 100),
(9, 'Math', 50, 100),
(10, 'Math', 90, 100);

SELECT s.student_id, s.first_name, s.last_name, AVG(g.marks_obtained) AS avg_marks
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.student_id;


SELECT s.student_id, s.first_name, s.last_name,
       (a.attended_classes / a.total_classes) * 100 AS attendance_percent
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id;

SELECT s.first_name, s.last_name,
       (a.attended_classes / a.total_classes) * 100 AS attendance_percent,
       AVG(g.marks_obtained) AS avg_marks
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.student_id
ORDER BY avg_marks DESC;

START TRANSACTION;
UPDATE Grades SET marks_obtained = marks_obtained + 2 WHERE marks_obtained < 60;
ROLLBACK;

START TRANSACTION;
UPDATE Grades SET marks_obtained = marks_obtained + 1 WHERE marks_obtained BETWEEN 70 AND 80;
COMMIT;
