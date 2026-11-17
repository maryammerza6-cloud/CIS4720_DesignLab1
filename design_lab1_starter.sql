/* ==========================================================================
   design_lab1_starter.sql
   CIS 4720 Database Management and SQL
   Design Lab 1, From a Spreadsheet to Tables

   WHAT THIS FILE IS
   The campus tutoring center keeps its records in a spreadsheet. This file
   loads that spreadsheet into a table called tutoring_sheet, exactly as the
   center keeps it, and has a numbered heading for every step of the lab.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. Some steps also ask you to answer a question in a
   comment. The comments are graded.
   ========================================================================== */


-- =================================================================
-- SETUP. Run these three first, one at a time, while you are still
-- connected to information_schema.
-- =================================================================

-- every schema on this server. tutoring_db will not be in the list yet.
show databases;

-- make yours. IF NOT EXISTS means it is safe to run twice.
create database if not exists tutoring_db;

-- switch into it, so everything below lands in the right place.
use tutoring_db;


-- ======================================================================
-- THE SPREADSHEET. One row per tutoring session. Look at the students
-- column: every student who came is crammed into one cell.
-- ======================================================================

CREATE TABLE tutoring_sheet (
    session_id   INT,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    students     VARCHAR(200)
);
INSERT INTO tutoring_sheet VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS), 1003 Chloe Nguyen (CIS)');
INSERT INTO tutoring_sheet VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting)');
INSERT INTO tutoring_sheet VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', '1001 Ana Lopez (CIS), 1004 Dev Patel (Biology), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', '1003 Chloe Nguyen (CIS), 1004 Dev Patel (Biology)');
INSERT INTO tutoring_sheet VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS)');

-- CHECK. Six rows, sessions 101 to 106.
SELECT * FROM tutoring_sheet;


-- ######################################################################
-- YOUR DESIGN LAB 1 WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
-- ######################################################################


-- =================================================================
-- STEP 3. Ask the spreadsheet two questions
--
-- Copy the queries from the handout. Answer the question in a comment.
-- =================================================================

-- Step 3: Count how many sessions Ana Lopez attended.
SELECT COUNT(*)
FROM tutoring_sheet
WHERE students LIKE '%Ana Lopez%';

-- Count the total number of rows in the tutoring spreadsheet.
SELECT COUNT(*)
FROM tutoring_sheet;

-- COUNT cannot count individual students because
-- the students column contains multiple names in one cell.
-- It counts the session rows instead of each student visit.


-- =================================================================
-- STEP 4. First normal form, one value per cell
--
-- Write the CREATE TABLE. Then run the DATA FOR STEP 4 block below it.
-- =================================================================

-- Step 4: Create a table with one row for each student in a session.
-- The session ID and student ID together identify each attendance record.
CREATE TABLE tutoring_1nf (
    session_id INT NOT NULL,
    session_date DATE,
    room VARCHAR(10),
    tutor_id INT,
    tutor_name VARCHAR(40),
    tutor_email VARCHAR(60),
    course_code VARCHAR(10),
    course_title VARCHAR(40),
    student_id INT NOT NULL,
    student_name VARCHAR(40),
    student_major VARCHAR(30),
    rating INT,
    PRIMARY KEY (session_id, student_id)
);


-- ----------------------------------------------------------------------
-- DATA FOR STEP 4. Run these eleven INSERTs AFTER your CREATE TABLE for
-- tutoring_1nf. They only work if your columns are in the same order as
-- the table in the handout. One row per student per session.
-- ----------------------------------------------------------------------

INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 3);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1001, 'Ana Lopez', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1004, 'Dev Patel', 'Biology', 5);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1005, 'Elena Ruiz', 'Undeclared', 2);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 4);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1005, 'Elena Ruiz', 'Undeclared', 3);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1004, 'Dev Patel', 'Biology', 4);
INSERT INTO tutoring_1nf VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);

