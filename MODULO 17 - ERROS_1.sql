/*
Mensagens de erros cadastradas;
*/
SELECT * FROM sys.messages
--

/*
 As mensagens dos usuários são cadastradas com códigos a partir de 50.000 até 2.147.483.647. 
 Combinação única linguagem + message_id;
 Permissão: sysadmin ou serveradmin
*/
--Adicionar
EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'O item já existe',   
   @lang = 'English';

EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'O item já existe',   
   @lang = 'Portuguese';

-- Consultando a mensagem
SELECT * FROM sys.messages WHERE message_id = 60000
--
RAISERROR(60000, 11, 1);

-- Remover a mensagem
EXEC sp_dropmessage  
    @msgnum = 60000,  
    @lang = 'Portuguese'; 


EXEC sp_dropmessage  
    @msgnum = 60000,  
    @lang = 'English'; 

-------------------------
--Capturando @@Error
DECLARE @Erro VARCHAR(8000);

SELECT 10/0
SELECT @Erro = @@ERROR; --	Número do erro
SELECT @Erro;

--------------------------