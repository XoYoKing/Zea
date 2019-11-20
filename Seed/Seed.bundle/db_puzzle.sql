/*菜单表*/
CREATE TABLE IF NOT EXISTS 'p_menu' (
    'p_menu_id' TEXT PRIMARY KEY NOT NULL UNIQUE,
    'p_menu_title' TEXT,
    'p_menu_icon' TEXT
);

INSERT INTO 'p_menu'
VALUES ('0', 'start', 'menu_start');

INSERT INTO 'p_menu'
VALUES ('1', 'record', 'menu_record');

INSERT INTO 'p_menu'
VALUES ('2', 'gallery', 'menu_gallery');

INSERT INTO 'p_menu'
VALUES ('3', 'level', 'menu_level');

INSERT INTO 'p_menu'
VALUES ('4', 'help', 'menu_help');

INSERT INTO 'p_menu'
VALUES ('5', 'about', 'menu_about');


/*等级表*/
CREATE TABLE IF NOT EXISTS 'p_level' (
    'p_level_id' TEXT PRIMARY KEY NOT NULL UNIQUE,
    'p_level_title' TEXT,
    'p_level_order' TEXT,
    'p_level_detail' TEXT
);

INSERT INTO 'p_level'
VALUES ('0', 'newbie', '3', 'level_newbie_detail');

INSERT INTO 'p_level'
VALUES ('1', 'junior', '4', 'level_junior_detail');

INSERT INTO 'p_level'
VALUES ('2', 'senior', '5', 'level_senior_detail');

INSERT INTO 'p_level'
VALUES ('3', 'master', '7', 'level_master_detail');

INSERT INTO 'p_level'
VALUES ('4', 'guru', '9', 'level_guru_detail');

INSERT INTO 'p_level'
VALUES ('5', 'god', '11', 'level_god_detail');


/*图片表*/
CREATE TABLE IF NOT EXISTS 'p_gallery' (
    'p_gallery_id' TEXT PRIMARY KEY NOT NULL UNIQUE,
    'p_gallery_title' TEXT,
    'p_gallery_image' TEXT
);

INSERT INTO 'p_gallery'
VALUES ('0', 'animal', 'db_gallery_animal_0');

INSERT INTO 'p_gallery'
VALUES ('1', 'animal', 'db_gallery_animal_1');

INSERT INTO 'p_gallery'
VALUES ('2', 'animal', 'db_gallery_animal_2');

INSERT INTO 'p_gallery'
VALUES ('3', 'cultural', 'db_gallery_cultural_0');

INSERT INTO 'p_gallery'
VALUES ('4', 'natural', 'db_gallery_natural_0');

INSERT INTO 'p_gallery'
VALUES ('5', 'natural', 'db_gallery_natural_1');


/*记录表*/
CREATE TABLE IF NOT EXISTS 'p_record' (
    'p_record_id' TEXT PRIMARY KEY NOT NULL UNIQUE,
    'p_record_level_order' TEXT,
    'p_record_level_title' TEXT,
    'p_record_image' TEXT,
    'p_record_time' TEXT,
    'p_record_count' TEXT,
    'p_record_timestamp' TEXT
);
