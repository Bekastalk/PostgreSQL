create table customers
(
    id            serial primary key,
    first_name    varchar(50) not null,
    last_name     varchar(50) not null,
    date_of_birth date        not null,
    address       varchar(100),
    email         varchar(100),
    phone         varchar(20)
);


insert into customers (first_name, last_name, date_of_birth, address, email, phone)
values ('zhanybek', 'akmatov', '1990-01-01', 'Chuy Avenue, 123', 'zhanybek@example.com', '1234567890'),
       ('gulzat', 'zhaparova', '1992-05-15', 'Ala-Archa, 456', 'gulzat@example.com', '9876543210'),
       ('ermek', 'zhumagulov', '1988-12-10', 'Orto-Sai, 789', 'ermek@example.com', '5678901234');


create table accounts
(
    id             serial primary key,
    customer_id    int references customers (id),
    account_number varchar(20) not null,
    account_type   varchar(50) not null,
    balance        decimal(10, 2) default 0.0
);


insert into accounts (customer_id, account_number, account_type, balance)
values (1, '1234567890', 'checking', 10000.00),
       (2, '0987654321', 'savings', 5000.00),
       (3, '5432109876', 'checking', 7500.00);


create table transactions
(
    id               serial primary key,
    account_id       int references accounts (id),
    transaction_date date           not null,
    amount           decimal(10, 2) not null,
    transaction_type varchar(50)    not null,
    description      varchar(100)
);


insert into transactions (account_id, transaction_date, amount, transaction_type, description)
values (1, '2023-07-01', 500.00, 'debit', 'Покупка в магазине'),
       (2, '2023-07-02', 1000.00, 'credit', 'Зачисление зарплаты'),
       (1, '2023-07-03', 200.00, 'debit', 'Снятие наличных');


create table loans
(
    id            serial primary key,
    customer_id   int references customers (id),
    loan_amount   decimal(10, 2) not null,
    interest_rate decimal(5, 2)  not null,
    loan_term     int            not null,
    loan_status   varchar(50)    not null
);


insert into loans (customer_id, loan_amount, interest_rate, loan_term, loan_status)
values (1, 50000.00, 7.5, 36, 'active'),
       (2, 25000.00, 6.0, 24, 'closed'),
       (3, 100000.00, 8.0, 60, 'active');


create table credit_cards
(
    id          serial primary key,
    customer_id int references customers (id),
    card_number varchar(16)    not null,
    card_type   varchar(50)    not null,
    card_limit  decimal(10, 2) not null,
    card_status varchar(50)    not null
);


insert into credit_cards (customer_id, card_number, card_type, card_limit, card_status)
values (1, '1234567812345678', 'visa', 10000.00, 'active'),
       (2, '9876543298765432', 'mastercard', 5000.00, 'active'),
       (3, '5432109854321098', 'visa', 7500.00, 'blocked');

create table branches
(
    branch_id   serial primary key,
    branch_name varchar(100) not null,
    address     varchar(100) not null,
    manager_id  int
);

ALTER TABLE branches
    ADD CONSTRAINT fk_manager
        FOREIGN KEY (manager_id)
            REFERENCES employees (employee_id);

insert into branches (branch_name, address, manager_id)
values ('Филиал Бишкек', 'ул. Чуй, 123', 1),
       ('Филиал Ош', 'ул. Ленина, 456', 2),
       ('Филиал Каракол', 'ул. Орозбекова, 789', 3);
create table employees
(
    employee_id serial primary key,
    first_name  varchar(50)  not null,
    last_name   varchar(50)  not null,
    position    varchar(100) not null,
    branch_id   int
);

insert into employees (first_name, last_name, position, branch_id)
values ('Адилет', 'Асанов', 'Менеджер', 1),
       ('Айгерим', 'Абдыкадырова', 'Кассир', 2),
       ('Бакыт', 'Абдылдаев', 'Кредитный специалист', 3);

ALTER TABLE employees
    ADD CONSTRAINT fk_branch
        FOREIGN KEY (branch_id)
            REFERENCES branches (branch_id);

create table atms
(
    atm_id    serial primary key,
    location  varchar(100) not null,
    branch_id int references branches (branch_id)
);


insert into atms (location, branch_id)
values ('ул. Манаса, 10', 1),
       ('пр. Чынгыза Айтматова, 20', 2),
       ('ул. Молдо, 30', 3);

create table bank_services
(
    service_id   serial primary key,
    service_name varchar(100) not null,
    description  varchar(200)
);


insert into bank_services (service_name, description)
values ('Открытие счета', 'Открытие банковского счета для физических лиц'),
       ('Кредитование', 'Выдача кредитов на различные цели'),
       ('Переводы', 'Перевод денежных средств внутри страны и за рубеж');


create table service_requests
(
    request_id   serial primary key,
    customer_id  int references customers (id),
    service_id   int references bank_services (service_id),
    request_date date        not null,
    status       varchar(50) not null
);


insert into service_requests (customer_id, service_id, request_date, status)
values (1, 1, '2023-07-01', 'открыт'),
       (2, 2, '2023-07-02', 'в обработке'),
       (3, 3, '2023-07-03', 'закрыт');
