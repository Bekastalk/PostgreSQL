create table patients
(
    id             serial primary key,
    first_name     varchar     not null,
    last_name      varchar     not null,
    date_of_birth  date        not null,
    gender         varchar     not null,
    adress         varchar     not null,
    contast_number varchar(13) not null
);


INSERT INTO patients (first_name, last_name, date_of_birth, gender, adress, contast_number)
VALUES ('Aibek', 'Asanov', '2003-05-15', 'Male', 'Kyzyl-Asker', '+996704445566'),
       ('Aleksandr', 'Gulyayev', '1999-05-15', 'Male', 'Tokmok', '+996504665544'),
       ('Aimona', 'Esenova', '2005-04-15', 'Female', 'Osh', '+996704778899');


alter table patients rename column last_name to patients_name;

alter table patients rename column patients_name to FIO;

alter table patients
    add column age int;

alter table patients drop column age;

drop table doctors;

truncate table employee cascade;

create table doctors
(
    id             serial primary key,
    first_name     varchar not null,
    last_name      varchar not null,
    spesialization varchar not null,
    contact_number varchar not null
);

ALTER TABLE doctors
    ALTER COLUMN contact_number DROP NOT NULL;

ALTER TABLE doctors
    ADD CONSTRAINT unique_contact_number UNIQUE (contact_number);

insert into doctors (first_name, last_name, spesialization, contact_number)
values ('Aida', 'Kubanova', 'Allergolog', '+996502662233
');

insert into doctors(first_name, last_name, spesialization, co
    ntact_number)
values ('AIbek', 'Sagynov', 'Urolog', '+996502668833');

create table schedule
(
    id          serial primary key,
    doctor_id   int     not null,
    day_of_week varchar not null,
    start_time  time    not null,
    end_time    time    not null
);

alter table schedule
    alter column doctor_id drop not null;

ALTER TABLE schedule
    ADD CONSTRAINT fk_doctor_id FOREIGN KEY (doctor_id) REFERENCES doctors (id);

insert into schedule(doctor_id, day_of_week, start_time, end_time)
values (1, 'Monday', '08:30:00', '20:30:00'),
       (2, 'Tuesday', '08:30:00', '20:30:00'),
       (3, 'Sunday', '08:30:00', '20:30:00');

insert into visits(patient_id, doctor_id, vizit_date, symptoms, diagnosic)
values (1, 1, '2023-07-04', 'temperature', 'influenza'),
       (2, 2, '2023-07-06', 'cough', 'tonsillitis'),
       (3, 3, '2023-07-09', 'headache', 'sinusitis');

insert into departaments(departament_name, location, contact_number)
values ('Lor', 'Bishkek', '+996506996633'),
       ('Stom', 'Bishkek', '+996908665599'),
       ('Terapia', 'Bishkek', '+996555447788');

create table services
(
    id             serial primary key,
    service_name   varchar not null,
    departament_id int references departaments (id),
    cost           int     not null
);

insert into services(service_name, departament_id, cost)
values ('Lor', 1, 401),
       ('Stom', 2, 503),
       ('Terapia', 3, 207);

create table prescriptions
(
    id        serial primary key,
    visit_id  int references visits (id),
    test_name varchar not null,
    result    varchar not null
);

insert into prescriptions(visit_id, test_name, result)
values (1, 'temperature', 'influenza'),
       (2, 'cough', 'tonsillitis'),
       (3, 'headache', 'sinusitis');

create table insurance_companies
(
    id             serial primary key,
    company_name   varchar not null,
    contact_number varchar not null,
    address        varchar not null
);

insert into insurance_companies(company_name, contact_number, address)
values ('Asman', '+996777552266', 'Bishkek'),
       ('Ai', '+996779885577', 'Osh'),
       ('Zhyldyz', '+996555998822', 'Bishkek');

create table invoices
(
    id           serial primary key,
    visit_id     int references visits (id),
    patient_id   int references patients (id),
    invoice_date date not null,
    amount       int  not null
);

insert into invoices(visit_id, patient_id, invoice_date, amount)
values (1, 1, '2023-02-12', 500),
       (2, 2, '2023-03-17', 800),
       (3, 3, '2023-05-19', 200);


create table staff
(
    id             serial primary key,
    first_name     varchar not null,
    last_name      varchar not null,
    position       varchar not null,
    contact_number varchar not null
);

insert into staff(first_name, last_name, position, contact_number)
values ('Zhanuzak', 'Anashov', 'Lor', '+996778996611'),
       ('Nurik', 'Asanov', 'Stom', '+996999886633'),
       ('Nazema', 'Alibaeva', 'Terapevt', '+996708554477');