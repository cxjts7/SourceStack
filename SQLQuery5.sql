CREATE TABLE Teacher( 
Id INT, 
[Name] NVARCHAR(25), 
Age INT, 
Gender BIT 
) 

CREATE UNIQUE CLUSTERED INDEX IX_Teacher_ID ON Teacher(id)