exec sp_configure 'show advanced options'
exec sp_configure 'Ole Automation Procedures'


EXEC sp_configure 'show advanced options', 1;
RECONFIGURE
GO

EXEC sp_configure 'Ole Automation Procedures', 1;
RECONFIGURE
GO

Declare @Object as Int;
Declare @ResponseText as Varchar(8000);
 
Exec sp_OACreate 'WinHttp.WinHttpRequest.5.1', @Object OUT;
Exec sp_OAMethod @Object, 'open', NULL, 'get',
                                                              'https://httpbin.org/get', --Your Web Service Url (invoked)
                                                              'false'
Exec sp_OAMethod @Object, 'send'
Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
 
Select @ResponseText
 
Exec sp_OADestroy @Object