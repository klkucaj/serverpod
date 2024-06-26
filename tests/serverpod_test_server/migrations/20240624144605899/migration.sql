BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "datetime_default" (
    "id" bigserial PRIMARY KEY,
    "dateTimeDefaultNow" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateTimeDefaultStr" timestamp without time zone NOT NULL DEFAULT '2024-06-03 22:00:00'::timestamp without time zone,
    "dateTimeDefaultStrNull" timestamp without time zone DEFAULT '2024-06-03 22:00:00'::timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "datetime_default_database" (
    "id" bigserial PRIMARY KEY,
    "dateTimeDefaultDatabaseNow" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "dateTimeDefaultDatabaseStr" timestamp without time zone DEFAULT '2024-05-10 22:00:00'::timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "datetime_default_mix" (
    "id" bigserial PRIMARY KEY,
    "dateTimeDefaultAndDefaultModel" timestamp without time zone NOT NULL DEFAULT '2024-05-01 22:00:00'::timestamp without time zone,
    "dateTimeDefaultAndDefaultDatabase" timestamp without time zone NOT NULL DEFAULT '2024-05-10 22:00:00'::timestamp without time zone,
    "dateTimeDefaultModelAndDefaultDatabase" timestamp without time zone NOT NULL DEFAULT '2024-05-10 22:00:00'::timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "datetime_default_model" (
    "id" bigserial PRIMARY KEY,
    "dateTimeDefaultModelNow" timestamp without time zone NOT NULL,
    "dateTimeDefaultModelStr" timestamp without time zone NOT NULL,
    "dateTimeDefaultModelStrNull" timestamp without time zone
);


--
-- MIGRATION VERSION FOR serverpod_test
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_test', '20240624144605899', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240624144605899', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_test_module
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_test_module', '20240115074247714', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074247714', "timestamp" = now();


COMMIT;