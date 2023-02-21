--Drop table FormBuilder

IF NOT EXISTS ( SELECT TABLE_NAME  
FROM INFORMATION_SCHEMA.tables  
WHERE TABLE_NAME = 'FormBuilder' )  
BEGIN 
	
	CREATE TABLE FormBuilder(
	FormID INT IDENTITY PRIMARY KEY, 
	FormName VARCHAR(200) UNIQUE NOT NULL,
	FormCreatedDate DATE,FormLastUpdatedDate DATE, 
	FormCreatedBy VARCHAR(100),
	FormLastUpdatedBy VARCHAR(100))

	INSERT INTO FormBuilder(FormName,FormCreatedDate,FormLastUpdatedDate,FormCreatedBy,FormLastUpdatedBy) 
	VALUES('MissingVehicles',GETDATE(),GETDATE(),'Sweety','Sweety'),
	      ('SeizedProperty',GETDATE(),GETDATE(),'Sweety','Sweety')
END


IF NOT EXISTS ( SELECT TABLE_NAME  
FROM INFORMATION_SCHEMA.tables  
WHERE TABLE_NAME = 'FormFields' )  
BEGIN

	CREATE TABLE FormFields(
	FieldId INT IDENTITY PRIMARY KEY, 
	FormId INT,
	FieldLabel VARCHAR(100), 
	FieldType VARCHAR(100), 
	FieldOptions VARCHAR(100), 
	FieldRequired VARCHAR(100), 
	FOREIGN KEY (FormId) REFERENCES FormBuilder(FormID)
	)


	INSERT INTO FormFields(FormId,FieldLabel,FieldType,FieldOptions,FieldRequired)
	VALUES(1,'District','Alphabet','',''),
		  (1,'Police Station','Alpha Numeric','',''),
		  (1,'Vehicle no','Alpha Numeric','',''),
		  (1,'MissingDate','Date','',''),
		  (1,'RepotingDate','Date','',''),
		  (1,'Complaint Name','Alphabet','',''),
		  (1,'Complaint Address','Alpha Numeric','',''),
		  (1,'Mobile No','Numeric','',''),
		  (1,'Enquiry Officer','Alpha Numeric','',''),
		  (1,'Present Status','Alphabet','','')

	INSERT INTO FormFields(FormId,FieldLabel,FieldType,FieldOptions,FieldRequired)
	VALUES(2,'District','Alphabet','',''),
		  (2,'Police Station','Alpha Numeric','',''),
		  (2,'Register Entry No','Alpha Numeric','',''),
		  (2,'Date of seizure','Date','',''),
		  (2,'Case reference','Alphabet','',''),
		  (2,'Present station','Alpha Numeric','',''),
		  (2,'Present place of items','Alpha Numeric','','')

END

