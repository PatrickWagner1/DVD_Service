CREATE USER dvd_user WITH ENCRYPTED PASSWORD 'dvd_password';
GRANT ALL PRIVILEGES ON DATABASE dvd_db TO dvd_user;

CREATE TABLE test_table(
erste_spalte VARCHAR (50),
zweite_spalte VARCHAR (50)
);

INSERT INTO test_table VALUES ('1.1','1.2'),('2.1','2.2');

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dvd_user;