-- Count how many tutoring sessions each student attended.
SELECT student_name, COUNT(*) AS sessions
FROM tutoring_1nf
GROUP BY student_name
ORDER BY student_name;

-- =================================================================
-- STEP 5. Make a copy to break
-- =================================================================

-- Step 5: Make a copy of the tutoring_1nf table to test problems without changing the original data.
CREATE TABLE anomaly_copy AS
SELECT *
FROM tutoring_1nf;

-- Count the number of rows in the copied table.
SELECT COUNT(*) AS total_rows
FROM anomaly_copy;


-- =================================================================
-- STEP 6. The update problem
--
-- Copy the UPDATE from the handout. Answer the question in a comment.
-- =================================================================

-- Step 6: Update Maya Chen's email for session 101 only.
UPDATE anomaly_copy
SET tutor_email = 'maya.chen@campus.edu'
WHERE session_id = 101;

-- Check all email addresses stored for tutor 501.
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM anomaly_copy
WHERE tutor_id = 501;

-- The new email should be correct, but the old email
-- still appears in other rows. The table does not
-- tell us which email is current.


-- =================================================================
-- STEP 7. The insert problem
--
-- Write the INSERT. Copy the error into a comment.
-- =================================================================
-- Step 7: Try to add a new course without a tutoring session.
INSERT INTO anomaly_copy (course_code, course_title)
VALUES ('CIS 4720', 'Database Management');

-- Expected error: Field 'session_id' doesn't have a default value.
-- The insert fails because the table requires a session ID.
-- This means we cannot add a new course until a session exists.

-- =================================================================
-- STEP 8. The delete problem
--
-- Write the DELETE and the check. Answer the question in a comment.
-- =================================================================

-- Step 8: Delete all records for session 103.
DELETE FROM anomaly_copy
WHERE session_id = 103;

-- Check which courses are still in the table.
SELECT DISTINCT course_code, course_title
FROM anomaly_copy;

-- We only wanted to delete session 103, but we also
-- lost the information about MATH 1600.
-- This happened because that course was only
-- stored in the rows for session 103.


-- =================================================================
-- STEP 9. Find the dependencies, and design third normal form
--
-- Answer in comments. Use the template in the handout.
-- =================================================================

-- Step 9: Check whether each student ID has one name and major.
SELECT student_id,
       COUNT(DISTINCT student_name) AS names,
       COUNT(DISTINCT student_major) AS majors
FROM tutoring_1nf
GROUP BY student_id;

-- Functional Dependencies:
-- session_date: session_id (Partial)
-- room: session_id (Partial)
-- tutor_id: session_id (Partial)
-- tutor_name: tutor_id (Transitive)
-- tutor_email: tutor_id (Transitive)
-- course_code: session_id (Partial)
-- course_title: course_code (Transitive)
-- student_name: student_id (Partial)
-- student_major: student_id (Partial)
-- rating: session_id and student_id (Full)

-- Third Normal Form (3NF) Design:
-- The SESSION table contains transitive dependencies.
-- Tutor names and emails belong in a separate TUTOR table.
-- Course titles belong in a separate COURSE table.

-- The five tables are:
-- STUDENT: Primary key is student_id.
-- TUTOR: Primary key is tutor_id.
-- COURSE: Primary key is course_code.
-- SESSION: Primary key is session_id.
-- ATTENDANCE: Primary key is (session_id, student_id).

-- This design separates student, tutor, course, session,
-- and attendance information to reduce duplicated data.


-- =================================================================
-- STEP 10. Build the five tables
--
-- Order matters: a table that is pointed at must exist first.
-- =================================================================

-- Create the student table to store each student's information.
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(40) NOT NULL,
    student_major VARCHAR(30)
);

-- Create the tutor table to store tutor information.
CREATE TABLE tutor (
    tutor_id INT PRIMARY KEY,
    tutor_name VARCHAR(40) NOT NULL,
    tutor_email VARCHAR(60) UNIQUE
);

-- Create the course table to store course information.
CREATE TABLE course (
    course_code VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(40) NOT NULL
);

