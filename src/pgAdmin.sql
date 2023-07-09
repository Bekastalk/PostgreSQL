create table Students
(
    student_id    serial primary key,
    first_name    varchar(50),
    last_name     varchar(50),
    date_of_birth DATE,
    address       varchar(100),
    email         VARCHAR(100),
    phone         VARCHAR(20)
);

alter table Students rename to students2;

alter table students2 rename column student_id to id;

insert into students2(first_name, last_name, date_of_birth, address, email, phone)
values ('Asan', 'Asanov', '2003-01-01', 'Ahunbaeva 123a', 'asan@example.com', '+996777888999'),
       ('Esen', 'Esenov', '2003-01-01', 'Ahunbaeva 124a', 'esen@example.com', '+996777668997'),
       ('Beksultan', 'Mamadkadyrov', '2004-11-01', 'Vostok5', 'beka@example.com', '+996777884599');


create table professors
(
    id            serial primary key,
    first_name    varchar(50) not null,
    last_name     varchar(50) not null,
    date_of_birth date        not null,
    address       varchar(100),
    email         varchar(100),
    phone         varchar(20)
);



insert into professors(first_name, last_name, date_of_birth, address, email, phone)
values ('Zhyldyz', 'Aitmatov', '1975-06-15', 'Manas 123', 'zhylbyz.aitmatov@example.com', '+996555123456'),
       ('Asyl', 'Orozbekov', '1980-09-25', 'Chui 456', 'asyl.orozbekov@example.com', '+996555987654'),
       ('Ascar', 'Asanov', '1980-09-25', 'Ahunbaeva', 'ascar.orozbekov@example.com', '+996555774411');

create table courses
(
    id           serial primary key,
    course_name  varchar(100) not null,
    description  text,
    professor_id int references professors (id)
);

insert into courses(course_name, description, professor_id)
values ('Mathematics', 'Introduction to mathematics', 1),
       ('Computer Science', 'Fundamentals of computer science', 2),
       ('Biology', 'Introduction to biology', 3);

create table enrollments
(
    id              serial primary key,
    student_id      int references students2 (id),
    course_id       int references courses (id),
    enrollment_date date not null
);

insert into enrollments (student_id, course_id, enrollment_date)
values (1, 1, '2023-07-01'),
       (2, 1, '2023-07-02'),
       (2, 2, '2023-07-03');

create table departments
(
    id              serial primary key,
    department_name varchar(100) not null,
    location        varchar(100)
);

insert into departments (department_name, location)
values ('Computer Science', 'Building A, Room 101'),
       ('Biology', 'Building B, Room 202'),
       ('Mathematics', 'Building C, Room 303');

create table semesters
(
    id            serial primary key,
    semester_name varchar(50) not null,
    start_date    date        not null,
    end_date      date        not null
);

insert into semesters (semester_name, start_date, end_date)
values ('Spring 2023', '2023-01-01', '2023-05-31'),
       ('Summer 2023', '2023-06-01', '2023-08-31'),
       ('Fall 2023', '2023-09-01', '2023-12-31');

create table assignments
(
    id              serial primary key,
    course_id       int references courses (id),
    assignment_name varchar(100) not null,
    due_date        date         not null
);


insert into assignments (course_id, assignment_name, due_date)
values (1, 'homework 1', '2023-07-15'),
       (2, 'lab report 2', '2023-07-20'),
       (1, 'homework 2', '2023-07-30');

create table grades
(
    id            serial primary key,
    enrollment_id int references enrollments (id),
    assignment_id int references assignments (id),
    grade         float
);

insert into grades (enrollment_id, assignment_id, grade)
values (1, 1, 90.5),
       (1, 2, 85.0),
       (2, 1, 92.0);

create table attendance
(
    id            serial primary key,
    enrollment_id int references enrollments (id),
    date          date        not null,
    status        varchar(10) not null
);

insert into attendance (enrollment_id, date, status)
values (1, '2023-07-01', 'present'),
       (1, '2023-07-02', 'absent'),
       (2, '2023-07-03', 'present');

create table resources
(
    id            serial primary key,
    course_id     int references courses (id),
    resource_name varchar(100) not null,
    description   text
);

insert into resources (course_id, resource_name, description)
values (1, 'lecture slides', 'slides for lecture 1'),
       (1, 'sample code', 'sample code for homework 1'),
       (2, 'lab manual', 'manual for lab report 2');