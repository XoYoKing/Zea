CREATE TABLE 'p_level' (
	'p_level_id' INTEGER PRIMARY KEY NOT NULL UNIQUE,
	'p_level_title' TEXT,
	'p_level_order' INTEGER,
	'p_level_detail' TEXT
);

INSERT INTO 'p_level'
VALUES (1, 'newbie', 3, 'level_newbie_detail');

INSERT INTO 'p_level'
VALUES (2, 'junior', 4, 'level_junior_detail');

INSERT INTO 'p_level'
VALUES (3, 'senior', 5, 'level_senior_detail');

INSERT INTO 'p_level'
VALUES (4, 'master', 7, 'level_master_detail');

INSERT INTO 'p_level'
VALUES (5, 'guru', 9, 'level_guru_detail');

INSERT INTO 'p_level'
VALUES (6, 'god', 11, 'level_god_detail');



CREATE TABLE 'p_menu' (
	'p_menu_id' INTEGER PRIMARY KEY NOT NULL UNIQUE,
	'p_menu_title' TEXT,
	'p_menu_icon' TEXT
);

INSERT INTO 'p_menu'
VALUES (1, 'start', 'menu_start');

INSERT INTO 'p_menu'
VALUES (2, 'record', 'menu_record');

INSERT INTO 'p_menu'
VALUES (3, 'gallery', 'menu_gallery');

INSERT INTO 'p_menu'
VALUES (4, 'level', 'menu_level');

INSERT INTO 'p_menu'
VALUES (5, 'help', 'menu_help');

INSERT INTO 'p_menu'
VALUES (6, 'about', 'menu_about');