-- Create the session table and connect it to tutor and course.
CREATE TABLE session (
    session_id INT PRIMARY KEY,
    session_date DATE NOT NULL,
    room VARCHAR(10),
    tutor_id INT NOT NULL,
    course_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id),
    FOREIGN KEY (course_code) REFERENCES course(course_code)
);

-- Create the attendance table to connect students with sessions.
CREATE TABLE attendance (
    session_id INT NOT NULL,
    student_id INT NOT NULL,
    rating INT,
    PRIMARY KEY (session_id, student_id),
    FOREIGN KEY (session_id) REFERENCES session(session_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);


-- =================================================================
-- STEP 11. Load the five tables from tutoring_1nf
-- =================================================================

-- Add the students from the original table.
INSERT INTO student (student_id, student_name, student_major)
SELECT DISTINCT student_id, student_name, student_major
FROM tutoring_1nf;

-- Add each tutor only once.
INSERT INTO tutor (tutor_id, tutor_name, tutor_email)
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM tutoring_1nf;

-- Add the different courses.
INSERT INTO course (course_code, course_title)
SELECT DISTINCT course_code, course_title
FROM tutoring_1nf;

-- Add the tutoring sessions.
INSERT INTO session (session_id, session_date, room, tutor_id, course_code)
SELECT DISTINCT session_id, session_date, room, tutor_id, course_code
FROM tutoring_1nf;

-- Add the attendance records with student ratings.
INSERT INTO attendance (session_id, student_id, rating)
SELECT session_id, student_id, rating
FROM tutoring_1nf;
SHOW TABLES;

-- =================================================================
-- STEP 12. Put the spreadsheet back together
--
-- Copy the view and the check from the handout.
-- =================================================================

-- Step 12: Rebuild the original data by joining the five tables.
CREATE VIEW tutoring_rebuilt AS
SELECT se.session_id, se.session_date, se.room,
       t.tutor_id, t.tutor_name, t.tutor_email,
       c.course_code, c.course_title,
       st.student_id, st.student_name, st.student_major,
       a.rating
FROM attendance a
JOIN session se ON a.session_id = se.session_id
JOIN tutor t ON se.tutor_id = t.tutor_id
JOIN course c ON se.course_code = c.course_code
JOIN student st ON a.student_id = st.student_id;

-- Check whether all original attendance records match the rebuilt data.
SELECT COUNT(*) AS matching_rows
FROM tutoring_1nf o
JOIN tutoring_rebuilt r
  ON o.session_id = r.session_id
  AND o.student_id = r.student_id
WHERE o.session_date = r.session_date
  AND o.room = r.room
  AND o.tutor_email = r.tutor_email
  AND o.course_title = r.course_title
  AND o.student_name = r.student_name
  AND o.student_major = r.student_major
  AND o.rating = r.rating;

-- =================================================================
-- STEP 13. Show the three problems are gone
-- =================================================================

-- Step 13: Update Maya Chen's email in the tutor table.
UPDATE tutor
SET tutor_email = 'maya.chen@campus.edu'
WHERE tutor_id = 501;

-- Check Maya's email in the rebuilt data.
SELECT DISTINCT tutor_email
FROM tutoring_rebuilt
WHERE tutor_id = 501;

-- The update problem is fixed because Maya's email
-- is stored in one place instead of many rows.


-- Add a new course without needing a tutoring session.
INSERT INTO course (course_code, course_title)
VALUES ('CIS 4720', 'Database Management');

-- The insert problem is fixed because courses can
-- be added without having an existing session.


-- Try to delete session 103 to test the foreign key.
DELETE FROM session
WHERE session_id = 103;

-- Expected error: A foreign key constraint prevents deletion.
-- The delete problem is fixed because attendance records
-- are protected, and course information is stored separately.

-- =================================================================
-- STEP 14 and 15. Push to GitHub and submit the URL
--
-- Nothing to write here. Follow the handout.
-- =================================================================

-- your comment goes here
-- your statements go here
