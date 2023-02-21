--USE [TEAMUPDEMO]
CREATE PROCEDURE [dbo].[usp_CreateDynamicTable] 
(
	@formID INT=0
)
AS
BEGIN

/********************************************************************************************************
	Filename	: [usp_CreateDynamicTable].sql
	Author		: Sweety
	Description	: Create table fro system dynamically
	Created_at  : 21-02-2023
	---------------------------------------------------------------------------------------------------------
	********************************************************************************************************/
	SET NOCOUNT ON

	DECLARE @tempTable TABLE (Id INT IDENTITY, ColumnName VARCHAR(100), DataType VARCHAR(100) )
	DECLARE @tableName VARCHAR(100),
			@countColumns INT,
			@counter INT =1,
			@dynamicQuery VARCHAR(100)=NULL,
			@fieldName VARCHAR(100),
			@fieldType VARCHAR(100)

	SELECT @tableName=FB.FormName 
	FROM FormBuilder FB WITH(NOLOCK)
	WHERE FormID=@formID

	INSERT INTO @tempTable(ColumnName,DataType)
	SELECT FF.FieldLabel , FF.FieldType
	FROM FormFields FF WITH(NOLOCK) 
	WHERE FormID=@formID

	SET @dynamicQuery='CREATE TABLE '+ @tableName +'( ID INT IDENTITY '

	SET @CountColumns= (
						SELECT COUNT(*) FROM FormFields WITH(NOLOCK) WHERE FormID=@formID)

	WHILE(@counter<=@countColumns)
	BEGIN

		SELECT 
			@fieldName=REPLACE(ColumnName,' ','_') ,
			@fieldType= CASE 
							WHEN DataType='Alphabet'  THEN 'VARHCHAR(MAX)'
							WHEN DataType='Alpha Numeric'  THEN 'NVARCHAR(MAX)'
							WHEN DataType='Date'  THEN 'DATE'
							WHEN DataType='Numeric'  THEN 'INT'
						END
		FROM @tempTable 
		WHERE ID=@counter
		
		SET @dynamicQuery=@dynamicQuery+',' + @fieldName + ' ' + @fieldType 

		SET @counter=@counter+1;

	END

	SET @dynamicQuery=@dynamicQuery+')'

	EXEC @dynamicQuery

END