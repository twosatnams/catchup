CREATE TABLE friends
(
id integer,
user varchar(255),
friend varchar(255),
pending boolean
);

INSERT INTO friends
VALUES (1,'John','Jack',true);

INSERT INTO friends
VALUES (2,'John','Katie',true);

INSERT INTO friends
VALUES (3,'John','Brad',true);

INSERT INTO friends
VALUES (4,'Brad','Katie',true);

INSERT INTO friends
VALUES (5,'Darren','Henry',true);

INSERT INTO friends
VALUES (6,'Darren','John',true);

INSERT INTO friends
VALUES (7,'Irene','John',true);

INSERT INTO friends
VALUES (8,'John','Mark',true);

INSERT INTO friends
VALUES (9,'Katie','Mark',true);

INSERT INTO friends
VALUES (10,'Brad','Irene',true);


QUERY
SELECT friend
FROM friends
WHERE user = 'John'

UNION

SELECT user
FROM friends
WHERE friend = 'John'

ANSWER
Jack
Katie
Brad
Mark
Darren
Irene
