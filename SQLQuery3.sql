CREATE TABLE [dbo].[Problem] (
    [Id]              VARCHAR (8)  NOT NULL,
    [Title]           VARCHAR (12) NOT NULL,
    [Content]         TEXT         NOT NULL,
    [NeedRemoteHelp]  BIT          NOT NULL,
    [Reward]          VARCHAR (10) NOT NULL,
    [PublishDateTime] DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);