﻿CREATE TABLE [User]
(
	[UserName] INT NOT NULL  PRIMARY KEY,
	[Password] Char(10) NOT NULL
);

CREATE TABLE [Keyword]
(
	[Name] Char(10) NOT NULL  PRIMARY KEY,
	[Used] INT NOT NULL
);

ALTER TABLE [User] ADD InvitedBy INT;

ALTER TABLE [User] ALTER COLUMN InvitedBy NVARCHAR(10);

ALTER TABLE [User] DROP COLUMN InvitedBy;