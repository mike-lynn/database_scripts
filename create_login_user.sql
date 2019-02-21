
--:connect (server name)

DECLARE @credential NVARCHAR(250) = 'windows credential';

DECLARE @sql_login NVARCHAR(512) = 'CREATE LOGIN [$$credential$$] FROM WINDOWS;'

SELECT @sql_login = REPLACE(@sql_login, '$$credential$$', @credential);

EXECUTE sp_executesql @sql_login;

USE [database];

DECLARE @sql NVARCHAR(2000) = 'CREATE USER [$$credential$$] FOR LOGIN [$$credential$$];

ALTER ROLE db_datareader ADD MEMBER [$$credential$$];';

SELECT @sql = REPLACE(@sql, '$$credential$$', @credential);

EXECUTE sp_executesql @sql;
