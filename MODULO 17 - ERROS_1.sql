/*
Mensagens de erros cadastradas;
*/
SELECT * FROM sys.messages
--

/*
 As mensagens dos usu�rios s�o cadastradas com c�digos a partir de 50.000 at� 2.147.483.647. 
 Combina��o �nica linguagem + message_id;
 Permiss�o: sysadmin ou serveradmin
*/
--Adicionar
EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'O item j� existe',   
   @lang = 'English';

EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'O item j� existe',   
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
SELECT @Erro = @@ERROR; --	N�mero do erro
SELECT @Erro;

--------------------------