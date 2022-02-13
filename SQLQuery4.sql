INSERT [User](UserName, Password) VALUES(17, 1234);
SELECT * FROM [User];
ALTER TABLE [User] ALTER COLUMN Password CHAR(20);
UPDATE [User] SET UserName = '17bang';
INSERT [User](UserName, Password) VALUES('Admin', NULL);
INSERT [User](UserName) VALUES('Admin-1');
INSERT [User](UserName, Password) VALUES('SuperAdmin', 123456);
UPDATE [Problem] SET Reward = 0;

BEGIN TRAN
DELETE [User];
ROLLBACK