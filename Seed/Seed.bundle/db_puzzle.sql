CREATE TABLE "p_level" (
    "p_level_id" TEXT PRIMARY KEY NOT NULL UNIQUE,
    "p_level_title" TEXT,
    "p_level_order" TEXT,
    "p_level_detail" TEXT
);

INSERT INTO "p_level"
VALUES ('0', 'newbie', '3', 'level_newbie_detail');

INSERT INTO "p_level"
VALUES ('1', 'junior', '4', 'level_junior_detail');

INSERT INTO "p_level"
VALUES ('2', 'senior', '5', 'level_senior_detail');

INSERT INTO "p_level"
VALUES ('3', 'master', '7', 'level_master_detail');

INSERT INTO "p_level"
VALUES ('4', 'guru', '9', 'level_guru_detail');

INSERT INTO "p_level"
VALUES ('5', 'god', '11', 'level_god_detail');



CREATE TABLE "p_menu" (
    "p_menu_id" TEXT PRIMARY KEY NOT NULL UNIQUE,
    "p_menu_title" TEXT,
    "p_menu_icon" TEXT
);

INSERT INTO "p_menu"
VALUES ('0', 'start', 'menu_start');

INSERT INTO "p_menu"
VALUES ('1', 'record', 'menu_record');

INSERT INTO "p_menu"
VALUES ('2', 'gallery', 'menu_gallery');

INSERT INTO "p_menu"
VALUES ('3', 'level', 'menu_level');

INSERT INTO "p_menu"
VALUES ('4', 'help', 'menu_help');

INSERT INTO "p_menu"
VALUES ('5', 'about', 'menu_about');
