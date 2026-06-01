-- Aidify — Demo Users Seed
-- Run AFTER 01_Schema.sql and 02_SeedRoles.sql
-- Passwords stored as plain text (development only — see HASHING_GUIDE.md to add BCrypt)
USE AidifyDB;
GO

-- ── Demo users ──────────────────────────────────────────────────────────────
-- Password for all three accounts: Admin123!
DECLARE @DemoPasswordHash NVARCHAR(255) = '$2a$11$yv4ZlZ60ftfCtZVzVlcvReMqkb55g64qE5jKa1j.dIYYm9kyo8WN2';
-- (plain text — replace with BCrypt hashes before production)

INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
SELECT 'Aidify Admin',    'admin@aidify.edu',      @DemoPasswordHash, RoleId, 1, 1
FROM Roles WHERE RoleName = 'Admin';

INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
SELECT 'Demo Instructor', 'instructor@aidify.edu', @DemoPasswordHash, RoleId, 1, 1
FROM Roles WHERE RoleName = 'Instructor';

INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
SELECT 'Demo Learner',    'learner@aidify.edu',    @DemoPasswordHash, RoleId, 1, 1
FROM Roles WHERE RoleName = 'Learner';

PRINT 'Demo users created — login with Admin123! for all three accounts';
