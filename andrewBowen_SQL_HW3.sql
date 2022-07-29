-- Andrew Bowen
-- SQL Bridge HW 3

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS company_groups;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS user_groups;
DROP TABLE IF EXISTS group_rooms;
DROP TABLE IF EXISTS users_groups_rooms;

-- Creating tables
CREATE TABLE users (
	user_id int NOT NULL,
    user_name varchar(50)
);
-- Insert values into tables

INSERT INTO USERS (user_id, user_name) VALUES (100, "Modesto");
INSERT INTO USERS (user_id, user_name) VALUES (101, "Ayine");
INSERT INTO USERS (user_id, user_name) VALUES (102, "Christopher");
INSERT INTO USERS (user_id, user_name) VALUES (103, "Cheong Woo");
INSERT INTO USERS (user_id, user_name) VALUES (104, "Salwat");
INSERT INTO USERS (user_id, user_name) VALUES (105, "Heidy");


CREATE TABLE rooms (
	room_id int NOT NULL,
    room_name varchar(50)
);

-- Inserting room values into rooms table
INSERT INTO rooms (room_id, room_name) VALUES (301, "101");
INSERT INTO rooms (room_id, room_name) VALUES (302, "102");
INSERT INTO rooms (room_id, room_name) VALUES (303, "Auditorium A");
INSERT INTO rooms (room_id, room_name) VALUES (304, "Auditorium B");

CREATE TABLE company_groups (
	group_id int,
    group_name varchar(50)
);

-- Inserting values into our groups table
INSERT INTO company_groups (group_id, group_name) VALUES (201, "Sales");
INSERT INTO company_groups (group_id, group_name) VALUES (202, "I.T.");
INSERT INTO company_groups (group_id, group_name) VALUES (203, "Operations");
INSERT INTO company_groups (group_id, group_name) VALUES (204, "Administration");


CREATE TABLE user_groups (
	user_id int NOT NULL REFERENCES users(user_id),
    group_id varchar(50) REFERENCES company_groups(group_id),
    ug_id int,
    CONSTRAINT ug_id PRIMARY KEY(user_id, group_id)
);

INSERT INTO user_groups (user_id, group_id, ug_id) VALUES (100, 202, 1001);
INSERT INTO user_groups (user_id, group_id, ug_id) VALUES (101, 202, 1002);
INSERT INTO user_groups (user_id, group_id, ug_id) VALUES (102, 201, 1003);
INSERT INTO user_groups (user_id, group_id, ug_id) VALUES (103, 201, 1004);
INSERT INTO user_groups (user_id, group_id, ug_id) VALUES (104, 204, 1005);


CREATE TABLE group_rooms (
	room_id int NOT NULL REFERENCES rooms(room_id),
    room_name varchar(50),
    group_id int REFERENCES company_groups(group_id),
    group_name varchar(50),
    CONSTRAINT pk_group_rooms PRIMARY KEY(room_id, group_id)
);

-- Entering group -> room relationship table
INSERT INTO group_rooms (room_id, room_name, group_id, group_name)
	VALUES (301, "101", 202, "I.T.");
INSERT INTO group_rooms (room_id, room_name, group_id, group_name)
	VALUES (302, "102", 202, "I.T.");
INSERT INTO group_rooms (room_id, room_name, group_id, group_name)
	VALUES (302, "102", 201, "Sales");
INSERT INTO group_rooms (room_id, room_name, group_id, group_name)
	VALUES (303, "Auditorium A", 201, "Sales");
    

-- Creating one table (many-to-many) with all 3 dimensions
CREATE TABLE users_groups_rooms (
		ugr_id int,
        user_id int,
        group_id int,
        room_id int
	);
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1000, 100, 202, 301); -- Modesto 101
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1001, 100, 202, 302); -- Modesto 102
-- Ayine IT acces (101 & 102)
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1002, 101, 202, 301);
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1003, 101, 202, 302);
-- Sales group room access -- Cheong Woo and Christopher
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1004, 102, 201, 302);
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1005, 102, 201, 303);
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1006, 103, 201, 302);
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1007, 103, 201, 303);
-- Salwat -- Admin (no room access)
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1008, 104, 204, NULL);
    -- Heidy
INSERT INTO users_groups_rooms (ugr_id, user_id, group_id, room_id)
	VALUES (1009, 104, NULL, NULL);


        
    
SELECT * FROM users;
SELECT * FROM company_groups;
SELECT * FROM rooms;
SELECT * FROM users_groups_rooms;
-- LEFT JOIN user_groups ug ON u.user_id = ug.user_id;


-- Now let's do our JOIN statements
-- 1 All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
SELECT g.group_name, u.user_name FROM users u 
INNER JOIN user_groups ug ON u.user_id = ug.user_id
RIGHT JOIN company_groups g ON g.group_id = ug.group_id;

/*
2 All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them.
*/
-- Need to connect the rooms table to our groups table via the group_rooms table
SELECT r.room_name, g.group_name FROM company_groups g
INNER JOIN group_rooms gr ON g.group_id = gr.group_id
RIGHT JOIN rooms r ON gr.room_id = r.room_id;

/*A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room.*/
-- This will be many to many as a user may have access to multiple rooms. via their group, so even if the group -> user relationship is one to many, the relationship to the rooms could be many to many
SELECT u.user_name, g.group_name, r.room_name FROM users u
INNER JOIN users_groups_rooms ugr ON u.user_id = ugr.user_id
	RIGHT JOIN company_groups g ON ugr.group_id = g.group_id
    RIGHT JOIN rooms r ON ugr.room_id = r.room_id
    ORDER BY user_name, group_name, room_name
    ;


-- Trying to accomplish above without referencing our users_groups_rooms table
SELECT u.user_name, g.group_name, r.room_name FROM users u
INNER JOIN user_groups ug ON u.user_id = ug.user_id
	RIGHT JOIN company_groups g ON g.group_id = ug.group_id
	RIGHT JOIN group_rooms gr ON g.group_id = gr.group_id
	RIGHT JOIN rooms r ON gr.room_id = r.room_id
ORDER BY user_name, group_name, room_name
;

